report 50096 "BC6_Update Receipt Status"
{
    ProcessingOnly = true;
    UseRequestPage = false;
    Caption = 'Update Receipt Status';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                trigger OnAfterGetRecord()
                begin
                    UpdateVATAmounts();
                    MODIFY();
                end;
            }

            trigger OnAfterGetRecord()
            begin
                BC6_FunctMgt.FctReceiptStatus("Purchase Header");
                MODIFY();
                W.UPDATE(1, "Purchase Header"."No.");
            end;

            trigger OnPostDataItem()
            begin
                W.CLOSE();
            end;

            trigger OnPreDataItem()
            begin
                W.OPEN('#1##############');
            end;
        }
    }
    var

        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
        W: Dialog;
}

