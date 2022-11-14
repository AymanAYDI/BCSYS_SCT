report 50063 "Modifier axes écritures compta"
{
    Permissions = tabledata "G/L Entry" = rm,
                  tabledata "Cust. Ledger Entry" = rm,
                  tabledata "Vendor Ledger Entry" = rm,
                  tabledata "FA Ledger Entry" = rm;
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = sorting("Entry No.");
            dataitem(DataItem8503; "Cust. Ledger Entry")
            {
                DataItemLink = "Entry No." = field("Entry No.");
                DataItemTableView = sorting("Entry No.");

                trigger OnAfterGetRecord()
                begin
                    "Dimension Set ID" := Gnew_DimSetID;
                    MODIFY();
                end;

                trigger OnPreDataItem()
                begin
                    Window.UPDATE(1, 'Phase 1/3 Cust. Ledger Entry');
                end;
            }
            dataitem(DataItem4114; "Vendor Ledger Entry")
            {
                DataItemLink = "Entry No." = field("Entry No.");
                DataItemTableView = sorting("Entry No.");

                trigger OnAfterGetRecord()
                begin
                    "Dimension Set ID" := Gnew_DimSetID;
                    MODIFY();
                end;

                trigger OnPreDataItem()
                begin
                    Window.UPDATE(1, 'Phase 2/3 Vendor Ledger Entry');
                end;
            }
            dataitem(DataItem9888; "FA Ledger Entry")
            {
                DataItemLink = "G/L Entry No." = field("Entry No.");
                DataItemTableView = sorting("Entry No.");

                trigger OnAfterGetRecord()
                begin
                    "Dimension Set ID" := Gnew_DimSetID;
                    MODIFY();
                end;

                trigger OnPreDataItem()
                begin
                    Window.UPDATE(1, 'Phase 3/3 FA Ledger Entry');
                end;
            }

            trigger OnAfterGetRecord()
            begin
                "Dimension Set ID" := Gnew_DimSetID;
                MODIFY();
            end;

            trigger OnPreDataItem()
            begin
                /* // Modification PBD 04/09/15
                IF (COPYSTR(Gcode_DocumentNo,1,3) = 'FNP') OR
                   (COPYSTR(Gcode_DocumentNo,1,5) = 'EXFNP') OR
                   (COPYSTR(Gcode_DocumentNo,1,6) = 'EXTFNP') THEN
                BEGIN
                  IF Lrec_GL_Entry.GET(Gint_EntryNo) THEN
                    SETFILTER("G/L Entry"."Transaction No.",'%1',Lrec_GL_Entry."Transaction No.")
                  ELSE
                    SETFILTER("G/L Entry"."Entry No.",'%1',Gint_EntryNo);
                END ELSE                      */

                SETFILTER("G/L Entry"."Entry No.", '%1', Gint_EntryNo);
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
    begin
        Gcode_AxeReserve := 'RESERVE';
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
        Gcode_AccountNo: Code[20];
        Gcode_AxeReserve: Code[20];
        Gcode_DocumentNo: Code[20];
        Window: Dialog;
        Gint_EntryNo: Integer;
        Gint_FA_EntryNo: Integer;
        Gnew_DimSetID: Integer;

    procedure SetGLEntry(Prec_GLEntry: Record "G/L Entry"; pi_NewDimSetID: Integer)
    begin
        Gcode_DocumentNo := Prec_GLEntry."Document No.";
        Gint_EntryNo := Prec_GLEntry."Entry No.";
        Gint_FA_EntryNo := Prec_GLEntry."FA Entry No.";
        Gcode_AccountNo := Prec_GLEntry."G/L Account No.";
        Gnew_DimSetID := pi_NewDimSetID;
    end;
}
