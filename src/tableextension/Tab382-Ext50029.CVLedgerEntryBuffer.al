tableextension 50029 "BC6_CVLedgerEntryBuffer" extends "CV Ledger Entry Buffer" //382
{
    fields
    {
        field(50020; "BC6_Document Type Prepaid"; enum "BC6_Document Type Prepaid")
        {
            DataClassification = CustomerContent;
        }
        field(50021; "BC6_Document Prepaid"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'N° Document Prépayé';
        }
    }
}
