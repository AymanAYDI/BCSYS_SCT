pageextension 50008 "BC6_PostedSalesCreditMemo" extends "Posted Sales Credit Memo" //134
{
    layout
    {
        modify("Sell-to Contact No.")
        {
            Visible = false;
        }
        modify("Sell-to Contact")
        {
            Visible = false;
        }

        modify("Salesperson Code")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
    }
    actions
    {
        addafter(SendCustom)
        {
            group("BC6_&Ligne")
            {
                Caption = '&Line';
                separator(Action94)
                {
                }
                action("BC6_Modifier axes analytiques")
                {
                    Caption = 'Modify dimensions';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //MODIF JX-AUD 24/05/2011
                        CurrPage.SalesCrMemoLines.PAGE.ReturnRecord(Grec_SalesCrMemoLine);
                        Grec_SalesCrMemoLine."BC6_ModifyDimensions"();
                        ;
                        //Fin MODIF JX-AUD 24/05/2011
                    end;
                }
                action("Modifier désignation")
                {
                    Caption = 'Modify description';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //MODIF JX-AUD 24/05/2011
                        CurrPage.SalesCrMemoLines.PAGE.ReturnRecord(Grec_SalesCrMemoLine);
                        ModifierDesignation.SetPostedCreditMemo(Grec_SalesCrMemoLine);
                        ModifierDesignation.RUNMODAL();
                        CLEAR(ModifierDesignation);
                        //Fin MODIF JX-AUD 24/05/2011
                    end;
                }
                separator(Action5)
                {
                }
            }
        }
    }

    var
        Grec_SalesCrMemoLine: Record "Sales Cr.Memo Line";
        ModifierDesignation: Page "BC6_Modification désignation";
}
