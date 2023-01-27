report 50091 "BC6_Update Vat Amounts"
{
    ProcessingOnly = true;
    UseRequestPage = false;
    Caption = 'Update Vat Amounts';

    dataset
    {
        dataitem("Purchase Line"; "Purchase Line")
        {
            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE("Document Type" = FILTER(Order | Invoice));

            trigger OnAfterGetRecord()
            begin
                W.UPDATE(1, "Document No.");
                UpdateVATAmounts();
                MODIFY();
            end;
        }
    }
    trigger OnPreReport()
    begin
        W.OPEN('#1##########');
    end;

    var
        W: Dialog;
}

