pageextension 50087 "BC6_BlanketPurchaseOrders" extends "Blanket Purchase Orders" //9310
{
    Caption = 'Blanket Purchase Orders';

    layout
    {
        addafter("Vendor Authorization No.")
        {
            field("BC6_Lines Amount"; Rec."BC6_Lines Amount")
            {
                ApplicationArea = All;
            }
        }
    }
}
