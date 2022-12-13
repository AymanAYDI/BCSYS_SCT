table 50009 "BC6_Magnitude correspondence"
{
    Caption = 'Magnitude correspondence', Comment = 'FRA="Correspondance Magnitude"';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.', Comment = 'FRA="N° ligne"';
            DataClassification = CustomerContent;
        }
        field(2; Rubric; Code[10])
        {
            Caption = 'Rubric', Comment = 'FRA="Rubrique"';
            DataClassification = CustomerContent;
        }
        field(3; Level; Integer)
        {
            Caption = 'Level', Comment = 'FRA="Niveau"';
            DataClassification = CustomerContent;
        }
        field(4; "Account No."; Text[200])
        {
            Caption = 'Account No.', Comment = 'FRA="N° compte"';
            DataClassification = CustomerContent;
        }
        field(5; Sign; Text[3])
        {
            Caption = 'Sign', Comment = 'FRA="Signe"';
            DataClassification = CustomerContent;
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Montant', Comment = 'FRA="Montant"';
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
