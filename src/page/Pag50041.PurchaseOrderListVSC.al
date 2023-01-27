page 50041 "BC6_Purchase Order List VSC"
{
    // NAVW16.00.01,JX-VSC1.0-XAD,JX-VSC1.1-AUD-XAD,JX-VSC1.2-XAD,JX-VSC1.3-XAD
    // 
    // Début Modif JX-XAD du 11/06/2008
    // Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
    // Ajout du champ "Code utilisateur affecté" sur l'en-tête du formulaire
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Purchase Orders', Comment = 'FRA="Commandes achat"';
    CardPageID = "BC6_Purchase Order VSC";
    Editable = false;
    PageType = List;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = CONST(Order));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = All;
                }
                field("Lines Amount"; Rec."BC6_Lines Amount")
                {
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                }
                field("Matricule No."; Rec."BC6_Matricule No.")
                {
                    ApplicationArea = All;
                }
                field("Quote No."; Rec."Quote No.")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Status Code"; Rec."BC6_Status Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Creation date"; Rec."BC6_Creation date")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        DimMgt.LookupDimValueCodeNoUpdate(1);
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        DimMgt.LookupDimValueCodeNoUpdate(2);
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Document Prepaid"; Rec."BC6_Document Prepaid")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Amount Prepaid"; Rec."BC6_Amount Prepaid")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    Visible = JobQueueActive;
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(Control1901138007; "Vendor Details FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No."), "Date Filter" = FIELD("Date Filter");
                Visible = true;
                ApplicationArea = All;
            }
            systempart(Control1900383207; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Control1905767507; Notes)
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
            group("C&ommande")
            {
                Caption = 'O&rder', Comment = 'FRA="C&ommande"';
                Image = "Order";
                action("Axes analytiques")
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions', Comment = 'FRA="Axes analytiques"';
                    Image = Dimensions;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim();
                    end;
                }
                action(Statistics)
                {
                    Caption = 'Statistics', Comment = 'FRA="Statistiques"';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F7';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.CalcInvDiscForHeader();
                        COMMIT();
                        PAGE.RUNMODAL(PAGE::"Purchase Order Statistics", Rec);
                    end;
                }
                action(Approbations)
                {
                    Caption = 'Approvals', Comment = 'FRA="Approbations"';
                    Image = Approvals;
                    Promoted = false;
                    ApplicationArea = All;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntries.SetRecordFilters(DATABASE::"Purchase Header", Rec."Document Type", Rec."No.");
                        ApprovalEntries.RUN();
                    end;
                }
                action("Co&mmentaires")
                {
                    Caption = 'Co&mments', Comment = 'FRA="Co&mmentaires"';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No."), "Document Line No." = CONST(0);
                    ApplicationArea = All;
                }
            }
            group(Documents)
            {
                Caption = 'Documents', Comment = 'FRA="Documents"';
                Image = Documents;
                action("Réceptions")
                {
                    Caption = 'Receipts', Comment = 'FRA="Réceptions"';
                    Image = PostedReceipts;
                    Promoted = false;
                    RunObject = Page "Posted Purchase Receipts";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ApplicationArea = All;
                }
                action(Factures)
                {
                    Caption = 'Invoices', Comment = 'FRA="Factures"';
                    Image = Invoice;
                    Promoted = false;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ApplicationArea = All;
                }
                action("Factures acom&pte")
                {
                    Caption = 'Prepa&yment Invoices', Comment = 'FRA="Factures acom&pte"';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                    ApplicationArea = All;
                }
                action("A&voirs acompte")
                {
                    Caption = 'Prepayment Credi&t Memos', Comment = 'FRA="A&voirs acompte"';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Purchase Credit Memos";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                    ApplicationArea = All;
                }
            }
            group("Entrepôt")
            {
                Caption = 'Warehouse', Comment = 'FRA="Entrepôt"';
                Image = Warehouse;
                action("Lignes prélè&v./rangement stock")
                {
                    Caption = 'In&vt. Put-away/Pick Lines', Comment = 'FRA="Lignes prélè&v./rangement stock"';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Purchase Order"), "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                    ApplicationArea = All;
                }
                action("Lignes réception entrep.")
                {
                    Caption = 'Whse. Receipt Lines', Comment = 'FRA="Lignes réception entrep."';
                    Image = ReceiptLines;
                    RunObject = Page "Whse. Receipt Lines";
                    RunPageLink = "Source Type" = CONST(39), "Source Subtype" = FIELD("Document Type"), "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    ApplicationArea = All;
                }
                separator(Action1102601040)
                {
                }
            }
        }
        area(processing)
        {
            group("Général")
            {
                Caption = 'General', Comment = 'FRA="Général"';
                Image = Print;
                action("&Imprimer")
                {
                    Caption = '&Print', Comment = 'FRA="&Imprimer"';
                    Ellipsis = true;
                    Image = Print;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        DocPrintENU: Codeunit "BC6_PrintOrderVSC";
                    begin
                        //modifcation AUD le 08/04/2009
                        //mise en commentaire du code
                        //DocPrint.PrintPurchHeader(Rec);
                        DocPrintENU.PrintOrderVSC(Rec);
                        //fin modification
                    end;
                }
            }
            group(Lancer)
            {
                Caption = 'Release', Comment = 'FRA="Lancer"';
                Image = ReleaseDoc;
                action("&Lancer")
                {
                    Caption = 'Re&lease', Comment = 'FRA="&Lancer"';
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
                separator(Action1102601023)
                {
                }
            }
            group("Fonction&s")
            {
                Caption = 'F&unctions', Comment = 'FRA="Fonction&s"';
                Image = "Action";
                action("Envoyer demande d'approbation")
                {
                    Caption = 'Send A&pproval Request', Comment = 'FRA="Envoyer demande d''approbation"';
                    Image = SendApprovalRequest;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                action("Annuler l'approbation")
                {
                    Caption = 'Cancel Approval Re&quest', Comment = 'FRA="Annuler l''approbation"';
                    Image = Cancel;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                        WorkflowWebhookManagement.FindAndCancel(RecordId);
                    end;
                }
                action("Envoyer commande achat IC")
                {
                    AccessByPermission = TableData "IC G/L Account" = R;
                    Caption = 'Send IC Purchase Order', Comment = 'FRA="Envoyer commande achat IC"';
                    Image = IntercompanyOrder;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                    begin
                        if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
                            ICInOutboxMgt.SendPurchDoc(Rec, false);
                    end;
                }
                action("Payer ce document")
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
            group(Action12)
            {
                Caption = 'Warehouse', Comment = 'FRA="Entrepôt"';
                Image = Warehouse;
                action("Créer &réception entrepôt")
                {
                    AccessByPermission = TableData "Warehouse Receipt Header" = R;
                    Caption = 'Create &Whse. Receipt', Comment = 'FRA="Créer &réception entrepôt"';
                    Image = NewReceipt;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                    begin
                        GetSourceDocInbound.CreateFromPurchOrder(Rec);

                        IF NOT Rec.FIND('=><') THEN
                            Rec.INIT();
                    end;
                }
                action("Créer prélèv./rangement stoc&k")
                {
                    AccessByPermission = TableData "Posted Invt. Put-away Header" = R;
                    Caption = 'Create Inventor&y Put-away/Pick', Comment = 'FRA="Créer prélèv./rangement stoc&k"';
                    Ellipsis = true;
                    Image = CreatePutawayPick;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.CreateInvtPutAwayPick();

                        IF NOT Rec.FIND('=><') THEN
                            Rec.INIT();
                    end;
                }
            }
            group("&Validation")
            {
                Caption = 'P&osting', Comment = 'FRA="&Validation"';
                Image = Post;
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
                action("&Valider")
                {
                    Caption = 'P&ost', Comment = 'FRA="&Valider"';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.SendToPosting(CODEUNIT::"Purch.-Post (Yes/No)");
                    end;
                }
                action("Valider et i&mprimer")
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
                    begin
                        Rec.SendToPosting(CODEUNIT::"Purch.-Post + Print");
                    end;
                }
                action("Valider par l&ot")
                {
                    Caption = 'Post &Batch', Comment = 'FRA="Valider par l&ot"';
                    Ellipsis = true;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Orders", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Supprimer de la file d'attente des travaux")
                {
                    Caption = 'Remove From Job Queue', Comment = 'FRA="Supprimer de la file d''attente des travaux"';
                    Image = RemoveLine;
                    Visible = JobQueueActive;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.CancelBackgroundPosting();
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        Rec.SetSecurityFilterOnRespCenter();

        JobQueueActive := PurchasesPayablesSetup.JobQueueActive();

        //Début Modif JX-XAD du 11/06/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Assigned User ID", FunctionsMgt.jx_GetPurchasesFilter());
        Rec.FILTERGROUP(0);
        //Fin Modif JX-XAD du 11/06/2008
    end;

    var
        FunctionsMgt: Codeunit "BC6_FunctionsMgt";
        DimMgt: Codeunit DimensionManagement;
        ReportPrint: Codeunit "Test Report-Print";
        [InDataSet]
        JobQueueActive: Boolean;
}

