xmlport 50027 "BC6_Import BC Masse Presta"
{
    Direction = Import;
    Format = VariableText;
    FieldSeparator = ';';
    UseRequestPage = false;
    FileName = '*.csv';
    Caption = 'Import BC Masse Presta';
    schema
    {
        textelement(Root)
        {
            tableelement(ImportBCMassePresta; Integer)
            {
                AutoSave = false;
                AutoUpdate = false;
                AutoReplace = false;
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
                textelement(Gtext_Champ23)
                {
                }
                textelement(Gtext_Champ24)
                {
                }
                textelement(Gtext_Champ25)
                {
                }
                textelement(Gtext_Champ26)
                {
                }
                textelement(Gtext_Champ27)
                {
                }
                textelement(Gtext_Champ28)
                {
                }
                trigger OnBeforeInsertRecord()
                BEGIN
                    Gint_Compteur += 1;//pour passer l'en tˆte du fichier
                    IF Gint_Compteur = 1 THEN
                        currXMLport.SKIP();

                    IF Vend.GET(Gtext_Champ1) THEN BEGIN
                        //Creation de l'entˆte de commande
                        CLEAR(Grec_PurchaseHeader);
                        Grec_PurchaseHeader.INIT();
                        Grec_PurchaseHeader.VALIDATE("Document Type", Grec_PurchaseHeader."Document Type"::Order);
                        Grec_PurchaseHeader.VALIDATE("No.");
                        Grec_PurchaseHeader.VALIDATE("Buy-from Vendor No.", Gtext_Champ1);
                        Grec_PurchaseHeader."Your Reference" := COPYSTR(Gtext_Champ2, 1, 30);
                        Grec_PurchaseHeader."BC6_Matricule No." := Gtext_Champ3;
                        Grec_PurchaseHeader."BC6_Import Vendor Email" := Gtext_Champ28;//Modif JX-AUD du 17/06/2013
                        Grec_PurchaseHeader.INSERT(TRUE);

                        Grec_PurchaseHeader.VALIDATE("Posting Date", TODAY);
                        Grec_PurchaseHeader."Assigned User ID" := Gtext_Champ6;
                        Grec_PurchaseHeader.MODIFY();

                        //Cr‚ation de la ligne de commande
                        //Cl‚ primaire: Document Type,Document No.,Line No.
                        CLEAR(Grec_PurchaseLines);
                        Grec_PurchaseLines."Document Type" := Grec_PurchaseHeader."Document Type"::Order;
                        Grec_PurchaseLines."Document No." := Grec_PurchaseHeader."No.";
                        EVALUATE(Grec_PurchaseLines.Type, Gtext_Champ7);
                        Grec_PurchaseLines."Line No." := 10000;
                        Grec_PurchaseLines.VALIDATE("No.", Gtext_Champ8);
                        Grec_PurchaseLines.Description := COPYSTR(Gtext_Champ9, 1, 50);
                        EVALUATE(Grec_PurchaseLines.Quantity, Gtext_Champ10);
                        Grec_PurchaseLines.VALIDATE(Quantity);
                        EVALUATE(Grec_PurchaseLines."Direct Unit Cost", Gtext_Champ11);
                        Grec_PurchaseLines.VALIDATE("Direct Unit Cost");
                        Grec_PurchaseLines."BC6_Matricule No." := Gtext_Champ3;
                        Grec_PurchaseLines.INSERT(TRUE);

                        //Insertion des axes analytiques pour la ligne
                        InsérerAnalytique();

                        //Cr‚ation du contrat de la commande
                        CLEAR(Grec_Matricule);
                        //CLEAR(Grec_Contract);
                        IF NOT Grec_Matricule.GET(Grec_PurchaseHeader."BC6_Matricule No.") THEN BEGIN
                            Grec_Matricule.INIT();
                            Grec_Matricule."Matricule No." := Grec_PurchaseHeader."BC6_Matricule No.";
                            Grec_Matricule.INSERT();
                            //  ERROR(STRSUBSTNO(Text014,Grec_PurchaseHeader."Matricule No."))
                        END;
                        //  ELSE BEGIN
                        //     IF NOT Grec_Contract.GET(Grec_PurchaseHeader."No.") THEN BEGIN
                        //         Grec_Contract."BC6 Initial quote No" := Grec_PurchaseHeader."No.";
                        //         Grec_Contract."BC6 Order No." := Grec_PurchaseHeader."No.";
                        //         Grec_Contract."BC6 User" := Grec_PurchaseHeader."Assigned User ID";
                        //         Grec_Contract."BC6 Speaking VSCT" := Grec_PurchaseHeader."Assigned User ID";
                        //         Grec_Contract."BC6 Speaking supplier" := Gtext_Champ17;
                        //         Grec_Contract."BC6 Nom prestataire" := Grec_Matricule."BC6 Provider name";
                        //         Grec_Contract."BC6 Prénom prestataire" := Grec_Matricule."BC6 Provider first name";
                        //         //EVALUATE(Grec_Contract."Date of entry",FORMAT('01' + DELSTR(Gtext_Champ12,1,2) + DELSTR(Gtext_Champ12,3)));;
                        //         //Grec_Contract."End date" := CALCDATE('<CM>', Grec_Contract."Date of entry");
                        //         EVALUATE(Grec_Contract."BC6 Date of entry", Gtext_Champ18);
                        //         EVALUATE(Grec_Contract."BC6 End date", Gtext_Champ19);
                        //         Grec_Contract."BC6 Description1" := COPYSTR(Gtext_Champ20, 1, 250);
                        //         Grec_Contract."BC6 Description2" := COPYSTR(Gtext_Champ21, 1, 250);
                        //         Grec_Contract."BC6 Description3" := COPYSTR(Gtext_Champ22, 1, 250);
                        //         Grec_Contract."BC6 Description4" := COPYSTR(Gtext_Champ23, 1, 250);
                        //         Grec_Contract."BC6 Description5" := COPYSTR(Gtext_Champ24, 1, 250);
                        //         Grec_Contract."BC6 Description6" := COPYSTR(Gtext_Champ25, 1, 250);
                        //         Grec_Contract."BC6 Description7" := COPYSTR(Gtext_Champ26, 1, 250);
                        //         Grec_Contract."BC6 Description8" := COPYSTR(Gtext_Champ27, 1, 250);
                        //         Grec_Contract.INSERT;

                        //         Gcu_ContractManagement.AutoInit(Grec_PurchaseHeader."No.");
                        //     END;
                        // END;

                        //Modif JX-AUD du 17/06/2013
                        Grec_PurchaseHeader."BC6_Import" := TRUE;
                        Grec_PurchaseHeader.MODIFY();
                        //Fin Modif JX-AUD du 17/06/2013
                    END;
                    lu += 1;
                END;
            }


        }
    }
    VAR
        //Grec_Contract: Record "BC6 Contract";
        Grec_Matricule: Record "BC6_Matricule";
        Grec_DimensionValue: Record "Dimension Value";
        Grecord_GeneralLedgerSetup: Record "General Ledger Setup";
        Grec_PurchaseHeader: Record "Purchase Header";
        Grec_PurchaseLines: Record "Purchase Line";
        Vend: Record Vendor;
        Gcode_Axe: ARRAY[50] OF Code[20];
        Gcode_Section: ARRAY[50] OF Code[20];
        Gint_Compteur: Integer;
        i: Integer;
        lu: Integer;
        Text009: Label 'The file has been imported.', Comment = 'FRA="Le fichier a bien été importé."';
        Text010: Label 'This processing only concerns the companies VSCT and VSC', Comment = 'FRA="Ce traitement ne concerne que les sociétés VSCT et VSC"';
        Text013: Label 'Error on line "%3" for command "%4". \\ Code "%1" for analytical section "%2" does not exist.', Comment = 'FRA="Erreur sur la ligne "%3" pour la commande"%4".\\Le code "%1" pour la section analytique "%2" n''existe pas."';

    trigger OnInitXMLport()
    BEGIN
        IF (COMPANYNAME <> 'VSCT') AND (COMPANYNAME <> 'VSC') THEN

            //IF (COMPANYNAME <> 'VSCT') AND (COMPANYNAME <> 'VSC') AND (COMPANYNAME <> 'VSCT Copy For Cl“ture 2018') THEN

            ERROR(Text010);
        Gint_Compteur := 0;
    END;

    trigger OnPreXMLport()
    BEGIN
        //bloquer la table Purchase Header
        Grec_PurchaseHeader.LOCKTABLE();

        //r‚cup‚ration des codes axe analytique
        IF Grecord_GeneralLedgerSetup.FIND('-') THEN BEGIN
            Gcode_Axe[1] := Grecord_GeneralLedgerSetup."Shortcut Dimension 3 Code";//PERIODE
            Gcode_Axe[2] := Grecord_GeneralLedgerSetup."Shortcut Dimension 4 Code";//ORGANISATION
            Gcode_Axe[3] := Grecord_GeneralLedgerSetup."Shortcut Dimension 5 Code";//CLIENT
            Gcode_Axe[4] := Grecord_GeneralLedgerSetup."Shortcut Dimension 6 Code";//PRODUIT
            Gcode_Axe[5] := Grecord_GeneralLedgerSetup."Shortcut Dimension 8 Code";//INTRAGROUPE
        END;
    END;

    trigger OnPostXMLport()
    BEGIN
        MESSAGE(Text009);
    END;

    PROCEDURE "InsérerAnalytique"();
    VAR
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    BEGIN
        //Insertion des axes en rapport avec le fichier
        CLEAR(Gcode_Section);
        Gcode_Section[1] := Gtext_Champ12;
        Gcode_Section[2] := Gtext_Champ13;
        Gcode_Section[3] := Gtext_Champ14;
        Gcode_Section[4] := Gtext_Champ15;
        Gcode_Section[5] := Gtext_Champ16;

        FOR i := 1 TO 5 DO BEGIN
            //test si le code analytique existe
            IF NOT Grec_DimensionValue.GET(Gcode_Axe[i], Gcode_Section[i]) THEN
                ERROR(STRSUBSTNO(Text013, Gcode_Section[i], Gcode_Axe[i], Grec_PurchaseLines."Line No.", Grec_PurchaseHeader."No."));
            //Correction aprŠs lecture du fichier Excel si des 0 sont manquants lors d'une mise … jour par l'utilisateur.
            IF Gcode_Axe[i] = 'PERIODE' THEN
                case STRLEN(Gcode_Section[i]) of
                    3:
                        Gcode_Section[i] := '0' + Gcode_Section[i];
                    2:
                        Gcode_Section[i] := '00' + Gcode_Section[i];
                    1:
                        Gcode_Section[i] := '000' + Gcode_Section[i];
                end;
            //Fin correction
        END;
        // Ajout des sections et attribuation dimension set id
        Grec_PurchaseLines."Dimension Set ID" := BC6_FunctMgt.SetNewDimIDSpec(Grec_PurchaseLines."Dimension Set ID", Grec_PurchaseLines."Shortcut Dimension 1 Code",
                                     Grec_PurchaseLines."Shortcut Dimension 2 Code", Gcode_Axe, Gcode_Section);
        Grec_PurchaseLines.MODIFY();
    END;



}
