tableextension 50010 "BC6_PurchInvHeader" extends "Purch. Inv. Header" //122
{
    fields
    {
        field(50001; "BC6_Original user"; Code[50])
        {
            Caption = 'Original user';
            Editable = true;
            TableRelation = "User Setup";
            DataClassification = CustomerContent;
        }
        field(50002; "BC6_Creation date"; Date)
        {
            Caption = 'Creation date';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(50003; "BC6_Invoice receipt date"; Date)
        {
            Caption = 'Invoice receipt date';
            DataClassification = CustomerContent;
        }
        field(50005; "BC6_Matricule No."; Code[20])
        {
            Caption = 'Code matricule';
            TableRelation = "BC6_Matricule";
            DataClassification = CustomerContent;
        }
        field(50012; BC6_Litige; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50013; "BC6_BC No."; Code[20])
        {
            Caption = 'BC No.';
            DataClassification = CustomerContent;
        }
        field(50014; "BC6_Yooz No."; Code[20])
        {
            Caption = 'No. Yooz';
            DataClassification = CustomerContent;
        }
        field(50015; "BC6_Yooz Token link"; Text[250])
        {
            Caption = 'Yooz Token link';
            DataClassification = CustomerContent;
        }
        field(50030; "BC6_Document Prepaid"; Boolean)
        {
            Caption = 'Document PréPayé';
            DataClassification = CustomerContent;
        }
        field(50031; "BC6_Amount Prepaid"; Decimal)
        {
            Caption = 'Montant PréPayé';
            DataClassification = CustomerContent;
        }
        field(50032; "BC6_Document Type Prepaid"; enum "BC6_Document Type Prepaid")
        {
            Caption = 'Type Document Prépayé';
            DataClassification = CustomerContent;
        }
        field(50033; "BC6_Document No. Prepaid"; Code[20])
        {
            Caption = 'N° Document Prépayé';
            DataClassification = CustomerContent;
        }
    }
}
