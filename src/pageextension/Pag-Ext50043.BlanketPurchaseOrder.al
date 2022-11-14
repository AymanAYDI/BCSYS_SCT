pageextension 50043 "BC6_BlanketPurchaseOrder" extends "Blanket Purchase Order"
{
    // Modif JX-XAD du 11/06/2008
    // Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
    Caption = 'Blanket Purchase Order';
    layout
    {
        modify("Invoice Details")
        {
            Caption = 'Invoicing';
        }

        modify("Shipping and Payment")
        {
            Caption = 'Shipping';
        }

        modify(Control1901138007)
        {
            Visible = true;
        }
        modify(Control1904651607)
        {
            Visible = true;
        }

        modify(Control1905767507)
        {
            Visible = true;
        }

        //Unsupported feature: Code Modification on ""Buy-from Vendor No."(Control 4).OnValidate".

        //trigger "(Control 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        OnAfterValidateBuyFromVendorNo(Rec,xRec);
        CurrPage.Update;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        BuyfromVendorNoOnAfterValidate;
        */
        //end;

        modify("Buy-from Vendor Name")
        {
            Visible = false;
        }
        modify("No. of Archived Versions")
        {
            Visible = false;
        }

        //Unsupported feature: Code Modification on ""Currency Code"(Control 12).OnAssistEdit".

        //trigger OnAssistEdit()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Clear(ChangeExchangeRate);
        ChangeExchangeRate.SetParameter("Currency Code","Currency Factor",WorkDate);
        if ChangeExchangeRate.RunModal = ACTION::OK then begin
          Validate("Currency Factor",ChangeExchangeRate.GetParameter);
          SaveInvoiceDiscountAmount;
        end;
        Clear(ChangeExchangeRate);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CLEAR(ChangeExchangeRate);
        ChangeExchangeRate.SetParameter("Currency Code","Currency Factor",WORKDATE);
        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
          VALIDATE("Currency Factor",ChangeExchangeRate.GetParameter);
          CurrPage.UPDATE;
        END;
        CLEAR(ChangeExchangeRate);
        */
        //end;

        //Unsupported feature: Code Modification on ""Currency Code"(Control 12).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.Update;
        PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0,Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrPage.UPDATE;
        PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0,Rec);
        */
        //end;

        //Unsupported feature: Code Insertion on ""Pay-to Vendor No."(Control 22)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        PaytoVendorNoOnAfterValidate;
        */
        //end;

        modify(Control5)
        {
            Visible = false;
        }

        modify(WorkflowStatus)
        {
            Visible = false;
        }
    }
    actions
    {
        modify(Statistics)
        {
            Promoted = true;
            PromotedCategory = Process;
        }
        modify(Card)
        {
            Visible = false;
        }
        addafter(Statistics)
        {
            action(BC6_Card)
            {
                ApplicationArea = Suite;
                Caption = 'Card';
                Image = EditLines;
                Promoted = true;
                PromotedCategory = Category8;
                RunObject = page "Vendor List";
                RunPageLink = "No." = field("Buy-from Vendor No.");
                ShortCutKey = 'Shift+F7';
                ToolTip = 'View or edit detailed information about the vendor on the purchase document.';
            }
        }

        //Unsupported feature: Code Modification on "MakeOrder(Action 77).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
          CODEUNIT.Run(CODEUNIT::"Blnkt Purch Ord. to Ord. (Y/N)",Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
          CODEUNIT.RUN(CODEUNIT::"Blnkt Purch Ord. to Ord. (Y/N)",Rec);
        */
        //end;

        addafter(CopyDocument)
        {
            separator(Action135)
            {
            }
        }
        addafter(CancelApprovalRequest)
        {
            separator(Action139)
            {
            }
        }
    }

    var
        UserMgt: Codeunit "BC6_FunctionsMgt";

    //Unsupported feature: Code Modification on "OnNewRecord".

    //trigger OnNewRecord(BelowxRec: Boolean)
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Responsibility Center" := UserMgt.GetPurchasesFilter;

    if (not DocNoVisible) and ("No." = '') then
      SetBuyFromVendorFromFilter;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Responsibility Center" := UserMgt.GetPurchasesFilter;
    */
    //end;

    trigger OnOpenPage()

    begin
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Assigned User ID", UserMgt.jx_GetPurchasesFilter());
        Rec.FILTERGROUP(0);
    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        if Rec.GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
            if Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
                Rec.SETRANGE("Buy-from Vendor No.");
        CurrPage.UPDATE();
    end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE();
    end;
}
