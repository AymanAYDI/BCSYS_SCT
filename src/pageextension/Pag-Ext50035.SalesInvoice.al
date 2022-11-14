pageextension 50035 "BC6_SalesInvoice" extends "Sales Invoice"
{
    // // ajout LAB du 25/08/2010
    // // ajout des champs mandataire, mandataire payeur et groupe compta client
    //
    // MODIF JX-XAD 20/05/2011
    // Ajout du champ "Votre référence"
    //
    // //Modif JX-AUD du 13/02/2013
    // //Modification du bouton Validation-->Valider & Validation-->Valider & Imprimer
    // pour rendre le champ " N° doc. Ext. " obligatoire pour les clients ci-dessous :
    // o         Pour VSCT  c'est le client ASNCF00000.
    // o         Pour VSC c'est le client ASNCFGLX00

    layout
    {
        addafter("Bill-to Contact")
        {
            field("BC6_VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                ApplicationArea = All;
            }
            field("BC6_Customer Posting Group"; Rec."Customer Posting Group")
            {
                Editable = true;
                ApplicationArea = All;
            }
        }
        modify("Your Reference")
        {
            Visible = false;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }

        addafter(Status)
        {
            field("BC6_Paying agent"; Rec."BC6_Paying agent")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("Function_CustomerCard")
        {
            Visible = false;
        }
        modify(DocAttach)
        {
            Visible = false;
        }
        modify(Approve)
        {
            Visible = false;
        }
        modify(Reject)
        {
            Visible = false;
        }
        modify(Delegate)
        {
            Visible = false;
        }
        modify(Comment)
        {
            Visible = false;
        }
        modify(CreatePurchaseInvoice)
        {
            Visible = false;
        }
        modify(GetRecurringSalesLines)
        {
            Visible = false;
        }
        modify(IncomingDocCard)
        {
            Visible = false;
        }
        modify(SelectIncomingDoc)
        {
            Visible = false;
        }
        modify(IncomingDocAttachFile)
        {
            Visible = false;
        }
        modify(RemoveIncomingDoc)
        {
            Visible = false;
        }
        modify(CreateFlow)
        {
            Visible = false;
        }
        modify(SeeFlows)
        {
            Visible = false;
        }
        modify(PostAndNew)
        {
            Visible = false;
        }
        modify(PostAndSend)
        {
            Visible = false;
        }
        modify(Preview)
        {
            Visible = false;
        }
        modify(DraftInvoice)
        {
            Visible = false;
        }
        modify(ProformaInvoice)
        {
            Visible = false;
        }
        addafter(Dimensions)
        {
            action(BC6_Client)
            {
                Caption = 'Customer';
                Image = Customer;
                RunObject = page "Customer List";
                RunPageLink = "No." = field("Sell-to Customer No."), "Date Filter" = field("Date Filter");
                ShortCutKey = 'Shift+F7';
                ApplicationArea = Basic, Suite;
                Enabled = IsCustomerOrContactNotEmpty;
                Promoted = true;
                PromotedCategory = Category11;
                ToolTip = 'View or edit detailed information about the customer on the sales document.';
            }
        }
        addafter(CalculateInvoiceDiscount)
        {
            separator(Action142)
            {
            }
            action("BC6_Extraire &codes vente client std")
            {
                Caption = 'Get St&d. Cust. Sales Codes';
                Ellipsis = true;
                Image = CustomerCode;
                ApplicationArea = All;

                trigger OnAction()
                var
                    StdCustSalesCode: Record "Standard Customer Sales Code";
                begin
                    StdCustSalesCode.InsertSalesLines(Rec);
                end;
            }
            separator(Action139)
            {
            }
        }
        addafter(CancelApprovalRequest)
        {
            separator(Action161)
            {
            }
        }
        addafter("Test Report")
        {
            action("BC6_Post and &Print")
            {
                Caption = 'Post and &Print';
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Shift+F9';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    PostDocument(CODEUNIT::"Purch.-Post + Print", "Navigate After Posting"::"Do Nothing");
                end;
            }
        }
    }

    var
        IsCustomerOrContactNotEmpty: Boolean;

    local procedure SelltoCustomerNoOnAfterValidat()
    begin
        if Rec.GETFILTER("Sell-to Customer No.") = xRec."Sell-to Customer No." then
            if Rec."Sell-to Customer No." <> xRec."Sell-to Customer No." then
                Rec.SETRANGE("Sell-to Customer No.");
        CurrPage.UPDATE();
    end;

    local procedure BilltoCustomerNoOnAfterValidat()
    begin
        CurrPage.UPDATE();
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.UPDATE();
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.UPDATE();
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE();
    end;

    local procedure PostDocument(PostingCodeunitID: Integer; Navigate: Enum "Navigate After Posting")
    var
        SalesHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
        InstructionMgt: Codeunit "Instruction Mgt.";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        OfficeMgt: Codeunit "Office Management";
        DocumentIsPosted: Boolean;
        IsScheduledPosting: Boolean;
        PreAssignedNo: Code[20];
    begin
        if ApplicationAreaMgmtFacade.IsFoundationEnabled() then
            LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);
        PreAssignedNo := Rec."No.";

        Rec.SendToPosting(PostingCodeunitID);

        IsScheduledPosting := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        DocumentIsPosted := (not SalesHeader.Get(Rec."Document Type", Rec."No.")) or IsScheduledPosting;

        if IsScheduledPosting then
            CurrPage.Close();
        CurrPage.Update(false);

        if PostingCodeunitID <> CODEUNIT::"Sales-Post (Yes/No)" then
            exit;

        if OfficeMgt.IsAvailable() then begin
            SalesInvoiceHeader.SetCurrentKey("Pre-Assigned No.");
            SalesInvoiceHeader.SetRange("Pre-Assigned No.", PreAssignedNo);
            if SalesInvoiceHeader.FindFirst() then
                PAGE.Run(PAGE::"Posted Sales Invoice", SalesInvoiceHeader);
        end else
            case Navigate of
                "Navigate After Posting"::"Posted Document":
                    if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode()) then
                        ShowPostedConfirmationMessage(PreAssignedNo);
                "Navigate After Posting"::"New Document":
                    if DocumentIsPosted then begin
                        SalesHeader.Init();
                        SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Invoice);

                        SalesHeader.Insert(true);
                        PAGE.Run(PAGE::"Sales Invoice", SalesHeader);
                    end;
            end;
    end;

    local procedure ShowPostedConfirmationMessage(PreAssignedNo: Code[20])
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
        OpenPostedSalesInvQst: label 'The invoice is posted as number %1 and moved to the Posted Sales Invoices window.\\Do you want to open the posted invoice?', Comment = '%1 = posted document number';

    begin
        SalesInvoiceHeader.SetCurrentKey("Pre-Assigned No.");
        SalesInvoiceHeader.SetRange("Pre-Assigned No.", PreAssignedNo);
        if SalesInvoiceHeader.FindFirst() then
            if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedSalesInvQst, SalesInvoiceHeader."No."),
                 InstructionMgt.ShowPostedConfirmationMessageCode())
            then
                PAGE.Run(PAGE::"Posted Sales Invoice", SalesInvoiceHeader);
    end;
}
