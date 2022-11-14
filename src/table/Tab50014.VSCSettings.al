table 50014 "BC6_VSC Settings"
{
    Caption = 'VSC Settings';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; "On Client"; Boolean)
        {
            Caption = 'Instance Client';
            DataClassification = CustomerContent;
        }
        field(3; "New Server"; Boolean)
        {
            Caption = 'Réutilisation Instance';
            DataClassification = CustomerContent;
        }
        field(10; "BC Path"; Text[250])
        {
            Caption = 'Dossier Fichier PDF BC';
            DataClassification = CustomerContent;
        }
        field(11; "BC Test Mode"; Boolean)
        {
            Caption = 'Mode Test BC';
            DataClassification = CustomerContent;
        }
        field(12; "BC E-Mail Test"; Text[100])
        {
            Caption = 'E-mail Test BC';
            DataClassification = CustomerContent;
        }
        field(13; "BCUse Temporary Path"; Boolean)
        {
            Caption = 'Utiliser répertoire temporaire';
            DataClassification = CustomerContent;
        }
        field(20; "Draft Account. Dep. Manag"; Text[100])
        {
            Caption = 'Avis Virement : Nom du responsable';
            DataClassification = CustomerContent;
        }
        field(21; "Draft Account. Dep. Phone"; Code[20])
        {
            Caption = 'Avis Virement : Téléphone';
            DataClassification = CustomerContent;
        }
        field(30; "URL Type"; enum "BC6_URL Type")
        {
            Caption = 'Type URL';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
