table 50017 "BC6_Mail Body Setup"
{
    DataClassification = CustomerContent;
    Caption = 'Mail Body Setup', Comment = 'FRA="Mail Body Setup"';

    fields
    {
        field(1; "Mail Type"; enum "BC6_Mail Type")
        {
            Caption = 'Type Mail', Comment = 'FRA="Type Mail"';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'N° Ligne', Comment = 'FRA="N° Ligne"';
            DataClassification = CustomerContent;
        }
        field(4; Textline; Text[250])
        {
            Caption = 'Ligne Texte', Comment = 'FRA="Ligne Texte"';
            DataClassification = CustomerContent;
        }
        field(5; Seperator; enum BC6_Separator)
        {
            DataClassification = CustomerContent;
            Caption = 'Separator', Comment = 'FRA="Separator"';
        }
    }

    keys
    {
        key(Key50000; "Mail Type", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
