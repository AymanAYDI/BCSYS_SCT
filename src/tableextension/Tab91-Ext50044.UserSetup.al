tableextension 50044 "BC6_UserSetup" extends "User Setup" //91
{
    fields
    {
        field(50000; "BC6_Droits acces doc. achat"; enum "BC6_Droits acces doc. achat")
        {
            DataClassification = CustomerContent;
        }
        field(50001; BC6_Service; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Service', Comment = 'FRA="Service"';
        }
        field(50002; BC6_Picture; Blob)
        {
            Caption = 'Signature', Comment = 'FRA="Signature"';
            Subtype = Bitmap;
            DataClassification = CustomerContent;
        }
        field(50003; BC6_Fonction; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Fonction', Comment = 'FRA="Fonction"';
        }
        field(50004; BC6_Nom; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Nom', Comment = 'FRA="Nom"';
        }
        field(50010; BC6_Approbateur; Boolean)
        {
            FieldClass = FlowField;
            Caption = 'Approbateur', Comment = 'FRA="Approbateur"';
            CalcFormula = exist("User Setup" where("Approver ID" = field("User ID")));
            Editable = false;
        }
    }
}
