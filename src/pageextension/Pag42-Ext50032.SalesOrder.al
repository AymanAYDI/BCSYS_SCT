pageextension 50032 "BC6_SalesOrder" extends "Sales Order" //42
{
    // //Modif JX-AUD du 07/02/2013
    // //Modification du bouton Validation-->Valider
    // pour rendre le champ " N° doc. Ext. " obligatoire pour les clients ci-dessous :
    // o         Pour VSCT  c'est le client ASNCF00000.
    // o         Pour VSC c'est le client ASNCFGLX00

    layout
    {
        addafter("No. of Archived Versions")
        {
            field("BC6_BC6 Your Reference"; Rec."Your Reference")
            {
                Caption = 'Our reference', Comment = 'FRA="Notre référence"';
                ApplicationArea = All;
            }
            field("ShortcutDimCode[9]"; ShortcutDimCode[9])
            {
                CaptionClass = '1,2,9';
                ApplicationArea = All;
                trigger OnLookup(var Text: Text): Boolean
                begin
                    LookupShortcutDimCode(9, ShortcutDimCode[9]);
                end;

                trigger OnValidate()
                begin
                    ValidateShortcutDimCode(9, ShortcutDimCode[9]);
                end;
            }
        }
    }
    actions
    {
        modify(Post)
        {
            Visible = false;
        }
        modify(PostAndNew)
        {
            Visible = false;
        }
        addbefore("Dimensions")
        {
            action(BC6_card)
            {
                ShortCutKey = 'Shift+F7';
                Caption = 'Card', Comment = 'FRA="Fiche"';
                RunObject = Page "Customer List";
                RunPageLink = "No." = FIELD("Sell-to Customer No.");
                Image = EditLines;
                ApplicationArea = All;
            }
        }
        addafter(Post)
        {
            action("BC6_Post and &Print")
            {
                Caption = 'Post and &Print', Comment = 'FRA="Valider et i&mprimer"';
                Ellipsis = true;
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Shift+F9';
                ApplicationArea = All;

                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                    PrepaymentMgt: Codeunit "Prepayment Mgt.";
                begin
                    //Modif JX-AUD du 07/02/2013
                    IF (COMPANYNAME = 'VSC') OR (COMPANYNAME = 'VSC - RECETTE') THEN
                        IF "Sell-to Customer No." = 'ASNCFGLX00' THEN
                            IF "External Document No." = '' THEN
                                ERROR(Text003);

                    IF (COMPANYNAME = 'VSCT') OR (COMPANYNAME = 'VSCT - RECETTE') THEN
                        IF "Sell-to Customer No." = 'ASNCF00000' THEN
                            IF "External Document No." = '' THEN
                                ERROR(Text003);
                    //Fin modif JX-AUD du 07/02/2013

                    IF ApprovalMgt.PrePostApprovalCheckPurch(PurchaseHeader) THEN
                        IF PrepaymentMgt.TestSalesPrepayment(Rec) THEN
                            ERROR(STRSUBSTNO(Text001, "Document Type", "No."))
                        ELSE
                            IF PrepaymentMgt.TestSalesPayment(Rec) THEN
                                ERROR(STRSUBSTNO(Text002, "Document Type", "No."))
                            ELSE
                                PostSalesOrder(CODEUNIT::"Sales-Post (Yes/No)", "Navigate After Posting"::"New Document");
                END;
            }
        }


        addafter("Create &Warehouse Shipment")
        {
            action("BC6_P&ost")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'P&ost', Comment = 'FRA="&Valider"';
                Ellipsis = true;
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ShortCutKey = 'F9';
                trigger OnAction()
                VAR
                    PurchaseHeader: Record "Purchase Header";
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                    PrepaymentMgt: Codeunit "Prepayment Mgt.";
                BEGIN
                    //Modif JX-AUD du 07/02/2013
                    IF (COMPANYNAME = 'VSC') OR (COMPANYNAME = 'VSC - RECETTE') THEN
                        IF "Sell-to Customer No." = 'ASNCFGLX00' THEN
                            IF "External Document No." = '' THEN
                                ERROR(Text003);

                    IF (COMPANYNAME = 'VSCT') OR (COMPANYNAME = 'VSCT - RECETTE') THEN
                        IF "Sell-to Customer No." = 'ASNCF00000' THEN
                            IF "External Document No." = '' THEN
                                ERROR(Text003);
                    //Fin modif JX-AUD du 07/02/2013

                    IF ApprovalMgt.PrePostApprovalCheckPurch(PurchaseHeader) THEN
                        IF PrepaymentMgt.TestSalesPrepayment(Rec) THEN
                            ERROR(STRSUBSTNO(Text001, "Document Type", "No."))
                        ELSE
                            IF PrepaymentMgt.TestSalesPayment(Rec) THEN
                                ERROR(STRSUBSTNO(Text002, "Document Type", "No."))
                            ELSE
                                PostSalesOrder(CODEUNIT::"Sales-Post (Yes/No)", "Navigate After Posting"::"Posted Document");
                END;

            }
        }
    }
    var
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
        Text001: Label 'Do you want to change %1 in all related records in the warehouse?', Comment = 'FRA="Souhaitez-vous modifier %1 dans tous les enregistrements associés de l''entrepôt?"';
        Text002: Label 'The update has been interrupted to respect the warning.', Comment = 'FRA="La mise à jour a été interrompue pour respecter l''alerte."';
        Text003: Label 'Please enter field External Document No.', Comment = 'FRA="Veuillez saisir le champ N° doc. externe"';
        ShortcutDimCode: array[10] of Code[20];
        DocumentIsPosted: Boolean;
        OpenPostedSalesOrderQst: Label 'The order is posted as number %1 and moved to the Posted Sales Invoices window.\\Do you want to open the posted invoice?', Comment = 'FRA="La commande est affichée sous le numéro %1 et déplacée dans la fenêtre Factures ventes enregistrées.\\Voulez-vous ouvrir la facture enregistrée ?"';
        DocumentIsScheduledForPosting: Boolean;

    trigger OnAfterGetRecord()
    begin
        // JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
        // SetExtDocNoMandatoryCondition;
        // Ajout ABE 18/05/2016
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        // Fin ABE 18/05/2016
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //"Responsibility Center" := UserMgt.GetSalesFilter;
        // Ajout ABE 18/05/2016
        CLEAR(ShortcutDimCode);
        // Fin ABE 18/05/2016
    end;

    local procedure PostSalesOrder(PostingCodeunitID: Integer; Navigate: Enum "Navigate After Posting")
    var
        SalesHeader: Record "Sales Header";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        if ApplicationAreaMgmtFacade.IsFoundationEnabled() then
            LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);

        Rec.SendToPosting(PostingCodeunitID);

        DocumentIsScheduledForPosting := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        DocumentIsPosted := (not SalesHeader.Get(Rec."Document Type", Rec."No.")) or DocumentIsScheduledForPosting;
        CurrPage.Update(false);
        if PostingCodeunitID <> CODEUNIT::"Sales-Post (Yes/No)" then
            exit;

        case Navigate of
            "Navigate After Posting"::"Posted Document":
                begin
                    if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode()) then
                        ShowPostedConfirmationMessage();

                    if DocumentIsScheduledForPosting or DocumentIsPosted then
                        CurrPage.Close();
                end;
            "Navigate After Posting"::"New Document":
                if DocumentIsPosted then begin
                    Clear(SalesHeader);
                    SalesHeader.Init();
                    SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Order);

                    SalesHeader.Insert(true);
                    PAGE.Run(PAGE::"Sales Order", SalesHeader);
                end;
        end;
    end;

    local procedure ShowPostedConfirmationMessage()
    var
        OrderSalesHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        if not OrderSalesHeader.Get(Rec."Document Type", Rec."No.") then begin
            SalesInvoiceHeader.SetRange("No.", Rec."Last Posting No.");
            if SalesInvoiceHeader.FindFirst() then
                if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedSalesOrderQst, SalesInvoiceHeader."No."),
                     InstructionMgt.ShowPostedConfirmationMessageCode())
                then
                    PAGE.Run(PAGE::"Posted Sales Invoice", SalesInvoiceHeader);
        end;
    end;

}

