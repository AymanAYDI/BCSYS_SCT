report 50038 "BC6_Modifier axes avoir"
{
    // JX-XAD 24/03/2010
    // Modification des axes analyutiques pour les factures enregistrées
    // 
    // JX-AUD 25/05/2011
    // Modification sur la visibilité des axes analytiques s'ils existent
    // 
    // BC6 EABO 16/01/20

    Caption = 'Modify invoice dimensions', Comment = 'FRA="Modifier axes facture"';
    Permissions = TableData "G/L Entry" = rm,
                  TableData "Purch. Cr. Memo Line" = rm,
                  TableData "FA Ledger Entry" = rm,
                  TableData "Value Entry" = rm;
    ProcessingOnly = true;
    UseRequestPage = false;
    UseSystemPrinter = false;

    dataset
    {
        dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.");
            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemLink = "Document No." = FIELD("Document No.");
                DataItemTableView = SORTING("Entry No.");

                trigger OnAfterGetRecord()
                var
                    L_GLEntry: Record "G/L Entry";
                begin
                    //BC6 EABO 16/01/20 >>
                    //"Dimension Set ID" := Gnew_DimSetID;
                    //MODIFY;
                    IF L_GLEntry.GET("G/L Entry"."Entry No.") THEN BEGIN
                        L_GLEntry."Dimension Set ID" := Gnew_DimSetID;
                        L_GLEntry.MODIFY();
                    END;
                    //BC6 EABO 16/01/20 <<
                end;

                trigger OnPreDataItem()
                begin
                    //BC6 EABO 16/01/20 >>
                    IF "Purch. Cr. Memo Line".Type <> "Purch. Cr. Memo Line".Type::"G/L Account" THEN
                        CurrReport.BREAK();
                    SETRANGE("G/L Account No.", "Purch. Cr. Memo Line"."No.");
                    //SETRANGE("Dimension Set ID",GLast_DimSetID);
                    //SETRANGE(Amount,"Purch. Cr. Memo Line".Amount * (-1));
                    //BC6 EABO 16/01/20 <<

                    Window.UPDATE(1, 'Phase 1/3 G/L Entry');
                end;
            }
            dataitem(DataItem8894; "Value Entry")
            {
                DataItemLink = "Document No." = FIELD("Document No."), "Document Line No." = FIELD("Line No.");
                DataItemTableView = SORTING("Entry No.");

                trigger OnAfterGetRecord()
                begin
                    "Dimension Set ID" := Gnew_DimSetID;
                    MODIFY();
                end;

                trigger OnPreDataItem()
                begin
                    Window.UPDATE(1, 'Phase 2/3 Value Entry');
                end;
            }
            dataitem("FA Ledger Entry"; "FA Ledger Entry")
            {
                DataItemLink = "Document No." = FIELD("Document No."), "FA No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.");

                trigger OnAfterGetRecord()
                var
                    L_FALedgerEntry: Record "FA Ledger Entry";
                begin
                    //BC6 EABO 16/01/20 >>
                    //"Dimension Set ID" := Gnew_DimSetID;
                    //MODIFY;
                    IF L_FALedgerEntry.GET("FA Ledger Entry"."Entry No.") THEN BEGIN
                        L_FALedgerEntry."Dimension Set ID" := Gnew_DimSetID;
                        L_FALedgerEntry.MODIFY();
                    END;
                    //BC6 EABO 16/01/20 <<
                end;

                trigger OnPreDataItem()
                begin
                    //BC6 EABO 16/01/20 >>
                    IF "Purch. Cr. Memo Line".Type <> "Purch. Cr. Memo Line".Type::"G/L Account" THEN
                        CurrReport.BREAK();

                    SETRANGE("Dimension Set ID", GLast_DimSetID);
                    //BC6 EABO 16/01/20 <<

                    Window.UPDATE(1, 'Phase 3/3 FA Ledger Entry');
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Gcode_AxeReserveLigneFacture := '';
                IF Grec_DimSetEntry.GET("Dimension Set ID", Gcode_AxeReserve) THEN
                    Gcode_AxeReserveLigneFacture := Grec_DimSetEntry."Dimension Value Code";

                IF Gcode_AxeReserveLigneFacture = '' THEN
                    IF NOT CONFIRM(Text006) THEN
                        ERROR(Text002);

                //BC6 EABO 16/01/20 >>
                "Dimension Set ID" := Gnew_DimSetID;
                MODIFY();
                //BC6 EABO 16/01/20 <<
            end;

            trigger OnPostDataItem()
            begin
                //BC6 EABO 16/01/20 >>
                //"Dimension Set ID" := Gnew_DimSetID;
                //MODIFY;
                //BC6 EABO 16/01/20 <<
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Document No.", '%1', Gcode_DocumentNo);
                SETFILTER("Line No.", '%1', Gcode_LineNo);
            end;
        }
    }

    trigger OnInitReport()
    var
        Lrec_Dimension: Record Dimension;
    begin
        //Test existence axe analytique
        Gcode_AxeReserve := 'RESERVE';
        IF NOT Lrec_Dimension.GET(Gcode_AxeReserve) THEN
            ERROR(Text005);
    end;

    trigger OnPostReport()
    begin
        Window.CLOSE();
    end;

    trigger OnPreReport()
    begin
        Window.OPEN('#1########################');
    end;

    var
        Grec_DimSetEntry: Record "Dimension Set Entry";
        Text002: Label 'Operation canceled !', Comment = 'FRA="Opération annulée !"';
        Gcode_DocumentNo: Code[20];
        Gcode_LineNo: Integer;
        Gcode_ItemNo: Code[20];
        Text005: Label 'To use the change function of analytics, you must create an analytical axis named ''RESERVE''', Comment = 'FRA="Pour utiliser la fonction de modification de l''analytique,\\vous devez créer un axe analytique nommé ''RESERVE''"';
        Text006: Label 'This document was created before the introduction of the modified analytical functionality.\\The accounting entries will not be updated.\\Would you still continue?', Comment = 'FRA="Ce document a été créé avant la mise en place de la fonctionnalité de modification analytique.\\Les écritures comptables ne pourront pas être mises à jour.\\Souhaitez-vous tout de même poursuivre ?"';
        Gcode_AxeReserve: Code[20];
        Gcode_AxeReserveLigneFacture: Code[20];
        Gnew_DimSetID: Integer;
        Window: Dialog;
        GLast_DimSetID: Integer;

    procedure SetPostedInvoice(Prec_PurchCrMemoLine: Record "Purch. Cr. Memo Line"; pi_NewDimSetID: Integer)
    begin
        Gcode_DocumentNo := Prec_PurchCrMemoLine."Document No.";
        Gcode_LineNo := Prec_PurchCrMemoLine."Line No.";
        Gcode_ItemNo := Prec_PurchCrMemoLine."No.";
        Gnew_DimSetID := pi_NewDimSetID;
        //BC6 EABO 16/01/20 >>
        GLast_DimSetID := Prec_PurchCrMemoLine."Dimension Set ID";
        //BC6 EABO 16/01/20 <<
    end;
}

