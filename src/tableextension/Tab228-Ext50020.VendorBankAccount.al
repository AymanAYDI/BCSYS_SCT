tableextension 50020 "BC6_VendorBankAccount" extends "Vendor Bank Account" //228
{
    fields
    {
        field(50000; "BC6_Change RIB/IBAN"; Date)
        {
            Caption = 'Change RIB/IBAN';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }
}
