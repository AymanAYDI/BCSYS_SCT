pageextension 50041 "BC6_PurchaseQuote" extends "Purchase Quote" //49
{
    // // Rendre le Bouton "Archive Document" visible
    Caption = 'Purchase Quote', Comment = 'FRA="Devis"';
    PromotedActionCategories = 'Gérer,Processus,Editions,Naviguer';

    layout
    {
        modify("Buy-from Contact No.")
        {
            Importance = Additional;
        }
        modify("Assigned User ID")
        {
            Importance = Standard;
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
                Caption = 'Montants Document', Comment = 'FRA="Montants Document"';
                Provider = PurchLines;
                SubPageLink = "Document Type" = field("Document Type"), "No." = field("Document No.");
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(Approvals)
        {
            action("BC6_Send A&pproval Request")
            {
                Caption = 'Send A&pproval Request', Comment = 'FRA="Envoyer demande d''approbation"';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin
                    // if ApprovalMgt.CheckPurchaseApprovalPossible(Rec) then
                    //     ApprovalMgt.OnSendPurchaseDocForApproval(Rec);
                    //D‚but Modif JX-XAD du 24/06/2010
                    //Modif JX-AUD du 29/01/2013
                    VerifSaisieAxesAnalytiques();
                    //Fin modif JX-AUD du 29/01/2013
                    if ApprovalMgt.CheckPurchaseApprovalPossible(Rec) then
                        ApprovalMgt.OnSendPurchaseDocForApproval(Rec);

                end;
            }
            action(BC6_CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest', Comment = 'FRA="Annuler demande d''approbation"';
                Enabled = CanCancelApprovalForRecord;
                Image = CancelApprovalRequest;
                ToolTip = 'Cancel the approval request.', Comment = 'FRA="Annuler la demande d''approbation"';

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                end;
            }
            action("BC6_Re&open")
            {
                Caption = 'Re&open', Comment = 'FRA="R&ouvrir"';
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
                    CurrPage.PurchLines.PAGE.ClearTotalPurchaseHeader();
                end;
            }
            action("BC6_Make &Order")
            {
                Caption = 'Make &Order', Comment = 'FRA="&Transformer en commande"';
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
            action(BC6_CopyDocument)
            {
                ApplicationArea = Suite;
                Caption = 'Copy Document', Comment = 'FRA="Copier document"';
                Ellipsis = true;
                Enabled = Rec."No." <> '';
                Image = CopyDocument;
                ToolTip = 'Copy document lines and header information from another sales document to this document. You can copy a posted sales invoice into a new sales invoice to quickly create a similar document.', Comment = 'FRA="Copiez les lignes document et les informations d''en-tête d''un autre document vente vers celui-ci. Vous pouvez copier une facture vente validée dans une nouvelle facture vente pour créer rapidement un document similaire."';

                trigger OnAction()
                begin
                    Rec.CopyDocument();
                    if Rec.Get(Rec."Document Type", Rec."No.") then;
                    CurrPage.PurchLines.Page.ForceTotalsCalculation();
                    CurrPage.Update();
                end;
            }
        }
        addafter("Archive Document")
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
                    lPaymentMgt.CreatePaymentDoc(Rec);
                end;
            }
        }
        modify(MakeOrder)
        {
            Visible = false;
        }
        modify(Print)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Reopen)
        {
            Visible = false;
        }
        modify("&Quote")
        {
            Caption = '&Quote', Comment = 'FRA="&Naviguer"';
        }
        modify(Statistics)
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
        modify(CancelApprovalRequest)
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
            Promoted = true;
            PromotedIsBig = true;
            PromotedCategory = Category4;
        }
        modify(CopyDocument)
        {
            Visible = false;
        }
        modify(SendApprovalRequest)
        {
            Visible = false;
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
        CanCancelApprovalForRecord: Boolean;

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

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance();
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
    end;

}
