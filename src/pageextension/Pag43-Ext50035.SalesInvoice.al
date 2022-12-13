pageextension 50035 "BC6_SalesInvoice" extends "Sales Invoice" //43
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
                trigger OnValidate()
                begin
                    CurrPage.Update();
                end;
            }
            field("BC6_Customer Posting Group"; Rec."Customer Posting Group")
            {
                Editable = true;
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
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Customer Posting Group")
        {
            Visible = false;
        }
    }
    actions
    {
        modify("Function_CustomerCard")
        {
            Visible = false;
        }
        modify(Post)
        {
            Visible = false;
        }
        addafter(Dimensions)
        {
            action(BC6_Client)
            {
                Caption = 'Customer', Comment = 'FRA="Client"';
                Image = Customer;
                RunObject = page "Customer List";
                RunPageLink = "No." = field("Sell-to Customer No."), "Date Filter" = field("Date Filter");
                ShortCutKey = 'Shift+F7';
                ApplicationArea = Basic, Suite;
                Enabled = IsCustomerOrContactNotEmpty;
                Promoted = true;
                PromotedCategory = Category11;
                ToolTip = 'View or edit detailed information about the customer on the sales document.', Comment = 'FRA="View or edit detailed information about the customer on the sales document."';
            }
        }
        addfirst("P&osting")
        {
            action(BC6_Post)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'P&ost', Comment = 'FRA="&Valider"';
                Image = PostOrder;
                ShortCutKey = 'F9';
                AboutTitle = 'When all is set, you post', Comment = 'FRA="Quand tout est réglé, vous postez"';
                AboutText = 'After entering the sales lines and other information, you post the invoice to make it count.? After posting, the sales invoice is moved to the Posted Sales Invoices list.', Comment = 'FRA="Après avoir entré les lignes de vente et d’autres informations, vous postez la facture pour la faire compter.? Après l’affichage, la facture est transférée à la liste des factures de vente affichées."';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.', Comment = 'FRA="Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books."';

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
                        PostDocument(CODEUNIT::"Sales-Post (Yes/No)", "Navigate After Posting"::"Posted Document");
                end;
            }
        }
        addafter("Test Report")
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
                        PostDocument(CODEUNIT::"Purch.-Post + Print", "Navigate After Posting"::"Do Nothing");
                end;
            }
        }
    }

    var
        IsCustomerOrContactNotEmpty: Boolean;

    local procedure PostDocument(PostingCodeunitID: Integer; Navigate: Enum "Navigate After Posting")
    var
        SalesHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        OfficeMgt: Codeunit "Office Management";
        DocumentIsPosted: Boolean;
        IsScheduledPosting: Boolean;
        PreAssignedNo: Code[20];
    begin
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
        OpenPostedSalesInvQst: label 'The invoice is posted as number %1 and moved to the Posted Sales Invoices window.\\Do you want to open the posted invoice?', Comment = 'FRA="La facture est affichée sous le numéro %1 et déplacée dans la fenêtre Factures ventes enregistrées.\\Voulez-vous ouvrir la facture enregistrée ?"';
    begin
        SalesInvoiceHeader.SetCurrentKey("Pre-Assigned No.");
        SalesInvoiceHeader.SetRange("Pre-Assigned No.", PreAssignedNo);
        if SalesInvoiceHeader.FindFirst() then
            if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedSalesInvQst, SalesInvoiceHeader."No."),
                 InstructionMgt.ShowPostedConfirmationMessageCode())
            then
                InstructionMgt.ShowPostedDocument(SalesInvoiceHeader, Page::"Sales Invoice");
    end;

    local procedure SetIsCustomerOrContactNotEmpty()
    begin
        IsCustomerOrContactNotEmpty := (Rec."Sell-to Customer No." <> '') or (Rec."Sell-to Contact No." <> '');
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetIsCustomerOrContactNotEmpty()
    end;

}
