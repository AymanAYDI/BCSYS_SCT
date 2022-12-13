report 50023 "Modifier axe période factures"
{
    Caption = 'Modify period dimension for invoices', Comment = 'FRA="Modifier axe période factures"';
    ProcessingOnly = true;
    UseSystemPrinter = false;
    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            DataItemTableView = sorting("No.");
            dataitem(DimensionSetEntry; "Dimension Set Entry")
            {
                DataItemLink = "Dimension Set ID" = field("Dimension Set ID");
                DataItemTableView = sorting("Dimension Set ID", "Dimension Code"); // TODO: a vérifier
                //DataItemTableView = SORTING("Dimension Set ID", "Line No.", "Dimension Code") WHERE("Dimension Code" = CONST(PERIODE));

                trigger OnAfterGetRecord()
                begin
                    DimensionSetEntry."Dimension Value Code" := Gcode_AxePériode;
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
                    //DataItemTableView = SORTING("Table ID", "Dimension Set ID", "Dimension Code") WHERE("Table ID" = CONST(17), "Dimension Code" = CONST(PERIODE));

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
                    //DataItemTableView = SORTING("Table ID", "Dimension Set ID", "Dimension Code") WHERE("Table ID" = CONST(5802), "Dimension Code" = CONST(PERIODE));
                    trigger OnAfterGetRecord()
                    begin
                        LedgerEntryDimension2."Dimension Value Code" := Gcode_AxePériode;
                        MODIFY();
                    end;
                }
            }
            dataitem(DataItem4114; "Vendor Ledger Entry")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Entry No.");
                dataitem(LedgerEntryDimension3; "Dimension Set Entry")
                {
                    DataItemLink = "Dimension Set ID" = field("Dimension Set ID");
                    DataItemTableView = sorting("Dimension Set ID", "Dimension Code");
                    //DataItemTableView = SORTING("Table ID", "Dimension Set ID", "Dimension Code") WHERE("Table ID" = CONST(25), "Dimension Code" = CONST(PERIODE));

                    trigger OnAfterGetRecord()
                    begin
                        LedgerEntryDimension3."Dimension Value Code" := Gcode_AxePériode;
                        MODIFY();
                    end;
                }
            }
            dataitem(DataItem9888; "FA Ledger Entry")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Entry No.");
                dataitem(LedgerEntryDimension4; "Dimension Set Entry")
                {
                    DataItemLink = "Dimension Set ID" = field("Dimension Set ID");
                    DataItemTableView = sorting("Dimension Set ID", "Dimension Code");
                    //DataItemTableView = SORTING("Table ID", "Dimension Set ID", "Dimension Code") WHERE("Table ID" = CONST(5601), "Dimension Code" = CONST(PERIODE));

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
                SETFILTER("No.", '%1', Grec_PurchInvHeader."No.");
            end;
        }
    }

    var
        Grec_PurchInvHeader: Record "Purch. Inv. Header";
        "Gcode_AxePériode": Code[20];
        Text001: label 'All accounting will be updated to the invoice %1', Comment = 'FRA="Toute la comptabilité analytique sera mise à jour pour la facture %1"';
        Text002: label 'Operation canceled !', Comment = 'FRA="Facture enregistrée n° : "';

    procedure SetPostedInvoice(Lrec_PurchInvHeader: Record "Purch. Inv. Header")
    begin
        Grec_PurchInvHeader := Lrec_PurchInvHeader;
    end;
}
