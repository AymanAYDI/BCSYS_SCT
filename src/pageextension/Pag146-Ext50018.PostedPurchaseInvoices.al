pageextension 50018 "BC6_PostedPurchaseInvoices" extends "Posted Purchase Invoices" //146
{
    layout
    {
        addafter("No.")
        {
            field(BC6_Litige; Rec."BC6_Litige")
            {
                ApplicationArea = All;
            }
        }
        addafter("Buy-from Vendor Name")
        {
            field("BC6_Vendor Invoice No."; Rec."Vendor Invoice No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
        }
        addafter(Amount)
        {
            field("BC6_Remaining Amount"; Rec."Remaining Amount")
            {
                ApplicationArea = All;
            }
        }
        addafter("Posting Date")
        {
            field("BC6_Creation date"; Rec."BC6_Creation date")
            {
                ApplicationArea = All;
            }
            field("BC6_Invoice receipt date"; Rec."BC6_Invoice receipt date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shipment Method Code")
        {
            field("BC6_BC No."; Rec."BC6_BC No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Yooz No."; Rec."BC6_Yooz No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Yooz Token link"; Rec."BC6_Yooz Token link")
            {
                Editable = false;
                ExtendedDatatype = URL;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addfirst("&Invoice")
        {
            action(BC6_Fiche)
            {
                Caption = 'Card', Comment = 'FRA="Fiche"';
                Image = EditLines;
                RunObject = page "Posted Purchase Invoices";
                RunPageLink = "No." = field("No.");
                ShortCutKey = 'Shift+F5';
                ApplicationArea = All;
            }
        }
        addafter("Navigate")
        {
            action("BC6_Payer ce document")
            {
                Caption = 'Payer ce document', Comment = 'FRA="Payer ce document"';
                Image = VendorPayment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    lPaymentMgt: Codeunit "BC6_Vendor Payments";
                begin
                    lPaymentMgt.CreatePaymentInv(Rec);
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        FunctionsMgt: Codeunit BC6_FunctionsMgt;
    begin
        //D‚but Modif JX-XAD du 05/08/2008
        //Filtrer sur le (ou les) utilisateur(s) li‚s au droit de l'utilisateur courant (voir table des paramŠtres utilisateur)
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("User ID", FunctionsMgt.jx_GetPurchasesFilter());
        Rec.FILTERGROUP(0);
        //Fin Modif JX-XAD du 05/08/2008
    end;
}
