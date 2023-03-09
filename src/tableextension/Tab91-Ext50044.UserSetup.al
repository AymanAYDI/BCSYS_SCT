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

        //TODO:Table 'Product Group' is removed.
        // field(50011; BC6_ProductGroupCode; Code[10])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Product Group Code', Comment = 'FRA="Code groupe produit"';
        //     TableRelation = "Product Group".Code WHERE("Item Category Code" = FILTER(''));
        // }
        field(50012; BC6_Sign; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sign', Comment = 'FRA="Signature"';
            trigger OnValidate()
            var
                Text001: Label 'Only one user must be selected !', Comment = 'FRA="Un seul utilisateur doit étre sélectionné !"';
            begin
                IF BC6_Sign THEN BEGIN
                    RecGUserSetup.SETRANGE(BC6_Sign, TRUE);
                    IF NOT RecGUserSetup.ISEMPTY THEN
                        ERROR(Text001);
                END;
            end;
        }
        field(50013; "BC6_Sign Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Sign Name', Comment = 'FRA="Nom et prenom (signature)"';
        }

    }
    var
        RecGUserSetup: Record "User Setup";

}
