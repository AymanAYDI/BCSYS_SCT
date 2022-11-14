tableextension 50019 "BC6_VendorLedgerEntry" extends "Vendor Ledger Entry" //25
{
    fields
    {
        field(50013; "BC6_BC No."; Code[20])
        {
            Caption = 'BC No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50014; "BC6_Yooz No."; Code[20])
        {
            Caption = 'No. Yooz';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50015; "BC6_Yooz Token link"; Text[250])
        {
            Caption = 'Yooz Token link';
            Editable = false;
            ExtendedDatatype = URL;
            DataClassification = CustomerContent;
        }
        field(50016; "BC6_Sort Yooz No."; Decimal)
        {
            Caption = 'No. Yooz';
            DecimalPlaces = 0 : 0;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50020; "BC6_Document Type Prepaid"; enum "BC6_Document Type Prepaid")
        {
            Caption = 'Type Document Prépayé';
            DataClassification = CustomerContent;
        }
        field(50021; "BC6_Document Prepaid"; Code[20])
        {
            Caption = 'N° Document Prépayé';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        /* key(Key1; "Vendor No.", "Applies-to ID", "BC6_Sort Yooz No.")
         {
         }
         key(Key2; "Vendor No.", "BC6_Document Type Prepaid", "BC6_Document Prepaid")
         {
         }*/
    }
}
