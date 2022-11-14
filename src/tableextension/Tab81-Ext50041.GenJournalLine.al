tableextension 50041 "BC6_GenJournalLine" extends "Gen. Journal Line" //81
{
    fields
    {
        field(50000; "BC6_Vendor No."; Code[20])
        {
            Caption = 'N° Fournisseur';
            TableRelation = Vendor."No.";
            DataClassification = CustomerContent;
        }
        field(50001; "BC6_Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;
        }
        field(50002; "BC6_Temp Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50003; "BC6_Temp Rcpt No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50004; "BC6_Temp Rcpt Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
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
        field(50020; "BC6_Document Type Prepaid"; enum "BC6_Document Type Prepaid")
        {
            DataClassification = CustomerContent;
        }
        field(50021; "BC6_Document Prepaid"; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }
}
