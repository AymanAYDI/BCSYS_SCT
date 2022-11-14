report 50062 "BC6_Modifier axes avoir ventes"
{
    Caption = 'Modify CrMemo dimensions ';
    Permissions = tabledata "G/L Entry" = rm,
                  tabledata "Sales Cr.Memo Line" = rm,
                  tabledata "FA Ledger Entry" = rm,
                  tabledata "Value Entry" = rm;
    ProcessingOnly = true;
    UseRequestPage = false;
    UseSystemPrinter = false;

    dataset
    {
        dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
        {
            DataItemTableView = sorting("Document No.", "Line No.");
            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemLink = "Document No." = field("Document No.");
                DataItemTableView = sorting("Entry No.");

                trigger OnAfterGetRecord()
                var
                    L_GLEntry: Record "G/L Entry";
                begin
                    //BC6 EABO 16/01/20 >>
                    //IF Grec_GLEntry.GET("Value Entry"."Entry No.") THEN BEGIN
                    // Grec_GLEntry."Dimension Set ID" := Gnew_DimSetID;
                    // Grec_GLEntry.MODIFY;
                    //END;
                    if L_GLEntry.GET("G/L Entry"."Entry No.") then begin
                        L_GLEntry."Dimension Set ID" := Gnew_DimSetID;
                        L_GLEntry.MODIFY();
                    end;
                    //BC6 EABO 16/01/20 <<
                end;

                trigger OnPreDataItem()
                begin
                    //BC6 EABO 16/01/20 >>
                    if "Sales Cr.Memo Line".Type <> "Sales Cr.Memo Line".Type::"G/L Account" then
                        CurrReport.BREAK();
                    SETRANGE("G/L Account No.", "Sales Cr.Memo Line"."No.");
                    //BC6 EABO 16/01/20 <<
                    Window.UPDATE(1, 'Phase 1/3 G/L Entry');
                end;
            }
            dataitem(DataItem8894; "Value Entry")
            {
                DataItemLink = "Document No." = field("Document No."), "Document Line No." = field("Line No.");
                DataItemTableView = sorting("Document No.");

                trigger OnAfterGetRecord()
                begin
                    //BCSYS 231220
                    //IF Grec_ValueEntry.GET("Value Entry"."Entry No.") THEN BEGIN
                    // Grec_ValueEntry."Dimension Set ID" := Gnew_DimSetID;
                    // Grec_ValueEntry.MODIFY;
                    //END;
                    "Dimension Set ID" := Gnew_DimSetID;
                    MODIFY();
                    //FIN BCSYS 231220
                end;

                trigger OnPreDataItem()
                begin
                    Window.UPDATE(1, 'Phase 2/3 Value Entry');
                end;
            }
            dataitem("FA Ledger Entry"; "FA Ledger Entry")
            {
                DataItemLink = "Document No." = field("Document No."), "FA No." = field("No.");
                DataItemTableView = sorting("Entry No.");

                trigger OnAfterGetRecord()
                var
                    L_FALedgerEntry: Record "FA Ledger Entry";
                begin
                    //BC6 EABO 16/01/20 >>
                    //IF Grec_FALedgerEntry.GET("Value Entry"."Entry No.") THEN BEGIN
                    // Grec_FALedgerEntry."Dimension Set ID" := Gnew_DimSetID;
                    // Grec_FALedgerEntry.MODIFY;
                    //END;

                    if L_FALedgerEntry.GET("FA Ledger Entry"."Entry No.") then begin
                        L_FALedgerEntry."Dimension Set ID" := Gnew_DimSetID;
                        L_FALedgerEntry.MODIFY();
                    end;
                    //BC6 EABO 16/01/20 <<
                end;

                trigger OnPreDataItem()
                begin
                    //BC6 EABO 16/01/20 >>
                    if "Sales Cr.Memo Line".Type <> "Sales Cr.Memo Line".Type::"G/L Account" then
                        CurrReport.BREAK();

                    SETRANGE("Dimension Set ID", GLast_DimSetID);
                    //BC6 EABO 16/01/20 <<

                    Window.UPDATE(1, 'Phase 3/3 FA Ledger Entry');
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Gcode_AxeReserveLigneFacture := '';
                if Grec_DimSetEntry.GET("Dimension Set ID", Gcode_AxeReserve) then
                    Gcode_AxeReserveLigneFacture := Grec_DimSetEntry."Dimension Value Code";

                if Gcode_AxeReserveLigneFacture = '' then
                    if not CONFIRM(Text006) then
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

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    var
        Lrec_Dimension: Record Dimension;
    begin
        //Test existence axe analytique
        Gcode_AxeReserve := 'RESERVE';
        if not Lrec_Dimension.GET(Gcode_AxeReserve) then
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
        Gcode_AxeReserve: Code[20];
        Gcode_AxeReserveLigneFacture: Code[20];
        Gcode_DocumentNo: Code[20];
        Gcode_ItemNo: Code[20];
        Window: Dialog;
        Gcode_LineNo: Integer;
        GLast_DimSetID: Integer;
        Gnew_DimSetID: Integer;
        Text002: label 'Operation canceled !';
        Text005: label 'To use the change function of analytics, you must create an analytical axis named ''RESERVE''';
        Text006: label 'This document was created before the introduction of the modified analytical functionality.\\The accounting entries will not be updated.\\Would you still continue?';

    procedure SetPostedInvoice(Prec_SalesCrMemoLine: Record "Sales Cr.Memo Line"; pi_NewDimSetID: Integer)
    begin
        Gcode_DocumentNo := Prec_SalesCrMemoLine."Document No.";
        Gcode_LineNo := Prec_SalesCrMemoLine."Line No.";
        Gcode_ItemNo := Prec_SalesCrMemoLine."No.";
        Gnew_DimSetID := pi_NewDimSetID;
        //BC6 EABO 16/01/20 >>
        GLast_DimSetID := Prec_SalesCrMemoLine."Dimension Set ID";
        //BC6 EABO 16/01/20 <<
    end;
}
