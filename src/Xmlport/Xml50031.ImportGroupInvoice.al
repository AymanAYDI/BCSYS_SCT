xmlport 50031 "BC6_Import Group Invoice"
{
    Caption = 'Import Group Invoice';
    Format = VariableText;
    FieldSeparator = ';';
    UseRequestPage = false;
    FileName = '*.csv';
    Permissions = TableData "G/L Entry" = rm,
                TableData "Gen. Journal Template" = imd,
                TableData "Gen. Journal Batch" = imd,
                TableData "Dimension Set Entry" = rim,
                TableData "Dimension Set Tree Node" = rim;
    Direction = Import;
    schema
    {
        textelement(Root)
        {
            tableelement(ImportGroupInvoice; Integer)
            {
                AutoSave = false;
                AutoUpdate = false;
                AutoReplace = false;
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
                textelement(Gtext_Champ17) { }
                textelement(Gtext_Champ18) { }
                textelement(Gtext_Champ19) { }
                textelement(Gtext_Champ20) { }
                textelement(Gtext_Champ21) { }
                textelement(Gtext_Champ22) { }
                textelement(Gtext_Champ23) { }
                textelement(Gtext_Champ24) { }
                textelement(Gtext_Champ25) { }
                textelement(Gtext_Champ26) { }
                textelement(Gtext_Champ27) { }
                textelement(Gtext_Champ28) { }
                textelement(Gtext_Champ29) { }
                textelement(Gtext_Champ30) { }
                textelement(Gtext_Champ31) { }
                textelement(Gtext_Champ32) { }
                textelement(Gtext_Champ33) { }
                textelement(Gtext_Champ34) { }
                textelement(Gtext_Champ35) { }
                textelement(Gtext_Champ36) { }
                textelement(Gtext_Champ37) { }
                trigger OnBeforeInsertRecord()
                BEGIN
                    Gint_Compteur += 1;//pour passer l'en tˆte du fichier
                    IF Gint_Compteur = 1 THEN
                        currXMLport.SKIP();

                    //Insertion des enregistrements dans la table "Import Invoice Group"

                    //Colonnes A-->N insertion facture vente

                    //test si tous les champs sont vident partie ventes
                    IF NOT ((Gtext_Champ1 = '') AND
                      (Gtext_Champ2 = '') AND
                      (Gtext_Champ3 = '') AND
                      (Gtext_Champ4 = '') AND
                      (Gtext_Champ5 = '') AND
                      (Gtext_Champ6 = '') AND
                      (Gtext_Champ7 = '') AND
                      (Gtext_Champ8 = '') AND
                      (Gtext_Champ9 = '') AND
                      (Gtext_Champ10 = '') AND
                      (Gtext_Champ11 = '') AND
                      (Gtext_Champ12 = '') AND
                      (Gtext_Champ13 = ''))
                      THEN BEGIN
                        Grec_ImportInvoiceGroup.INIT();
                        Grec_ImportInvoiceGroup."BC6 Invoice type" := Grec_ImportInvoiceGroup."BC6 Invoice type"::Sale;
                        Grec_ImportInvoiceGroup."BC6 Society code" := Gtext_Champ1;
                        Grec_ImportInvoiceGroup."BC6 Line No." := Gtext_Champ14;
                        Grec_ImportInvoiceGroup."BC6 Cus. Vend. No." := Gtext_Champ2;
                        EVALUATE(Grec_ImportInvoiceGroup."BC6 Posting date", FORMAT(TODAY));
                        EVALUATE(Grec_ImportInvoiceGroup."BC6 Document date", FORMAT(TODAY));
                        Grec_ImportInvoiceGroup."BC6 Assigned user ID" := USERID;
                        Grec_ImportInvoiceGroup."BC6 Your reference" := "Gcu_ANSI-ASCII".Ansi2Ascii(Gtext_Champ12);
                        Grec_ImportInvoiceGroup."BC6 External doc. No." := Gtext_Champ13;
                        Grec_ImportInvoiceGroup."BC6 Invoice No." := '';
                        Grec_ImportInvoiceGroup."BC6 Line type" := Grec_ImportInvoiceGroup."BC6 Line type"::"G/L Account";
                        Grec_ImportInvoiceGroup."BC6 Account No." := Gtext_Champ11;
                        Grec_ImportInvoiceGroup."BC6 Designation" := "Gcu_ANSI-ASCII".Ansi2Ascii(Gtext_Champ3);
                        EVALUATE(Grec_ImportInvoiceGroup."BC6 Quantity", Gtext_Champ10);
                        Grec_ImportInvoiceGroup."BC6 Axe 0" := Gtext_Champ4;
                        Grec_ImportInvoiceGroup."BC6 Axe 1" := Gtext_Champ5;
                        Grec_ImportInvoiceGroup."BC6 Axe 2" := Gtext_Champ6;
                        Grec_ImportInvoiceGroup."BC6 Axe 3" := Gtext_Champ7;
                        Grec_ImportInvoiceGroup."BC6 Axe 4" := Gtext_Champ8;
                        Grec_ImportInvoiceGroup."BC6 Axe 5" := Gtext_Champ9;
                        //
                        Grec_ImportInvoiceGroup."BC6 Axe 6" := Gtext_Champ36;
                        Grec_ImportInvoiceGroup."BC6 Axe 7" := Gtext_Champ37;
                        Grec_ImportInvoiceGroup.INSERT();
                    END;

                    //Colonnes P-->AH insertion partie achat
                    IF NOT ((Gtext_Champ16 = '') AND
                      (Gtext_Champ17 = '') AND
                      (Gtext_Champ18 = '') AND
                      (Gtext_Champ19 = '') AND
                      (Gtext_Champ20 = '') AND
                      (Gtext_Champ21 = '') AND
                      (Gtext_Champ22 = '') AND
                      (Gtext_Champ23 = '') AND
                      (Gtext_Champ24 = '') AND
                      (Gtext_Champ25 = '') AND
                      (Gtext_Champ26 = '') AND
                      (Gtext_Champ27 = '') AND
                      (Gtext_Champ28 = '') AND
                      (Gtext_Champ29 = '') AND
                      (Gtext_Champ30 = '') AND
                      (Gtext_Champ31 = '') AND
                      (Gtext_Champ32 = '') AND
                      (Gtext_Champ33 = '') AND
                      (Gtext_Champ35 = ''))
                       THEN BEGIN
                        Grec_ImportInvoiceGroup.INIT();
                        Grec_ImportInvoiceGroup."BC6 Invoice type" := Grec_ImportInvoiceGroup."BC6 Invoice type"::Purchase;
                        Grec_ImportInvoiceGroup."BC6 Society code" := Gtext_Champ16;
                        Grec_ImportInvoiceGroup."BC6 Line No." := Gtext_Champ34;
                        Grec_ImportInvoiceGroup."BC6 Cus. Vend. No." := Gtext_Champ17;
                        EVALUATE(Grec_ImportInvoiceGroup."BC6 Posting date", Gtext_Champ18);
                        EVALUATE(Grec_ImportInvoiceGroup."BC6 Document date", Gtext_Champ19);
                        Grec_ImportInvoiceGroup."BC6 Assigned user ID" := Gtext_Champ21;
                        Grec_ImportInvoiceGroup."BC6 Your reference" := "Gcu_ANSI-ASCII".Ansi2Ascii(Gtext_Champ32);
                        Grec_ImportInvoiceGroup."BC6 External doc. No." := '';
                        Grec_ImportInvoiceGroup."BC6 Invoice No." := Gtext_Champ33;
                        Grec_ImportInvoiceGroup."BC6 Line type" := Grec_ImportInvoiceGroup."BC6 Line type"::"G/L Account";
                        Grec_ImportInvoiceGroup."BC6 Account No." := Gtext_Champ23;
                        Grec_ImportInvoiceGroup."BC6 Designation" := "Gcu_ANSI-ASCII".Ansi2Ascii(Gtext_Champ24);
                        EVALUATE(Grec_ImportInvoiceGroup."BC6 Quantity", Gtext_Champ31);
                        Grec_ImportInvoiceGroup."BC6 Axe 0" := Gtext_Champ25;
                        Grec_ImportInvoiceGroup."BC6 Axe 1" := Gtext_Champ26;
                        Grec_ImportInvoiceGroup."BC6 Axe 2" := Gtext_Champ27;
                        Grec_ImportInvoiceGroup."BC6 Axe 3" := Gtext_Champ28;
                        Grec_ImportInvoiceGroup."BC6 Axe 4" := Gtext_Champ29;
                        Grec_ImportInvoiceGroup."BC6 Axe 5" := Gtext_Champ30;
                        //
                        Grec_ImportInvoiceGroup."BC6 Axe 6" := Gtext_Champ36;
                        Grec_ImportInvoiceGroup."BC6 Axe 7" := Gtext_Champ37;
                        //
                        Grec_ImportInvoiceGroup."BC6 Gen. Prod. Posting Group" := Gtext_Champ35;
                        Grec_ImportInvoiceGroup.INSERT();
                    END;
                END;
            }
        }
    }

    trigger OnPreXMLport()
    BEGIN
        Grec_ImportInvoiceGroup.DELETEALL();
    END;

    trigger OnPostXMLport()
    BEGIN
        CreateInvoice();
    END;

    VAR
        Grec_ImportInvoiceGroup: Record "BC6_Import Group Invoice";
        Grec_DimensionValue: Record "Dimension Value";
        Grecord_GeneralLedgerSetup: Record "General Ledger Setup";
        Grec_NoSeries: Record "No. Series";
        Grec_LastNoSeriesLine: Record "No. Series Line";
        Grec_PurchaseHeader: Record "Purchase Header";
        Grec_PurchaseLine: Record "Purchase Line";
        Grec_SalesHeader: Record "Sales Header";
        Grec_SalesLines: Record "Sales Line";
        "Gcu_ANSI-ASCII": Codeunit "BC6_ANSI_ASCII converter";
        EventsMgt: Codeunit BC6_EventsMgt;
        Debug: Boolean;
        Gcode_PurchaseInvoiceNoSeries: Code[10];
        Gcode_SaleInvoiceNoSeries: Code[10];
        Gcode_Axe: ARRAY[50] OF Code[20];
        Gcode_No: Code[20];
        Gcode_Section: ARRAY[50] OF Code[20];
        GLSetupShortcutDimCode: ARRAY[50] OF Code[20];
        Gint_Compteur: Integer;
        Gint_LineNo: Integer;
        i: Integer;
        Text002: Label 'This Shortcut Dimension is not defined in the %1.', Comment = 'FRA="Ce racourci axe n''est pas défini dans les %1."';
        Text003: Label '%1 is not an available %2 for that dimension.', Comment = 'FRA="%1 : %2 n''est pas un %3 disponible pour l''axe analytique %4."';
        Text013: Label 'The code "%1" for the analytical section "%2" (Axis %6) does not exist for the company %3 (Import Line No. %4, Imported Qty %5)', Comment = 'FRA="Le code "%1" pour la section analytique "%2" (Axe %6) n''existe pas pour la société %3 (N° Ligne Import %4, Qté Importée %5)"';
        Text014: Label '%1 %2 is blocked.', Comment = 'FRA="%1 %2 est bloqué."';
        Text015: Label '%1 %2 can''t be found.', Comment = 'FRA="%1 %2 ne peut être trouvé."';
        Text016: Label '%1 %2 - %3 is blocked.', Comment = 'FRA="%1 %2 - %3 est bloqué."';
        Text017: Label '%1 for %2 %3 - %4 must not be %5.', Comment = 'FRA="%1 pour %2 %3 - %4 ne doit as être %5."';
        Text018: Label '%1 for %2 is missing.', Comment = 'FRA="%1 pour %2 est manquant."';
        Gtext_Company: Text[30];
        DimErr: Text[250];

    PROCEDURE CreateInvoice();
    BEGIN
        Gcode_SaleInvoiceNoSeries := '';
        Gcode_PurchaseInvoiceNoSeries := '';
        Debug := FALSE;

        //lecture des lignes de la table Grec_ImportInvoiceGroup
        IF Grec_ImportInvoiceGroup.FIND('-') THEN
            REPEAT

                //Travail sur le nom de la soci‚t‚ + souche nø
                CASE Grec_ImportInvoiceGroup."BC6 Society code" OF
                    'VSCG':
                        BEGIN
                            Gtext_Company := 'VFEC';
                            Gcode_SaleInvoiceNoSeries := 'VAP';
                            Gcode_PurchaseInvoiceNoSeries := 'PI';
                        END;
                    'AGVSC':
                        BEGIN
                            Gtext_Company := 'Agence';
                            Gcode_SaleInvoiceNoSeries := 'VAP';
                            Gcode_PurchaseInvoiceNoSeries := 'PI';
                        END;
                    'VSC':
                        BEGIN
                            Gtext_Company := 'VSC';
                            Gcode_SaleInvoiceNoSeries := 'VAP';
                            Gcode_PurchaseInvoiceNoSeries := 'PI';
                        END;
                    'VSCT':
                        BEGIN
                            Gtext_Company := 'VSCT';
                            Gcode_SaleInvoiceNoSeries := 'VAP';
                            Gcode_PurchaseInvoiceNoSeries := 'PI';
                        END;
                    ELSE
                        ERROR('Ce code société ' + Grec_ImportInvoiceGroup."BC6 Society code" + ' est à paramétrer dans le code ');
                END;

                //changement de société sur les différentes tables
                Grec_NoSeries.CHANGECOMPANY(Gtext_Company);
                Grec_LastNoSeriesLine.CHANGECOMPANY(Gtext_Company);
                Grec_SalesHeader.CHANGECOMPANY(Gtext_Company);
                EventsMgt.SetCompany_SalesHeader(Gtext_Company);
                Grec_SalesLines.CHANGECOMPANY(Gtext_Company);
                Grec_SalesLines.SetCompany(Gtext_Company);
                Grec_PurchaseHeader.CHANGECOMPANY(Gtext_Company);
                EventsMgt.SetCompany_PurchaseHeader(Gtext_Company);
                Grec_PurchaseLine.CHANGECOMPANY(Gtext_Company);
                Grec_PurchaseLine.SetCompany(Gtext_Company);
                Grecord_GeneralLedgerSetup.CHANGECOMPANY(Gtext_Company);
                Grec_DimensionValue.CHANGECOMPANY(Gtext_Company);
                RecuperationAxeSociete();
                //Travail sur le num‚ro de la ligne
                EVALUATE(Gint_LineNo, COPYSTR(Grec_ImportInvoiceGroup."BC6 Line No.", (STRPOS(Grec_ImportInvoiceGroup."BC6 Line No.", '_') + 1)));
                Gint_LineNo := Gint_LineNo * 10000;

                CASE Grec_ImportInvoiceGroup."BC6 Invoice type" OF
                    Grec_ImportInvoiceGroup."BC6 Invoice type"::Purchase:  //Traitement d'une facture achat
                        BEGIN
                            //entˆte
                            IF Gint_LineNo = 10000 THEN BEGIN
                                ActivateNoSeries(Gcode_PurchaseInvoiceNoSeries);
                                GetLastNoSeries(Gcode_PurchaseInvoiceNoSeries);//Avoir le num‚ro de facture
                                InsertHeaderPurchaseInvoice(Grec_ImportInvoiceGroup);
                                InsertLinePurchaseInvoice(Grec_ImportInvoiceGroup, Gcode_No, Gint_LineNo);
                                DeactivateNoSeries(Gcode_PurchaseInvoiceNoSeries);
                            END ELSE
                                //lignes
                                InsertLinePurchaseInvoice(Grec_ImportInvoiceGroup, Gcode_No, Gint_LineNo);
                            ValidateLastNoSeries(Gcode_No);//Validation du num‚ro de facture si tout est bon
                        END;
                    Grec_ImportInvoiceGroup."BC6 Invoice type"::Sale: //Traitement d'une facture vente
                        BEGIN
                            //entˆte
                            IF Gint_LineNo = 10000 THEN BEGIN
                                ActivateNoSeries(Gcode_SaleInvoiceNoSeries);
                                GetLastNoSeries(Gcode_SaleInvoiceNoSeries);//Avoir le  num‚ro de facture
                                InsertHeaderSalesInvoice(Grec_ImportInvoiceGroup);
                                InsertLineSalesInvoice(Grec_ImportInvoiceGroup, Gcode_No, Gint_LineNo);
                                DeactivateNoSeries(Gcode_SaleInvoiceNoSeries);
                            END ELSE
                                //lignes
                                InsertLineSalesInvoice(Grec_ImportInvoiceGroup, Gcode_No, Gint_LineNo);
                            ValidateLastNoSeries(Gcode_No);//Validation du num‚ro de facture si tout est bon
                        END;
                END;
            //  Debug := FALSE;
            UNTIL Grec_ImportInvoiceGroup.NEXT() = 0;

        MESSAGE('Traitement terminé');
        //Grec_ImportInvoiceGroup.DELETEALL;
    END;

    PROCEDURE InsertHeaderPurchaseInvoice(Gloc_ImportInvoiceGroup: Record "BC6_Import Group Invoice");
    BEGIN
        //Pour des soucis de traitement on active temporairement la souche de nø manuel sur la soci‚t‚ en cours
        Grec_NoSeries.CHANGECOMPANY(COMPANYNAME);
        ActivateNoSeries(Gcode_PurchaseInvoiceNoSeries);

        Grec_PurchaseHeader.LOCKTABLE();
        Grec_PurchaseHeader.INIT();
        Grec_PurchaseHeader.VALIDATE(Grec_PurchaseHeader."Document Type", Grec_PurchaseHeader."Document Type"::Invoice);
        Grec_PurchaseHeader.VALIDATE(Grec_PurchaseHeader."No.", Gcode_No);
        Grec_PurchaseHeader.INSERT(TRUE);

        //on desactive ensuite cette souche sur la soci‚t‚ en cours
        DeactivateNoSeries(Gcode_PurchaseInvoiceNoSeries);
        Grec_NoSeries.CHANGECOMPANY(Gtext_Company);//on se remet sur la soci‚t‚ … int‚grer les factures

        Grec_PurchaseHeader.VALIDATE(Grec_PurchaseHeader."Buy-from Vendor No.", Gloc_ImportInvoiceGroup."BC6 Cus. Vend. No.");
        Grec_PurchaseHeader.VALIDATE(Grec_PurchaseHeader."Posting Date", Gloc_ImportInvoiceGroup."BC6 Posting date");
        Grec_PurchaseHeader.VALIDATE(Grec_PurchaseHeader."Document Date", Gloc_ImportInvoiceGroup."BC6 Document date");
        Grec_PurchaseHeader."No. Series" := Gcode_PurchaseInvoiceNoSeries;
        Grec_PurchaseHeader."Your Reference" := Gloc_ImportInvoiceGroup."BC6 Your reference";
        Grec_PurchaseHeader."Assigned User ID" := Gloc_ImportInvoiceGroup."BC6 Assigned user ID";
        Grec_PurchaseHeader."BC6_Original user" := Gloc_ImportInvoiceGroup."BC6 Assigned user ID";
        Grec_PurchaseHeader."BC6_Creation date" := TODAY;
        Grec_PurchaseHeader."Vendor Invoice No." := Gloc_ImportInvoiceGroup."BC6 Invoice No.";
        Grec_PurchaseHeader.MODIFY();

        IF Debug THEN
            MESSAGE('Achat %1 %2 %3 %4', Gtext_Company, Grec_PurchaseHeader."Document Type", Grec_PurchaseHeader."No.", Grec_PurchaseHeader."Buy-from Vendor No.");
    END;

    PROCEDURE InsertLinePurchaseInvoice(Gloc_ImportInvoiceGroup: Record "BC6_Import Group Invoice"; Gloc_NumInvoice: Code[10]; Gloc_NumLigne: Integer);
    BEGIN
        IF Grec_PurchaseHeader.GET(Grec_PurchaseHeader."Document Type"::Invoice, Gcode_No) THEN BEGIN
            Grec_PurchaseLine.INIT();
            Grec_PurchaseLine.VALIDATE("Line No.", Gloc_NumLigne);
            Grec_PurchaseLine."Document Type" := Grec_PurchaseLine."Document Type"::Invoice;
            Grec_PurchaseLine.VALIDATE("Document No.", Grec_PurchaseHeader."No.");
            Grec_PurchaseLine.VALIDATE(Type, Gloc_ImportInvoiceGroup."BC6 Line type");
            Grec_PurchaseLine.VALIDATE("No.", Gloc_ImportInvoiceGroup."BC6 Account No.");
            Grec_PurchaseLine.VALIDATE("Gen. Prod. Posting Group", Gloc_ImportInvoiceGroup."BC6 Gen. Prod. Posting Group");
            Grec_PurchaseLine.Description := Gloc_ImportInvoiceGroup."BC6 Designation";
            Grec_PurchaseLine.VALIDATE(Quantity, Gloc_ImportInvoiceGroup."BC6 Quantity");
            Grec_PurchaseLine.VALIDATE(Grec_PurchaseLine."Direct Unit Cost", 1);
            Grec_PurchaseLine.VALIDATE("Unit of Measure Code", 'EUROS');
            Grec_PurchaseLine.INSERT();
        END;

        InsérerAnalytiqueAchat(Grec_ImportInvoiceGroup."BC6 Axe 0", Grec_ImportInvoiceGroup."BC6 Axe 1", Grec_ImportInvoiceGroup."BC6 Axe 2"
                               , Grec_ImportInvoiceGroup."BC6 Axe 3", Grec_ImportInvoiceGroup."BC6 Axe 4", Grec_ImportInvoiceGroup."BC6 Axe 5"
                               , Grec_ImportInvoiceGroup."BC6 Axe 6", Grec_ImportInvoiceGroup."BC6 Axe 7");

        IF Debug THEN
            MESSAGE('Achat %1', Grec_PurchaseLine."Dimension Set ID");
    END;

    PROCEDURE InsertHeaderSalesInvoice(Gloc_ImportInvoiceGroup: Record "BC6_Import Group Invoice");
    BEGIN
        //Pour des soucis de traitement on active temporairement la souche de nø manuel sur la soci‚t‚ en cours
        Grec_NoSeries.CHANGECOMPANY(COMPANYNAME);
        ActivateNoSeries(Gcode_SaleInvoiceNoSeries);

        Grec_SalesHeader.LOCKTABLE();
        Grec_SalesHeader.INIT();
        Grec_SalesHeader.VALIDATE(Grec_SalesHeader."Document Type", Grec_SalesHeader."Document Type"::Invoice);
        Grec_SalesHeader.VALIDATE(Grec_SalesHeader."No.", Gcode_No);
        Grec_SalesHeader.INSERT(TRUE);

        //on desactive ensuite cette souche sur la soci‚t‚ en cours
        DeactivateNoSeries(Gcode_SaleInvoiceNoSeries);
        Grec_NoSeries.CHANGECOMPANY(Gtext_Company);//on se remet sur la soci‚t‚ … int‚grer les factures

        Grec_SalesHeader.VALIDATE(Grec_SalesHeader."Sell-to Customer No.", Gloc_ImportInvoiceGroup."BC6 Cus. Vend. No.");
        Grec_SalesHeader."External Document No." := Gloc_ImportInvoiceGroup."BC6 External doc. No.";
        Grec_SalesHeader.VALIDATE(Grec_SalesHeader."Posting Date", TODAY);
        Grec_SalesHeader.VALIDATE(Grec_SalesHeader."Document Date", TODAY);
        Grec_SalesHeader."No. Series" := Gcode_SaleInvoiceNoSeries;
        Grec_SalesHeader."Your Reference" := Gloc_ImportInvoiceGroup."BC6 Your reference";
        Grec_SalesHeader."Assigned User ID" := Gloc_ImportInvoiceGroup."BC6 Assigned user ID";
        Grec_SalesHeader.MODIFY();

        IF Debug THEN
            MESSAGE('Vente %1 %2 %3 %4', Gtext_Company, Grec_SalesHeader."Document Type", Grec_SalesHeader."No.", Grec_SalesHeader."Sell-to Customer No.");
    END;

    PROCEDURE InsertLineSalesInvoice(Gloc_ImportInvoiceGroup: Record "BC6_Import Group Invoice"; Gloc_NumInvoice: Code[10]; Gloc_NumLigne: Integer);
    BEGIN
        //Grec_SalesLines.CHANGECOMPANY(GTEXT_COMPANY);
        IF Grec_SalesHeader.GET(Grec_SalesHeader."Document Type"::Invoice, Gcode_No) THEN BEGIN
            Grec_SalesLines.INIT();
            Grec_SalesLines.VALIDATE("Line No.", Gloc_NumLigne);
            Grec_SalesLines."Document Type" := Grec_SalesLines."Document Type"::Invoice;
            Grec_SalesLines.VALIDATE("Document No.", Grec_SalesHeader."No.");
            Grec_SalesLines.VALIDATE(Type, Gloc_ImportInvoiceGroup."BC6 Line type");
            Grec_SalesLines.VALIDATE("No.", Gloc_ImportInvoiceGroup."BC6 Account No.");
            Grec_SalesLines.Description := Gloc_ImportInvoiceGroup."BC6 Designation";
            Grec_SalesLines.VALIDATE(Quantity, Gloc_ImportInvoiceGroup."BC6 Quantity");
            Grec_SalesLines.VALIDATE("Unit Price", 1);
            Grec_SalesLines.VALIDATE("Unit of Measure Code", 'EUROS');
            Grec_SalesLines.INSERT();
        END;

        InsérerAnalytiqueVentes(Grec_ImportInvoiceGroup."BC6 Axe 0", Grec_ImportInvoiceGroup."BC6 Axe 1", Grec_ImportInvoiceGroup."BC6 Axe 2"
                                , Grec_ImportInvoiceGroup."BC6 Axe 3", Grec_ImportInvoiceGroup."BC6 Axe 4", Grec_ImportInvoiceGroup."BC6 Axe 5"
                                , Grec_ImportInvoiceGroup."BC6 Axe 6", Grec_ImportInvoiceGroup."BC6 Axe 7");

        IF Debug THEN
            MESSAGE('Vente %1', Grec_SalesLines."Dimension Set ID");
    END;

    PROCEDURE GetLastNoSeries(NoSeriesName: Text[30]);
    BEGIN
        //traitement pour avoir le num‚ro de facture
        IF Grec_LastNoSeriesLine.GET(NoSeriesName, 10000) THEN
            Gcode_No := INCSTR(Grec_LastNoSeriesLine."Last No. Used");
    END;

    PROCEDURE ValidateLastNoSeries(Gcode_NoV: Code[10]);
    BEGIN
        Grec_LastNoSeriesLine."Last No. Used" := Gcode_NoV;
        Grec_LastNoSeriesLine.MODIFY();
    END;

    PROCEDURE ActivateNoSeries(NoSeriesName: Text[30]);
    BEGIN
        //Mettre le nø souche des facture vente ou achat en manuel de la soci‚t‚
        IF Grec_NoSeries.GET(NoSeriesName) THEN
            IF NOT Grec_NoSeries."Manual Nos." THEN BEGIN
                Grec_NoSeries.VALIDATE(Grec_NoSeries."Manual Nos.", TRUE);
                Grec_NoSeries.MODIFY();
            END;
    END;

    PROCEDURE DeactivateNoSeries(NoSeriesName: Text[30]);
    BEGIN
        //Enlever, le nø souche des facture vente ou achat en manuel de la soci‚t‚
        IF Grec_NoSeries.GET(NoSeriesName) THEN BEGIN
            Grec_NoSeries.VALIDATE(Grec_NoSeries."Manual Nos.", FALSE);
            Grec_NoSeries.MODIFY();
        END;
    END;

    PROCEDURE RecuperationAxeSociete();
    BEGIN
        //r‚cup‚ration des codes axe analytique
        IF Grecord_GeneralLedgerSetup.FIND('-') THEN BEGIN
            Gcode_Axe[1] := Grecord_GeneralLedgerSetup."Shortcut Dimension 3 Code"; //Axe 0
            Gcode_Axe[2] := Grecord_GeneralLedgerSetup."Shortcut Dimension 4 Code"; //Axe 1
            Gcode_Axe[3] := Grecord_GeneralLedgerSetup."Shortcut Dimension 5 Code"; //Axe 2
            Gcode_Axe[4] := Grecord_GeneralLedgerSetup."Shortcut Dimension 6 Code"; //Axe 3
            Gcode_Axe[5] := Grecord_GeneralLedgerSetup."Shortcut Dimension 7 Code"; //Axe 4
            Gcode_Axe[6] := Grecord_GeneralLedgerSetup."Shortcut Dimension 8 Code"; //Axe 5
            Gcode_Axe[7] := Grecord_GeneralLedgerSetup."BC6_Shortcut Dimension 9 Code"; //Axe 6
            Gcode_Axe[8] := Grecord_GeneralLedgerSetup."BC6_Shortcut Dimension 10 Code"; //Axe 7
        END;
    END;

    LOCAL PROCEDURE "InsérerAnalytiqueVentes"(Section1: Code[20]; Section2: Code[20]; Section3: Code[20]; Section4: Code[20]; Section5: Code[20]; Section6: Code[20]; Section7: Code[20]; Section8: Code[20]);
    BEGIN
        //Insertion des axes en rapport avec le fichier
        CLEAR(Gcode_Section);
        Gcode_Section[1] := Section1;
        Gcode_Section[2] := Section2;
        Gcode_Section[3] := Section3;
        Gcode_Section[4] := Section4;
        Gcode_Section[5] := Section5;
        Gcode_Section[6] := Section6;
        Gcode_Section[7] := Section7;
        Gcode_Section[8] := Section8;

        Grec_SalesLines."Dimension Set ID" := 0;
        FOR i := 1 TO 8 DO
            //test si le code analytique existe
            IF (Gcode_Section[i] <> '') AND (Gcode_Axe[i] <> '') THEN BEGIN
                IF NOT Grec_DimensionValue.GET(Gcode_Axe[i], Gcode_Section[i]) THEN
                    ERROR(STRSUBSTNO(Text013, Gcode_Section[i], Gcode_Axe[i], Gtext_Company, Grec_ImportInvoiceGroup."BC6 Line No.", Grec_ImportInvoiceGroup."BC6 Quantity", i));
                //Correction aprŠs lecture du fichier Excel si des 0 sont manquants lors d'une mise … jour par l'utilisateur.
                IF Gcode_Axe[i] = 'PERIODE' THEN
                    IF STRLEN(Gcode_Section[i]) = 3 THEN
                        Gcode_Section[i] := '0' + Gcode_Section[i]
                    ELSE
                        IF STRLEN(Gcode_Section[i]) = 2 THEN
                            Gcode_Section[i] := '00' + Gcode_Section[i]
                        ELSE
                            IF STRLEN(Gcode_Section[i]) = 1 THEN
                                Gcode_Section[i] := '000' + Gcode_Section[i];
                //Fin correction
                // Migration Nav 2015
                ValidateShortcutDimValues(i + 2, Gcode_Section[i], Grec_SalesLines."Dimension Set ID");
            END;

        Grec_SalesLines.MODIFY();
    END;

    PROCEDURE "InsérerAnalytiqueAchat"(Section1: Code[20]; Section2: Code[20]; Section3: Code[20]; Section4: Code[20]; Section5: Code[20]; Section6: Code[20]; Section7: Code[20]; Section8: Code[20]);
    VAR
        Lcu_Dimension: Codeunit DimensionManagement;
    BEGIN
        //Insertion des axes en rapport avec le fichier
        CLEAR(Gcode_Section);
        Gcode_Section[1] := Section1;
        Gcode_Section[2] := Section2;
        Gcode_Section[3] := Section3;
        Gcode_Section[4] := Section4;
        Gcode_Section[5] := Section5;
        Gcode_Section[6] := Section6;
        Gcode_Section[7] := Section7;
        Gcode_Section[8] := Section8;

        Grec_PurchaseLine."Dimension Set ID" := 0;
        FOR i := 1 TO 8 DO
            //test si le code analytique existe
            IF (Gcode_Section[i] <> '') AND (Gcode_Axe[i] <> '') THEN BEGIN
                IF NOT Grec_DimensionValue.GET(Gcode_Axe[i], Gcode_Section[i]) THEN
                    ERROR(STRSUBSTNO(Text013, Gcode_Section[i], Gcode_Axe[i], Gtext_Company, Grec_ImportInvoiceGroup."BC6 Line No.", Grec_ImportInvoiceGroup."BC6 Quantity", i));
                //Correction aprŠs lecture du fichier Excel si des 0 sont manquants lors d'une mise … jour par l'utilisateur.
                IF Gcode_Axe[i] = 'PERIODE' THEN
                    IF STRLEN(Gcode_Section[i]) = 3 THEN
                        Gcode_Section[i] := '0' + Gcode_Section[i]
                    ELSE
                        IF STRLEN(Gcode_Section[i]) = 2 THEN
                            Gcode_Section[i] := '00' + Gcode_Section[i]
                        ELSE
                            IF STRLEN(Gcode_Section[i]) = 1 THEN
                                Gcode_Section[i] := '000' + Gcode_Section[i];
                //Fin correction
                // Migration Nav 2015
                ValidateShortcutDimValues(i + 2, Gcode_Section[i], Grec_PurchaseLine."Dimension Set ID");
            END;

        Grec_PurchaseLine.MODIFY();
    END;

    PROCEDURE ValidateDimValueCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20]);
    VAR
        DimVal: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
    BEGIN
        // Migration Nav 2015 : Fonction copi‚e … partir du codeunit 408
        // Ajout du changecompany sur la variable locale
        DimVal.CHANGECOMPANY(Gtext_Company);
        GLSetup.CHANGECOMPANY(Gtext_Company);

        // --> Code fonction d'origine
        GLSetup.GET();
        GLSetupShortcutDimCode[1] := GLSetup."Shortcut Dimension 1 Code";
        GLSetupShortcutDimCode[2] := GLSetup."Shortcut Dimension 2 Code";
        GLSetupShortcutDimCode[3] := GLSetup."Shortcut Dimension 3 Code";
        GLSetupShortcutDimCode[4] := GLSetup."Shortcut Dimension 4 Code";
        GLSetupShortcutDimCode[5] := GLSetup."Shortcut Dimension 5 Code";
        GLSetupShortcutDimCode[6] := GLSetup."Shortcut Dimension 6 Code";
        GLSetupShortcutDimCode[7] := GLSetup."Shortcut Dimension 7 Code";
        GLSetupShortcutDimCode[8] := GLSetup."Shortcut Dimension 8 Code";
        GLSetupShortcutDimCode[9] := GLSetup."BC6_Shortcut Dimension 9 Code";
        GLSetupShortcutDimCode[10] := GLSetup."BC6_Shortcut Dimension 10 Code";

        IF (GLSetupShortcutDimCode[FieldNumber] = '') AND (ShortcutDimCode <> '') THEN
            ERROR(Text002, GLSetup.TABLECAPTION);
        DimVal.SETRANGE("Dimension Code", GLSetupShortcutDimCode[FieldNumber]);
        IF ShortcutDimCode <> '' THEN BEGIN
            DimVal.SETRANGE(Code, ShortcutDimCode);
            IF NOT DimVal.FINDFIRST() THEN BEGIN
                DimVal.SETFILTER(Code, STRSUBSTNO('%1*', ShortcutDimCode));
                IF DimVal.FINDFIRST() THEN
                    ShortcutDimCode := DimVal.Code
                ELSE
                    ERROR(
                      STRSUBSTNO(Text003, COMPANYNAME,
                        ShortcutDimCode, DimVal.FIELDCAPTION(Code), GLSetupShortcutDimCode[FieldNumber]));
            END;
        END;
    END;

    PROCEDURE ValidateShortcutDimValues(FieldNumber: Integer; VAR ShortcutDimCode: Code[20]; VAR DimSetID: Integer);
    VAR
        TempDimSetEntry: Record "Dimension Set Entry" TEMPORARY;
        DimVal: Record "Dimension Value";
    BEGIN
        // Migration Nav 2015 : Fonction copi‚e … partir du codeunit 408
        // Ajout du changecompany sur la variable locale
        DimVal.CHANGECOMPANY(Gtext_Company);

        // --> Code fonction d'origine
        ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimVal."Dimension Code" := GLSetupShortcutDimCode[FieldNumber];
        IF ShortcutDimCode <> '' THEN BEGIN
            DimVal.GET(DimVal."Dimension Code", ShortcutDimCode);
            IF NOT CheckDim(DimVal."Dimension Code") THEN
                ERROR(GetDimErr());
            IF NOT CheckDimValue(DimVal."Dimension Code", ShortcutDimCode) THEN
                ERROR(GetDimErr());
        END;
        GetDimensionSet(TempDimSetEntry, DimSetID);
        IF TempDimSetEntry.GET(TempDimSetEntry."Dimension Set ID", DimVal."Dimension Code") THEN
            IF TempDimSetEntry."Dimension Value Code" <> ShortcutDimCode THEN
                TempDimSetEntry.DELETE();
        IF ShortcutDimCode <> '' THEN BEGIN
            TempDimSetEntry."Dimension Code" := DimVal."Dimension Code";
            TempDimSetEntry."Dimension Value Code" := DimVal.Code;
            TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
            IF TempDimSetEntry.INSERT() THEN;
        END;
        DimSetID := GetDimensionSetID(TempDimSetEntry);
    END;

    PROCEDURE GetDimensionSet(VAR TempDimSetEntry: Record "Dimension Set Entry" TEMPORARY; DimSetID: Integer);
    VAR
        DimSetEntry2: Record "Dimension Set Entry";
    BEGIN
        // Migration Nav 2015 : Fonction copi‚e … partir du codeunit 408
        // --> Code fonction d'origine
        TempDimSetEntry.DELETEALL();
        DimSetEntry2.CHANGECOMPANY(Gtext_Company);
        DimSetEntry2.SETRANGE("Dimension Set ID", DimSetID);
        IF DimSetEntry2.FINDSET() THEN
            REPEAT
                TempDimSetEntry := DimSetEntry2;
                TempDimSetEntry.INSERT();
            UNTIL DimSetEntry2.NEXT() = 0;
    END;

    PROCEDURE GetDimensionSetID(VAR DimSetEntry: Record "Dimension Set Entry"): Integer;
    VAR
        DimSetEntry2: Record "Dimension Set Entry";
        DimSetTreeNode: Record "Dimension Set Tree Node";
        Found: Boolean;
    BEGIN
        // Migration Nav 2015 : Fonction copi‚e … partir du codeunit 408
        // Ajout du changecompany sur la variable locale
        DimSetEntry2.CHANGECOMPANY(Gtext_Company);
        DimSetTreeNode.CHANGECOMPANY(Gtext_Company);

        // --> Code fonction d'origine
        DimSetEntry2.COPY(DimSetEntry);
        IF DimSetEntry."Dimension Set ID" > 0 THEN
            DimSetEntry.SETRANGE("Dimension Set ID", DimSetEntry."Dimension Set ID");

        DimSetEntry.SETCURRENTKEY("Dimension Value ID");
        DimSetEntry.SETFILTER("Dimension Code", '<>%1', '');
        DimSetEntry.SETFILTER("Dimension Value Code", '<>%1', '');

        IF NOT DimSetEntry.FINDSET() THEN
            EXIT(0);

        Found := TRUE;
        DimSetTreeNode."Dimension Set ID" := 0;
        REPEAT
            DimSetEntry.TESTFIELD("Dimension Value ID");
            IF Found THEN
                IF NOT DimSetTreeNode.GET(DimSetTreeNode."Dimension Set ID", DimSetEntry."Dimension Value ID") THEN BEGIN
                    Found := FALSE;
                    DimSetTreeNode.LOCKTABLE();
                END;
            IF NOT Found THEN BEGIN
                DimSetTreeNode."Parent Dimension Set ID" := DimSetTreeNode."Dimension Set ID";
                DimSetTreeNode."Dimension Value ID" := DimSetEntry."Dimension Value ID";
                DimSetTreeNode."Dimension Set ID" := 0;
                DimSetTreeNode."In Use" := FALSE;
                IF NOT DimSetTreeNode.INSERT(TRUE) THEN
                    DimSetTreeNode.GET(DimSetTreeNode."Parent Dimension Set ID", DimSetTreeNode."Dimension Value ID");
            END;
        UNTIL DimSetEntry.NEXT() = 0;
        IF NOT DimSetTreeNode."In Use" THEN BEGIN
            IF Found THEN BEGIN
                DimSetTreeNode.LOCKTABLE();
                DimSetTreeNode.GET(DimSetTreeNode."Parent Dimension Set ID", DimSetTreeNode."Dimension Value ID");
            END;
            DimSetTreeNode."In Use" := TRUE;
            DimSetTreeNode.MODIFY();
            InsertDimSetEntries(DimSetEntry, DimSetTreeNode."Dimension Set ID");
        END;

        DimSetEntry.COPY(DimSetEntry2);

        EXIT(DimSetTreeNode."Dimension Set ID");
    END;

    LOCAL PROCEDURE InsertDimSetEntries(VAR DimSetEntry: Record "Dimension Set Entry"; NewID: Integer);
    VAR
        DimSetEntry2: Record "Dimension Set Entry";
    BEGIN
        // Migration Nav 2015 : Fonction copi‚e … partir du codeunit 408
        // Ajout du changecompany sur la variable locale
        DimSetEntry2.CHANGECOMPANY(Gtext_Company);
        // --> Code fonction d'origine
        DimSetEntry2.LOCKTABLE();
        IF DimSetEntry.FINDSET() THEN
            REPEAT
                DimSetEntry2 := DimSetEntry;
                DimSetEntry2."Dimension Set ID" := NewID;
                DimSetEntry2.INSERT();
            UNTIL DimSetEntry.NEXT() = 0;
    END;

    PROCEDURE CheckDim(DimCode: Code[20]): Boolean;
    VAR
        Dim: Record Dimension;
    BEGIN
        // Migration Nav 2015 : Fonction copi‚e … partir du codeunit 408
        // Ajout du changecompany sur la variable locale
        Dim.CHANGECOMPANY(Gtext_Company);
        // --> Code fonction d'origine
        IF Dim.GET(DimCode) THEN BEGIN
            IF Dim.Blocked THEN BEGIN
                DimErr :=
                  STRSUBSTNO(Text014, Dim.TABLECAPTION, DimCode);
                EXIT(FALSE);
            END;
        END ELSE BEGIN
            DimErr :=
              STRSUBSTNO(Text015, Dim.TABLECAPTION, DimCode);
            EXIT(FALSE);
        END;
        EXIT(TRUE);
    END;

    PROCEDURE CheckDimValue(DimCode: Code[20]; DimValCode: Code[20]): Boolean;
    VAR
        DimVal: Record "Dimension Value";
    BEGIN
        // Migration Nav 2015 : Fonction copi‚e … partir du codeunit 408
        // Ajout du changecompany sur la variable locale
        DimVal.CHANGECOMPANY(Gtext_Company);
        // --> Code fonction d'origine
        IF (DimCode <> '') AND (DimValCode <> '') THEN
            IF DimVal.GET(DimCode, DimValCode) THEN BEGIN
                IF DimVal.Blocked THEN BEGIN
                    DimErr :=
                      STRSUBSTNO(
                        Text016, DimVal.TABLECAPTION, DimCode, DimValCode);
                    EXIT(FALSE);
                END;
                IF NOT (DimVal."Dimension Value Type" IN
                        [DimVal."Dimension Value Type"::Standard,
                         DimVal."Dimension Value Type"::"Begin-Total"])
                THEN BEGIN
                    DimErr :=
                      STRSUBSTNO(Text017, DimVal.FIELDCAPTION("Dimension Value Type"),
                        DimVal.TABLECAPTION, DimCode, DimValCode, FORMAT(DimVal."Dimension Value Type"));
                    EXIT(FALSE);
                END;
            END ELSE BEGIN
                DimErr :=
                  STRSUBSTNO(
                    Text018, DimVal.TABLECAPTION, DimCode);
                EXIT(FALSE);
            END;
        EXIT(TRUE);
    END;

    PROCEDURE GetDimErr(): Text[250];
    BEGIN
        // Migration Nav 2015 : Fonction copi‚e … partir du codeunit 408
        // --> Code fonction d'origine
        EXIT(DimErr);
    END;
}
