pageextension 50036 "BC6_SalesCreditMemo" extends "Sales Credit Memo" //44
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

    layout
    {
        modify("Payment Method Code")
        {
            Visible = false;
        }
        addafter("Your Reference")
        {
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
        modify("Customer Posting Group")
        {
            Visible = false;
        }
        addafter("VAT Bus. Posting Group")
        {
            field("BC6_Customer Posting Group2"; Rec."Customer Posting Group")
            {
                Editable = true;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify(Post)
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
                Caption = 'Customer', Comment = 'FRA="Client"';
                Enabled = IsCustomerOrContactNotEmpty;
                Image = Customer;
                RunObject = page "Customer List";
                RunPageLink = "No." = field("Sell-to Customer No."),
                                  "Date Filter" = field("Date Filter");
                ShortCutKey = 'Shift+F7';
                ToolTip = 'View or edit detailed information about the customer.', Comment = 'FRA="Afficher ou modifier des informations détaillées sur le client."';
            }
        }
        addafter("Co&mments")
        {
            action("BC6_Axes analytiques")
            {
                AccessByPermission = tabledata Dimension = R;
                Caption = 'Dimensions', Comment = 'FRA="Axes analytiques"';
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
        addfirst("P&osting")
        {
            action("BC6_P&ost")
            {
                Promoted = true;
                Caption = 'P&ost', Comment = 'FRA="&Valider"';
                PromotedIsBig = true;
                Image = PostOrder;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                    Text003: Label 'Please enter field External Document No.', Comment = 'FRA="Veuillez saisir le champ N° doc. externe"';
                begin
                    //Modif JX-AUD du 13/02/2013
                    IF (COMPANYNAME = 'VSC') OR (COMPANYNAME = 'VSC - RECETTE') THEN
                        IF Rec."Sell-to Customer No." = 'ASNCFGLX00' THEN
                            IF Rec."External Document No." = '' THEN
                                ERROR(Text003);

                    IF (COMPANYNAME = 'VSCT') OR (COMPANYNAME = 'VSCT - RECETTE') THEN
                        IF Rec."Sell-to Customer No." = 'ASNCF00000' THEN
                            IF Rec."External Document No." = '' THEN
                                ERROR(Text003);
                    //Fin modif JX-AUD du 13/02/2013
                    IF ApprovalMgt.PrePostApprovalCheckSales(Rec) THEN
                        PostDocument(CODEUNIT::"Sales-Post (Yes/No)");
                end;
            }
        }
        addafter(TestReport)
        {
            action("BC6_Post and &Print")
            {
                Caption = 'Post and &Print', Comment = 'FRA="Valider et i&mprimer"';
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Shift+F9';
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                    Text003: Label 'Please enter field External Document No.', Comment = 'FRA="Veuillez saisir le champ N° doc. externe"';
                begin
                    IF (COMPANYNAME = 'VSC') OR (COMPANYNAME = 'VSC - RECETTE') THEN
                        IF Rec."Sell-to Customer No." = 'ASNCFGLX00' THEN
                            IF Rec."External Document No." = '' THEN
                                ERROR(Text003);

                    IF (COMPANYNAME = 'VSCT') OR (COMPANYNAME = 'VSCT - RECETTE') THEN
                        IF Rec."Sell-to Customer No." = 'ASNCF00000' THEN
                            IF Rec."External Document No." = '' THEN
                                ERROR(Text003);
                    //Fin modif JX-AUD du 13/02/2013

                    IF ApprovalMgt.PrePostApprovalCheckSales(Rec) THEN
                        PostDocument(CODEUNIT::"Sales-Post + Print");
                end;
            }
        }
    }

    var
        DocumentIsPosted: Boolean;
        IsCustomerOrContactNotEmpty: Boolean;

    local procedure PostDocument(PostingCodeunitID: Integer)
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesHeader: Record "Sales Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
        OfficeMgt: Codeunit "Office Management";
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
        OpenPostedSalesCrMemoQst: label 'The credit memo is posted as number %1 and moved to the Posted Sales Credit Memos window.\\Do you want to open the posted credit memo?', Comment = 'FRA="L''avoir vente est inscrit au numéro %1 et déplacé à la fenêtre Avoirs vente enregistrés. Voulez-vous ouvrir l’avoirs vente enregistrés?"';
    begin
        SalesCrMemoHeader.SetRange("Pre-Assigned No.", PreAssignedNo);
        if SalesCrMemoHeader.FindFirst() then
            if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedSalesCrMemoQst, SalesCrMemoHeader."No."),
                 InstructionMgt.ShowPostedConfirmationMessageCode())
            then
                InstructionMgt.ShowPostedDocument(SalesCrMemoHeader, Page::"Sales Credit Memo");
    end;

    local procedure CheckSalesCheckAllLinesHaveQuantityAssigned()
    var
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
    begin
        LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);
    end;

    local procedure SetIsCustomerOrContactNotEmpty()
    var
    begin
        IsCustomerOrContactNotEmpty := (Rec."Sell-to Customer No." <> '') or (Rec."Sell-to Contact No." <> '');
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetIsCustomerOrContactNotEmpty();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetIsCustomerOrContactNotEmpty();
    end;

    trigger OnOpenPage()
    var
        EnvironmentInfo: Codeunit "Environment Information";
    begin
        SetIsCustomerOrContactNotEmpty();
    end;

}
