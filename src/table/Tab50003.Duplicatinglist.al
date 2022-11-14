table 50003 "BC6_Duplicating list"
{
    Caption = 'Liste de duplication';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Name; Text[30])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(2; Duplication; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if not Duplication then
                    Dimension := false;
            end;
        }
        field(3; Dimension; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if not Duplication then
                    Dimension := false;
            end;
        }
        field(4; Echec; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key50000; Name)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    //[Scope('Internal')]
    /// <summary>
    /// SelectAll.
    /// </summary>
    /// <param name="Pbool_SelectAll">Boolean.</param>
    procedure SelectAll(Pbool_SelectAll: Boolean)
    begin
        //DEBUT MODIF JX-XAD 07/06/2011
        if Find('-') then
            repeat
                Validate(Duplication, Pbool_SelectAll);
                Modify();
            until Next() = 0;
        Commit();
        //FIN MODIF JX-XAD 07/06/2011
    end;

    // [Scope('Internal')]
    /// <summary>
    /// SelectAllWithDim.
    /// </summary>
    /// <param name="Pbool_SelectAllWithDim">Boolean.</param>
    procedure SelectAllWithDim(Pbool_SelectAllWithDim: Boolean)
    begin
        //DEBUT MODIF JX-XAD 07/06/2011
        if Find('-') then
            repeat
                Validate(Dimension, Pbool_SelectAllWithDim);
                Modify();
            until Next() = 0;
        Commit();
        //FIN MODIF JX-XAD 07/06/2011
    end;
}
