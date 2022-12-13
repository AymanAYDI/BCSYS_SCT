tableextension 50025 "BC6_DimensionValue" extends "Dimension Value" //349
{
    fields
    {
        field(50000; BC6_Masked; Boolean)
        {
            Caption = 'Masked', Comment = 'FRA="Masqué"';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key50000; "Dimension Value ID")
        {
        }
    }
}

