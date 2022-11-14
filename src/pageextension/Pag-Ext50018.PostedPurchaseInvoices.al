pageextension 50018 "BC6_PostedPurchaseInvoices" extends "Posted Purchase Invoices"
{
    layout
    {
        addafter("No.")
        {
            field(BC6_Litige; Rec."BC6_Litige")
            {
                ApplicationArea = All;
            }
        }
        addafter("Buy-from Vendor Name")
        {
            field("BC6_Vendor Invoice No."; Rec."Vendor Invoice No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
        }
        addafter(Amount)
        {
            field("BC6_Remaining Amount"; Rec."Remaining Amount")
            {
                ApplicationArea = All;
            }
        }
        addafter("Posting Date")
        {
            field("BC6_Creation date"; Rec."BC6_Creation date")
            {
                ApplicationArea = All;
            }
            field("BC6_Invoice receipt date"; Rec."BC6_Invoice receipt date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shipment Method Code")
        {
            field("BC6_BC No."; Rec."BC6_BC No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Yooz No."; Rec."BC6_Yooz No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Yooz Token link"; Rec."BC6_Yooz Token link")
            {
                Editable = false;
                ExtendedDatatype = URL;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addfirst("&Invoice")
        {
            action(BC6_Fiche)
            {
                Caption = 'Card';
                Image = EditLines;
                RunObject = page "Posted Purchase Invoices";
                RunPageLink = "No." = field("No.");
                ShortCutKey = 'Shift+F5';
                ApplicationArea = All;
            }
        }
        addafter("&Print")
        {
            action("BC6_Payer ce document")
            {
                Caption = 'Payer ce document';
                Image = VendorPayment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    lPaymentMgt: Codeunit "BC6_Vendor Payments";
                begin
                    lPaymentMgt.CreatePaymentInv(Rec);
                end;
            }
        }
    }
}
