pageextension 50042 "BC6_PurchaseOrder" extends "Purchase Order" //50
{
    // NAVW16.00.01,JX-VSC1.0-XAD,JX-VSC1.1-AUD-XAD,JX-VSC1.2-XAD,JX-VSC1.3-XAD
    //
    // Début Modif JX-XAD du 11/06/2008
    // Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
    // Ajout du champ "Code utilisateur affecté" sur l'en-tête du formulaire
    // ------------------------------------ V1.1 --------------------------------
    //
    // //modifcation AUD le 08/04/2009
    // //mise en commentaire du code
    //
    // Modif JX-XAD du 15/05/2009
    // Appel du dataport 50011 depuis le bouton dem. prix ==> Annuler réceptions et modifier quantités
    //
    // ---------------------------------------- V1.2 ----------------------------------------
    // AJOUT JX-XAD 13/01/2010
    // Nouvelle fonction dans le bouton Commande : "Liste des factures associées"
    // Ce bouton fait appel à un formulaire qui affiche toutes les factures (en cours et enregistrées)
    // liées à la commande.
    //
    // ------------------------------ V1.2 ---------------------------
    // CREATION JX-XAD 26/02/2010
    // Gestion des contrats : ajout des boutons "Contrat" + "Imprimer contrat"
    //
    // MODIF JX-XAD 06/08/2010 Suite migration
    // Mise à jour de la disposition des champs sur le formulaire
    //
    // //Modif JX-AUD du 17/02/2012
    // //Ajout du Champs "Matricule" et traitement de celui-ci
    //
    // ----------------------------------------Suivi Migration---------------------------------------------------------
    // //MODIF JX-ABE 01/10/2015 Suite migration
    // //Ajout le bouton Nouveau sur le ruban
    //
    // //MODIF JX-ABE du 05/10/2015
    // //Rendre le Bouton "Archive Document" visible

    PromotedActionCategories = 'Gérer,Processus,Editions,Naviguer';
    layout
    {
        modify("Buy-from Vendor No.")
        {
            Importance = Promoted;
            ShowMandatory = true;
        }
        modify("Buy-from Contact")
        {
            Importance = Additional;
        }
        modify("Due Date")
        {
            Importance = Promoted;
        }
        modify("Vendor Invoice No.")
        {
            Visible = false;
        }
        modify("Order Date")
        {
            Importance = Promoted;
        }
        modify("Vendor Order No.")
        {
            Visible = false;
        }
        modify("Vendor Shipment No.")
        {
            Visible = false;
        }
        modify("Order Address Code")
        {
            Visible = false;
        }
        modify(Status)
        {
            Importance = Promoted;
        }
        modify("Invoice Details")
        {
            Caption = 'Invoicing';
        }
        modify("Shipping and Payment")
        {
            Caption = 'Shipping';
        }
        modify("Pay-to Contact")
        {
            Importance = Additional;
        }
        modify(Control1904651607)
        {
            Visible = true;
        }
        modify(Control1903435607)
        {
            Visible = true;
        }
        modify(Control1905767507)
        {
            Visible = true;
        }
        modify("Buy-from Vendor Name")
        {
            Visible = false;
        }
        modify("Posting Description")
        {
            Visible = false;
        }
        modify(Control122)
        {
            Visible = false;
        }
        modify("Buy-from County")
        {
            Visible = false;
        }
        modify("Buy-from Country/Region Code")
        {
            Visible = false;
        }
        modify("Posting Date")
        {
            Visible = false;
        }
        modify(Control83)
        {
            Visible = false;
        }
        modify(Control94)
        {
            Visible = false;
        }
        modify(Control99)
        {
            Visible = false;
        }
        modify(Control98)
        {
            Visible = false;
        }
        modify("No. of Archived Versions")
        {
            Visible = false;
        }

        modify(Control101)
        {
            Visible = false;
        }

        modify(Control124)
        {
            Visible = false;
        }
        modify("Ship-to County")
        {
            Visible = false;
        }
        modify(Control71)
        {
            Visible = false;
        }
        modify(PayToOptions)
        {
            Visible = false;
        }
        modify(Control95)
        {
            Visible = false;
        }
        modify("Pay-to Name")
        {
            Visible = false;
        }

        modify(Control123)
        {
            Visible = false;
        }
        modify("Pay-to County")
        {
            Visible = false;
        }
        modify("Pay-to Country/Region Code")
        {
            Visible = false;
        }

        modify("Attached Documents")
        {
            Visible = false;
        }
        modify(Control23)
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

        addafter("No. of Archived Versions")
        {
            field("BC6_Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
            field("BC6_Matricule No."; Rec."BC6_Matricule No.")
            {
                ApplicationArea = All;
            }
            field(BC6_Import; Rec."BC6_Import")
            {
                ApplicationArea = All;
            }
        }
        addafter("Responsibility Center")
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
        addafter(Status)
        {
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
        addfirst("Invoice Details")
        {
            field("BC6_Pay-to Vendor No."; Rec."Pay-to Vendor No.")
            {
                Importance = Promoted;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    PaytoVendorNoOnAfterValidate();
                end;
            }
        }
        addfirst(FactBoxes)
        {
            part("Montants Document"; "BC6_Purchase Doc. Factbox")
            {
                Caption = 'Montants Document';
                Provider = PurchLines;
                SubPageLink = "Document Type" = field("Document Type"), "No." = field("Document No.");
                ApplicationArea = All;
            }
        }
        addafter("Ship-to Contact")
        {
            field("BC6_Import Vendor Email"; Rec."BC6_Import Vendor Email")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify(Dimensions)
        {
            Promoted = false;
            Visible = false;
        }
        modify(Statistics)
        {
            Visible = false;
        }
        modify("Co&mments")
        {
            Visible = false;
        }
        modify(Invoices)
        {
            Promoted = true;
            PromotedIsBig = true;
            PromotedCategory = Category4;
        }
        modify(PostedPrepaymentInvoices)
        {
            Visible = false;
        }
        modify(PostedPrepaymentCrMemos)
        {
            Visible = false;
        }
        modify(Warehouse)
        {
            Visible = false;
        }
        modify(PostPrepaymentInvoice)
        {
            Visible = false;
        }
        modify(Release)
        {
            Promoted = true;
            PromotedCategory = Process;
            PromotedIsBig = true;
        }
        modify(Reopen)
        {
            Promoted = true;
            PromotedIsBig = true;
            PromotedCategory = Process;
        }
        modify(CalculateInvoiceDiscount)
        {
            Visible = false;
        }
        modify(GetRecurringPurchaseLines)
        {
            Caption = 'Get St&d. Vend. Purchase Codes';
            Visible = false;
        }
        modify(CopyDocument)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(MoveNegativeLines)
        {
            Visible = false;
        }
        modify("Dr&op Shipment")
        {
            Visible = false;
        }
        modify("Get &Sales Order")
        {
            Visible = false;
        }
        modify("Speci&al Order")
        {
            Visible = false;
        }
        modify("Functions_GetSalesOrder")
        {
            Visible = false;
        }
        modify(Action186)
        {
            Visible = false;
        }
        modify(Action187)
        {
            Visible = false;
        }
        modify("Archive Document")
        {
            Visible = true;
        }
        modify("Send Intercompany Purchase Order")
        {
            Caption = 'Send IC Purchase Order';
            Visible = false;
        }
        modify("Request Approval")
        {
            Caption = 'Approval';
        }
        modify("Whse. Receipt Lines")
        {
            Visible = false;
        }
        modify("Create Inventor&y Put-away/Pick")
        {
            Visible = false;
        }
        modify("P&osting")
        {
            Visible = false;
        }
        modify("Post and &Print")
        {
            Promoted = true;
            PromotedCategory = Process;
            Visible = false;
        }
        modify("Prepa&yment")
        {
            Visible = false;
        }
        modify(Approvals)
        {
            Visible = false;
        }
        modify(DocAttach)
        {
            Visible = false;
        }
        modify(Receipts)
        {
            Visible = false;
        }
        modify(Approval)
        {
            Caption = 'Approval';
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
        modify(SendApprovalRequest)
        {
            Visible = false;
        }
        modify(CancelApprovalRequest)
        {
            Visible = false;
        }
        modify(Flow)
        {
            Visible = false;
        }
        modify(CreateFlow)
        {
            Visible = false;
        }
        modify(Post)
        {
            Visible = false;
        }
        modify(Preview)
        {
            Visible = false;
        }
        modify(PreviewPrepmtInvoicePosting)
        {
            Visible = false;
        }
        modify(PreviewPrepmtCrMemoPosting)
        {
            Visible = false;
        }
        modify(Print)
        {
            Visible = false;
        }
        modify("&Print")
        {
            Visible = false;
        }
        modify(SendCustom)
        {
            Visible = false;
        }
        addafter(Approvals)
        {
            action(BC6_Approbations)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = false;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                begin
                    ApprovalEntries.SetRecordFilters(DATABASE::"Purchase Header", Rec."Document Type", Rec."No.");
                    ApprovalEntries.RUN();
                end;
            }
        }
        addafter("Co&mments")
        {
            action("BC6_Invoices related to ordering")
            {
                Caption = 'Listes des factures associées';
                Image = ReturnRelated;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Page_ListeFactures: Page "BC6_Invoices related  ordering";
                begin
                    //DEBUT AJOUT JX-XAD 24/12/2009
                    Page_ListeFactures.jx_InitForm(Rec."No.");
                    Page_ListeFactures.RUNMODAL();
                    CLEAR(Page_ListeFactures);
                    //FIN AJOUT JX-XAD 24/12/2009
                end;
            }
        }
        addafter(Invoices)
        {
            action(BC6_Receipts)
            {
                Caption = 'Receipts';
                Image = PostedReceipts;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = page "Posted Purchase Receipts";
                RunPageLink = "Order No." = field("No.");
                RunPageView = sorting("Order No.");
                ApplicationArea = All;
            }
        }
        addfirst(Warehouse)
        {
            separator(Action181)
            {
            }
        }
        addafter(PreviewPrepmtInvoicePosting)
        {
            separator(Action611)
            {
            }
        }
        addafter(CalculateInvoiceDiscount)
        {
            separator(Action190)
            {
            }
        }
        addafter(GetRecurringPurchaseLines)
        {
            separator(Action75)
            {
            }
        }
        addbefore(Release)
        {
            action("BC6_P&ost")
            {
            }
        }
        addafter(CopyDocument)
        {
            action("BC6_&Imprimer")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    DocPrintENU.PrintOrderVSC(Rec);
                end;
            }
        }
        addafter(MoveNegativeLines)
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
        addafter(Action186)
        {
            separator(Action1000000004)
            {
            }
            action("Liste des factures associées")
            {
                Caption = 'List of invoices associated';
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //DEBUT AJOUT JX-XAD 24/12/2009
                    Form_ListeFactures.jx_InitForm(Rec."No.");
                    Form_ListeFactures.RUNMODAL();
                    CLEAR(Form_ListeFactures);
                    //FIN AJOUT JX-XAD 24/12/2009
                end;
            }
        }
        addafter("Send Intercompany Purchase Order")
        {
            separator(Action189)
            {
            }
        }
        addafter(Approval)
        {
            action("BC6_Send A&pproval Request")
            {
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin
                    if ApprovalMgt.CheckPurchaseApprovalPossible(Rec) then
                        ApprovalMgt.OnSendPurchaseDocForApproval(Rec);
                end;
            }
            action("Annuler l'approbation")
            {
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                    WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                begin
                    ApprovalMgt.OnCancelPurchaseApprovalRequest(Rec);
                    WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                end;
            }
        }
        addafter("Remove From Job Queue")
        {
            separator(Action201)
            {
            }
        }
    }

    var
        Grec_Dimension: Record Dimension;
        Grec_DimSetEntry: Record "Dimension Set Entry";
        Grecord_GeneralLedgerSetup: Record "General Ledger Setup";
        Grec_PurchaseLine: Record "Purchase Line";
        DocPrintENU: Codeunit "BC6_PrintOrderVSC";
        Form_ListeFactures: Page "BC6_Invoices related  ordering";
        Gcode_Axe1: Code[20];
        Gcode_Axe2: Code[20];
        Gcode_Axe3: Code[20];
        Gcode_Axe4: Code[20];
        Gtext_Axe1: Text[50];
        Gtext_Axe2: Text[50];
        Gtext_Axe3: Text[50];
        Gtext_Axe4: Text[50];

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        if Rec.GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
            if Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
                Rec.SETRANGE("Buy-from Vendor No.");
        CurrPage.UPDATE();
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(true);
    end;

    local procedure PaytoVendorNoOnAfterValidate()
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

    local procedure Prepayment37OnAfterValidate()
    begin
        CurrPage.UPDATE();
    end;

    local procedure VerifSaisieAxesAnalytiques()
    begin
        if Grecord_GeneralLedgerSetup.FIND('-') then begin
            Gcode_Axe1 := Grecord_GeneralLedgerSetup."Shortcut Dimension 3 Code";//Axe 0
            if Grec_Dimension.GET(Gcode_Axe1) then Gtext_Axe1 := Grec_Dimension.Name;
            Gcode_Axe2 := Grecord_GeneralLedgerSetup."Shortcut Dimension 4 Code";// Axe 1
            if Grec_Dimension.GET(Gcode_Axe2) then Gtext_Axe2 := Grec_Dimension.Name;
            Gcode_Axe3 := Grecord_GeneralLedgerSetup."Shortcut Dimension 5 Code";// Axe 2
            if Grec_Dimension.GET(Gcode_Axe3) then Gtext_Axe3 := Grec_Dimension.Name;
            Gcode_Axe4 := Grecord_GeneralLedgerSetup."Shortcut Dimension 6 Code";// Axe 3
            if Grec_Dimension.GET(Gcode_Axe4) then Gtext_Axe4 := Grec_Dimension.Name;
        end;

        if Rec."Document Type" = Rec."Document Type"::Quote then//DA
        begin
            Grec_PurchaseLine.SETFILTER("Document No.", Rec."No.");
            if Grec_PurchaseLine.FIND('-') then
                repeat
                    if Grec_PurchaseLine.Type <> Grec_PurchaseLine.Type::" " then begin
                        if Gcode_Axe1 <> '' then
                            if not Grec_DimSetEntry.GET(Grec_PurchaseLine."Dimension Set ID", Gcode_Axe1) then
                                ERROR('Vous devez saisir l''axe analytique ' + FORMAT(Gtext_Axe1) + ' sur la ligne ' + FORMAT(Grec_PurchaseLine."Line No."));
                        if Gcode_Axe2 <> '' then
                            if not Grec_DimSetEntry.GET(Grec_PurchaseLine."Dimension Set ID", Gcode_Axe2) then
                                ERROR('Vous devez saisir l''axe analytique ' + FORMAT(Gtext_Axe2) + ' sur la ligne ' + FORMAT(Grec_PurchaseLine."Line No."));
                        if Gcode_Axe3 <> '' then
                            if not Grec_DimSetEntry.GET(Grec_PurchaseLine."Dimension Set ID", Gcode_Axe3) then
                                ERROR('Vous devez saisir l''axe analytique ' + FORMAT(Gtext_Axe3) + ' sur la ligne ' + FORMAT(Grec_PurchaseLine."Line No."));
                        if Gcode_Axe4 <> '' then
                            if not Grec_DimSetEntry.GET(Grec_PurchaseLine."Dimension Set ID", Gcode_Axe4) then
                                ERROR('Vous devez saisir l''axe analytique ' + FORMAT(Gtext_Axe4) + ' sur la ligne ' + FORMAT(Grec_PurchaseLine."Line No."));
                    end;
                until Grec_PurchaseLine.NEXT() = 0;
        end;

        if Rec."Document Type" = Rec."Document Type"::Order then//Commande
        begin
            Grec_PurchaseLine.SETFILTER("Document No.", Rec."No.");
            if Grec_PurchaseLine.FIND('-') then
                repeat
                    if Grec_PurchaseLine.Type <> Grec_PurchaseLine.Type::" " then begin
                        if Gcode_Axe1 <> '' then
                            if not Grec_DimSetEntry.GET(Grec_PurchaseLine."Dimension Set ID", Gcode_Axe1) then
                                ERROR('Vous devez saisir l''axe analytique ' + FORMAT(Gtext_Axe1) + ' sur la ligne ' + FORMAT(Grec_PurchaseLine."Line No."));
                        if Gcode_Axe2 <> '' then
                            if not Grec_DimSetEntry.GET(Grec_PurchaseLine."Dimension Set ID", Gcode_Axe2) then
                                ERROR('Vous devez saisir l''axe analytique ' + FORMAT(Gtext_Axe2) + ' sur la ligne ' + FORMAT(Grec_PurchaseLine."Line No."));
                        if Gcode_Axe3 <> '' then
                            if not Grec_DimSetEntry.GET(Grec_PurchaseLine."Dimension Set ID", Gcode_Axe3) then
                                ERROR('Vous devez saisir l''axe analytique ' + FORMAT(Gtext_Axe3) + ' sur la ligne ' + FORMAT(Grec_PurchaseLine."Line No."));
                        if Gcode_Axe4 <> '' then
                            if not Grec_DimSetEntry.GET(Grec_PurchaseLine."Dimension Set ID", Gcode_Axe4) then
                                ERROR('Vous devez saisir l''axe analytique ' + FORMAT(Gtext_Axe4) + ' sur la ligne ' + FORMAT(Grec_PurchaseLine."Line No."));
                    end;
                until Grec_PurchaseLine.NEXT() = 0;
        end;
    end;

    local procedure PostDocument(PostingCodeunitID: Integer; Navigate: Enum "Navigate After Posting")
    var
        PurchaseHeader: Record "Purchase Header";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
        InstructionMgt: Codeunit "Instruction Mgt.";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        DocumentIsPosted: Boolean;
        IsScheduledPosting: Boolean;

    begin
        if ApplicationAreaMgmtFacade.IsFoundationEnabled() then
            LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);

        Rec.SendToPosting(PostingCodeunitID);

        IsScheduledPosting := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        DocumentIsPosted := (not PurchaseHeader.Get(Rec."Document Type", Rec."No.")) or IsScheduledPosting;

        if IsScheduledPosting then
            CurrPage.Close();
        CurrPage.Update(false);

        if PostingCodeunitID <> CODEUNIT::"Purch.-Post (Yes/No)" then
            exit;

        case Navigate of
            "Navigate After Posting"::"Posted Document":
                if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode()) then
                    ShowPostedConfirmationMessage();
            "Navigate After Posting"::"New Document":
                if DocumentIsPosted then begin
                    Clear(PurchaseHeader);
                    PurchaseHeader.Init();
                    PurchaseHeader.Validate("Document Type", PurchaseHeader."Document Type"::Order);
                    PurchaseHeader.Insert(true);
                    PAGE.Run(PAGE::"Purchase Order", PurchaseHeader);
                end;
        end;
    end;

    local procedure ShowPostedConfirmationMessage()
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        OrderPurchaseHeader: Record "Purchase Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
        OpenPostedPurchaseOrderQst: label 'The order is posted as number %1 and moved to the Posted Purchase Invoices window.\\Do you want to open the posted invoice?', Comment = '%1 = posted document number';

    begin
        if not OrderPurchaseHeader.Get(Rec."Document Type", Rec."No.") then begin
            PurchInvHeader.SetRange("No.", Rec."Last Posting No.");
            if PurchInvHeader.FindFirst() then
                if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedPurchaseOrderQst, PurchInvHeader."No."),
                     InstructionMgt.ShowPostedConfirmationMessageCode())
                then
                    PAGE.Run(PAGE::"Posted Purchase Invoice", PurchInvHeader);
        end;
    end;
}
