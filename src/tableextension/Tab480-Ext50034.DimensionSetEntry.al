tableextension 50034 "BC6_DimensionSetEntry" extends "Dimension Set Entry" //480
{
    fields
    {
        modify("Dimension Value Code")
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Dimension Code"), "BC6_Masked" = CONST(false));
        }
    }
}

