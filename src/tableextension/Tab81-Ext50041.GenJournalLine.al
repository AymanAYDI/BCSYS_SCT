tableextension 50041 "BC6_GenJournalLine" extends "Gen. Journal Line" //81
{
    fields
    {
        field(50000; "BC6_Vendor No."; Code[20])
        {
            Caption = 'N° Fournisseur', Comment = 'FRA="N° Fournisseur"';
            TableRelation = Vendor."No.";
            DataClassification = CustomerContent;
        }
        field(50001; "BC6_Customer No."; Code[20])
        {
            Caption = 'Customer No.', Comment = 'FRA="N° Client"';
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;
        }
        field(50002; "BC6_Temp Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Temp Entry No.', Comment = 'FRA="Temp Entry No."';
        }
        field(50003; "BC6_Temp Rcpt No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Temp Rcpt No.', Comment = 'FRA="Temp Rcpt No."';
        }
        field(50004; "BC6_Temp Rcpt Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Temp Rcpt Line No.', Comment = 'FRA="Temp Rcpt Line No."';
        }
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
        field(50020; "BC6_Document Type Prepaid"; enum "BC6_Document Type Prepaid")
        {
            DataClassification = CustomerContent;
            Caption = 'Document Type Prepaid', Comment = 'FRA="Type Document Prépayé"';
        }
        field(50021; "BC6_Document Prepaid"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document Prepaid', Comment = 'FRA="Document Prepaid"';
        }
    }
    procedure ShowShortcutDimCodeV(var ShortcutDimCode: array[8] of Code[20])
    var
        FunctionsMgt: Codeunit BC6_FunctionsMgt;
    begin
        FunctionsMgt.Cdu408_GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

}
