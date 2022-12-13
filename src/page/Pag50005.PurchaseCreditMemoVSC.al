page 50005 "BC6_Purchase Credit Memo VSC"
{
    // Modif JX-XAD du 11/06/2008
    // Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
    // 
    // ------------------------------ V1.2 ---------------------------
    // CREATION JX-XAD 26/02/2010
    // Gestion des contrats : ajout du bouton "Contrat"
    // 
    // //Modif JX-AUD 30/11/2012
    // //Mise en invisibilité des boutons Facture,Ligne, Fonctions,Validation
    // 
    // //Ajout des boutons "Approbation de facture" & "Annuler l’approbation"
    // 
    // 
    // // 22/06/17- JX-ABE- Ajout des champs N° Yooz & Lien Token Yooz
    // // 22/06/17- JX-ABE-Modif l'intitulé du bouton"Approbation de facture" par "Approbation d'Avoir".

    Caption = 'Purchase Cr.Memo', Comment = 'FRA="Avoir Achat"';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER("Credit Memo"));

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'General', Comment = 'FRA="Général"';
                field("No."; Rec."No.")
                {
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE();
                    end;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        BuyfromVendorNoOnAfterValidate();
                    end;
                }
                field("Buy-from Contact No."; Rec."Buy-from Contact No.")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Address"; Rec."Buy-from Address")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Buy-from Address 2"; Rec."Buy-from Address 2")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    Caption = 'Buy-from Post Code/City', Comment = 'FRA="CP/Ville fournisseur"';
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Buy-from City"; Rec."Buy-from City")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    Importance = Additional;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        PurchaserCodeOnAfterValidate();
                    end;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Yooz No."; Rec."BC6_Yooz No.")
                {
                    ApplicationArea = All;
                }
                field("Yooz Token link"; Rec."BC6_Yooz Token link")
                {
                    ExtendedDatatype = URL;
                    ApplicationArea = All;
                }
            }
            part(PurchLines; "Purch. Cr. Memo Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
            group(Facturation)
            {
                Caption = 'Invoicing', Comment = 'FRA="Facturation"';
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        PaytoVendorNoOnAfterValidate();
                    end;
                }
                field("Pay-to Contact No."; Rec."Pay-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Address"; Rec."Pay-to Address")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Address 2"; Rec."Pay-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    Caption = 'Pay-to Post Code/City', Comment = 'FRA="CP/Ville"';
                    ApplicationArea = All;
                }
                field("Pay-to City"; Rec."Pay-to City")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV();
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV();
                    end;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field("On Hold"; Rec."On Hold")
                {
                    ApplicationArea = All;
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValid();
                    end;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
            }
            group(Livraison)
            {
                Caption = 'Shipping', Comment = 'FRA="Livraison"';
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code/City', Comment = 'FRA="CP/Ville destinataire"';
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = All;
                }
            }
            group(International)
            {
                Caption = 'Foreign Trade', Comment = 'FRA="International"';
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ChangeExchangeRate);
                        ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date");
                        IF ChangeExchangeRate.RUNMODAL() = ACTION::OK THEN BEGIN
                            Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter());
                            CurrPage.UPDATE();
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;

                    trigger OnValidate()
                    begin
                        CurrencyCodeOnAfterValidate();
                    end;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Entry Point"; Rec."Entry Point")
                {
                    ApplicationArea = All;
                }
                field("Area"; Rec.Area)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part("Montants Document"; "BC6_Purchase Doc. Factbox")
            {
                Caption = 'Montants Document', Comment = 'FRA="Montants Document"';
                Provider = PurchLines;
                SubPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("Document No.");
                ApplicationArea = All;
            }
            part(Control1000000014; "Approval FactBox")
            {
                SubPageLink = "Table ID" = CONST(38), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                Visible = false;
                ApplicationArea = All;
            }
            part(Control1000000013; "Vendor Details FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = false;
                ApplicationArea = All;
            }
            part(Control1000000012; "Vendor Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = true;
                ApplicationArea = All;
            }
            part(Control1000000011; "Vendor Hist. Buy-from FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = true;
                ApplicationArea = All;
            }
            part(Control1000000010; "Vendor Hist. Pay-to FactBox")
            {
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = false;
                ApplicationArea = All;
            }
            part(Control1000000005; "Purchase Line FactBox")
            {
                Provider = PurchLines;
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No."), "Line No." = FIELD("Line No.");
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Control1000000004; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Control1000000001; Notes)
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Fa&cture")
            {
                Caption = '&Invoice', Comment = 'FRA="Fa&cture"';
                Visible = false;
                action(Statistiques)
                {
                    Caption = 'Statistics', Comment = 'FRA="Statistiques"';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        PurchSetup.GET();
                        IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
                            CurrPage.PurchLines.PAGE.CalcInvDisc();
                            COMMIT();
                        END;
                        PAGE.RUNMODAL(PAGE::"Purchase Statistics", Rec);
                    end;
                }
                action(Fiche)
                {
                    Caption = 'Card', Comment = 'FRA="Fiche"';
                    Image = EditLines;
                    RunObject = Page "Vendor List";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F5';
                    ApplicationArea = All;
                }
                action("Co&mmentaires")
                {
                    Caption = 'Co&mments', Comment = 'FRA="Co&mmentaires"';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No."), "Document Line No." = CONST(0);
                    ApplicationArea = All;
                }
                action("A&xes analytiques")
                {
                    Caption = 'Dimensions', Comment = 'FRA="A&xes analytiques"';
                    Image = Dimensions;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim();
                    end;
                }
            }
        }
        area(processing)
        {
            group("&Validation")
            {
                Caption = 'P&osting', Comment = 'FRA="&Validation"';
                Visible = false;
                action("Impression test")
                {
                    Caption = 'Test Report', Comment = 'FRA="Impression test"';
                    Ellipsis = true;
                    Image = TestReport;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
            group("Fonction&s")
            {
                Caption = 'F&unctions', Comment = 'FRA="Fonction&s"';
                Visible = false;
                action("Extraire codes &achat fourn. std")
                {
                    Caption = 'Get St&d. Vend. Purchase Codes', Comment = 'FRA="Extraire codes &achat fourn. std"';
                    Ellipsis = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        StdVendPurchCode: Record "Standard Vendor Purchase Code";
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                action("&Copier document")
                {
                    Caption = 'Copy Document', Comment = 'FRA="&Copier document"';
                    Ellipsis = true;
                    Image = CopyDocument;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL();
                        CLEAR(CopyPurchDoc);
                    end;
                }
                action("Déplacer lignes négatives")
                {
                    Caption = 'Move Negative Lines', Comment = 'FRA="Déplacer lignes négatives"';
                    Ellipsis = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegPurchLines);
                        MoveNegPurchLines.SetPurchHeader(Rec);
                        MoveNegPurchLines.RUNMODAL();
                        MoveNegPurchLines.ShowDocument();
                    end;
                }
                action("Approbation d'avoir")
                {
                    Caption = 'Send A&pproval Request', Comment = 'FRA="Approbation d''avoir"';
                    Image = SendApprovalRequest;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //IF ApprovalMgt.SendPurchaseApprovalRequest(Rec) THEN;

                        if ApprovalMgt.CheckPurchaseApprovalPossible(Rec) then
                            ApprovalMgt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                action("Annuler l'approbation")
                {
                    Caption = 'Cancel Approval Re&quest', Comment = 'FRA="Annuler l''approbation"';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalMgt.OnCancelPurchaseApprovalRequest(Rec);
                    end;
                }
                action(Lancer)
                {
                    Caption = 'Re&lease', Comment = 'FRA="Lancer"';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action("R&ouvrir")
                {
                    Caption = 'Re&open', Comment = 'FRA="R&ouvrir"';
                    Image = ReOpen;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            action("A&pprobation d'avoir")
            {
                Caption = 'A&pproval Invoice', Comment = 'FRA="A&pprobation d''avoir"';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin
                    if ApprovalMgt.CheckPurchaseApprovalPossible(Rec) then
                        ApprovalMgt.OnSendPurchaseDocForApproval(Rec);

                end;
            }
            action("Annuler l'appro&bation")
            {
                Caption = 'Cancel Approval', Comment = 'FRA="Annuler l''appro&bation"';
                Promoted = true;
                PromotedCategory = Process;
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
            action("&Contacts")
            {
                Caption = '&Contacts', Comment = 'FRA="&Contacts"';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    FunctionsMgt.LookupContacts(Rec);
                end;
            }
            action("Order &Addresses")
            {
                Caption = 'Order &Addresses', Comment = 'FRA="&Adresses de commande"';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    FunctionsMgt.LookupOrderAddr(Rec);
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD();
        EXIT(Rec.ConfirmDeletion());
    end;

    trigger OnInit()
    begin
        PurchHistoryBtn1Visible := TRUE;
        PayToCommentBtnVisible := TRUE;
        PayToCommentPictVisible := TRUE;
        PurchHistoryBtnVisible := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FILTERGROUP(0);
        END;

        //Début Modif JX-XAD du 11/06/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Assigned User ID", FunctionsMgt.jx_GetPurchasesFilter());
        Rec.FILTERGROUP(0);
        //Fin Modif JX-XAD du 11/06/2008
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        CopyPurchDoc: Report "Copy Purchase Document";
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        FunctionsMgt: Codeunit "BC6_FunctionsMgt";
        ChangeExchangeRate: Page "Change Exchange Rate";
        [InDataSet]
        PurchHistoryBtnVisible: Boolean;
        [InDataSet]
        PayToCommentPictVisible: Boolean;
        [InDataSet]
        PayToCommentBtnVisible: Boolean;
        [InDataSet]
        PurchHistoryBtn1Visible: Boolean;

    // local procedure UpdateInfoPanel()
    // var
    //     DifferBuyFromPayTo: Boolean;
    // begin
    //     DifferBuyFromPayTo := Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
    //     PurchHistoryBtnVisible := DifferBuyFromPayTo;
    //     PayToCommentPictVisible := DifferBuyFromPayTo;
    //     PayToCommentBtnVisible := DifferBuyFromPayTo;
    //     PurchHistoryBtn1Visible := PurchInfoPaneMgmt.DocExist(Rec, Rec."Buy-from Vendor No.");
    //     IF DifferBuyFromPayTo THEN
    //         PurchHistoryBtnVisible := PurchInfoPaneMgmt.DocExist(Rec, Rec."Pay-to Vendor No.")
    // end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE();
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE();
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE();
    end;

    local procedure CurrencyCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;
}

