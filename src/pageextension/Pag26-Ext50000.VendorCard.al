pageextension 50000 "BC6_VendorCard" extends "Vendor Card" //26
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("BC6_Registration No."; Rec."BC6_Registration No.")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addbefore("&Payment Addresses")
        {
            action("Dupliquer vers une autre société")
            {
                Caption = 'Duplicate to another company', Comment = 'FRA="Dupliquer vers une autre société"';
                Image = CopyFromChartOfAccounts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //DEBUT MODIF JX-XAD 03/04/2009

                    //DEBUT MODIF JX-XAD le 15/06/2010
                    //GForm_Dupliquer.initialiser(Gopt_TypeFiche::Vendor,"No.");
                    GForm_Dupliquer.initialiser(Gopt_TypeFiche::Vendor, Rec."No.", '');
                    //FIN MODIF JX-XAD le 15/06/2010
                    GForm_Dupliquer.RUNMODAL();
                    CLEAR(GForm_Dupliquer);
                    //FIN MODIF JX-XAD 03/04/2009
                end;
            }
        }
        modify(Quotes)
        {
            Caption = 'Quotes', Comment = 'FRA="Devis"';
        }
        modify(NewBlanketPurchaseOrder)
        {
            visible = false;
        }
        modify(NewPurchaseQuote)
        {
            Caption = 'Purchase Quote', Comment = 'FRA="Devis"';
            Promoted = true;
        }
        modify(NewPurchaseInvoice)
        {
            Visible = false;
        }
        modify(NewPurchaseOrder)
        {
            Visible = false;
        }
        modify(NewPurchaseReturnOrder)
        {
            Visible = false;
        }
    }
    var
        GForm_Dupliquer: Page "BC6_Duplicating List";
        Gopt_TypeFiche: Option ,Vendor,"G/L Account",Item,VendorBankAccount;
}
