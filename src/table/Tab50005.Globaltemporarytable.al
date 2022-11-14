table 50005 "BC6_Global temporary table"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Line No."; Integer)
        {
            Description = 'FNP-SA';
            DataClassification = CustomerContent;
        }
        field(2; "Document No."; Text[100])
        {
            Description = 'FNP-SA';
            DataClassification = CustomerContent;
        }
        field(3; "External document No."; Text[100])
        {
            Description = 'FNP-SA';
            DataClassification = CustomerContent;
        }
        field(4; "Account No."; Text[100])
        {
            Description = 'FNP-SA';
            DataClassification = CustomerContent;
        }
        field(5; "Posting date"; Date)
        {
            Description = 'FNP-SA';
            DataClassification = CustomerContent;
        }
        field(6; "Document date"; Date)
        {
            Description = 'FNP-SA';
            DataClassification = CustomerContent;
        }
        field(7; "Credit amount"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            Description = 'FNP-SA';
            DataClassification = CustomerContent;
        }
        field(8; "Debit amount"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            Description = 'FNP-SA';
            DataClassification = CustomerContent;
        }
        field(9; Description; Text[100])
        {
            Description = 'FNP-SA';
            DataClassification = CustomerContent;
        }
        field(10; "Vendor No."; Text[100])
        {
            Description = 'FNP-SA';
            DataClassification = CustomerContent;
        }
        field(11; "Axe 0"; Text[100])
        {
            Description = 'FNP-SA';
            DataClassification = CustomerContent;
        }
        field(12; "Axe 1"; Text[100])
        {
            Description = 'FNP-SA';
            DataClassification = CustomerContent;
        }
        field(13; "Axe 2"; Text[100])
        {
            Description = 'FNP-SA';
            DataClassification = CustomerContent;
        }
        field(14; "Axe 3"; Text[100])
        {
            Description = 'FNP-SA';
            DataClassification = CustomerContent;
        }
        field(15; "Axe 4"; Text[100])
        {
            Description = 'FNP-SA';
            DataClassification = CustomerContent;
        }
        field(16; "Axe 5"; Text[100])
        {
            Description = 'FNP-SA';
            DataClassification = CustomerContent;
        }
        field(17; "Vendor name"; Text[50])
        {
            Description = 'FNP-SA';
            DataClassification = CustomerContent;
        }
        field(18; "VAT rates"; Decimal)
        {
            Description = 'FNP-SA';
            DataClassification = CustomerContent;
        }
        field(20; "Dimension Set ID"; Integer)
        {
            Description = 'FNP-SA';
            TableRelation = "Dimension Set Entry";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key50000; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key50001; "Account No.")
        {
        }
        key(Key50002; "Document No.", "External document No.")
        {
        }
    }

    fieldgroups
    {
    }
}
