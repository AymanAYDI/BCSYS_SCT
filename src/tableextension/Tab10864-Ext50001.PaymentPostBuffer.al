tableextension 50001 "BC6_PaymentPostBuffer" extends "Payment Post. Buffer" //10864
{
    fields
    {
        field(50000; "BC6_Document Type Prepaid"; Option)
        {
            Caption = 'Document Type Prepaid';
            OptionCaption = ' ,Quote,Order,FAP';
            OptionMembers = " ",Quote,Order,FAP;
            DataClassification = CustomerContent;
        }
        field(50001; "BC6_Document Prepaid"; Code[20])
        {
            Caption = 'Document Prepaid';
            DataClassification = CustomerContent;
        }
    }
}

