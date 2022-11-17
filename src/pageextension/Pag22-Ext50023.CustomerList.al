pageextension 50023 "BC6_CustomerList" extends "Customer List" //22
{
    // MODIF JX-XAD 21/09/2010
    // Ajout du champ solde
    //
    // MODIF JX-AUD 07/06/2012
    // Ajout du champ solde période
    Caption = 'Customer List';

    layout
    {
        addafter(Contact)
        {
            field(BC6_Balance; Rec.Balance)
            {
                ApplicationArea = All;
            }
            field("BC6_Net Change"; Rec."Net Change")
            {
                ApplicationArea = All;
            }
        }
    }
}
