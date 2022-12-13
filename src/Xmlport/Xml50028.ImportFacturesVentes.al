xmlport 50028 "BC6_Import Factures Ventes"
{
    Direction = Import;
    Format = VariableText;
    FieldSeparator = '[;]';
    UseRequestPage = false;
    FileName = '*.csv';
    Caption = 'Import Factures Ventes', Comment = 'FRA="Import Factures Ventes"';

    schema
    {
        textelement(Root)
        {
            tableelement(ImportFactureVente; Integer)
            {
                textelement(Gtext_Champ1) { }
                textelement(Gtext_Champ2) { }
                textelement(Gtext_Champ3) { }
                textelement(Gtext_Champ4) { }
                textelement(Gtext_Champ5) { }
                textelement(Gtext_Champ6) { }
                textelement(Gtext_Champ7) { }
                textelement(Gtext_Champ8) { }
                textelement(Gtext_Champ9) { }
                textelement(Gtext_Champ10) { }
                textelement(Gtext_Champ11) { }
                textelement(Gtext_Champ12) { }
                textelement(Gtext_Champ13) { }
                textelement(Gtext_Champ14) { }
                textelement(Gtext_Champ15) { }
                textelement(Gtext_Champ16) { }

                //SourceTable =2000000026;
                // AutoSave =No;
                // AutoUpdate =No;
                // AutoReplace =No;
                trigger OnBeforeInsertRecord()
                begin
                    Gint_Compteur += 1;//pour passer l'en tˆte du fichier
                    if Gint_Compteur = 1 then
                        currXMLport.SKIP();

                    // Gtext_CHAMP1];     //Soci‚t‚
                    // Gtext_CHAMP2];     //Nø client factur‚
                    // Gtext_CHAMP3];     //D‚signation ligne facture
                    // Gtext_CHAMP4];     //axe0
                    // Gtext_CHAMP5];     //axe1
                    // Gtext_CHAMP6];     //axe2
                    // Gtext_CHAMP7];     //axe3
                    // Gtext_CHAMP8];     //axe4
                    // Gtext_CHAMP9];     //axe5
                    // Gtext_CHAMP10];   //qt‚ ligne
                    // Gtext_CHAMP11];   //Nø compte g‚n‚ral
                    // Gtext_CHAMP12];   //Votre r‚f‚rence
                    // Gtext_CHAMP13];   //Nø doc externe
                    // Gtext_CHAMP14];   //Nø ligne

                    //V‚rification si le Nø client factur‚ existe bien sinon on importe pas le fichier
                    if not Grec_Customer.GET(Gtext_Champ2) then
                        ERROR(STRSUBSTNO(Text0001, Gtext_Champ2, Gint_Compteur));

                    //v‚rification si le champ "Votre r‚f‚rence" d‚passe 30 caractŠres
                    if STRLEN(Gtext_Champ12) > 30 then
                        ERROR(STRSUBSTNO(Text0004, Gint_Compteur));

                    //*****************************création de l'entˆte de facture***********************************
                    EVALUATE(Gint_NumLigne, COPYSTR(Gtext_Champ14, 1, (STRPOS(Gtext_Champ14, '_') - 1)));
                    Gtemporaire.RESET();
                    Gtemporaire.SETFILTER(Gtemporaire.Piece, FORMAT(Gint_NumLigne));
                    Gtemporaire.SETFILTER(Gtemporaire.Compte, '');

                    if not (Gtemporaire.FindFirst()) then begin //si la facture n'existe pas on la créer
                        //traitement pour avoir le numéro de facture
                        if Grec_LastNoSeriesLine.GET('VAP', 10000) then begin
                            Gcode_No := INCSTR(Grec_LastNoSeriesLine."Last No. Used");
                            Grec_LastNoSeriesLine."Last No. Used" := Gcode_No;
                        end;

                        Grec_SalesHeader.INIT();
                        Grec_SalesHeader.VALIDATE(Grec_SalesHeader."Document Type", Grec_SalesHeader."Document Type"::Invoice);
                        Grec_SalesHeader.VALIDATE(Grec_SalesHeader."No.", Gcode_No);
                        Grec_SalesHeader.INSERT(true);

                        Grec_SalesHeader.VALIDATE("Sell-to Customer No.", Gtext_Champ2);
                        Grec_SalesHeader."External Document No." := Gtext_Champ13;
                        Grec_SalesHeader.VALIDATE(Grec_SalesHeader."Document Date", TODAY);
                        Grec_SalesHeader."No. Series" := 'VAP';
                        Grec_SalesHeader."Your Reference" := "Gcu_ANSI-ASCII".Ansi2Ascii(Gtext_Champ12);
                        Grec_SalesHeader.MODIFY();

                        Grec_LastNoSeriesLine.MODIFY();

                        Gtemporaire.INIT();
                        Gtemporaire.Piece := Gint_NumLigne;
                        Gtemporaire.Compte := Gcode_No;
                        Gtemporaire.INSERT();

                    end else
                        Gcode_No := Gtemporaire.Compte;

                    //****************************insertion des lignes de la facture*********************************
                    //pour les lignes article : travail sur le N_ligne_facture
                    EVALUATE(Gint_LineNo, COPYSTR(Gtext_Champ14, (STRPOS(Gtext_Champ14, '_') + 1)));
                    Gint_LineNo := Gint_LineNo * 10000;
                    if Gtext_Champ10 = '' then
                        Gtext_Champ10 := '0';
                    if not EVALUATE(Gdecimal_Quantite, Gtext_Champ10) then
                        ERROR(Text0002);

                    //V‚rification du compte g‚n‚ral
                    if not Grec_GLAccount.GET(Gtext_Champ11) then
                        ERROR(STRSUBSTNO(Text0003, Gtext_Champ11));

                    Grec_SalesLines.INIT();
                    Grec_SalesLines.VALIDATE(Grec_SalesLines."Line No.", Gint_LineNo);
                    Grec_SalesLines."Document Type" := Grec_SalesLines."Document Type"::Invoice;
                    Grec_SalesLines."Document No." := Gcode_No;
                    Grec_SalesLines.VALIDATE(Grec_SalesLines.Type, Grec_SalesLines.Type::"G/L Account");
                    Grec_SalesLines.VALIDATE(Grec_SalesLines."No.", Gtext_Champ11);
                    Grec_SalesLines.Description := "Gcu_ANSI-ASCII".Ansi2Ascii(Gtext_Champ3);
                    Grec_SalesLines.VALIDATE(Grec_SalesLines.Quantity, Gdecimal_Quantite);
                    Grec_SalesLines."Unit Price" := 1;
                    Grec_SalesLines.VALIDATE(Grec_SalesLines."Unit of Measure Code", 'EUROS');
                    Grec_SalesLines.INSERT();

                    InsérerAnalytique();
                end;
            }
        }
    }

    var
        Gtemporaire: Record "BC6_Table temporaire" temporary;
        Grec_Customer: Record Customer;
        Grec_DimensionValue: Record "Dimension Value";
        Grec_GLAccount: Record "G/L Account";
        Grecord_GeneralLedgerSetup: Record "General Ledger Setup";
        Grec_NoSeries: Record "No. Series";
        Grec_LastNoSeriesLine: Record "No. Series Line";
        Grec_SalesHeader: Record "Sales Header";
        Grec_SalesLines: Record "Sales Line";
        "Gcu_ANSI-ASCII": Codeunit "BC6_ANSI_ASCII converter";
        Gbool_NoSoucheManuel: Boolean;
        Gcode_Axe: array[50] of Code[20];
        Gcode_No: Code[20];
        Gcode_Section: array[50] of Code[20];
        Gdecimal_Quantite: Decimal;
        Gint_Compteur: Integer;
        Gint_LineNo: Integer;
        Gint_NumLigne: Integer;
        i: Integer;
        Text0001: label 'The client "%1" does not exist row %2', Comment = 'FRA="Le client "%1" n''existe pas ligne %2"';
        Text0002: label 'Error converting quantity to decimal', Comment = 'FRA="Erreur sur la conversion de la quantité en decimal"';
        Text0003: label 'General account %1 does not exist', Comment = 'FRA="Le compte général %1 n''existe pas"';
        Text0004: label 'The Your reference field exceeds the 30 characters allowed line %1', Comment = 'FRA="Le champ Votre référence dépasse les 30 caractères autorisés ligne %1"';
        Text009: label 'The file has been imported successfully.', Comment = 'FRA="Le fichier a bien été importé."';
        Text013: label 'Error on line "%3" of file. \\ Code "%1" for analytical section "%2" does not exist.', Comment = 'FRA="Erreur sur la ligne "%3" du fichier.\\Le code "%1" pour la section analytique "%2" n''existe pas."';

    trigger OnInitXMLport()
    begin
        if (COMPANYNAME = 'HEXATOURISME') or (COMPANYNAME = 'HEXATOURISME - RECETTE') then
            ERROR('Ce développement n''est pas destiné à la société ' + COMPANYNAME);
        Gint_Compteur := 0;
        Gint_LineNo := 0;
    end;

    trigger OnPreXMLport()
    begin
        //bloquer la table Sales Header
        Grec_SalesHeader.LOCKTABLE();

        //Mettre le nø souche des facture vente en manuel
        if Grec_NoSeries.GET('VAP') then
            if not Grec_NoSeries."Manual Nos." then begin
                Gbool_NoSoucheManuel := false;
                Grec_NoSeries.VALIDATE(Grec_NoSeries."Manual Nos.", true);
                Grec_NoSeries.MODIFY();
            end else
                Gbool_NoSoucheManuel := true;

        //récupération des codes axe analytique
        if Grecord_GeneralLedgerSetup.FIND('-') then begin
            Gcode_Axe[1] := Grecord_GeneralLedgerSetup."Shortcut Dimension 3 Code";
            Gcode_Axe[2] := Grecord_GeneralLedgerSetup."Shortcut Dimension 4 Code";
            Gcode_Axe[3] := Grecord_GeneralLedgerSetup."Shortcut Dimension 5 Code";
            Gcode_Axe[4] := Grecord_GeneralLedgerSetup."Shortcut Dimension 6 Code";
            Gcode_Axe[5] := Grecord_GeneralLedgerSetup."Shortcut Dimension 7 Code";//inutile dans ce developpement
            Gcode_Axe[6] := Grecord_GeneralLedgerSetup."Shortcut Dimension 8 Code";
            Gcode_Axe[7] := Grecord_GeneralLedgerSetup."BC6_Shortcut Dimension 9 Code";
            Gcode_Axe[8] := Grecord_GeneralLedgerSetup."BC6_Shortcut Dimension 10 Code";
        end;

        Gtemporaire.DELETEALL();
    end;

    trigger OnPostXMLport()
    begin
        //Enlever, le nø souche des factures de ventes en manuel
        if Grec_NoSeries.GET('VAP') then
            if not Gbool_NoSoucheManuel then begin
                Grec_NoSeries.VALIDATE(Grec_NoSeries."Manual Nos.", false);
                Grec_NoSeries.MODIFY();
            end;

        MESSAGE(Text009);
    end;

    procedure "InsérerAnalytique"();
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        //Insertion des axes en rapport avec le fichier
        CLEAR(Gcode_Section);
        Gcode_Section[1] := Gtext_Champ4;
        Gcode_Section[2] := Gtext_Champ5;
        Gcode_Section[3] := Gtext_Champ6;
        Gcode_Section[4] := Gtext_Champ7;
        Gcode_Section[5] := Gtext_Champ8;
        Gcode_Section[6] := Gtext_Champ9;
        Gcode_Section[7] := Gtext_Champ15;
        Gcode_Section[8] := Gtext_Champ16;

        for i := 1 to 8 do begin
            //test si le code analytique existe
            if Gcode_Section[i] <> '' then
                if not Grec_DimensionValue.GET(Gcode_Axe[i], Gcode_Section[i]) then
                    ERROR(STRSUBSTNO(Text013, Gcode_Section[i], Gcode_Axe[i], Gint_Compteur));
            //Correction aprŠs lecture du fichier Excel si des 0 sont manquants lors d'une mise … jour par l'utilisateur.
            if Gcode_Axe[i] = 'PERIODE' then
                if STRLEN(Gcode_Section[i]) = 3 then
                    Gcode_Section[i] := '0' + Gcode_Section[i]
                else
                    if STRLEN(Gcode_Section[i]) = 2 then
                        Gcode_Section[i] := '00' + Gcode_Section[i]
                    else
                        if STRLEN(Gcode_Section[i]) = 1 then
                            Gcode_Section[i] := '000' + Gcode_Section[i];
            //Fin correction
        end;

        // Ajout des sections et attribuation dimension set id
        Grec_SalesLines."Dimension Set ID" := BC6_FunctMgt.SetNewDimIDSpec(Grec_SalesLines."Dimension Set ID", Grec_SalesLines."Shortcut Dimension 1 Code",
                                     Grec_SalesLines."Shortcut Dimension 2 Code", Gcode_Axe, Gcode_Section);
        Grec_SalesLines.MODIFY();
    end;
}
