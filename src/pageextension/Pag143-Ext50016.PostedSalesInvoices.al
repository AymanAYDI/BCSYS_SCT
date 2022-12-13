pageextension 50016 "BC6_PostedSalesInvoices" extends "Posted Sales Invoices" //143
{
    layout
    {
        addafter("No.")
        {
            field("BC6_BC6 External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
            }
            field("BC6_BC6 Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify(Print)
        {
            Caption = 'Print Invoice', Comment = 'FRA="Imprimer facture"';
            PromotedIsBig = true;
            Promoted = true;
        }
        addafter(Print)
        {
            action("BC6_Imprimer facture forfait")
            {
                Caption = 'Print invoice plan', Comment = 'FRA="Imprimer facture forfait"';
                Image = ConfirmAndPrint;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //Modif JX-AUD du 07/02/2013
                    CurrPage.SETSELECTIONFILTER(SalesInvHeader);
                    REPORT.RUNMODAL(REPORT::"BC6_Facture vente forfait", TRUE, FALSE, SalesInvHeader);
                    //Fin modif JX-AUD du 07/02/2013
                end;
            }
        }
    }

    var
        SalesInvHeader: Record "Sales Invoice Header";
}

