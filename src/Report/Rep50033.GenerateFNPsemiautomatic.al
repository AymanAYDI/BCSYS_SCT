report 50033 "Generate FNP semi-automatic"
{
    // ------------------------------------- JX-VSC1.2 -------------------------------------
    // CREATION JX-XAD 10/11/2009
    // Génération des FNP semi-automatiques
    // Création d'un fichier au format csv contenant la liste de :
    // - toutes les commandes en cours non réceptionnées
    // - toutes les demandes d'achat
    // Ce report a pour objectif de générer les données dans une table temporaire
    // Un dataport se chargera des générer toutes les données dans un fichier Excel (format csv)
    // 
    // MOFIF JX-XAD 27/04/2010
    // Modification concernant le traitement de l'axe analytique PERIODE

    Caption = 'Generate FNP semi-automatic', Comment = 'FRA="Générer FNP semi-automatiques"';
    ProcessingOnly = true;

    dataset
    {
        dataitem(LineOrder; "Purchase Line")
        {
            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
            dataitem(LineCSV; Integer)
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 .. 3));

                trigger OnAfterGetRecord()
                begin

                    CASE LineCSV.Number OF

                        1:
                            BEGIN
                                //***************** Insertion ligne CREDIT *****************
                                Grec_TemporaryTable.INIT();
                                Gint_Ligne += 10000;
                                Grec_TemporaryTable."Line No." := Gint_Ligne;
                                Grec_TemporaryTable."Document No." := Gcode_NoFNP;
                                Grec_TemporaryTable."External document No." := PADSTR(LineOrder."Document No.", 20);
                                Grec_TemporaryTable."Account No." := Gcode_CompteGénéral;
                                Grec_TemporaryTable."Posting date" := Gdate_Compta;
                                Grec_TemporaryTable."Document date" := Gdate_Document;
                                Grec_TemporaryTable."Credit amount" := Gdec_MontantTTC;
                                Grec_TemporaryTable."Description" := Gtext_Description;
                                Grec_TemporaryTable."Vendor No." := LineOrder."Buy-from Vendor No.";
                                Grec_TemporaryTable."Vendor name" := Gtext_Fournisseur;
                                Grec_TemporaryTable."VAT rates" := LineOrder."VAT %";
                                //  InsérérAnalytique();   Modification NAv 2015
                                Grec_TemporaryTable."Dimension Set ID" := LineOrder."Dimension Set ID";
                                Grec_TemporaryTable.INSERT();
                            END;

                        2:
                            BEGIN
                                //***************** Insertion ligne DEBIT *****************
                                Grec_TemporaryTable.INIT();
                                Gint_Ligne += 10000;
                                Grec_TemporaryTable."Line No." := Gint_Ligne;
                                Grec_TemporaryTable."Document No." := Gcode_NoFNP;
                                Grec_TemporaryTable."External document No." := PADSTR(LineOrder."Document No.", 20);
                                Grec_TemporaryTable."Account No." := LineOrder."Gen. Prod. Posting Group";
                                Grec_TemporaryTable."Posting date" := Gdate_Compta;
                                Grec_TemporaryTable."Document date" := Gdate_Document;
                                Grec_TemporaryTable."Debit amount" := Gdec_MontantHT;
                                Grec_TemporaryTable."Description" := Gtext_Description;
                                Grec_TemporaryTable."Vendor No." := LineOrder."Buy-from Vendor No.";
                                Grec_TemporaryTable."Vendor name" := Gtext_Fournisseur;
                                Grec_TemporaryTable."VAT rates" := LineOrder."VAT %";
                                //  InsérérAnalytique();   Modification NAv 2015
                                Grec_TemporaryTable."Dimension Set ID" := LineOrder."Dimension Set ID";
                                Grec_TemporaryTable.INSERT();
                            END;

                        3:

                            //***************** Insertion ligne TVA si montant non nul *****************
                            IF ((Gdec_MontantTTC - Gdec_MontantHT) <> 0) THEN BEGIN
                                Grec_TemporaryTable.INIT();
                                Gint_Ligne += 10000;
                                Grec_TemporaryTable."Line No." := Gint_Ligne;
                                Grec_TemporaryTable."Document No." := Gcode_NoFNP;
                                Grec_TemporaryTable."External document No." := PADSTR(LineOrder."Document No.", 20);
                                Grec_TemporaryTable."Account No." := Gcode_CompteTVA;
                                Grec_TemporaryTable."Posting date" := Gdate_Compta;
                                Grec_TemporaryTable."Document date" := Gdate_Document;
                                Grec_TemporaryTable."Debit amount" := Gdec_MontantTTC - Gdec_MontantHT;
                                Grec_TemporaryTable."Description" := Gtext_Description;
                                Grec_TemporaryTable."Vendor No." := LineOrder."Buy-from Vendor No.";
                                Grec_TemporaryTable."Vendor name" := Gtext_Fournisseur;
                                Grec_TemporaryTable."VAT rates" := LineOrder."VAT %";
                                //  InsérérAnalytique();   Modification NAv 2015
                                Grec_TemporaryTable."Dimension Set ID" := LineOrder."Dimension Set ID";
                                Grec_TemporaryTable.INSERT();
                            END ELSE
                                CurrReport.SKIP();
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //********************* Traitement des commandes non réceptionnées et des demandes d'achat ***********************************

                Gdate_Document := 0D;
                IF (LineOrder."Document Type" = LineOrder."Document Type"::Order) AND (LineOrder."Qty. to Receive" <> 0) THEN BEGIN
                    Gdec_MontantHT := LineOrder."Qty. to Receive" * "Direct Unit Cost";
                    Gdec_MontantTTC := Gdec_MontantHT + (Gdec_MontantHT * "VAT %" / 100);
                    IF Grec_PurchaseHeader.GET(LineOrder."Document Type"::Order, LineOrder."Document No.") THEN
                        Gdate_Document := Grec_PurchaseHeader."Document Date";
                END ELSE
                    IF (LineOrder."Document Type" = LineOrder."Document Type"::Quote)
                       AND (LineOrder.Type <> LineOrder.Type::" ") AND (LineOrder."No." <> '') THEN BEGIN
                        Gdec_MontantHT := LineOrder.Quantity * "Direct Unit Cost";
                        Gdec_MontantTTC := Gdec_MontantHT + (Gdec_MontantHT * "VAT %" / 100);
                        IF Grec_PurchaseHeader.GET(LineOrder."Document Type"::Quote, LineOrder."Document No.") THEN
                            Gdate_Document := Grec_PurchaseHeader."Document Date";
                    END ELSE
                        CurrReport.SKIP();

                IF Grec_Fournisseur.GET("Buy-from Vendor No.") THEN BEGIN
                    Gtext_Fournisseur := Grec_Fournisseur.Name;
                    Gtext_Description := 'SA-' + PADSTR(Grec_Fournisseur.Name + '-' + Description, 47)
                END ELSE BEGIN
                    Gtext_Fournisseur := '';
                    Gtext_Description := '';
                END;

                IF (Type = Type::Item) OR ((Type = Type::"G/L Account") AND (COPYSTR("Gen. Prod. Posting Group", 1, 1) = '6')) THEN BEGIN
                    Gcode_CompteGénéral := '40800001';
                    Gcode_CompteTVA := '44586100'
                END ELSE
                    IF (Type = Type::"Fixed Asset") OR ((Type = Type::"G/L Account") AND (COPYSTR("Gen. Prod. Posting Group", 1, 1) = '2')) THEN BEGIN
                        Gcode_CompteGénéral := '40840001';
                        Gcode_CompteTVA := '44586400';
                    END;
            end;

            trigger OnPreDataItem()
            begin
                //Compteur de ligne
                Gint_Ligne := 0;

                //Recherche de l'année comptable en cours
                //Début MOFIF JX-XAD 27/04/2010
                /*
                Grec_ParamCompa.RESET;
                IF Grec_ParamCompa.FIND('-') THEN BEGIN
                  Grec_ParamCompa.CALCFIELDS(Grec_ParamCompa."Posting Allowed From");
                  Gdate_DébutExerciceComptable := Grec_ParamCompa."Posting Allowed From";
                  IF NOT EVALUATE(Gint_AnnéeComptable,FORMAT(Gdate_DébutExerciceComptable,4,'<Year,4>')) THEN
                    EVALUATE(Gint_AnnéeComptable,FORMAT(WORKDATE,4,'<Year,4>'));
                END;
                */
                EVALUATE(Gint_AnnéeComptable, FORMAT(WORKDATE(), 4, '<Year,4>'));
                //Fin MOFIF JX-XAD 27/04/2010


                //Initialisation du N° document FNP
                Grec_NoSeriesLine.SETFILTER(Grec_NoSeriesLine."Series Code", '%1', 'FNP-SA');
                IF Grec_NoSeriesLine.FIND('-') THEN
                    IF Grec_NoSeriesLine."Last No. Used" <> '' THEN
                        Gcode_NoFNP := INCSTR(Grec_NoSeriesLine."Last No. Used")
                    ELSE
                        Gcode_NoFNP := Grec_NoSeriesLine."Starting No.";

                //On ne prend que les devis et commandes
                LineOrder.SETFILTER(LineOrder."Document Type", '%1|%2', LineOrder."Document Type"::Order, LineOrder."Document Type"::Quote);

                //Initialisation de la table temporaire
                Grec_TemporaryTable.LOCKTABLE();
                Grec_TemporaryTable.DELETEALL();

            end;
        }
    }
    var
        Grec_TemporaryTable: Record "BC6_Global temporary table";
        Grec_NoSeriesLine: Record "No. Series Line";
        Grec_PurchaseHeader: Record "Purchase Header";
        Grec_Fournisseur: Record Vendor;
        "Gcode_CompteGénéral": Code[20];
        Gcode_CompteTVA: Code[20];
        Gcode_NoFNP: Code[20];
        Gdate_Compta: Date;
        Gdate_Document: Date;
        Gdec_MontantHT: Decimal;
        Gdec_MontantTTC: Decimal;
        "Gint_AnnéeComptable": Integer;
        Gint_Ligne: Integer;
        Gtext_Description: Text[50];
        Gtext_Fournisseur: Text[50];
}

