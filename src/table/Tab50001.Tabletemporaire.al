table 50001 "BC6_Table temporaire"
{
    DataClassification = CustomerContent;

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
