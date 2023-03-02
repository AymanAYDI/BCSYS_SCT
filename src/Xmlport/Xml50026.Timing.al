xmlport 50026 "BC6_Timing"
{
    Direction = Import;
    Format = VariableText;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    UseRequestPage = false;
    FileName = '*.csv';
    Caption = 'Timing';
    schema
    {
        textelement(Root)
        {
            tableelement("Timing"; Integer)
            {
                AutoSave = false;
                AutoUpdate = false;
                AutoReplace = false;

                textelement(Gtxt_CodeEntite)
                {
                }
                textelement(Gtxt_CodeMatricule)
                {
                }
                textelement(Gtxt_DateComptabilisation)
                {
                }
                textelement(Gtxt_Quantité)
                {
                }
                textelement(Gtxt_Axe0)
                {
                }
                textelement(Gtxt_Axe1)
                {
                }
                textelement(Gtxt_Axe2)
                {
                }
                textelement(Gtxt_Axe3)
                {
                }
                trigger OnBeforeInsertRecord()
                VAR
                    Nb: Integer;
                BEGIN
                    //Modif JX-AUD du 22/02/2012
                    Gint_CompteurLigne += 1;
                    IF ((Gint_CompteurLigne > 1) AND (Gtxt_CodeEntite = PurchSetup."BC6_Entity Code")) THEN //insertion des lignes du fichier dans une table temporaire
                    BEGIN
                        IF EVALUATE("Gdec_Quantité", Gtxt_Quantité) THEN;
                        IF EVALUATE(Gdate_DateComptabilisation, Gtxt_DateComptabilisation) THEN;
                        TempGrec_Import.RESET();
                        TempGrec_Import.SETRANGE("External document No.", Gtxt_CodeEntite);
                        TempGrec_Import.SETRANGE("Account No.", Gtxt_CodeMatricule);
                        TempGrec_Import.SETRANGE("Posting date", Gdate_DateComptabilisation);
                        TempGrec_Import.SETRANGE("Credit amount", "Gdec_Quantité");
                        TempGrec_Import.SETRANGE("Axe 0", Gtxt_Axe0);
                        TempGrec_Import.SETRANGE("Axe 1", Gtxt_Axe1);
                        TempGrec_Import.SETRANGE("Axe 2", Gtxt_Axe2);
                        TempGrec_Import.SETRANGE("Axe 3", Gtxt_Axe3);
                        IF NOT TempGrec_Import.FINDFIRST() THEN BEGIN

                            TempGrec_TemporaryTable.INIT();
                            TempGrec_TemporaryTable."Line No." := Gint_CompteurLigne;//inutile mais n‚cessaire pour l'insertion des donn‚es car cl‚ primaire
                            TempGrec_TemporaryTable."Document No." := FORMAT(Gint_CompteurLigne) + '' + Gtxt_CodeMatricule;//inutile mais n‚cessaire pour l'insert
                            TempGrec_TemporaryTable."External document No." := Gtxt_CodeEntite;
                            TempGrec_TemporaryTable."Account No." := Gtxt_CodeMatricule;
                            IF EVALUATE(Gdate_DateComptabilisation, Gtxt_DateComptabilisation) THEN
                                TempGrec_TemporaryTable."Posting date" := Gdate_DateComptabilisation;
                            IF EVALUATE("Gdec_Quantité", Gtxt_Quantité) THEN
                                TempGrec_TemporaryTable."Credit amount" := "Gdec_Quantité";
                            TempGrec_TemporaryTable."Axe 0" := Gtxt_Axe0;
                            TempGrec_TemporaryTable."Axe 1" := Gtxt_Axe1;
                            TempGrec_TemporaryTable."Axe 2" := Gtxt_Axe2;
                            TempGrec_TemporaryTable."Axe 3" := Gtxt_Axe3;
                            TempGrec_TemporaryTable.INSERT();
                            TempGrec_TemporaryTable2.INIT(); //initialisation d'une seconde table temporaire identique
                            TempGrec_TemporaryTable2 := TempGrec_TemporaryTable;
                            TempGrec_TemporaryTable2.INSERT();

                            Gint_NumImport += 1;
                            TempGrec_Import.INIT();
                            TempGrec_Import := TempGrec_TemporaryTable;
                            TempGrec_Import."Document No." := FORMAT(Gint_NumImport);
                            TempGrec_Import."Line No." := Gint_NumImport;
                            TempGrec_Import.INSERT();
                        END;
                    END;
                END;
            }
        }
    }
    PROCEDURE ValidateDimensions(Grec_PurchaseLine: Record "Purchase Line"; Axe0: Text[30]; Axe1: Text[30]; Axe2: Text[30]; Axe3: Text[30]): Boolean;
    BEGIN
        Gbool_AxesOk := TRUE;

        //recherche Axe0
        IF (PurchSetup."BC6_Verif Dim 0 on Purch. Line") AND (PurchSetup."BC6_Timing Dimension 0" <> '') THEN
            IF Grec_DocumentDimension.GET(Grec_PurchaseLine."Dimension Set ID", PurchSetup."BC6_Timing Dimension 0") THEN BEGIN
                IF NOT (Grec_DocumentDimension."Dimension Value Code" = Axe0) THEN
                    Gbool_AxesOk := FALSE;
            END ELSE
                Gbool_AxesOk := FALSE;

        //recherche Axe1
        IF (PurchSetup."BC6_Verif Dim 1 on Purch. Line") AND (PurchSetup."BC6_Timing Dimension 1" <> '') THEN
            IF Grec_DocumentDimension.GET(Grec_PurchaseLine."Dimension Set ID", PurchSetup."BC6_Timing Dimension 1") THEN BEGIN
                IF NOT (Grec_DocumentDimension."Dimension Value Code" = Axe1) THEN
                    Gbool_AxesOk := FALSE;
            END ELSE
                Gbool_AxesOk := FALSE;

        //recherche Axe2
        IF (PurchSetup."BC6_Verif Dim 2 on Purch. Line") AND (PurchSetup."BC6_Timing Dimension 2" <> '') THEN
            IF Grec_DocumentDimension.GET(Grec_PurchaseLine."Dimension Set ID", PurchSetup."BC6_Timing Dimension 2") THEN BEGIN
                IF NOT (Grec_DocumentDimension."Dimension Value Code" = Axe2) THEN
                    Gbool_AxesOk := FALSE;
            END ELSE
                Gbool_AxesOk := FALSE;

        //recherche Axe3
        IF (PurchSetup."BC6_Verif Dim 3 on Purch. Line") AND (PurchSetup."BC6_Timing Dimension 3" <> '') THEN
            IF Grec_DocumentDimension.GET(Grec_PurchaseLine."Dimension Set ID", PurchSetup."BC6_Timing Dimension 3") THEN BEGIN
                IF NOT (Grec_DocumentDimension."Dimension Value Code" = Axe3) THEN
                    Gbool_AxesOk := FALSE;
            END ELSE
                Gbool_AxesOk := FALSE;

        EXIT(Gbool_AxesOk);
    END;

    PROCEDURE AjouterAxeClient(lrec_TemporaryTable: Record "BC6_Global temporary table"; VAR lrec_PurchLine: Record "Purchase Line"): Boolean;
    VAR
        Lrec_DimSetEntry: Record "Dimension Set Entry";
        LRec_Purchline2: Record "Purchase Line";
        lRec_PurchlineNew: Record "Purchase Line";
        Temp_PurchLine: Record "Purchase Line" TEMPORARY;
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
        LCode_DimCode: ARRAY[50] OF Code[20];
        LCode_DimValueCode: ARRAY[50] OF Code[20];
    BEGIN
        //fonction permettant d'int‚grer l'axe 2 client
        Gbool_AxeClientOk := FALSE;

        //v‚rification des sections des axes … ne pas v‚rifier initialement
        IF (PurchSetup."BC6_Verif Dim 0 on Purch. Line") AND (PurchSetup."BC6_Verif Dim 1 on Purch. Line")
          AND (PurchSetup."BC6_Verif Dim 2 on Purch. Line") AND (PurchSetup."BC6_Verif Dim 3 on Purch. Line") THEN
            Gbool_AxeClientOk := TRUE
        ELSE BEGIN
            IF (NOT PurchSetup."BC6_Verif Dim 0 on Purch. Line") AND (PurchSetup."BC6_Timing Dimension 0" <> '') THEN
                IF Grec_DimensionValue.GET(PurchSetup."BC6_Timing Dimension 0", TempGrec_TemporaryTable."Axe 0") THEN
                    IF NOT Grec_DimensionValue.Blocked THEN
                        Gbool_AxeClientOk := TRUE;
            IF (NOT PurchSetup."BC6_Verif Dim 1 on Purch. Line") AND (PurchSetup."BC6_Timing Dimension 1" <> '') THEN
                IF Grec_DimensionValue.GET(PurchSetup."BC6_Timing Dimension 1", TempGrec_TemporaryTable."Axe 1") THEN
                    IF NOT Grec_DimensionValue.Blocked THEN
                        Gbool_AxeClientOk := TRUE;
            IF (NOT PurchSetup."BC6_Verif Dim 2 on Purch. Line") AND (PurchSetup."BC6_Timing Dimension 2" <> '') THEN
                IF Grec_DimensionValue.GET(PurchSetup."BC6_Timing Dimension 2", TempGrec_TemporaryTable."Axe 2") THEN
                    IF NOT Grec_DimensionValue.Blocked THEN
                        Gbool_AxeClientOk := TRUE;
            IF (NOT PurchSetup."BC6_Verif Dim 3 on Purch. Line") AND (PurchSetup."BC6_Timing Dimension 3" <> '') THEN
                IF Grec_DimensionValue.GET(PurchSetup."BC6_Timing Dimension 3", TempGrec_TemporaryTable."Axe 3") THEN
                    IF NOT Grec_DimensionValue.Blocked THEN
                        Gbool_AxeClientOk := TRUE;
        END;

        IF Gbool_AxeClientOk THEN BEGIN
            Temp_PurchLine := lrec_PurchLine;
            LCode_DimCode[1] := PurchSetup."BC6_Timing Dimension 0";
            LCode_DimValueCode[1] := lrec_TemporaryTable."Axe 0";
            LCode_DimCode[2] := PurchSetup."BC6_Timing Dimension 1";
            LCode_DimValueCode[2] := lrec_TemporaryTable."Axe 1";
            LCode_DimCode[3] := PurchSetup."BC6_Timing Dimension 2";
            LCode_DimValueCode[3] := lrec_TemporaryTable."Axe 2";
            LCode_DimCode[4] := PurchSetup."BC6_Timing Dimension 3";
            LCode_DimValueCode[4] := lrec_TemporaryTable."Axe 3";
            Temp_PurchLine."Dimension Set ID" := BC6_FunctMgt.SetNewDimIDSpec(Temp_PurchLine."Dimension Set ID", Temp_PurchLine."Shortcut Dimension 1 Code",
                                          Temp_PurchLine."Shortcut Dimension 2 Code", LCode_DimCode, LCode_DimValueCode);

            IF lrec_PurchLine."Quantity Received" = 0 THEN BEGIN
                IF Temp_PurchLine."Dimension Set ID" <> lrec_PurchLine."Dimension Set ID" THEN BEGIN
                    lrec_PurchLine."Dimension Set ID" := Temp_PurchLine."Dimension Set ID";
                    lrec_PurchLine.MODIFY();
                END;
            END ELSE
                IF Temp_PurchLine."Dimension Set ID" <> lrec_PurchLine."Dimension Set ID" THEN BEGIN
                    lRec_PurchlineNew := lrec_PurchLine;
                    LRec_Purchline2.RESET();
                    LRec_Purchline2.SETRANGE("Document Type", lrec_PurchLine."Document Type");
                    LRec_Purchline2.SETRANGE("Document No.", lrec_PurchLine."Document No.");
                    IF LRec_Purchline2.FINDLAST() THEN
                        lRec_PurchlineNew."Line No." := LRec_Purchline2."Line No." + 10000
                    ELSE
                        lRec_PurchlineNew."Line No." := 10000;
                    lRec_PurchlineNew.INSERT();
                    lRec_PurchlineNew."Dimension Set ID" := Temp_PurchLine."Dimension Set ID";
                    lRec_PurchlineNew."Outstanding Quantity" := lRec_PurchlineNew.Quantity;
                    lRec_PurchlineNew."Qty. to Invoice" := 0;
                    lRec_PurchlineNew."Qty. to Receive" := 0;
                    lRec_PurchlineNew."Qty. Rcd. Not Invoiced" := 0;
                    lRec_PurchlineNew."Amt. Rcd. Not Invoiced" := 0;
                    lRec_PurchlineNew."Quantity Received" := 0;
                    lRec_PurchlineNew."Quantity Invoiced" := 0;
                    lRec_PurchlineNew."Outstanding Qty. (Base)" := lRec_PurchlineNew."Quantity (Base)";
                    lRec_PurchlineNew."Qty. to Receive (Base)" := 0;
                    lRec_PurchlineNew."Qty. to Invoice (Base)" := 0;
                    lRec_PurchlineNew."Qty. Rcd. Not Invoiced (Base)" := 0;
                    lRec_PurchlineNew."Qty. Received (Base)" := 0;
                    lRec_PurchlineNew."Qty. Invoiced (Base)" := 0;
                    lRec_PurchlineNew."BC6_VTIME New Line" := TRUE;
                    lRec_PurchlineNew.MODIFY();
                    LCode_DimCode[1] := PurchSetup."BC6_Timing Dimension 0";
                    LCode_DimValueCode[1] := lrec_TemporaryTable."Axe 0";
                    LCode_DimCode[2] := PurchSetup."BC6_Timing Dimension 1";
                    LCode_DimValueCode[2] := lrec_TemporaryTable."Axe 1";
                    LCode_DimCode[3] := PurchSetup."BC6_Timing Dimension 2";
                    LCode_DimValueCode[3] := lrec_TemporaryTable."Axe 2";
                    LCode_DimCode[4] := PurchSetup."BC6_Timing Dimension 3";
                    LCode_DimValueCode[4] := lrec_TemporaryTable."Axe 3";
                    IF Lrec_DimSetEntry.GET(lrec_PurchLine."Dimension Set ID", 'INTRAGROUPE') THEN BEGIN
                        LCode_DimCode[5] := 'INTRAGROUPE';
                        LCode_DimValueCode[5] := Lrec_DimSetEntry."Dimension Value Code";
                    END;
                    lRec_PurchlineNew."Dimension Set ID" := BC6_FunctMgt.SetNewDimIDSpec(lRec_PurchlineNew."Dimension Set ID", lRec_PurchlineNew."Shortcut Dimension 1 Code",
                                                 lRec_PurchlineNew."Shortcut Dimension 2 Code", LCode_DimCode, LCode_DimValueCode);
                    lRec_PurchlineNew.MODIFY();
                    lrec_PurchLine := lRec_PurchlineNew;
                END;
        END;
        //si axe2 absent dans f2i et NAV alors on renvoie false
        EXIT(Gbool_AxeClientOk);
    END;

    PROCEDURE ModifierQuantite(TempGrec_TemporaryTable: Record "BC6_Global temporary table"; Grec_PurchaseLine1: Record "Purchase Line");
    VAR
        ReleasePurchDoc: Codeunit "Release Purchase Document";
    BEGIN
        //d‚but traitement pour ins‚r‚r la commande dans la table Grec_Temporary_Log_Ini
        TempGrec_Temporary_Table_Log_Ini.SETCURRENTKEY("Document No.", "External document No.");
        Gint_nb1 += 1;
        TempGrec_Temporary_Table_Log_Ini.SETFILTER(TempGrec_Temporary_Table_Log_Ini."Document No.", Grec_PurchaseLine1."Document No.");
        TempGrec_Temporary_Table_Log_Ini.
        SETFILTER(TempGrec_Temporary_Table_Log_Ini."External document No.", FORMAT(Grec_PurchaseLine1."Line No."));
        IF NOT TempGrec_Temporary_Table_Log_Ini.FIND('-') THEN BEGIN
            //v‚rification si premiŠre archive pour la ligne
            Grec_PurchaseLineArchive.SETFILTER(Grec_PurchaseLineArchive."Document Type",
            FORMAT(Grec_PurchaseLineArchive."Document Type"::Order));
            Grec_PurchaseLineArchive.SETFILTER(Grec_PurchaseLineArchive."Document No.", Grec_PurchaseLine1."Document No.");
            Grec_PurchaseLineArchive.SETFILTER(Grec_PurchaseLineArchive."Doc. No. Occurrence", '1');
            Grec_PurchaseLineArchive.SETFILTER(Grec_PurchaseLineArchive."Line No.", FORMAT(Grec_PurchaseLine1."Line No."));
            Grec_PurchaseLineArchive.SETFILTER(Grec_PurchaseLineArchive."BC6_Matricule No.", Grec_PurchaseLine1."BC6_Matricule No.");
            IF NOT Grec_PurchaseLineArchive.FIND('-') THEN BEGIN
                //on cr‚er une archive
                IF Grec_PurchHeader.GET(Grec_PurchHeader."Document Type"::Order, Grec_PurchaseLine1."Document No.") THEN
                    Grec_Archive_Management.StorePurchDocument(Grec_PurchHeader, FALSE);
                //on r‚cupŠre l'archive cr‚e et la ligne initiale
                Grec_PurchaseLineArchive.SETFILTER(Grec_PurchaseLineArchive."Document Type",
                FORMAT(Grec_PurchaseLineArchive."Document Type"::Order));
                Grec_PurchaseLineArchive.SETFILTER(Grec_PurchaseLineArchive."Document No.", Grec_PurchaseLine1."Document No.");
                Grec_PurchaseLineArchive.SETFILTER(Grec_PurchaseLineArchive."Doc. No. Occurrence", '1');
                Grec_PurchaseLineArchive.SETFILTER(Grec_PurchaseLineArchive."Line No.", FORMAT(Grec_PurchaseLine1."Line No."));
                Grec_PurchaseLineArchive.SETFILTER(Grec_PurchaseLineArchive."BC6_Matricule No.", Grec_PurchaseLine1."BC6_Matricule No.");
                IF Grec_PurchaseLineArchive.FIND('-') THEN BEGIN
                    TempGrec_Temporary_Table_Log_Ini.RESET();
                    TempGrec_Temporary_Table_Log_Ini.INIT();
                    TempGrec_Temporary_Table_Log_Ini."Line No." := Gint_nb1;
                    TempGrec_Temporary_Table_Log_Ini."Document No." := Grec_PurchaseLineArchive."Document No.";
                    TempGrec_Temporary_Table_Log_Ini."External document No." := FORMAT(Grec_PurchaseLineArchive."Line No.");
                    TempGrec_Temporary_Table_Log_Ini."Credit amount" := Grec_PurchaseLineArchive.Quantity;//Qt‚ initiale de la ligne
                    TempGrec_Temporary_Table_Log_Ini.INSERT();
                END;
            END ELSE BEGIN
                TempGrec_Temporary_Table_Log_Ini.RESET();
                TempGrec_Temporary_Table_Log_Ini.INIT();
                TempGrec_Temporary_Table_Log_Ini."Line No." := Gint_nb1;
                TempGrec_Temporary_Table_Log_Ini."Document No." := Grec_PurchaseLineArchive."Document No.";
                TempGrec_Temporary_Table_Log_Ini."External document No." := FORMAT(Grec_PurchaseLineArchive."Line No.");
                TempGrec_Temporary_Table_Log_Ini."Credit amount" := Grec_PurchaseLineArchive.Quantity;//Qt‚ initiale de la ligne
                TempGrec_Temporary_Table_Log_Ini.INSERT();

            END;
        END;
        TempGrec_Temporary_Table_Log_Ini.RESET();
        //fin

        IF Grec_PurchHeader.GET(Grec_PurchHeader."Document Type"::Order, Grec_PurchaseLine1."Document No.") THEN
            IF Grec_PurchHeader.Status <> Grec_PurchHeader.Status::Open THEN
                ReleasePurchDoc.PerformManualReopen(Grec_PurchHeader);
        //   IF Grec_PurchHeader.GET(Grec_PurchHeader."Document Type"::Order, Grec_PurchaseLine1."Document No.") THEN
        //         IF Grec_PurchHeader.Status = Grec_PurchHeader.Status::Released THEN BEGIN
        //             //on modifie le statut en "Ouvert" si la commande est lanc‚e
        //             Grec_PurchHeader.VALIDATE(Status, Grec_PurchHeader.Status::Open);
        //             Grec_PurchHeader.MODIFY;
        //             //COMMIT;
        //         END;
        Gint_LineNo2 := Grec_PurchaseLine1."Line No.";
        Gtxt_DocumentNo2 := Grec_PurchaseLine1."Document No.";
        //pour une commande ayant plusieurs lignes mettre toutes les "Quantit‚ … recevoir" … 0 avant de changer la quantit‚ et valider
        //la commande en reception
        Grec_PurchLine3.SETFILTER(Grec_PurchLine3."Document No.", Gtxt_DocumentNo2);
        IF Grec_PurchLine3.FIND('-') THEN
            REPEAT
            BEGIN
                Grec_PurchLine3.VALIDATE("Qty. to Receive", 0);
                Grec_PurchLine3.MODIFY();
            END;
            UNTIL Grec_PurchLine3.NEXT() = 0;

        //fonction permettant de modifier les quantit‚ de la commande
        Grec_PurchaseLine1.RESET();
        Grec_PurchaseLine1.GET(Grec_PurchaseLine1."Document Type"::Order, Gtxt_DocumentNo2, Gint_LineNo2);//rechargement de la ligne
        "Gdec_Quantité" := TempGrec_TemporaryTable."Credit amount";
        IF "Gdec_Quantité" > Grec_PurchaseLine1."Outstanding Quantity" THEN BEGIN
            Gdec_QuantiteCmdAvantV := Grec_PurchaseLine1.Quantity;
            Grec_PurchaseLine1.VALIDATE(Grec_PurchaseLine1.Quantity,
            Grec_PurchaseLine1.Quantity + ("Gdec_Quantité" - Grec_PurchaseLine1."Outstanding Quantity"));
            Grec_PurchaseLine1.MODIFY();
            Gdec_QuantiteCmdApresV := Grec_PurchaseLine1.Quantity;
            //InsertionExcel1(Grec_TemporaryTable,Gdec_QuantiteCmdAvant,Gdec_QuantiteCmdApres,Grec_PurchaseLine1."Document No.");
        END ELSE
            IF "Gdec_Quantité" < Grec_PurchaseLine1."Outstanding Quantity" THEN BEGIN
                Grec_PurchaseLine1.VALIDATE(Grec_PurchaseLine1.Quantity,
                (Grec_PurchaseLine1.Quantity + ("Gdec_Quantité" - Grec_PurchaseLine1."Outstanding Quantity")));
                Grec_PurchaseLine1.MODIFY();
            END ELSE BEGIN
                Grec_PurchaseLine1.VALIDATE(Grec_PurchaseLine1.Quantity, Grec_PurchaseLine1.Quantity);
                Grec_PurchaseLine1.MODIFY();
            END;

        //d‚but traitement pour int‚grer la ligne dans la table Grec_Temporary_Log_Rec
        TempGrec_Temporary_Table_Log_Rec.INIT();
        TempGrec_Temporary_Table_Log_Rec."Line No." := Gint_nb1;
        TempGrec_Temporary_Table_Log_Rec."Document No." := Grec_PurchaseLine1."Document No.";
        TempGrec_Temporary_Table_Log_Rec."External document No." := FORMAT(Grec_PurchaseLine1."Line No.");
        TempGrec_Temporary_Table_Log_Rec."Credit amount" := Grec_PurchaseLine1."Qty. to Receive";//Qt‚ … recevoir
        TempGrec_Temporary_Table_Log_Rec.INSERT();
        //fin
    END;

    PROCEDURE ValiderReception(TempGrec_TemporaryTable: Record "BC6_Global temporary table"; Grec_PurchaseLine: Record "Purchase Line");
    VAR
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    BEGIN
        //fonction permettant la validation automatique de la r‚ception
        Grec_PurchHeader2.RESET();

        IF Grec_PurchHeader2.GET(Grec_PurchHeader2."Document Type"::Order, Grec_PurchaseLine."Document No.") THEN //recuperation num commande
                                                                                                                  //modifier la date de comptabilisation de l'entˆte de la commande avant le traitement pour que la r‚ception aie la date du fichier
        BEGIN
            Grec_PurchHeader2.VALIDATE(Grec_PurchHeader2."Posting Date", TempGrec_TemporaryTable."Posting date");
            Grec_PurchHeader2.VALIDATE(Grec_PurchHeader2.Receive, TRUE);
            Grec_PurchHeader2.MODIFY();
            CODEUNIT.RUN(CODEUNIT::"Purch.-Post", Grec_PurchHeader2); //lancement du traitement de la r‚ception
            IF Grec_PurchHeader2.GET(Grec_PurchHeader2."Document Type"::Order, Grec_PurchaseLine."Document No.") THEN BEGIN
                BC6_FunctMgt.FctReceiptStatus(Grec_PurchHeader2);
                Grec_PurchHeader2.MODIFY();
            END;
        END;
    END;

    PROCEDURE InsertionExcel(Grec_TemporaryExcel: Record "BC6_Global temporary table"; Gtxt_Commentaire: Text[30]; Gtxt_Num_Commande: Text[30]);
    BEGIN
        //Modif JX-AUD 28/02/2012
        //Modif Buffer Excel
        Row := Row + 1;
        EnterCell(Row, 1, TempGrec_TemporaryTable."External document No.", FALSE, FALSE, FALSE);
        EnterCell(Row, 2, TempGrec_TemporaryTable."Account No.", FALSE, FALSE, FALSE);
        EnterCell(Row, 3, FORMAT(TempGrec_TemporaryTable."Posting date"), FALSE, FALSE, FALSE);
        EnterCell(Row, 4, FORMAT(TempGrec_TemporaryTable."Credit amount"), FALSE, FALSE, FALSE);
        EnterCell(Row, 5, TempGrec_TemporaryTable."Axe 0", FALSE, FALSE, FALSE);
        EnterCell(Row, 6, TempGrec_TemporaryTable."Axe 1", FALSE, FALSE, FALSE);
        EnterCell(Row, 7, TempGrec_TemporaryTable."Axe 2", FALSE, FALSE, FALSE);
        EnterCell(Row, 8, TempGrec_TemporaryTable."Axe 3", FALSE, FALSE, FALSE);
        EnterCell(Row, 9, Gtxt_Commentaire, FALSE, FALSE, FALSE);

        RecNo := RecNo + 1;
        Window.UPDATE(1, ROUND(RecNo / TotalRecNo * 10000, 1));
    END;

    LOCAL PROCEDURE EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean);
    BEGIN
        //Modif JX-AUD 28/02/2012
        //Modif Buffer Excel
        TempExcelBuffer.INIT();
        TempExcelBuffer.VALIDATE("Row No.", RowNo);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := CellValue;
        TempExcelBuffer.Formula := '';
        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.Italic := Italic;
        TempExcelBuffer.Underline := UnderLine;
        TempExcelBuffer.INSERT();
    END;

    PROCEDURE InsertionExcel1(Gdec_QuantiteCmdAvant: Decimal; Gdec_QuantiteCmdApres: Decimal; Gtext_Num_Commande: Text[30]; Gdec_QuantiteTotale: Decimal; Gint_NumeroLigne: Integer);
    BEGIN
        //Modif JX-AUD 28/02/2012
        //Modif Buffer Excel  //fichier lignes quantit‚ modifi‚e sup‚rieure
        Row1 := Row1 + 1;
        //{EnterCell1(Row1, 1, Grec_TemporaryTable."External document No.", FALSE, FALSE, FALSE);
        //EnterCell1(Row1, 2, Grec_TemporaryTable."Account No.", FALSE, FALSE, FALSE);
        //EnterCell1(Row1, 3, FORMAT(Grec_TemporaryTable."Posting date"), FALSE, FALSE, FALSE);
        //EnterCell1(Row1, 4, FORMAT(Grec_TemporaryTable."Credit amount"), FALSE, FALSE, FALSE);
        //EnterCell1(Row1, 5, Grec_TemporaryTable."Axe 0", FALSE, FALSE, FALSE);
        //EnterCell1(Row1, 6, Grec_TemporaryTable."Axe 1", FALSE, FALSE, FALSE);
        //EnterCell1(Row1, 7, Grec_TemporaryTable."Axe 2", FALSE, FALSE, FALSE);
        //EnterCell1(Row1, 8, Grec_TemporaryTable."Axe 3", FALSE, FALSE, FALSE);

        //EnterCell1(Row1, 9, FORMAT(Gdec_QuantiteCmdAvant), FALSE, FALSE, FALSE);
        //EnterCell1(Row1, 10, FORMAT(Gdec_QuantiteCmdApres), FALSE, FALSE, FALSE);
        //EnterCell1(Row1, 11, Gtext_Num_Commande, FALSE, FALSE, FALSE);}
        EnterCell1(Row1, 1, Gtext_Num_Commande, FALSE, FALSE, FALSE);
        EnterCell1(Row1, 2, FORMAT(Gint_NumeroLigne), FALSE, FALSE, FALSE);
        EnterCell1(Row1, 3, FORMAT(Gdec_QuantiteCmdAvant), FALSE, FALSE, FALSE);
        EnterCell1(Row1, 4, FORMAT(Gdec_QuantiteCmdApres), FALSE, FALSE, FALSE);
        EnterCell1(Row1, 5, FORMAT(Gdec_QuantiteTotale), FALSE, FALSE, FALSE);


        RecNo1 := RecNo1 + 1;
        Window1.UPDATE(1, ROUND(RecNo1 / TotalRecNo1 * 10000, 1));
    END;

    LOCAL PROCEDURE EnterCell1(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean);
    BEGIN
        //Modif JX-AUD 28/02/2012
        //Modif Buffer Excel  //fichier lignes quantit‚ modifi‚e sup‚rieure
        TempExcelBuffer1.INIT();
        TempExcelBuffer1.VALIDATE("Row No.", RowNo);
        TempExcelBuffer1.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer1."Cell Value as Text" := CellValue;
        TempExcelBuffer1.Formula := '';
        TempExcelBuffer1.Bold := Bold;
        TempExcelBuffer1.Italic := Italic;
        TempExcelBuffer1.Underline := UnderLine;
        TempExcelBuffer1.INSERT();
    END;

    PROCEDURE FinalisationFichierExcel();
    BEGIN
        //Modif JX-AUD 28/02/2012
        //Modif Buffer Excel //fichier lignes non import‚es
        Window.CLOSE();

        TempExcelBuffer.CreateNewBook(Text013);
        TempExcelBuffer.WriteSheet(Text013, COMPANYNAME, USERID);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.OpenExcel();

        // //Modif Buffer Excel //fichier lignes quantit‚ modifi‚e sup‚rieure
        // Window1.CLOSE;

        TempExcelBuffer1.CreateNewBook(Text015);
        TempExcelBuffer1.WriteSheet(Text015, COMPANYNAME, USERID);
        TempExcelBuffer1.CloseBook();
        TempExcelBuffer1.OpenExcel();
    END;

    trigger OnPreXMLport()
    BEGIN
        //Modif JX-AUD du 22/02/2012
        Gint_CompteurLigne := 0;
        Gint_nb := 0;
        //Fin modif JX-AUD du 22/02/2012
        TempGrec_TemporaryTable.SETCURRENTKEY("Account No.");
        TempGrec_Temporary_Table_Log_Ini.DELETEALL();
        TempGrec_Temporary_Table_Log_Rec.DELETEALL();
        Gint_nb1 := 0;
        Gint_NumImport := 0;
        //TempExcelBuffer.RESET;//Modif JX-AUD 28/02/2012
        PurchSetup.GET();
    END;

    trigger OnPostXMLport()
    BEGIN
        //Modif JX-AUD 28/02/2012
        //Modif Buffer Excel //fichier lignes non import‚es
        Window.OPEN(
          Text014 +
          '@1@@@@@@@@@@@@@@@@@@@@@\');
        Window.UPDATE(1, 0);
        TotalRecNo := TempGrec_TemporaryTable.COUNT;
        RecNo := 0;

        //TempExcelBuffer.DELETEALL;
        //CLEAR(TempExcelBuffer);
        TempExcelBuffer.RESET();
        EnterCell(1, 1, Text013, TRUE, FALSE, FALSE);
        EnterCell(1, 3, 'Import du ' + FORMAT(TODAY), TRUE, FALSE, FALSE);
        EnterCell(2, 1, 'Code entité', TRUE, FALSE, FALSE);
        EnterCell(2, 2, 'Code matricule', TRUE, FALSE, FALSE);
        EnterCell(2, 3, 'Date comptabilisation', TRUE, FALSE, FALSE);
        EnterCell(2, 4, 'Quantité', TRUE, FALSE, FALSE);
        EnterCell(2, 5, 'Axe 0', TRUE, FALSE, FALSE);
        EnterCell(2, 6, 'Axe 1', TRUE, FALSE, FALSE);
        EnterCell(2, 7, 'Axe 2', TRUE, FALSE, FALSE);
        EnterCell(2, 8, 'Axe 3', TRUE, FALSE, FALSE);
        EnterCell(2, 9, 'Commentaire', TRUE, FALSE, FALSE);

        Row := 2;
        //Fin modif Buffer Excel
        //Fin modif JX-AUD 28/02/2012

        //Modif Buffer Excel //fichier lignes quantit‚ modifi‚e
        Window1.OPEN(
          Text014 +
          '@1@@@@@@@@@@@@@@@@@@@@@\');
        Window1.UPDATE(1, 0);
        TotalRecNo1 := TempGrec_TemporaryTable.COUNT;
        RecNo1 := 0;

        //TempExcelBuffer.DELETEALL;
        //CLEAR(TempExcelBuffer);
        TempExcelBuffer1.RESET();
        EnterCell1(1, 1, Text015, TRUE, FALSE, FALSE);
        EnterCell1(1, 3, 'Import du ' + FORMAT(TODAY), TRUE, FALSE, FALSE);

        //EnterCell1(2, 1, 'Code entit‚', TRUE, FALSE, FALSE);
        //EnterCell1(2, 2, 'Code matricule', TRUE, FALSE, FALSE);
        //EnterCell1(2, 3, 'Date comptabilisation', TRUE, FALSE, FALSE);
        //EnterCell1(2, 4, 'Quantit‚', TRUE, FALSE, FALSE);
        //EnterCell1(2, 5, 'Axe 0', TRUE, FALSE, FALSE);
        //EnterCell1(2, 6, 'Axe 1', TRUE, FALSE, FALSE);
        //EnterCell1(2, 7, 'Axe 2', TRUE, FALSE, FALSE);
        //EnterCell1(2, 8, 'Axe 3', TRUE, FALSE, FALSE);
        //EnterCell1(2, 9, 'Quantit‚ cde avant', TRUE, FALSE, FALSE);
        //EnterCell1(2, 10, 'Quantit‚ cde aprŠs', TRUE, FALSE, FALSE);
        //EnterCell1(2, 11, 'Nø commande', TRUE, FALSE, FALSE);

        EnterCell1(2, 1, 'N° commande', TRUE, FALSE, FALSE);
        EnterCell1(2, 2, 'N° ligne commande', TRUE, FALSE, FALSE);
        EnterCell1(2, 3, 'Quantité ligne initiale', TRUE, FALSE, FALSE);
        EnterCell1(2, 4, 'Quantité ajoutée par F2i', TRUE, FALSE, FALSE);
        EnterCell1(2, 5, 'Quantité ligne cmd après', TRUE, FALSE, FALSE);

        Row1 := 2;
        //Fin modif Buffer Excel
        //Fin modif JX-AUD 28/02/2012

        //traitement cl‚ import
        Grec_PurchLine.SETCURRENTKEY("BC6_Matricule No.");

        IF TempGrec_TemporaryTable.FIND('-') THEN
            REPEAT
                //recherche si doublon dans la table temporaire pour la cl‚ Matricule,Axe0,Axe1,Axe2,Axe3
                TempGrec_TemporaryTable2.SETFILTER(TempGrec_TemporaryTable2."Account No.", TempGrec_TemporaryTable."Account No.");
                TempGrec_TemporaryTable2.SETFILTER(TempGrec_TemporaryTable2."Axe 0", TempGrec_TemporaryTable."Axe 0");
                TempGrec_TemporaryTable2.SETFILTER(TempGrec_TemporaryTable2."Axe 1", TempGrec_TemporaryTable."Axe 1");
                TempGrec_TemporaryTable2.SETFILTER(TempGrec_TemporaryTable2."Axe 2", TempGrec_TemporaryTable."Axe 2");
                TempGrec_TemporaryTable2.SETFILTER(TempGrec_TemporaryTable2."Axe 3", TempGrec_TemporaryTable."Axe 3");
                IF TempGrec_TemporaryTable2.FINDFIRST() THEN
                    IF TempGrec_TemporaryTable2.COUNT > 1 THEN //il y a plusieurs lignes


                        InsertionExcel(TempGrec_TemporaryTable, Text016, '')//doublon pour cl‚ Matricule,Axe0, Axe1, Axe2,Axe3
                    ELSE BEGIN
                        //si pas de doublons, on recherche les doublons pour la cl‚ Matricule, Axe0, Axe1, Axe3
                        ///Grec_TemporaryTable2.RESET;
                        ///Grec_TemporaryTable2.SETFILTER(Grec_TemporaryTable2."Account No.", Grec_TemporaryTable."Account No.");
                        ///Grec_TemporaryTable2.SETFILTER(Grec_TemporaryTable2."Axe 0", Grec_TemporaryTable."Axe 0");
                        ///Grec_TemporaryTable2.SETFILTER(Grec_TemporaryTable2."Axe 1", Grec_TemporaryTable."Axe 1");
                        ///Grec_TemporaryTable2.SETFILTER(Grec_TemporaryTable2."Axe 3", Grec_TemporaryTable."Axe 3");
                        ///IF Grec_TemporaryTable2.FIND('-') THEN
                        ///IF Grec_TemporaryTable2.COUNT > 1 THEN //il y a plusieurs lignes
                        ///BEGIN
                        //recherche de toutes les lignes commandes NAV pour le matricule
                        Grec_PurchLine.RESET();
                        Grec_PurchLine.SETFILTER("Document Type",
                        FORMAT(Grec_PurchLine."Document Type"::Order));//filtre sur le document type commande
                                                                       //Grec_PurchLine.SETFILTER(Grec_PurchLine."Outstanding Quantity",'>0');//filtre sur quantit‚ restante >0 // Migration Nav 2015
                        Grec_PurchLine.SETFILTER(Grec_PurchLine."BC6_Matricule No.", TempGrec_TemporaryTable2."Account No.");
                        Grec_PurchLine.SETFILTER(Quantity, '<>%1', 0);
                        Grec_PurchLine.SETRANGE(Grec_PurchLine."Quantity Received", 0);
                        Grec_PurchLine.SETRANGE("BC6_VTIME New Line", FALSE); // Nav 2015
                        TempGrec_TemporaryTable3.DELETEALL();
                        IF Grec_PurchLine.FINDLAST() THEN BEGIN
                            REPEAT
                                //puis qui ont la combinaison d'axes Axe0,Axe1,Axe3
                                IF ValidateDimensions(Grec_PurchLine, TempGrec_TemporaryTable2."Axe 0", TempGrec_TemporaryTable2."Axe 1",
                                TempGrec_TemporaryTable2."Axe 2", TempGrec_TemporaryTable2."Axe 3") THEN BEGIN
                                    //on insert la commande dans une table temporaire
                                    Gint_nb += 1;
                                    TempGrec_TemporaryTable3.INIT();
                                    TempGrec_TemporaryTable3."Line No." := Gint_nb;
                                    TempGrec_TemporaryTable3."Document No." := Grec_PurchLine."Document No.";
                                    TempGrec_TemporaryTable3."Account No." := FORMAT(Gint_nb) + '' + Grec_PurchLine."BC6_Matricule No.";
                                    TempGrec_TemporaryTable3."External document No." := FORMAT(Grec_PurchLine."Line No.");//LineNo.
                                    TempGrec_TemporaryTable3.INSERT();
                                END;
                            UNTIL Grec_PurchLine.NEXT() = 0;

                            //v‚rification si x lignes NAV dans la table temporaire
                            IF TempGrec_TemporaryTable3.FIND('-') THEN BEGIN
                                IF TempGrec_TemporaryTable3.COUNT > 1 THEN
                                    InsertionExcel(TempGrec_TemporaryTable2, Text017, '')//doublon pour cl‚ Matricule,Axe0, Axe1,Axe3
                                ELSE BEGIN
                                    //insertion de la reception
                                    Grec_PurchLine2.RESET();
                                    EVALUATE(Gint_LineNo, TempGrec_TemporaryTable3."External document No.");
                                    Grec_PurchLine2.GET(Grec_PurchLine2."Document Type"::Order, TempGrec_TemporaryTable3."Document No.",
                                    Gint_LineNo);
                                    IF NOT (Grec_PurchLine2.Quantity = Grec_PurchLine2."Quantity Invoiced") THEN BEGIN
                                        IF AjouterAxeClient(TempGrec_TemporaryTable2, Grec_PurchLine2) THEN BEGIN
                                            ModifierQuantite(TempGrec_TemporaryTable2, Grec_PurchLine2);
                                            Grec_PurchLine2.GET(Grec_PurchLine2."Document Type"::Order, TempGrec_TemporaryTable3."Document No.",
                                            Gint_LineNo);
                                            ValiderReception(TempGrec_TemporaryTable2, Grec_PurchLine2)
                                        END
                                        ELSE
                                            InsertionExcel(TempGrec_TemporaryTable2, Text020, '');//axe client erron‚
                                    END ELSE
                                        InsertionExcel(TempGrec_TemporaryTable2, Text022, '');//ligne d‚j… factur‚e
                                END;
                            END ELSE
                                InsertionExcel(TempGrec_TemporaryTable2, Text018, '');//aucune ligne nav
                        END ELSE
                            InsertionExcel(TempGrec_TemporaryTable2, Text023, '')//aucune ligne nav
                                                                                 ///END ELSE
                                                                                 ///BEGIN
                                                                                 ///END;
                    END;
            UNTIL TempGrec_TemporaryTable.NEXT() = 0;

        //d‚but traitement log lignes modifi‚es
        IF TempGrec_Temporary_Table_Log_Ini.FIND('-') THEN
            REPEAT
                Gdec_QuantiteIni := 0;
                Gdec_QuantiteIni := TempGrec_Temporary_Table_Log_Ini."Credit amount";
                Gdec_CalculQuantite := 0;
                TempGrec_Temporary_Table_Log_Rec.RESET();
                TempGrec_Temporary_Table_Log_Rec.SETFILTER("Document No.", TempGrec_Temporary_Table_Log_Ini."Document No.");
                TempGrec_Temporary_Table_Log_Rec.SETFILTER("External document No.", FORMAT(TempGrec_Temporary_Table_Log_Ini."External document No."));
                IF TempGrec_Temporary_Table_Log_Rec.FIND('-') THEN
                    REPEAT
                        Gdec_CalculQuantite += TempGrec_Temporary_Table_Log_Rec."Credit amount";
                    UNTIL TempGrec_Temporary_Table_Log_Rec.NEXT() = 0;

                //IF Gdec_CalculQuantite > Grec_Temporary_Table_Log_Ini."Credit amount" THEN
                //BEGIN
                EVALUATE(Gint_NumLigne, TempGrec_Temporary_Table_Log_Ini."External document No.");
                IF Grec_PurchLine.GET(Grec_PurchLine."Document Type"::Order, TempGrec_Temporary_Table_Log_Ini."Document No.",
                Gint_NumLigne) THEN
                    InsertionExcel1(Gdec_QuantiteIni, Gdec_CalculQuantite, TempGrec_Temporary_Table_Log_Ini."Document No.",
                    Grec_PurchLine.Quantity, Gint_NumLigne);
            //END;
            ///END;
            UNTIL TempGrec_Temporary_Table_Log_Ini.NEXT() = 0;
        //fin traitement log lignes modifi‚es

        FinalisationFichierExcel();//Modif JX-AUD 28/02/2012
    END;

    VAR
        TempGrec_Import: Record "BC6_Global temporary table" TEMPORARY;
        TempGrec_Temporary_Table_Log_Ini: Record "BC6_Global temporary table" TEMPORARY;
        TempGrec_Temporary_Table_Log_Rec: Record "BC6_Global temporary table" TEMPORARY;
        TempGrec_TemporaryTable: Record "BC6_Global temporary table" TEMPORARY;
        TempGrec_TemporaryTable2: Record "BC6_Global temporary table" TEMPORARY;
        TempGrec_TemporaryTable3: Record "BC6_Global temporary table" TEMPORARY;
        Grec_DocumentDimension: Record "Dimension Set Entry";
        Grec_DimensionValue: Record "Dimension Value";
        TempExcelBuffer: Record "Excel Buffer" TEMPORARY;
        TempExcelBuffer1: Record "Excel Buffer" TEMPORARY;
        Grec_PurchHeader: Record "Purchase Header";
        Grec_PurchHeader2: Record "Purchase Header";
        Grec_PurchLine: Record "Purchase Line";
        Grec_PurchLine2: Record "Purchase Line";
        Grec_PurchLine3: Record "Purchase Line";
        Grec_PurchaseLineArchive: Record "Purchase Line Archive";
        PurchSetup: Record "Purchases & Payables Setup";
        Grec_Archive_Management: Codeunit ArchiveManagement;
        Gbool_AxeClientOk: Boolean;
        Gbool_AxesOk: Boolean;
        Gdate_DateComptabilisation: Date;
        Gdec_CalculQuantite: Decimal;
        "Gdec_Quantité": Decimal;
        Gdec_QuantiteCmdApresV: Decimal;
        Gdec_QuantiteCmdAvantV: Decimal;
        Gdec_QuantiteIni: Decimal;
        Window: Dialog;
        Window1: Dialog;
        Gint_CompteurLigne: Integer;
        Gint_LineNo: Integer;
        Gint_LineNo2: Integer;
        Gint_nb: Integer;
        Gint_nb1: Integer;
        Gint_NumImport: Integer;
        Gint_NumLigne: Integer;
        RecNo: Integer;
        RecNo1: Integer;
        Row: Integer;
        Row1: Integer;
        TotalRecNo: Integer;
        TotalRecNo1: Integer;
        Text013: Label 'History of lines in error', Comment = 'FRA="Historique des lignes en erreur"';
        Text014: Label 'Analyzing Data...', Comment = 'FRA="Analyse données"';
        Text015: Label 'History of modified lines', Comment = 'FRA="Historique des lignes modifiées"';
        Text016: Label 'Duplicate file F2i Axis 2', Comment = 'FRA="Doublon fichier F2i Axe 2"';
        Text017: Label 'Duplicate Nav', Comment = 'FRA="Doublon Nav"';
        Text018: Label 'Non-existent Nav section', Comment = 'FRA="Section Inexistante Nav"';
        Text020: Label 'Customer axis wrong or blocked', Comment = 'FRA="Axe client erroné ou bloqué"';
        Text022: Label 'Line already billed', Comment = 'FRA="Ligne déjà facturée"';
        Text023: Label 'Non-existent Nav', Comment = 'FRA="Inexistant Nav"';
        Gtxt_DocumentNo2: Text[30];
}

