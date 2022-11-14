pageextension 50036 "BC6_SalesCreditMemo" extends "Sales Credit Memo"
{
    // // ajout AUD du 21/02/2011
    // // ajout des champs mandataire, mandataire payeur, et groupe compta client
    //
    // MODIF JX-XAD 20/05/2011
    // Ajout du champ "Votre référence"
    //
    // //Modif JX-AUD du 13/02/2013
    // //Modification du bouton Validation-->Valider & Validation-->Valider & Imprimer
    // pour rendre le champ " N° doc. Ext. " obligatoire pour les clients ci-dessous :
    // o         Pour VSCT  c'est le client ASNCF00000.
    // o         Pour VSC c'est le client ASNCFGLX00

    //Unsupported feature: Property Modification (SourceTableView) on ""Sales Credit Memo"(Page 44)".

    layout
    {
        modify("No.")
        {
            Importance = Promoted;
        }
        modify("Sell-to Customer No.")
        {
            Importance = Promoted;
            ShowMandatory = true;
        }
        modify("Sell-to Post Code")
        {
            Importance = Promoted;
        }
        modify("Sell-to Country/Region Code")
        {
            Importance = Promoted;
            Visible = false;
        }

        modify("External Document No.")
        {
            Importance = Promoted;
        }
        modify(Status)
        {
            Importance = Promoted;
        }
        modify("Credit Memo Details")
        {
            Caption = 'Shipping';
        }

        modify("Bill-to Contact")
        {
            Importance = Additional;
        }

        modify(Control1902018507)
        {
            Visible = true;
        }
        modify(Control1900316107)
        {
            Visible = true;
        }

        modify(Control1905767507)
        {
            Visible = true;
        }
        modify("Sell-to Customer Name")
        {
            Visible = false;
        }

        modify("Posting Description")
        {
            Visible = false;
        }

        modify("Your Reference")
        {
            Visible = false;
        }
        modify("Posting Date")
        {
            Visible = false;
        }

        modify("Work Description")
        {
            Visible = false;
        }
        modify(WorkDescription)
        {
            Visible = false;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Payment Method Code")
        {
            Visible = false;
        }
        modify("EU 3-Party Trade")
        {
            Visible = false;
        }
        modify("Bill-to Name")
        {
            Visible = false;
        }
        modify(Control55)
        {
            Visible = false;
        }
        modify("Bill-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Attached Documents")
        {
            Visible = false;
        }
        modify(Control19)
        {
            Visible = false;
        }
        modify(IncomingDocAttachFactBox)
        {
            Visible = false;
        }
        modify(WorkflowStatus)
        {
            Visible = false;
        }

        addafter("Sell-to Customer Name")
        {
            field("BC6_Sell-to Post Code"; Rec."Sell-to Post Code")
            {
                Importance = Additional;
                ApplicationArea = All;
            }
        }
        addafter("Sell-to Contact")
        {
            field("BC6_Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
            field(BC6_Agent; Rec."BC6_Agent")
            {
                ApplicationArea = All;
            }
        }
        addafter(Status)
        {
            field("BC6_Paying agent"; Rec."BC6_Paying agent")
            {
                ApplicationArea = All;
            }
        }
        addafter("VAT Bus. Posting Group")
        {
            field("BC6_Customer Posting Group2"; Rec."Customer Posting Group")
            {
                Editable = true;
                ApplicationArea = All;
            }
        }
        addafter("Sell-to Country/Region Code")
        {
            field("BC6_Ship-to Post Code"; Rec."Ship-to Post Code")
            {
                Importance = Promoted;
                ApplicationArea = All;
            }
        }
        addafter("Foreign Trade")
        {
            group(BC6_Lettrage)
            {
                Caption = 'Application';
            }
        }
    }
    actions
    {
        modify(Statistics)
        {
            Promoted = true;
            PromotedCategory = Process;
        }
        modify(Release)
        {
            Promoted = true;
            PromotedCategory = Process;
        }
        modify(ApplyEntries)
        {
            Promoted = true;
            PromotedCategory = Process;
        }
        modify(CopyDocument)
        {
            Promoted = true;
            PromotedCategory = Process;
        }
        modify("Request Approval")
        {
            Caption = 'Approval';
        }
        modify(Post)
        {
            Promoted = true;
            PromotedCategory = Process;
        }
        modify(DocAttach)
        {
            Visible = false;
        }
        modify("Credit Memo")
        {
            Visible = false;
        }
        modify(Customer)
        {
            Visible = false;
        }
        addbefore("Co&mments")
        {
            action(BC6_Customer)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customer';
                Enabled = IsCustomerOrContactNotEmpty;
                Image = Customer;
                RunObject = page "Customer List";
                RunPageLink = "No." = field("Sell-to Customer No."),
                                  "Date Filter" = field("Date Filter");
                ShortCutKey = 'Shift+F7';
                ToolTip = 'View or edit detailed information about the customer.';
            }
        }
        modify(Dimensions)
        {
            Visible = false;
        }
        modify(Approval)
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
        modify(IncomingDocument)
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
        modify(TestReport)
        {
            Visible = false;
        }
        modify(PostAndSend)
        {
            Visible = false;
        }
        modify("Preview Posting")
        {
            Visible = false;
        }
        addafter("Co&mments")
        {
            action("BC6_Axes analytiques")
            {
                AccessByPermission = tabledata Dimension = R;
                Caption = 'Dimensions';
                Image = Dimensions;
                ShortCutKey = 'Shift+Ctrl+D';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.ShowDocDim();
                    CurrPage.SAVERECORD();
                end;
            }
        }
        addafter(CalculateInvoiceDiscount)
        {
            separator(Action113)
            {
            }
        }
        addafter(ApplyEntries)
        {
            separator(Action126)
            {
            }
        }
        addafter(GetStdCustSalesCodes)
        {
            separator(Action128)
            {
            }
        }
        addafter(CancelApprovalRequest)
        {
            separator(Action130)
            {
            }
        }
        addbefore(TestReport)
        {
            action("BC6_P&ost")
            {
                Promoted = true;
                PromotedIsBig = true;
                Image = PostOrder;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    PostDocument(CODEUNIT::"Sales-Post (Yes/No)");
                end;
            }
        }
        addafter(Post)
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
                    PostDocument(CODEUNIT::"Sales-Post + Print");
                end;
            }
            action("BC6_Valider et envoyer par e-mail")
            {
                Caption = 'Post and Email';
                Image = PostMail;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesPostPrint: Codeunit "Sales-Post + Print";
                begin
                    SalesPostPrint.PostAndEmail(Rec);
                end;
            }
            action("BC6_Valider par l&ot")
            {
                Caption = 'Post &Batch';
                Ellipsis = true;
                Image = PostBatch;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    REPORT.RUNMODAL(REPORT::"Batch Post Sales Credit Memos", true, true, Rec);
                    CurrPage.UPDATE(false);
                end;
            }
        }
    }

    var
        IsCustomerOrContactNotEmpty: Boolean;

    local procedure SetControlAppearance()
    begin
        IsCustomerOrContactNotEmpty := (Rec."Sell-to Customer No." <> '') or (Rec."Sell-to Contact No." <> '');
    end;

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

    local procedure PostDocument(PostingCodeunitID: Integer)
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesHeader: Record "Sales Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
        OfficeMgt: Codeunit "Office Management";
        DocumentIsPosted: Boolean;
        IsScheduledPosting: Boolean;
        PreAssignedNo: Code[20];

    begin
        CheckSalesCheckAllLinesHaveQuantityAssigned();
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
            SalesCrMemoHeader.SetRange("Pre-Assigned No.", PreAssignedNo);
            if SalesCrMemoHeader.FindFirst() then
                PAGE.Run(PAGE::"Posted Sales Credit Memo", SalesCrMemoHeader);
        end else
            if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode()) then
                ShowPostedConfirmationMessage(PreAssignedNo);
    end;

    local procedure ShowPostedConfirmationMessage(PreAssignedNo: Code[20])
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
        OpenPostedSalesCrMemoQst: label 'The credit memo is posted as number %1 and moved to the Posted Sales Credit Memos window.\\Do you want to open the posted credit memo?', Comment = '%1 = posted document number';

    begin
        SalesCrMemoHeader.SetRange("Pre-Assigned No.", PreAssignedNo);
        if SalesCrMemoHeader.FindFirst() then
            if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedSalesCrMemoQst, SalesCrMemoHeader."No."),
                 InstructionMgt.ShowPostedConfirmationMessageCode())
            then
                PAGE.Run(PAGE::"Posted Sales Credit Memo", SalesCrMemoHeader);
    end;

    local procedure CheckSalesCheckAllLinesHaveQuantityAssigned()
    var
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";

    begin
        if ApplicationAreaMgmtFacade.IsFoundationEnabled() then
            LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);
    end;
}
