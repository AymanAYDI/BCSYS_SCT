pageextension 50043 "BC6_BlanketPurchaseOrder" extends "Blanket Purchase Order"
{
    // Modif JX-XAD du 11/06/2008
    // Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
    Caption = 'Blanket Purchase Order';
    layout
    {
        modify("Invoice Details")
        {
            Caption = 'Invoicing';
        }

        modify("Shipping and Payment")
        {
            Caption = 'Shipping';
        }

        modify(Control1901138007)
        {
            Visible = true;
        }
        modify(Control1904651607)
        {
            Visible = true;
        }

        modify(Control1905767507)
        {
            Visible = true;
        }
        modify("Buy-from Vendor Name")
        {
            Visible = false;
        }
        modify("No. of Archived Versions")
        {
            Visible = false;
        }
        modify(Control5)
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
        modify(Statistics)
        {
            Promoted = true;
            PromotedCategory = Process;
        }
        modify(Card)
        {
            Visible = false;
        }
        addafter(Statistics)
        {
            action(BC6_Card)
            {
                ApplicationArea = Suite;
                Caption = 'Card';
                Image = EditLines;
                Promoted = true;
                PromotedCategory = Category8;
                RunObject = page "Vendor List";
                RunPageLink = "No." = field("Buy-from Vendor No.");
                ShortCutKey = 'Shift+F7';
                ToolTip = 'View or edit detailed information about the vendor on the purchase document.';
            }
        }
        addafter(CopyDocument)
        {
            separator(Action135)
            {
            }
        }
        addafter(CancelApprovalRequest)
        {
            separator(Action139)
            {
            }
        }
    }

    var
        UserMgt: Codeunit "BC6_FunctionsMgt";

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
