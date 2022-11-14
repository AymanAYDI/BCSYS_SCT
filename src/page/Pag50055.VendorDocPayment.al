page 50055 "BC6_Vendor Doc. Payment"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Purchase Header";

    layout
    {
        area(content)
        {
            group("Paiement Document Fournisseur")
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."BC6_Total Amount")
                {
                    ApplicationArea = All;
                }
                field("Total Amount Incl. VAT"; Rec."BC6_Total Amount Incl. VAT")
                {
                    ApplicationArea = All;
                }
                field("Montant à Payer"; AmountToPay)
                {
                    Style = Unfavorable;
                    StyleExpr = true;
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000008; "Vendor Hist. Pay-to FactBox")
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
        Rec.CALCFIELDS("Amount Including VAT");
        AmountToPay := Rec."Amount Including VAT" - Rec."BC6_Amount Prepaid";
    end;

    var
        AmountToPay: Decimal;

    //[Scope('Internal')]
    /// <summary>
    /// ReturnAmount.
    /// </summary>
    /// <returns>Return value of type Decimal.</returns>
    procedure ReturnAmount(): Decimal
    begin
        exit(AmountToPay);
    end;
}
