report 50024 "Modifier axe période avoirs"
{
    Caption = 'Modify period dimension for credit memos';
    ProcessingOnly = true;
    UseSystemPrinter = false;

    dataset
    {
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            DataItemTableView = sorting("No.");
            dataitem("Dimension Set Entry"; "Dimension Set Entry")
            {
                DataItemLink = "Dimension Set ID" = field("Dimension Set ID");
                DataItemTableView = sorting("Dimension Set ID", "Dimension Code");
                //DataItemTableView = SORTING("Table ID", "Document No.", "Line No.", "Dimension Code") WHERE("Dimension Code" = CONST(PERIODE));

                trigger OnAfterGetRecord()
                begin
                    "Dimension Set Entry"."Dimension Value Code" := Gcode_AxePériode;
                    MODIFY();
                end;
            }
            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Entry No.");
                dataitem(LedgerEntryDimension1; "Dimension Set Entry")
                {
                    DataItemLink = "Dimension Set ID" = field("Dimension Set ID");
                    DataItemTableView = sorting("Dimension Set ID", "Dimension Code");
                    //DataItemTableView = SORTING(Table ID, Entry No., Dimension Code) WHERE(Table ID=CONST(17),Dimension Code=CONST(PERIODE));

                    trigger OnAfterGetRecord()
                    begin
                        LedgerEntryDimension1."Dimension Value Code" := Gcode_AxePériode;
                        MODIFY();
                    end;
                }
            }
            dataitem("Value Entry"; "Value Entry")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Entry No.");
                dataitem(LedgerEntryDimension2; "Dimension Set Entry")
                {
                    DataItemLink = "Dimension Set ID" = field("Dimension Set ID");
                    DataItemTableView = sorting("Dimension Set ID", "Dimension Code");
                    //DataItemTableView = SORTING(Table ID, Entry No., Dimension Code)WHERE(Table ID=CONST(5802),Dimension Code=CONST(PERIODE));

                    trigger OnAfterGetRecord()
                    begin
                        LedgerEntryDimension2."Dimension Value Code" := Gcode_AxePériode;
                        MODIFY();
                    end;
                }
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Entry No.");
                dataitem(LedgerEntryDimension3; "Dimension Set Entry")
                {
                    DataItemLink = "Dimension Set ID" = field("Dimension Set ID");
                    DataItemTableView = sorting("Dimension Set ID", "Dimension Code");
                    //DataItemTableView = SORTING(Table ID, Entry No., Dimension Code)WHERE(Table ID=CONST(25),Dimension Code=CONST(PERIODE));

                    trigger OnAfterGetRecord()
                    begin
                        LedgerEntryDimension3."Dimension Value Code" := Gcode_AxePériode;
                        MODIFY();
                    end;
                }
            }
            dataitem("FA Ledger Entry"; "FA Ledger Entry")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Entry No.");
                dataitem(LedgerEntryDimension4; "Dimension Set Entry")
                {
                    DataItemLink = "Dimension Set ID" = field("Dimension Set ID");
                    DataItemTableView = sorting("Dimension Set ID", "Dimension Code");
                    //DataItemTableView = SORTING(Table ID, Entry No., Dimension Code)WHERE(Table ID=CONST(5601),Dimension Code=CONST(PERIODE));

                    trigger OnAfterGetRecord()
                    begin
                        LedgerEntryDimension4."Dimension Value Code" := Gcode_AxePériode;
                        MODIFY();
                    end;
                }
            }

            trigger OnAfterGetRecord()
            begin
                if not CONFIRM(Text001, false, "No.") then
                    ERROR(Text002);

                /*
                IF NOT Grec_PostedDocDim2.GET(122,"Purch. Inv. Header"."No.",0,'PERIODE') THEN
                BEGIN
                  Grec_PostedDocDim2.INIT;
                  Grec_PostedDocDim2."Table ID" := 122;
                  Grec_PostedDocDim2."Document No." := "Purch. Inv. Header"."No.";
                  Grec_PostedDocDim2."Line No." := 0;
                  Grec_PostedDocDim2."Dimension Code" := 'PERIODE';
                  Grec_PostedDocDim2."Dimension Value Code" := Gcode_AxePériode;
                  Grec_PostedDocDim2.INSERT;
                END;
                */
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("No.", '%1', Grec_PurchCreditMemo."No.");
            end;
        }
    }

    var
        Grec_PurchCreditMemo: Record "Purch. Cr. Memo Hdr.";
        "Gcode_AxePériode": Code[20];
        // Grec_PostedDocDim: Record "Dimension Set Entry";
        // Grec_PostedDocDim2: Record "Dimension Set Entry";
        Text001: label 'All accounting will be updated to the credit memo %1';
        Text002: label 'Operation canceled !';

    procedure SetPostedCreditMemo(Lrec_PurchCreditMemo: Record "Purch. Cr. Memo Hdr.")
    begin
        Grec_PurchCreditMemo := Lrec_PurchCreditMemo;
    end;
}
