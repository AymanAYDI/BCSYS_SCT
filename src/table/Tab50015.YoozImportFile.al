table 50015 "BC6_Yooz Import File"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(5; "Yooz Import"; Boolean)
        {
            Caption = 'Import Yooz';
            DataClassification = CustomerContent;
        }
        field(10; "File Name"; Text[250])
        {
            Caption = 'Nom du Fichier';
            DataClassification = CustomerContent;
        }
        field(11; "File Name 2"; Text[250])
        {
            Caption = 'Nom du Fichier2';
            DataClassification = CustomerContent;
        }
        field(20; "Created Date"; Date)
        {
            Caption = 'Date Création';
            DataClassification = CustomerContent;
        }
        field(30; "Yooz Import Date"; Date)
        {
            Caption = 'Date Import Yooz';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Yooz Import", "Yooz Import Date")
        {
        }
        key(Key3; "File Name", "Yooz Import")
        {
        }
    }

    fieldgroups
    {
    }
}
