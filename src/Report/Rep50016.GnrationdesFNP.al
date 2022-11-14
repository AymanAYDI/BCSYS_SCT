report 50016 "BC6_Génération des FNP"
{
    Caption = 'Generation of invoices not received';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
        {
            DataItemTableView = sorting("Document No.", "Line No.");

            trigger OnAfterGetRecord()
            begin
                //BCSYS 180520 - Copy filter CCA
                if GDimSetEntry.GET("Dimension Set ID", 'PERIODE') then
                    Gcode_AxeEcriture := GDimSetEntry."Dimension Value Code"
                else
                    Gcode_AxeEcriture := '';

                if Gcode_AxeEcriture <= Gcode_ValeurAxe then begin
                    //Fin BCSYS 180520

                    //********************* Traitement des réceptions non facturées *******************************************
                    if ("Qty. Rcd. Not Invoiced" <> 0) then begin
                        Gdec_MontantTTC := "Qty. Rcd. Not Invoiced" * "Direct Unit Cost";
                        Gdec_MontantTTC += (Gdec_MontantTTC * "VAT %" / 100);
                        Gdec_MontantHT := "Qty. Rcd. Not Invoiced" * "Direct Unit Cost";
                        InsérerRéception();
                    end;

                    //********************* Traitement des réceptions facturées après la date de compta ***********************
                    Grec_EcritureValeur.RESET();
                    Grec_EcritureValeur.SETFILTER(Grec_EcritureValeur."Item Ledger Entry No.", '%1', "Purch. Rcpt. Line"."Item Rcpt. Entry No.");
                    Grec_EcritureValeur.SETFILTER(Grec_EcritureValeur."Invoiced Quantity", '<>%1', 0);
                    Grec_EcritureValeur.SETFILTER(Grec_EcritureValeur."Document Type", '%1', Grec_EcritureValeur."Document Type"::"Purchase Invoice");
                    Grec_EcritureValeur.SETFILTER(Grec_EcritureValeur."Posting Date", '>%1', Gdate_Compta);
                    if Grec_EcritureValeur.FIND('-') then
                        repeat
                            if Grec_LigneFactAchatEnregistrée.GET(Grec_EcritureValeur."Document No.", Grec_EcritureValeur."Document Line No.") then begin
                                Gdec_MontantHT := Grec_LigneFactAchatEnregistrée.Amount;
                                Gdec_MontantTTC := Grec_LigneFactAchatEnregistrée."Amount Including VAT";
                                InsérerRéception();
                            end;
                        until Grec_EcritureValeur.NEXT() = 0;
                end;
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Posting Date", '<=%1', Gdate_Compta);

                Gint_Ligne := 0;

                //********************* Recherche de l'année comptable en cours *********************
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
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field("Date de comptabilisation :"; Gdate_Compta)
                {
                    ApplicationArea = All;
                }
                field("Période"; Gcode_ValeurAxe)
                {
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        Grec_FeuilleComptaFNP.SETRANGE("Journal Template Name", Grec_FeuilleComptaFNP."Journal Template Name");
        Grec_FeuilleComptaFNP.SETRANGE("Journal Batch Name", Grec_FeuilleComptaFNP."Journal Batch Name");
        if (Grec_FeuilleComptaFNP.COUNT > 0) then
            if not CONFIRM(Text002) then
                ERROR(Text003);
        Grec_FeuilleComptaFNP.DELETEALL();
        Grec_FeuilleComptaFNP.LOCKTABLE();
        Gcode_NoFNP := Grec_FeuilleComptaFNP."Document No.";
        Gcode_CodeJournal := Grec_FeuilleComptaFNP."Source Code";

        if Grec_GenJnlBatch.GET(Grec_FeuilleComptaFNP."Journal Template Name", Grec_FeuilleComptaFNP."Journal Batch Name") then
            if Grec_GenJnlBatch."No. Series" <> 'FNP' then
                ERROR(Text001);

        //BCSYS 180520 - Copy filter CCA
        if Gcode_ValeurAxe = '' then
            ERROR(Text004);
    end;

    var
        GDimSetEntry: Record "Dimension Set Entry";
        Grec_GenJnlBatch: Record "Gen. Journal Batch";
        Grec_FeuilleComptaFNP: Record "Gen. Journal Line";
        "Grec_LigneFactAchatEnregistrée": Record "Purch. Inv. Line";
        Grec_EcritureValeur: Record "Value Entry";
        Grec_Fournisseur: Record Vendor;
        Gcode_CodeJournal: Code[10];
        Gcode_AxeEcriture: Code[20];
        "Gcode_CompteGénéral": Code[20];
        Gcode_CompteTVA: Code[20];
        Gcode_NoFNP: Code[20];
        Gcode_ValeurAxe: Code[20];
        Gdate_Compta: Date;
        Gdec_MontantHT: Decimal;
        Gdec_MontantTTC: Decimal;
        "Gint_AnnéeComptable": Integer;
        Gint_Ligne: Integer;
        Text001: label 'This sheet is not intended to invoices not received';
        Text002: label 'This sheet is not empty.\\All data being entered will be replaced.\\Would you like to continue?';
        Text003: label 'Operation canceled';
        Text004: label 'please fill the ''Periode'' axis';

    procedure SetFNPJnlLine(FeuilleComptaFNP: Record "Gen. Journal Line")
    begin
        Grec_FeuilleComptaFNP := FeuilleComptaFNP;
    end;

    procedure "InsérerRéception"()
    begin
        //***************** Initialisation suivant le cas type article ou immobilisation *****************
        if ("Purch. Rcpt. Line".Type = "Purch. Rcpt. Line".Type::Item) or (("Purch. Rcpt. Line".Type = "Purch. Rcpt. Line".Type::"G/L Account") and (COPYSTR("Purch. Rcpt. Line"."Gen. Prod. Posting Group", 1, 1) = '6')) then begin
            Gcode_CompteGénéral := '40800001';
            Gcode_CompteTVA := '44586100'
        end else
            if ("Purch. Rcpt. Line".Type = "Purch. Rcpt. Line".Type::"Fixed Asset") or (("Purch. Rcpt. Line".Type = "Purch. Rcpt. Line".Type::"G/L Account") and (COPYSTR("Purch. Rcpt. Line"."Gen. Prod. Posting Group", 1, 1) = '2')) then begin
                Gcode_CompteGénéral := '40840001';
                Gcode_CompteTVA := '44586400';
            end;

        //***************** Insertion ligne CREDIT *****************
        Grec_FeuilleComptaFNP.INIT();
        Gint_Ligne += 10000;
        Grec_FeuilleComptaFNP."Line No." := Gint_Ligne;
        Grec_FeuilleComptaFNP."Document No." := Gcode_NoFNP;
        Grec_FeuilleComptaFNP."External Document No." := PADSTR("Purch. Rcpt. Line"."Order No." + '-' + "Purch. Rcpt. Line"."Document No.", 20);
        Grec_FeuilleComptaFNP.VALIDATE("Source Code", Gcode_CodeJournal);
        Grec_FeuilleComptaFNP.VALIDATE("Account No.", Gcode_CompteGénéral);
        Grec_FeuilleComptaFNP.VALIDATE(Grec_FeuilleComptaFNP."Posting Date", Gdate_Compta);
        Grec_FeuilleComptaFNP.VALIDATE(Grec_FeuilleComptaFNP."Document Date", "Purch. Rcpt. Line"."Posting Date");
        Grec_FeuilleComptaFNP.VALIDATE("Credit Amount", Gdec_MontantTTC);
        if Grec_Fournisseur.GET("Purch. Rcpt. Line"."Buy-from Vendor No.") then
            Grec_FeuilleComptaFNP.Description := PADSTR(Grec_Fournisseur.Name + '-' + "Purch. Rcpt. Line".Description, 50);
        Grec_FeuilleComptaFNP."BC6_Vendor No." := "Purch. Rcpt. Line"."Buy-from Vendor No.";
        Grec_FeuilleComptaFNP.VALIDATE(Grec_FeuilleComptaFNP."Gen. Bus. Posting Group", '');
        Grec_FeuilleComptaFNP.VALIDATE(Grec_FeuilleComptaFNP."Gen. Prod. Posting Group", '');
        Grec_FeuilleComptaFNP.VALIDATE(Grec_FeuilleComptaFNP."VAT Bus. Posting Group", '');
        Grec_FeuilleComptaFNP.VALIDATE(Grec_FeuilleComptaFNP."VAT Prod. Posting Group", '');
        //  InsérérAnalytique();   Modification NAv 2015
        Grec_FeuilleComptaFNP."Dimension Set ID" := "Purch. Rcpt. Line"."Dimension Set ID";
        Grec_FeuilleComptaFNP.INSERT();

        //***************** Insertion ligne DEBIT *****************
        Gint_Ligne += 10000;
        Grec_FeuilleComptaFNP."Line No." := Gint_Ligne;
        Grec_FeuilleComptaFNP."Document No." := Gcode_NoFNP;
        Grec_FeuilleComptaFNP."External Document No." := PADSTR("Purch. Rcpt. Line"."Order No." + '-' + "Purch. Rcpt. Line"."Document No.", 20);
        Grec_FeuilleComptaFNP.VALIDATE("Source Code", Gcode_CodeJournal);
        Grec_FeuilleComptaFNP.VALIDATE("Account No.", "Purch. Rcpt. Line"."Gen. Prod. Posting Group");
        Grec_FeuilleComptaFNP.VALIDATE(Grec_FeuilleComptaFNP."Posting Date", Gdate_Compta);
        Grec_FeuilleComptaFNP.VALIDATE(Grec_FeuilleComptaFNP."Document Date", "Purch. Rcpt. Line"."Posting Date");
        Grec_FeuilleComptaFNP.VALIDATE("Debit Amount", Gdec_MontantHT);
        if Grec_Fournisseur.GET("Purch. Rcpt. Line"."Buy-from Vendor No.") then
            Grec_FeuilleComptaFNP.Description := PADSTR(Grec_Fournisseur.Name + '-' + "Purch. Rcpt. Line".Description, 50);
        Grec_FeuilleComptaFNP."BC6_Vendor No." := "Purch. Rcpt. Line"."Buy-from Vendor No.";
        Grec_FeuilleComptaFNP.VALIDATE(Grec_FeuilleComptaFNP."Gen. Bus. Posting Group", '');
        Grec_FeuilleComptaFNP.VALIDATE(Grec_FeuilleComptaFNP."Gen. Prod. Posting Group", '');
        Grec_FeuilleComptaFNP.VALIDATE(Grec_FeuilleComptaFNP."VAT Bus. Posting Group", '');
        Grec_FeuilleComptaFNP.VALIDATE(Grec_FeuilleComptaFNP."VAT Prod. Posting Group", '');
        //  InsérérAnalytique();   Modification NAv 2015
        Grec_FeuilleComptaFNP."Dimension Set ID" := "Purch. Rcpt. Line"."Dimension Set ID";
        Grec_FeuilleComptaFNP.INSERT();

        //***************** Insertion ligne TVA si montant non nul *****************
        if ((Gdec_MontantTTC - Gdec_MontantHT) <> 0) then begin
            Gint_Ligne += 10000;
            Grec_FeuilleComptaFNP."Line No." := Gint_Ligne;
            Grec_FeuilleComptaFNP."Document No." := Gcode_NoFNP;
            Grec_FeuilleComptaFNP."External Document No." := PADSTR("Purch. Rcpt. Line"."Order No." + '-' + "Purch. Rcpt. Line"."Document No.", 20);
            Grec_FeuilleComptaFNP.VALIDATE("Source Code", Gcode_CodeJournal);
            Grec_FeuilleComptaFNP.VALIDATE("Account No.", Gcode_CompteTVA);
            Grec_FeuilleComptaFNP.VALIDATE(Grec_FeuilleComptaFNP."Posting Date", Gdate_Compta);
            Grec_FeuilleComptaFNP.VALIDATE(Grec_FeuilleComptaFNP."Document Date", "Purch. Rcpt. Line"."Posting Date");
            Grec_FeuilleComptaFNP.VALIDATE("Debit Amount", Gdec_MontantTTC - Gdec_MontantHT);
            if Grec_Fournisseur.GET("Purch. Rcpt. Line"."Buy-from Vendor No.") then
                Grec_FeuilleComptaFNP.Description := PADSTR(Grec_Fournisseur.Name + '-' + "Purch. Rcpt. Line".Description, 50);
            Grec_FeuilleComptaFNP."BC6_Vendor No." := "Purch. Rcpt. Line"."Buy-from Vendor No.";
            Grec_FeuilleComptaFNP.VALIDATE(Grec_FeuilleComptaFNP."Gen. Bus. Posting Group", '');
            Grec_FeuilleComptaFNP.VALIDATE(Grec_FeuilleComptaFNP."Gen. Prod. Posting Group", '');
            Grec_FeuilleComptaFNP.VALIDATE(Grec_FeuilleComptaFNP."VAT Bus. Posting Group", '');
            Grec_FeuilleComptaFNP.VALIDATE(Grec_FeuilleComptaFNP."VAT Prod. Posting Group", '');
            //  InsérérAnalytique();   Modification NAv 2015
            Grec_FeuilleComptaFNP."Dimension Set ID" := "Purch. Rcpt. Line"."Dimension Set ID";
            Grec_FeuilleComptaFNP.INSERT();
        end;
        //Gcode_NoFNP := INCSTR(Gcode_NoFNP);
    end;
}
