pageextension 50037 "BC6_SalesList" extends "Sales List" //45
{
    // //MODIF JX-AUD du 15/03/2013
    // //Ajout du champ "Notre référence"
    layout
    {
        addafter("Bill-to Name")
        {
            field("BC6_Your Reference"; Rec."Your Reference")
            {
                Caption = 'Our Reference', Comment = 'FRA="Notre référence"';
                ApplicationArea = All;
            }
        }
    }


}

