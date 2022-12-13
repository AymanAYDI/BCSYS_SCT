pageextension 50012 "BC6_PostedPurchaseInvoice" extends "Posted Purchase Invoice" //138
{
    layout
    {
        addafter("No. Printed")
        {
            field("BC6_Original user"; Rec."BC6_Original user")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_User ID"; Rec."User ID")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Matricule No."; Rec."BC6_Matricule No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(BC6_Litige; Rec."BC6_Litige")
            {
                ApplicationArea = All;
            }
        }
        addafter("Document Date")
        {
            field("BC6_Creation date"; Rec."BC6_Creation date")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Invoice receipt date"; Rec."BC6_Invoice receipt date")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Responsibility Center")
        {
            field("BC6_BC No."; Rec."BC6_BC No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Yooz No."; Rec."BC6_Yooz No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Yooz Token link"; Rec."BC6_Yooz Token link")
            {
                ExtendedDatatype = URL;
                ApplicationArea = All;
            }
        }
        addafter("Pay-to Contact")
        {
            field("BC6_Vendor Posting Group2"; Rec."Vendor Posting Group")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(Approvals)
        {
            group("BC6_Modifier axe")
            {
                Caption = 'Modify dimension', Comment = 'FRA="Modifier axe"';
                action("Période")
                {
                    Caption = 'Period', Comment = 'FRA="Période"';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ModifierAxe.SetPostedInvoice(Rec);
                        ModifierAxe.RUNMODAL();
                        CLEAR(ModifierAxe);
                    end;
                }
            }
            action(BC6_Historique)
            {
                Caption = 'Historic', Comment = 'FRA="Historique"';
                ApplicationArea = All;

                trigger OnAction()
                var
                    Lrec_Historic: Record "BC6_VSC historic";
                    Lform_Historic: Page "BC6_VSC historic";
                begin
                    //Début Ajout JX-XAD 20/11/2009
                    //Lrec_Historic.SETFILTER(Lrec_Historic.Type,'%1',Lrec_Historic.Type::Invoice);//Modif JX-AUD 10/10/2011
                    Lrec_Historic.SETFILTER(Lrec_Historic.Type, '%1|%2', Lrec_Historic.Type::Invoice, Lrec_Historic.Type::Receipt);
                    Lrec_Historic.SETFILTER(Lrec_Historic."No.", '%1', Rec."Pre-Assigned No.");
                    Lform_Historic.SETTABLEVIEW(Lrec_Historic);
                    Lform_Historic.RUNMODAL();
                    //Fin Ajout JX-XAD 20/11/2009
                end;
            }
            group("BC6_&Ligne")
            {
                Caption = '&Line', Comment = 'FRA="&Ligne"';
                separator(Action108)
                {
                }
            }
        }
        addafter("&Navigate")
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

    var
        ModifierAxe: Report "Modifier axe période factures";
}
