tableextension 50035 "BC6_InvoicePostingBuffer" extends "Invoice Posting Buffer" //55
{
    fields
    {
        field(50000; BC6_Description; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
    }
}

