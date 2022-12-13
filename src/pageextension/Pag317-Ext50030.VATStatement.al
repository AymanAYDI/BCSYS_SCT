pageextension 50030 "BC6_VATStatement" extends "VAT Statement" //317
{
    // MODIF JX-XAD 31/03/2009 
    // Modif accès report 50026 (au lieu du report 20) depuis le bouton Fonction ==> Calculer et valider décl. TVA
    actions
    {
        modify("Calc. and Post VAT Settlement")
        {
            Visible = false;
        }
        addafter(Print)
        {
            action("BC6_BC6 Calc. and Post VAT Settlement")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Calculate and Post VAT Settlement', Comment = 'FRA="Calculer et valider décl. TVA"';
                Ellipsis = true;
                Image = SettleOpenTransactions;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report "VSC- Calc. Post VAT Settlement";
            }
        }
    }
}

