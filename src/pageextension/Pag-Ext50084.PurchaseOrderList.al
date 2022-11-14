pageextension 50084 "BC6_PurchaseOrderList" extends "Purchase Order List"
{
    layout
    {
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify(Status)
        {
            Visible = false;
        }
        addafter("Requested Receipt Date")
        {
            field("BC6_Document Prepaid"; Rec."BC6_Document Prepaid")
            {
                Editable = false;
                Importance = Additional;
                ApplicationArea = All;
            }
            field("BC6_Amount Prepaid"; Rec."BC6_Amount Prepaid")
            {
                Editable = false;
                Importance = Additional;
                ApplicationArea = All;
            }
        }
        addafter("Buy-from Vendor Name")
        {
            field("BC6_Status Code"; Rec."BC6_Status Code")
            {
                Visible = false;
            }
            field("BC6_Your Reference"; Rec."Your Reference")
            {
            }
            field("BC6_Lines Amount"; Rec."BC6_Lines Amount")
            {
            }
            field("BC6_Assigned User ID"; Rec."Assigned User ID")
            {
            }
            field("BC6_Matricule No."; Rec."BC6_Matricule No.")
            {
            }
            field("BC6_Quote No."; Rec."Quote No.")
            {
            }
            field(BC6_Status; Rec.Status)
            {
            }
            field("BC6_Creation date"; Rec."BC6_Creation date")
            {
            }
        }
    }
    actions
    {
        modify(Print)
        {
            Visible = false;
        }
        addfirst(Action9)
        {
            action(BC6_Print)
            {
                ApplicationArea = Suite;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category5;
                ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    DocPrintENU: Codeunit "BC6_PrintOrderVSC";
                begin
                    //modifcation AUD le 08/04/2009
                    //mise en commentaire du code
                    //DocPrint.PrintPurchHeader(Rec);
                    DocPrintENU.PrintOrderVSC(Rec);
                    //fin modification
                end;
            }
        }
        addafter("Send IC Purchase Order")
        {
            action("BC6_Payer ce document")
            {
                Caption = 'Payer ce document';
                Image = VendorPayment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    lPaymentMgt: Codeunit "BC6_Vendor Payments";
                begin
                    lPaymentMgt.CreatePaymentDoc(Rec);
                end;
            }
        }
    }

    var
        FunctionsMgt: Codeunit "BC6_FunctionsMgt";

    trigger OnOpenPage()
    begin
        //Début Modif JX-XAD du 11/06/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Assigned User ID", FunctionsMgt.jx_GetPurchasesFilter());
        Rec.FILTERGROUP(0);
        //Fin Modif JX-XAD du 11/06/2008
    end;
}
