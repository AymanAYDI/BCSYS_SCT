pageextension 50058 "BC6_PurchaseReturnOrder" extends "Purchase Return Order" //6640
{
    // Modif JX-XAD du 11/06/2008
    // Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)

    layout
    {
        modify("Buy-from Address")
        {
            QuickEntry = false;
        }
        modify("Buy-from Address 2")
        {
            QuickEntry = false;
        }
        modify("Buy-from Post Code")
        {
            QuickEntry = false;
        }
        modify("Buy-from City")
        {
            QuickEntry = false;
        }
        modify("Buy-from Contact No.")
        {
            QuickEntry = false;
        }
        modify("Vendor Authorization No.")
        {
            Importance = Promoted;
        }
        modify("Purchaser Code")
        {
            QuickEntry = false;
        }
        modify("Campaign No.")
        {
            QuickEntry = false;
        }
        modify("Responsibility Center")
        {
            QuickEntry = false;
        }
        modify("Assigned User ID")
        {
            QuickEntry = false;
        }
        modify("Job Queue Status")
        {
            QuickEntry = false;
        }
        modify(Status)
        {
            QuickEntry = false;
        }

        modify(Control1901138007)
        {
            Visible = true;
        }
        modify(Control1904651607)
        {
            Visible = false;
        }
        modify(Control1903435607)
        {
            Visible = true;
        }

        modify(Control3)
        {
            Visible = false;
        }
        modify(Control1905767507)
        {
            Visible = true;
        }
        modify("Buy-from Vendor Name")
        {
            Visible = false;
        }

        modify(Control69)
        {
            Visible = false;
        }
        modify("Buy-from County")
        {
            Visible = false;
        }

        modify("Buy-from Country/Region Code")
        {
            Visible = false;
        }
        modify("Posting Date")
        {
            Visible = false;
        }
        modify("Payment Terms Code")
        {
            Visible = false;
        }
        modify("Payment Method Code")
        {
            Visible = false;
        }
        modify(Control45)
        {
            Visible = false;
        }
        modify(ShipToOptions)
        {
            Visible = false;
        }
        modify(Control48)
        {
            Visible = false;
        }

        modify(Control62)
        {
            Visible = false;
        }
        modify(Control174)
        {
            Visible = false;
        }
        modify("Ship-to County")
        {
            Visible = false;
        }
        modify("Ship-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Pay-to Name")
        {
            Visible = false;
        }
        modify(Control79)
        {
            Visible = false;
        }
        modify("Pay-to County")
        {
            Visible = false;
        }
        modify("Pay-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Attached Documents")
        {
            Visible = false;
        }
        modify(Control21)
        {
            Visible = false;
        }
        modify(WorkflowStatus)
        {
            Visible = false;
        }
    }
    actions
    {
        modify(Approvals)
        {
            Visible = false;
        }
        modify(Approval)
        {
            Visible = false;
        }
        modify(Approve)
        {
            Visible = false;
        }
        modify(Reject)
        {
            Visible = false;
        }
        modify(Delegate)
        {
            Visible = false;
        }
        modify(Comment)
        {
            Visible = false;
        }
        modify(Preview)
        {
            Visible = false;
        }
        modify("Vendor")
        {
            Visible = false;
        }
        addbefore("Dimensions")
        {
            action(BC6_Vendor)
            {
                ApplicationArea = PurchReturnOrder;
                Caption = 'Vendor';
                Enabled = Rec."Buy-from Vendor No." <> '';
                Image = Vendor;
                Promoted = true;
                PromotedCategory = Category12;
                RunObject = page "Vendor List";
                RunPageLink = "No." = field("Buy-from Vendor No.");
                ShortCutKey = 'Shift+F7';
                ToolTip = 'View or edit detailed information about the vendor on the purchase document.';
            }
        }
    }
    var
        UserMgt: codeunit "BC6_FunctionsMgt";

    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Assigned User ID", UserMgt.jx_GetPurchasesFilter());
        Rec.FILTERGROUP(0);
    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        if Rec.GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
            if Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
                Rec.SETRANGE("Buy-from Vendor No.");
        CurrPage.UPDATE();
    end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE();
    end;
}
