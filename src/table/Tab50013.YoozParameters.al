table 50013 "BC6_Yooz Parameters"
{
    Caption = 'Yooz Parameters';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Yooz Export Path"; Text[250])
        {
            Caption = 'Répertoire Export Yooz';
            DataClassification = CustomerContent;
        }
        field(3; "Yooz Import Path"; Text[250])
        {
            Caption = 'Répertoire Import Automatique Yooz';
            DataClassification = CustomerContent;
        }
        field(4; "Yooz Imported File Path"; Text[250])
        {
            Caption = 'Déplacer Fichiers Importés Automatiquement dans le répertoire';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key50000; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
