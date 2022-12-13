tableextension 50019 "BC6_VendorLedgerEntry" extends "Vendor Ledger Entry" //25
{
    fields
    {
        field(50013; "BC6_BC No."; Code[20])
        {
            Caption = 'BC No.', Comment = 'FRA="N° BC"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50014; "BC6_Yooz No."; Code[20])
        {
            Caption = 'No. Yooz', Comment = 'FRA="N° Yooz"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50015; "BC6_Yooz Token link"; Text[250])
        {
            Caption = 'Yooz Token link', Comment = 'FRA="Yooz Token link"';
            Editable = false;
            ExtendedDatatype = URL;
            DataClassification = CustomerContent;
        }
        field(50016; "BC6_Sort Yooz No."; Decimal)
        {
            Caption = 'No. Yooz', Comment = 'FRA="N° Yooz"';
            DecimalPlaces = 0 : 0;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50020; "BC6_Document Type Prepaid"; enum "BC6_Document Type Prepaid")
        {
            Caption = 'Type Document Prépayé', Comment = 'FRA="Type Document Prépayé"';
            DataClassification = CustomerContent;
        }
        field(50021; "BC6_Document Prepaid"; Code[20])
        {
            Caption = 'N° Document Prépayé', Comment = 'FRA="N° Document Prépayé"';
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
