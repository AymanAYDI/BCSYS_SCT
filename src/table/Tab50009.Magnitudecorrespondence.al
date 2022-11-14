table 50009 "BC6_Magnitude correspondence"
{
    Caption = 'Magnitude correspondence';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(2; Rubric; Code[10])
        {
            Caption = 'Rubric';
            DataClassification = CustomerContent;
        }
        field(3; Level; Integer)
        {
            Caption = 'Level';
            DataClassification = CustomerContent;
        }
        field(4; "Account No."; Text[200])
        {
            Caption = 'Account No.';
            DataClassification = CustomerContent;
        }
        field(5; Sign; Text[3])
        {
            Caption = 'Sign';
            DataClassification = CustomerContent;
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Montant';
            DecimalPlaces = 2 : 5;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key50000; "Line No.")
        {
            Clustered = true;
        }
    }
}
