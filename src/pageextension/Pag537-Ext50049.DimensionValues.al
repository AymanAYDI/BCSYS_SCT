pageextension 50049 "BC6_DimensionValues" extends "Dimension Values" //537
{
    // //JX-AUD du 18/10/2012
    // //Ajout du champ Masqué

    layout
    {
        addfirst(Control1)
        {
            field("BC6_Dimension Code"; Rec."Dimension Code")
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
        addafter(Name)
        {
            field(BC6_Masked; Rec."BC6_Masked")
            {
                ApplicationArea = All;
            }
        }
    }
}

