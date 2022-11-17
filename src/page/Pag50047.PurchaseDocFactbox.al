page 50047 "BC6_Purchase Doc. Factbox"
{
    PageType = CardPart;
    SourceTable = "Purchase Header";
    Caption = 'Purchase Doc. Factbox';

    layout
    {
        area(content)
        {
            field("Total Amount"; Rec."BC6_Total Amount")
            {
                ApplicationArea = All;
            }
            field("VAT Amount"; VATAmount)
            {
                Caption = 'Total TVA';
                ApplicationArea = All;
            }
            field("Total Amount Incl. VAT"; Rec."BC6_Total Amount Incl. VAT")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS("BC6_Total Amount", "BC6_Total Amount Incl. VAT");
        if Rec."BC6_Total Amount Incl. VAT" < Rec."BC6_Total Amount" then
            VATAmount := 0
        else
            VATAmount := Rec."BC6_Total Amount Incl. VAT" - Rec."BC6_Total Amount";
    end;

    var
        VATAmount: Decimal;
}
