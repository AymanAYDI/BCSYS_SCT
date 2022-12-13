tableextension 50010 "BC6_PurchInvHeader" extends "Purch. Inv. Header" //122
{
    fields
    {
        field(50001; "BC6_Original user"; Code[50])
        {
            Caption = 'Original user', Comment = 'FRA="Utilisateur initial"';
            Editable = true;
            TableRelation = "User Setup";
            DataClassification = CustomerContent;
        }
        field(50002; "BC6_Creation date"; Date)
        {
            Caption = 'Creation date', Comment = 'FRA="Date de création"';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(50003; "BC6_Invoice receipt date"; Date)
        {
            Caption = 'Invoice receipt date', Comment = 'FRA="Date réception facture"';
            DataClassification = CustomerContent;
        }
        field(50005; "BC6_Matricule No."; Code[20])
        {
            Caption = 'Code matricule', Comment = 'FRA="Code matricule"';
            TableRelation = "BC6_Matricule";
            DataClassification = CustomerContent;
        }
        field(50012; BC6_Litige; Boolean)
        {
            Caption = 'Litige', Comment = 'FRA="Litige"';
            DataClassification = CustomerContent;
        }
        field(50013; "BC6_BC No."; Code[20])
        {
            Caption = 'BC No.', Comment = 'FRA="N° BC"';
            DataClassification = CustomerContent;
        }
        field(50014; "BC6_Yooz No."; Code[20])
        {
            Caption = 'No. Yooz', Comment = 'FRA="N° Yooz"';
            DataClassification = CustomerContent;
        }
        field(50015; "BC6_Yooz Token link"; Text[250])
        {
            Caption = 'Yooz Token link', Comment = 'FRA="Yooz Token link"';
            DataClassification = CustomerContent;
        }
        field(50030; "BC6_Document Prepaid"; Boolean)
        {
            Caption = 'Document PréPayé', Comment = 'FRA="Document PréPayé"';
            DataClassification = CustomerContent;
        }
        field(50031; "BC6_Amount Prepaid"; Decimal)
        {
            Caption = 'Montant PréPayé', Comment = 'FRA="Montant PréPayé"';
            DataClassification = CustomerContent;
        }
        field(50032; "BC6_Document Type Prepaid"; enum "BC6_Document Type Prepaid")
        {
            Caption = 'Type Document Prépayé', Comment = 'FRA="Type Document Prépayé"';
            DataClassification = CustomerContent;
        }
        field(50033; "BC6_Document No. Prepaid"; Code[20])
        {
            Caption = 'N° Document Prépayé', Comment = 'FRA="N° Document Prépayé"';
            DataClassification = CustomerContent;
        }
    }
}
