pageextension 50085 "BC6_PurchaseInvoices" extends "Purchase Invoices"
{
    layout
    {
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify(Status)
        {
            Visible = false;
        }
        addafter("Requested Receipt Date")
        {
            field("BC6_Document Prepaid"; Rec."BC6_Document Prepaid")
            {
                Editable = false;
                Importance = Additional;
                ApplicationArea = All;
            }
            field("BC6_Amount Prepaid"; Rec."BC6_Amount Prepaid")
            {
                Editable = false;
                Importance = Additional;
                ApplicationArea = All;
            }
        }
        addafter("Vendor Authorization No.")
        {
            field("BC6_Your Reference"; Rec."Your Reference")
            {
            }
            field("BC6_Lines Amount"; Rec."BC6_Lines Amount")
            {
            }
            field("BC6_Assigned User ID"; Rec."Assigned User ID")
            {
            }
            field("BC6_Creation date"; Rec."BC6_Creation date")
            {
            }
            field(BC6_Litige; Rec."BC6_Litige")
            {
            }
            field(BC6_Status; Rec.Status)
            {
            }
            field("BC6_Status Code"; Rec."BC6_Status Code")
            {
            }
            field("BC6_Status description"; Rec."BC6_Status description")
            {
            }
            field("BC6_Free comment"; Rec."BC6_Free comment")
            {
            }
            field("BC6_Free comment CDG"; Rec."BC6_Free comment CDG")
            {
            }
            field("BC6_Register amount"; Rec."BC6_Register amount")
            {
            }
        }
    }
    actions
    {
        addbefore("P&osting")
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
                    lPaymentMgt.CreatePaymentDoc(Rec);
                end;
            }
        }
    }

    var
        FunctionsMgt: Codeunit "BC6_FunctionsMgt";

    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Assigned User ID", FunctionsMgt.jx_GetPurchasesFilter());
        Rec.FILTERGROUP(0);
    end;
}
