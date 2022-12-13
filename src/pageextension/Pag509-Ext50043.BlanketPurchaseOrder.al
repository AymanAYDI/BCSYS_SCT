pageextension 50043 "BC6_BlanketPurchaseOrder" extends "Blanket Purchase Order" //509
{
    // Modif JX-XAD du 11/06/2008
    // Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
    Caption = 'Blanket Purchase Order', Comment = 'FRA="Commande ouverte achat"';
    actions
    {
        modify(Card)
        {
            Visible = false;
        }
        addafter(Statistics)
        {
            action(BC6_Card)
            {
                ApplicationArea = Suite;
                Caption = 'Card', Comment = 'FRA="Fiche"';
                Image = EditLines;
                Promoted = true;
                PromotedCategory = Category8;
                RunObject = page "Vendor List";
                RunPageLink = "No." = field("Buy-from Vendor No.");
                ShortCutKey = 'Shift+F7';
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
}
