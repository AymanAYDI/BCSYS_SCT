table 50016 "BC6_Mail Setup"
{
    DataClassification = CustomerContent;
    Caption = 'Mail Setup', Comment = 'FRA="Mail Setup"';

    fields
    {
        field(1; "Mail Type"; enum "BC6_Mail Type")
        {
            Caption = 'Type Mail', Comment = 'FRA="Type Mail"';
            DataClassification = CustomerContent;
        }
        field(2; Subject; Text[80])
        {
            Caption = 'Sujet', Comment = 'FRA="Sujet"';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key50000; "Mail Type")
        {
            Clustered = true;
        }
    }
}
