pageextension 50059 "BC6_PurchaseReturnOrderArchive" extends "Purchase Return Order Archive" //6644
{
    // Début Modif JX-XAD du 05/08/2008
    // Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
    actions
    {
        modify("Card")
        {
            Visible = false;
        }
        addbefore(Dimensions)
        {
            action(BC6_Card)
            {
                ApplicationArea = PurchReturnOrder;
                Caption = 'Card';
                Enabled = Rec."Buy-from Vendor No." <> '';
                Promoted = true;
                PromotedCategory = Category12;
                RunObject = page "Vendor List";
                RunPageLink = "No." = field("Buy-from Vendor No.");
                ShortCutKey = 'Shift+F7';
                ToolTip = 'View or edit detailed information about the vendor on the purchase document.';
                Image = EditLines;
            }
        }
    }

    var
        UserMgt: Codeunit "BC6_FunctionsMgt";

    trigger OnOpenPage()
    begin

        //Début Modif JX-XAD du 05/08/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Assigned User ID", UserMgt.jx_GetPurchasesFilter());
        Rec.FILTERGROUP(0);
        //Fin Modif JX-XAD du 05/08/2008
    end;
}
