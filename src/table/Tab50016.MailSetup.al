table 50016 "BC6_Mail Setup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Mail Type"; enum "BC6_Mail Type")
        {
            Caption = 'Type Mail';
            DataClassification = CustomerContent;
        }
        field(2; Subject; Text[80])
        {
            Caption = 'Sujet';
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

    fieldgroups
    {
    }
}
