report 50037 "BC6_Modifier axes facture"
{
    Caption = 'Modify invoice dimensions ';
    Permissions = tabledata "G/L Entry" = rm,
                  tabledata "Purch. Rcpt. Line" = rm,
                  tabledata "Purch. Inv. Line" = rm,
                  tabledata "Purch. Cr. Memo Line" = rm,
                  tabledata "FA Ledger Entry" = rm,
                  tabledata "Value Entry" = rm;
    ProcessingOnly = true;
    UseRequestPage = false;
    UseSystemPrinter = false;

    dataset
    {
        dataitem(DataItem5707; "Purch. Inv. Line")
        {
            DataItemTableView = sorting("Document No.", "Line No.");
            dataitem(DataItem7069; "G/L Entry")
            {
                DataItemLink = "Document No." = field("Document No.");
                DataItemTableView = sorting("Document Type", "Document No.") where("Document Type" = const(Invoice));

                trigger OnAfterGetRecord()
                begin
                    "Dimension Set ID" := Gnew_DimSetID;
                    MODIFY();
                end;

                trigger OnPreDataItem()
                begin
                    Window.UPDATE(1, 'Phase 1/3 G/L Entry');
                    SETRANGE("Dimension Set ID", Gold_DimSetID);
                end;
            }
            dataitem(DataItem8894; "Value Entry")
            {
                DataItemLink = "Document No." = field("Document No."), "Document Line No." = field("Line No.");
                DataItemTableView = sorting("Entry No.");

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
            dataitem(DataItem9888; "FA Ledger Entry")
            {
                DataItemLink = "Document No." = field("Document No."), "FA No." = field("No.");
                DataItemTableView = sorting("Entry No.");

                trigger OnAfterGetRecord()
                begin
                    "Dimension Set ID" := Gnew_DimSetID;
                    MODIFY();
                end;

                trigger OnPreDataItem()
                begin
                    Window.UPDATE(1, 'Phase 3/3 FA Ledger Entry');
                    SETRANGE("Dimension Set ID", Gold_DimSetID);
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

                "Dimension Set ID" := Gnew_DimSetID;
                MODIFY();
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Document No.", '%1', Gcode_DocumentNo);
                SETFILTER("Line No.", '%1', Gcode_LineNo);
            end;
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
        Gnew_DimSetID: Integer;
        Gold_DimSetID: Integer;
        Text002: label 'Operation canceled !';
        Text005: label 'To use the change function of analytics, you must create an analytical axis named ''RESERVE''';
        Text006: label 'This document was created before the introduction of the modified analytical functionality.\\The accounting entries will not be updated.\\Would you still continue?';

    procedure SetPostedInvoice(Prec_PurchInvLine: Record "Purch. Inv. Line"; pi_NewDimSetID: Integer)
    begin
        Gcode_DocumentNo := Prec_PurchInvLine."Document No.";
        Gcode_LineNo := Prec_PurchInvLine."Line No.";
        Gcode_ItemNo := Prec_PurchInvLine."No.";
        Gnew_DimSetID := pi_NewDimSetID;
        Gold_DimSetID := Prec_PurchInvLine."Dimension Set ID";
    end;
}
