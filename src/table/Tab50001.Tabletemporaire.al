table 50001 "BC6_Table temporaire"
{
    DataClassification = CustomerContent;
    Caption = 'Table temporaire', Comment = 'FRA="Table temporaire"';

    fields
    {
        field(1; Piece; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; Compte; Code[50])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Piece)
        {
            Clustered = true;
        }
    }
}
