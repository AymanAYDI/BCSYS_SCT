pageextension 50058 "BC6_PurchaseReturnOrder" extends "Purchase Return Order" //6640
{
    // Modif JX-XAD du 11/06/2008
    // Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)

    actions
    {
        modify("Vendor")
        {
            Visible = false;
        }
        addbefore("Dimensions")
        {
            action(BC6_Vendor)
            {
                ApplicationArea = PurchReturnOrder;
                Caption = 'Vendor', Comment = 'FRA="Fournisseur"';
                Enabled = Rec."Buy-from Vendor No." <> '';
                Image = Vendor;
                Promoted = true;
                PromotedCategory = Category12;
                RunObject = page "Vendor List";
                RunPageLink = "No." = field("Buy-from Vendor No.");
                ShortCutKey = 'Shift+F7';
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
}
