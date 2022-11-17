pageextension 50041 "BC6_PurchaseQuote" extends "Purchase Quote" //49
{
    // // Rendre le Bouton "Archive Document" visible
    Caption = 'Purchase Quote';
    PromotedActionCategories = 'Gérer,Processus,Editions,Naviguer';

    layout
    {
        modify("Buy-from Vendor No.")
        {
            Importance = Promoted;
        }
        modify("Buy-from Contact No.")
        {
            Importance = Additional;
        }

        modify("Due Date")
        {
            Importance = Promoted;
        }
        modify("Requested Receipt Date")
        {
            Importance = Additional;
        }
        modify("Vendor Shipment No.")
        {
            Importance = Additional;
        }
        modify("Purchaser Code")
        {
            Importance = Additional;
        }
        modify(Status)
        {
            Importance = Promoted;
        }
        modify("Invoice Details")
        {
            Caption = 'Invoicing';
        }
        modify("Currency Code")
        {
            Importance = Promoted;
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

        modify(Control79)
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
        modify(Control45)
        {
            Visible = false;
        }
        modify(ShippingOptionWithLocation)
        {
            Visible = false;
        }

        modify(Control90)
        {
            Visible = false;
        }
        modify("Ship-to County")
        {
            Visible = false;
        }

        modify("Ship-to Country/Region Code")
        {
            Visible = false;
        }

        modify(Control51)
        {
            Visible = false;
        }
        modify(PayToOptions)
        {
            Visible = false;
        }
        modify(Control67)
        {
            Visible = false;
        }
        modify("Pay-to Name")
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

        modify(IncomingDocAttachFactBox)
        {
            Visible = false;
        }
        modify(WorkflowStatus)
        {
            Visible = false;
        }
        modify("Vendor Order No.")
        {
            Importance = Additional;
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
    }
    actions
    {
        modify("&Quote")
        {
            Caption = '&Quote';
        }
        modify(Statistics)
        {
            Visible = false;
        }
        modify(Vendor)
        {
            Visible = false;
        }
        modify("Co&mments")
        {
            Visible = false;
        }
        modify(Dimensions)
        {
            Visible = false;
        }
        modify(Release)
        {
            Visible = false;
        }
        modify("F&unctions")
        {
            Visible = true;
        }
        modify(CalculateInvoiceDiscount)
        {
            Visible = false;
        }
        modify("Get St&d. Vend. Purchase Codes")
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
        modify(Print)
        {
            Visible = false;
        }
        modify(Send)
        {
            Visible = false;
        }
        modify(Reopen)
        {
            Visible = false;
        }
        modify(CopyDocument)
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
        modify(MakeOrder)
        {
            Visible = false;
        }
        addafter(Dimensions)
        {
            action(BC6_Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
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
        addfirst(Processing)
        {
            action("BC6_Send A&pproval Request")
            {
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin
                    if ApprovalMgt.CheckPurchaseApprovalPossible(Rec) then
                        ApprovalMgt.OnSendPurchaseDocForApproval(Rec);
                end;
            }
            action("BC6_Cancel Approval Re&quest")
            {
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                    WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                begin
                    ApprovalMgt.OnCancelPurchaseApprovalRequest(Rec);
                    WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    // IF ApprovalMgt.CancelPurchaseApprovalRequest(Rec, TRUE, TRUE) THEN;
                end;
            }
            action("BC6_Re&open")
            {
                Caption = 'Re&open';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ReleasePurchDoc: Codeunit "Release Purchase Document";
                begin
                    ReleasePurchDoc.PerformManualReopen(Rec);
                end;
            }
            action("BC6_Make &Order")
            {
                Caption = 'Make &Order';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin
                    VerifSaisieAxesAnalytiques();
                    if ApprovalMgt.PrePostApprovalCheckPurch(Rec) then
                        CODEUNIT.Run(CODEUNIT::"Purch.-Quote to Order (Yes/No)", Rec);
                end;
            }
            action("BC6_Copy Document")
            {
                Caption = 'Copy Document';
                Ellipsis = true;
                Image = CopyDocument;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.CopyDocument();
                    if Rec.Get(Rec."Document Type", Rec."No.") then;
                end;
            }
            action("BC6_&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
                    DocPrint: Codeunit "Document-Print";
                    LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";

                begin
                    if ApplicationAreaMgmtFacade.IsFoundationEnabled() then
                        LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);

                    DocPrint.PrintPurchHeader(Rec);
                end;
            }
        }
        addafter("Archive Document")
        {
            separator(Action147)
            {
            }
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
        Grec_Dimension: Record Dimension;
        Grec_DimSetEntry: Record "Dimension Set Entry";
        Grecord_GeneralLedgerSetup: Record "General Ledger Setup";
        Grec_PurchaseLine: Record "Purchase Line";
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

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE();
    end;

    procedure VerifSaisieAxesAnalytiques()
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
}
