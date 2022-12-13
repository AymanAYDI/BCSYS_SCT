xmlport 50018 "BC6_Import OD Paye"
{
    Caption = 'Import OD Paye', Comment = 'FRA="Import OD Paye"';
    Format = VariableText;
    FieldDelimiter = '<None>';
    FieldSeparator = '[;]';
    UseRequestPage = false;
    FileName = '*.csv';
    schema
    {
        textelement(Root)
        {
            tableelement(ODPaye; Integer)
            {
                AutoSave = false;
                AutoUpdate = false;
                AutoReplace = false;
                trigger OnBeforeInsertRecord()
                begin
                    Gint_Compteur += 1;//pour passer l'en tˆte du fichier
                    if Gint_Compteur > 1 then begin

                        //incr‚mentation du num‚ro de ligne
                        Gint_LineNo := Gint_LineNo + 10000;

                        //initialisation de la ligne
                        Grec_FeuilleODPaie.INIT();
                        Grec_FeuilleODPaie."Journal Template Name" := Gcode_JournalTemplateName;
                        Grec_FeuilleODPaie."Journal Batch Name" := Gcode_JournalBatchName;
                        Grec_FeuilleODPaie."Source Code" := 'COMPTA';
                        Grec_FeuilleODPaie."Line No." := Gint_LineNo;
                        Grec_FeuilleODPaie."Document No." := Gcode_ODPaie;
                        Grec_FeuilleODPaie.VALIDATE("Document No.", Gcode_ODPaie);

                        //champ 1: date
                        if EVALUATE(Gdate_PostingDate, Gtext_Champ1) then
                            Grec_FeuilleODPaie.VALIDATE("Posting Date", Gdate_PostingDate);

                        //champ 5: type document
                        //*******Grec_FeuilleODPaie."Document Type" := Grec_FeuilleODPaie."Document Type"::Gtext_Champ5;*****//
                        if (Gtext_Champ5 <> '') and (Gtext_Champ5 <> ' ') then
                            case LOWERCASE(Gcu_Converter.Ansi2Ascii(Gtext_Champ5)) of
                                'paiement':
                                    Grec_FeuilleODPaie.VALIDATE("Document Type", Grec_FeuilleODPaie."Document Type"::Payment);
                                'facture':
                                    Grec_FeuilleODPaie.VALIDATE("Document Type", Grec_FeuilleODPaie."Document Type"::Invoice);
                                'avoir':
                                    Grec_FeuilleODPaie.VALIDATE("Document Type", Grec_FeuilleODPaie."Document Type"::"Credit Memo");
                                'intérêt':
                                    Grec_FeuilleODPaie.VALIDATE("Document Type", Grec_FeuilleODPaie."Document Type"::"Finance Charge Memo");
                                'relance':
                                    Grec_FeuilleODPaie.VALIDATE("Document Type", Grec_FeuilleODPaie."Document Type"::Reminder);
                                'remboursement':
                                    Grec_FeuilleODPaie.VALIDATE("Document Type", Grec_FeuilleODPaie."Document Type"::Refund);
                                else
                                    ERROR('Le Type Document %1 n''existe pas, erreur sur la ligne %2 ', Gcu_Converter.Ansi2Ascii(Gtext_Champ5), Gint_Compteur);
                            end;

                        //champ 10: nøcompte
                        if EVALUATE(Gcode_AccountNo, Gtext_Champ10) then

                            //champ 6: type compte et champ 10: nøcompte
                            case LOWERCASE(Gcu_Converter.Ansi2Ascii(Gtext_Champ6)) of
                                'général':
                                    begin
                                        //Grec_FeuilleODPaie."Account Type" := Grec_FeuilleODPaie."Account Type"::"G/L Account";
                                        Grec_FeuilleODPaie.VALIDATE("Account Type", Grec_FeuilleODPaie."Account Type"::"G/L Account");
                                        if Grec_Account.GET(Gcode_AccountNo) then
                                            Grec_FeuilleODPaie.VALIDATE("Account No.", Gcode_AccountNo)
                                        else
                                            ERROR(Text003 + ' Général ' + Text004, Gcode_AccountNo, Gint_Compteur);
                                    end;
                                'client':
                                    begin
                                        //Grec_FeuilleODPaie."Account Type" := Grec_FeuilleODPaie."Account Type"::Customer;
                                        Grec_FeuilleODPaie.VALIDATE("Account Type", Grec_FeuilleODPaie."Account Type"::Customer);
                                        if Grec_Customer.GET(Gcode_AccountNo) then
                                            Grec_FeuilleODPaie.VALIDATE("Account No.", Gcode_AccountNo)
                                        else
                                            ERROR(Text003 + ' Client ' + Text004, Gcode_AccountNo, Gint_Compteur);
                                    end;
                                'fournisseur':
                                    begin
                                        //Grec_FeuilleODPaie."Account Type" := Grec_FeuilleODPaie."Account Type"::Vendor;
                                        Grec_FeuilleODPaie.VALIDATE("Account Type", Grec_FeuilleODPaie."Account Type"::Vendor);
                                        if Grec_Fournisseur.GET(Gcode_AccountNo) then
                                            Grec_FeuilleODPaie.VALIDATE("Account No.", Gcode_AccountNo)
                                        else
                                            ERROR(Text003 + ' Fournisseur ' + Text004, Gcode_AccountNo, Gint_Compteur);
                                    end;
                                'banque':
                                    begin
                                        //Grec_FeuilleODPaie."Account Type" := Grec_FeuilleODPaie."Account Type"::"Bank Account";
                                        Grec_FeuilleODPaie.VALIDATE("Account Type", Grec_FeuilleODPaie."Account Type"::"Bank Account");
                                        if Grec_Banque.GET(Gcode_AccountNo) then
                                            Grec_FeuilleODPaie.VALIDATE("Account No.", Gcode_AccountNo)
                                        else
                                            ERROR(Text003 + ' Banque ' + Text004, Gcode_AccountNo, Gint_Compteur);
                                    end;
                                'immobilisation':
                                    begin
                                        //Grec_FeuilleODPaie."Account Type" := Grec_FeuilleODPaie."Account Type"::"Fixed Asset";
                                        Grec_FeuilleODPaie.VALIDATE("Account Type", Grec_FeuilleODPaie."Account Type"::"Fixed Asset");
                                        if Grec_Immo.GET(Gcode_AccountNo) then
                                            Grec_FeuilleODPaie.VALIDATE("Account No.", Gcode_AccountNo)
                                        else
                                            ERROR(Text003 + ' Immobilisation ' + Text004, Gcode_AccountNo, Gint_Compteur);
                                    end;
                                'partenaire ic':
                                    begin
                                        //Grec_FeuilleODPaie."Account Type" := Grec_FeuilleODPaie."Account Type"::"IC Partner";
                                        Grec_FeuilleODPaie.VALIDATE("Account Type", Grec_FeuilleODPaie."Account Type"::"IC Partner");
                                        if Grec_PartenaireIC.GET(Gcode_AccountNo) then
                                            Grec_FeuilleODPaie.VALIDATE("Account No.", Gcode_AccountNo)
                                        else
                                            ERROR(Text003 + ' Partenaire IC ' + Text004, Gcode_AccountNo, Gint_Compteur);
                                    end;
                                else
                                    ERROR(Text005, Gcu_Converter.Ansi2Ascii(Gtext_Champ6), Gint_Compteur);
                            end;

                        //champ 7: nøclient
                        if Gtext_Champ7 <> '' then
                            if Grec_Customer.GET(Gtext_Champ7) then
                                Grec_FeuilleODPaie.VALIDATE("BC6_Customer No.", Gtext_Champ7)
                            else
                                ERROR('Le compte client n° %1 n''existe pas, erreur ligne n° %2 du fichier', Gtext_Champ7, Gint_Compteur);


                        //champ 8: nøfournisseur
                        if Gtext_Champ8 <> '' then
                            if Grec_Fournisseur.GET(Gtext_Champ8) then
                                Grec_FeuilleODPaie.VALIDATE("BC6_Vendor No.", Gtext_Champ8)
                            else
                                ERROR('Le compte fournisseur n° %1 n''existe pas, erreur ligne n° %2 du fichier', Gtext_Champ8, Gint_Compteur);


                        //champ 9: journal

                        //champ 17: lib‚ll‚
                        Grec_FeuilleODPaie.VALIDATE(Description, Gcu_Converter.Ansi2Ascii(Gtext_Champ17));

                        //MODIF JX-AUD 06/04/2011

                        //champ 18: sens et champ 19: montant
                        // IF EVALUATE(varDecimal, Gtext_Champ19) AND (Gtext_Champ18 = 'C')THEN BEGIN
                        //  Gdec_CreditAmount := varDecimal;
                        //   Grec_FeuilleODPaie.VALIDATE("Credit Amount",Gdec_CreditAmount);
                        // END;

                        // IF EVALUATE(varDecimal, Gtext_Champ19) AND (Gtext_Champ18 = 'D')THEN BEGIN
                        //    Gdec_DebitAmount := varDecimal;
                        //    Grec_FeuilleODPaie.VALIDATE("Debit Amount",Gdec_DebitAmount);
                        // END;

                        // JX-ABE-13/12/2016-Ajout : External Document No
                        //champ 22: External Document No
                        if EVALUATE(Gcode_ExternalDocumentNo, Gtext_Champ22) then
                            Grec_FeuilleODPaie.VALIDATE("External Document No.", Gcode_ExternalDocumentNo);
                        // JX-ABE-13/12/2016-Fin Ajout

                        //champ 19: Credit
                        if Gtext_Champ19 <> '' then
                            if EVALUATE(varDecimal, Gtext_Champ19) then begin
                                Gdec_CreditAmount := varDecimal;
                                Grec_FeuilleODPaie.VALIDATE(Grec_FeuilleODPaie."Credit Amount", Gdec_CreditAmount);
                            end;

                        // champ 18: Debit
                        if Gtext_Champ18 <> '' then
                            if EVALUATE(varDecimal1, Gtext_Champ18) then begin
                                Gdec_DebitAmount := varDecimal1;
                                Grec_FeuilleODPaie.VALIDATE(Grec_FeuilleODPaie."Debit Amount", Gdec_DebitAmount);
                            end;
                        //FINMODIF JX-AUD 06/04/2011

                        //champ 2: type compta.TVA
                        //*******Grec_FeuilleODPaie."Gen. Posting Type" := Grec_FeuilleODPaie."Gen. Posting Type"::Gtext_Champ2;****//
                        if Gtext_Champ2 <> '' then
                            case LOWERCASE(Gcu_Converter.Ansi2Ascii(Gtext_Champ2)) of
                                'achat':

                                    Grec_FeuilleODPaie.VALIDATE("Gen. Posting Type", Grec_FeuilleODPaie."Gen. Posting Type"::Purchase);
                                'vente':

                                    Grec_FeuilleODPaie.VALIDATE("Gen. Posting Type", Grec_FeuilleODPaie."Gen. Posting Type"::Sale);
                                'règlement':

                                    Grec_FeuilleODPaie.VALIDATE("Gen. Posting Type", Grec_FeuilleODPaie."Gen. Posting Type"::Settlement);
                                else
                                    ERROR('Le Type Document %1 n''existe pas, erreur sur la ligne %2 ', Gcu_Converter.Ansi2Ascii(Gtext_Champ5), Gint_Compteur);
                            end;

                        //champ 3: groupe compta. march‚
                        //**********Grec_FeuilleODPaie.VALIDATE("Gen. Bus. Posting Group",Gcu_Converter.Ansi2Ascii(Gtext_Champ3));******//
                        Gtext_ComptaM := Gcu_Converter.Ansi2Ascii(Gtext_Champ3);
                        if Gtext_ComptaM <> '' then
                            if Grec_GComptaMarche.GET(Gtext_ComptaM) then
                                Grec_FeuilleODPaie.VALIDATE("Gen. Bus. Posting Group", Gtext_ComptaM)
                            else
                                ERROR('Le Groupe compta. marché n° %1 n''existe pas, erreur ligne n° %2 du fichier', Gtext_ComptaM, Gint_Compteur);

                        //champ 4: groupe compta. produit
                        //***********Grec_FeuilleODPaie.VALIDATE("Gen. Prod. Posting Group",Gcu_Converter.Ansi2Ascii(Gtext_Champ4));*****//
                        Gtext_ComptaP := Gcu_Converter.Ansi2Ascii(Gtext_Champ4);
                        if Gtext_ComptaP <> '' then
                            if Grec_GComptaProduit.GET(Gtext_ComptaP) then
                                Grec_FeuilleODPaie.VALIDATE("Gen. Prod. Posting Group", Gtext_ComptaP)
                            else
                                ERROR('Le Groupe compta. produit n° %1 n''existe pas, erreur ligne n° %2 du fichier', Gtext_ComptaP, Gint_Compteur);

                        //insertion ligne
                        Grec_FeuilleODPaie.INSERT();

                        //appel fonction ins‚r‚r analytique
                        InsrerAnalytique();
                    end;
                    currXMLport.SKIP();
                end;
            }
            textelement(Gtext_Champ1)
            {
            }
            textelement(Gtext_Champ2)
            {
            }
            textelement(Gtext_Champ3)
            {
            }
            textelement(Gtext_Champ4)
            {
            }
            textelement(Gtext_Champ5)
            {
            }
            textelement(Gtext_Champ6)
            {
            }
            textelement(Gtext_Champ7)
            {
            }
            textelement(Gtext_Champ8)
            {
            }
            textelement(Gtext_Champ9)
            {
            }
            textelement(Gtext_Champ10)
            {
            }
            textelement(Gtext_Champ11)
            {
            }
            textelement(Gtext_Champ12)
            {
            }
            textelement(Gtext_Champ13)
            {
            }
            textelement(Gtext_Champ14)
            {
            }
            textelement(Gtext_Champ15)
            {
            }
            textelement(Gtext_Champ16)
            {
            }
            textelement(Gtext_Champ17)
            {
            }
            textelement(Gtext_Champ18)
            {
            }
            textelement(Gtext_Champ19)
            {
            }
            textelement(Gtext_Champ20)
            {
            }
            textelement(Gtext_Champ21)
            {
            }
            textelement(Gtext_Champ22)
            {
            }
        }
    }
    var
        Grec_Banque: Record "Bank Account";
        Grec_Company: Record Company;
        Grec_CompanyInfo: Record "Company Information";
        Grec_Customer: Record Customer;
        Grec_Dimension: Record Dimension;
        Grec_DimValue: Record "Dimension Value";
        Grec_Immo: Record "Fixed Asset";
        Grec_Account: Record "G/L Account";
        Grec_GComptaMarche: Record "Gen. Business Posting Group";
        Grec_GenJnlBatch: Record "Gen. Journal Batch";
        Grec_FeuilleODPaie: Record "Gen. Journal Line";
        Grec_GComptaProduit: Record "Gen. Product Posting Group";
        Grecord_GeneralLedgerSetup: Record "General Ledger Setup";
        Grec_PartenaireIC: Record "IC Partner";
        Grec_Fournisseur: Record Vendor;
        Gcu_Converter: Codeunit "BC6_ANSI_ASCII converter";
        Gcode_ODPaie: Code[14];
        Gcode_AccountNo: Code[20];
        Gcode_Axe: array[8] of Code[20];
        Gcode_JournalBatchName: Code[20];
        Gcode_JournalTemplateName: Code[20];
        Gcode_ExternalDocumentNo: Code[35];
        Gdate_PostingDate: Date;
        Gdec_CreditAmount: Decimal;
        Gdec_DebitAmount: Decimal;
        varDecimal: Decimal;
        varDecimal1: Decimal;
        Gint_Compteur: Integer;
        Gint_LineNo: Integer;
        i: Integer;
        Text001: label 'This fonction is not destinated for the current sheet', Comment = 'FRA="Cette fonction n''est pas destinée pour la feuille en cours"';
        Text002: label 'This sheet is not empty. Please open a new sheet', Comment = 'FRA="Cette feuille n''est pas vide. Veuillez ouvrir une nouvelle feuille"';
        Text003: label '"Account No. %1 does not exist for Account Type: "', Comment = 'FRA="Le compte N° %1 n'' existe pas pour le Type Compte : "';
        Text004: label 'at line no. %2 of file', Comment = 'FRA="à la ligne n° %2 du fichier"';
        Text005: label 'The Account Type %1 does not exist, error on line no. %2', Comment = 'FRA="Le Type Compte %1 n'' existe pas, erreur sur la ligne n° %2"';
        Gtext_ComptaM: Text[30];
        Gtext_ComptaP: Text[30];

    trigger OnInitXMLport()
    begin
        Gint_Compteur := 0;
        Gint_LineNo := 0;
        Grec_CompanyInfo.GET();
    end;

    trigger OnPreXMLport()
    begin
        Grec_Company.RESET();
        Grec_FeuilleODPaie.SETRANGE("Journal Template Name", Grec_FeuilleODPaie."Journal Template Name");
        Grec_FeuilleODPaie.SETRANGE("Journal Batch Name", Grec_FeuilleODPaie."Journal Batch Name");
        Gcode_ODPaie := Grec_FeuilleODPaie."Document No.";
        //Gcode_JournalTemplateName := 'GNRAL';
        //Gcode_JournalBatchName := 'ODPAIE';
        Gcode_JournalTemplateName := Grec_FeuilleODPaie."Journal Template Name";
        Gcode_JournalBatchName := Grec_FeuilleODPaie."Journal Batch Name";

        //r‚cup‚ration des codes axe analytique
        if Grecord_GeneralLedgerSetup.FIND('-') then begin
            Gcode_Axe[1] := Grecord_GeneralLedgerSetup."Shortcut Dimension 3 Code";
            Gcode_Axe[2] := Grecord_GeneralLedgerSetup."Shortcut Dimension 4 Code";
            Gcode_Axe[3] := Grecord_GeneralLedgerSetup."Shortcut Dimension 5 Code";
            Gcode_Axe[4] := Grecord_GeneralLedgerSetup."Shortcut Dimension 6 Code";
            Gcode_Axe[5] := Grecord_GeneralLedgerSetup."Shortcut Dimension 7 Code";
            Gcode_Axe[6] := Grecord_GeneralLedgerSetup."Shortcut Dimension 8 Code";
            Gcode_Axe[7] := Grecord_GeneralLedgerSetup."BC6_Shortcut Dimension 9 Code";
            Gcode_Axe[8] := Grecord_GeneralLedgerSetup."BC6_Shortcut Dimension 10 Code";
        end;
        if Grec_GenJnlBatch.GET(Grec_FeuilleODPaie."Journal Template Name", Grec_FeuilleODPaie."Journal Batch Name") then
            if Grec_GenJnlBatch."No. Series" <> 'ODPAIE' then
                ERROR(Text001);
        if (Grec_FeuilleODPaie.COUNT > 0) then
            ERROR(Text002);
    end;

    procedure SetODPaieJnlLine(FeuilleODPaie: Record "Gen. Journal Line");
    begin
        Grec_FeuilleODPaie := FeuilleODPaie;
    end;

    procedure "InsrerAnalytique"();
    var
        Lcu_Dimension: Codeunit "BC6_FunctionsMgt";
        LCode_DimCode: array[50] of Code[20];
        LCode_DimValueCode: array[50] of Code[20];
        j: Integer;
        ValeurChamps: Text;
    begin
        CLEAR(LCode_DimCode);
        CLEAR(LCode_DimValueCode);
        j := 0;

        for i := 1 to 8 do begin
            case i of
                1:
                    ValeurChamps := Gtext_Champ11;
                2:
                    ValeurChamps := Gtext_Champ12;
                3:
                    ValeurChamps := Gtext_Champ13;
                4:
                    ValeurChamps := Gtext_Champ14;
                5:
                    ValeurChamps := Gtext_Champ15;
                6:
                    ValeurChamps := Gtext_Champ16;
                7:
                    ValeurChamps := Gtext_Champ20;
                8:
                    ValeurChamps := Gtext_Champ21;
            end;
            if (Grec_Dimension.GET(Gcode_Axe[i])) and (ValeurChamps <> '') then begin
                if Grec_Dimension.Code = 'PERIODE' then
                    if STRLEN(ValeurChamps) = 3 then
                        ValeurChamps := '0' + ValeurChamps
                    else
                        if STRLEN(ValeurChamps) = 2 then
                            ValeurChamps := '00' + ValeurChamps
                        else
                            if STRLEN(ValeurChamps) = 1 then
                                ValeurChamps := '000' + ValeurChamps;
                if not Grec_DimValue.GET(Grec_Dimension.Code, ValeurChamps) then
                    ERROR('Section analytique %1 inconnue pour l''axe %2', ValeurChamps, Grec_Dimension.Code);
                j += 1;
                LCode_DimCode[j] := Grec_Dimension.Code;
                LCode_DimValueCode[j] := ValeurChamps;
                Grec_FeuilleODPaie."Dimension Set ID" := Lcu_Dimension.SetNewDimIDSpec(Grec_FeuilleODPaie."Dimension Set ID", Grec_FeuilleODPaie."Shortcut Dimension 1 Code",
                                         Grec_FeuilleODPaie."Shortcut Dimension 2 Code", LCode_DimCode, LCode_DimValueCode);
                Grec_FeuilleODPaie.MODIFY();
            end;
        end;
    end;
}
