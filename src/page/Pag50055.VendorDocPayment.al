page 50055 "BC6_Vendor Doc. Payment"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Purchase Header";
    Caption = 'Vendor Doc. Payment', Comment = 'FRA="Vendor Doc. Payment"';

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
                    Caption = 'Montant à Payer', Comment = 'FRA="Montant à Payer"';
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000008; "Vendor Hist. Pay-to FactBox")
            {
                ApplicationArea = All;
                //Caption = 'Pay-to Vendor History';
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS("Amount Including VAT");
        AmountToPay := Rec."Amount Including VAT" - Rec."BC6_Amount Prepaid";
    end;

    var
        AmountToPay: Decimal;

    procedure ReturnAmount(): Decimal
    begin
        exit(AmountToPay);
    end;
}
