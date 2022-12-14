table 50018 "BC6_No. Yooz"
{
    DataClassification = CustomerContent;
    Caption = 'No. Yooz', Comment = 'FRA="N° Yooz"';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.', Comment = 'FRA="N°"';
            TableRelation = "Payment Header";
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.', Comment = 'FRA="N° ligne"';
            DataClassification = CustomerContent;
        }
        field(3; "Applied Yooz No."; Text[250])
        {
            Caption = 'N° Yooz lettrés', Comment = 'FRA="N° Yooz lettrés"';
            Description = 'JX-YOOZ2';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key50000; "No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
