page 50003 "BC6_Purchase Invoice VSC"
{
    Caption = 'Purchase Invoice';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = where("Document Type" = filter(Invoice));

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
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
                    Caption = 'Buy-from Post Code/City';
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
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    Importance = Promoted;
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
                field("Document Prepaid"; Rec."BC6_Document Prepaid")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Amount Prepaid"; Rec."BC6_Amount Prepaid")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Document Type Prepaid"; Rec."BC6_Document Type Prepaid")
                {
                    ApplicationArea = All;
                }
                field("Document No. Prepaid"; Rec."BC6_Document No. Prepaid")
                {
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
                field(Litige; Rec."BC6_Litige")
                {
                    ApplicationArea = All;
                }
                field("BC No."; Rec."BC6_BC No.")
                {
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
            part(PurchLines; "BC6_Purch. Invoice Subform VSC")
            {
                SubPageLink = "Document No." = field("No.");
                ApplicationArea = All;
            }
            group(Facturation)
            {
                Caption = 'Invoicing';
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
                    Caption = 'Pay-to Post Code/City';
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
                Caption = 'Shipping';
                field("Ship-to Name"; 'Ship-to Name')
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; 'Ship-to Address')
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; 'Ship-to Address 2')
                {
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; 'Ship-to Post Code')
                {
                    Caption = 'Ship-to Post Code/City';
                    ApplicationArea = All;
                }
                field("Ship-to City"; 'Ship-to City')
                {
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; 'Ship-to Contact')
                {
                    ApplicationArea = All;
                }
                field("Location Code"; 'Location Code')
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; 'Shipment Method Code')
                {
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; 'Expected Receipt Date')
                {
                    ApplicationArea = All;
                }
            }
            group(International)
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; 'Currency Code')
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ChangeExchangeRate);
                        ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date");
                        if ChangeExchangeRate.RUNMODAL() = ACTION::OK then begin
                            Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter());
                            CurrPage.UPDATE();
                        end;
                        CLEAR(ChangeExchangeRate);
                    end;

                    trigger OnValidate()
                    begin
                        CurrencyCodeOnAfterValidate();
                    end;
                }
                field("Transaction Type"; 'Transaction Type')
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; 'Transaction Specification')
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; 'Transport Method')
                {
                    ApplicationArea = All;
                }
                field("Entry Point"; 'Entry Point')
                {
                    ApplicationArea = All;
                }
                field("Area"; 'Area')
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part("Montants Document"; "BC6_Purchase Doc. Factbox")
            {
                Caption = 'Montants Document';
                Provider = PurchLines;
                SubPageLink = "Document Type" = field("Document Type"), "No." = field("Document No.");
                ApplicationArea = All;
            }
            part(Control1000000045; "Approval FactBox")
            {
                SubPageLink = "Table ID" = const(38), "Document Type" = field("Document Type"), "Document No." = field("No.");
                Visible = false;
                ApplicationArea = All;
            }
            part(Control1000000044; "Vendor Details FactBox")
            {
                SubPageLink = "No." = field("Buy-from Vendor No.");
                Visible = false;
                ApplicationArea = All;
            }
            part(Control1000000043; "Vendor Statistics FactBox")
            {
                SubPageLink = "No." = field("Pay-to Vendor No.");
                Visible = true;
                ApplicationArea = All;
            }
            part(Control1000000039; "Vendor Hist. Buy-from FactBox")
            {
                SubPageLink = "No." = field("Buy-from Vendor No.");
                Visible = true;
                ApplicationArea = All;
            }
            part(Control1000000037; "Vendor Hist. Pay-to FactBox")
            {
                SubPageLink = "No." = field("Pay-to Vendor No.");
                Visible = false;
                ApplicationArea = All;
            }
            part(Control1000000035; "Purchase Line FactBox")
            {
                Provider = PurchLines;
                SubPageLink = "Document Type" = field("Document Type"), "Document No." = field("Document No."), "Line No." = field("Line No.");
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Control1000000031; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Control1000000030; Notes)
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
            group("&Invoice")
            {
                Caption = '&Invoice';
                Visible = false;
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = page "Vendor List";
                    RunPageLink = "No." = field("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F5';
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = field("Document Type"), "No." = field("No."), "Document Line No." = const(0);
                    Visible = false;
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim();
                    end;
                }
                action(Approbations)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
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
        }
        area(processing)
        {
            group("Fonction&s")
            {
                Caption = 'F&unctions';
                Visible = false;
                separator(Action1000000020)
                {
                }
                action("Extraire codes &achat fourn. std")
                {
                    Caption = 'Get St&d. Vend. Purchase Codes';
                    Ellipsis = true;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        StdVendPurchCode: Record "Standard Vendor Purchase Code";
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                separator(Action1000000026)
                {
                }
                action("Déplacer lignes négatives")
                {
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegPurchLines);
                        MoveNegPurchLines.SetPurchHeader(Rec);
                        MoveNegPurchLines.RUNMODAL();
                        MoveNegPurchLines.ShowDocument();
                    end;
                }
                separator(Action1000000032)
                {
                }
                action(Statistiques)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F7';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        PurchSetup.GET();
                        if PurchSetup."Calc. Inv. Discount" then begin
                            CurrPage.PurchLines.PAGE.CalcInvDisc();
                            COMMIT();
                        end;
                        PAGE.RUNMODAL(PAGE::"Purchase Statistics", Rec);
                    end;
                }
                action(Lancer)
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+F9';
                    Visible = false;
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
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                action("&Copier document")
                {
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL();
                        CLEAR(CopyPurchDoc);
                    end;
                }
                action("Approbation de Facture")
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
                action("Annuler l'approbation")
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
                    end;
                }
                action("Payer ce document")
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
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                        PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                    begin
                        Grec_MontantFacture := 0;
                        //calcul du montant de la facture
                        Grec_PurchaseLine.SETFILTER(Grec_PurchaseLine."Document No.", Rec."No.");
                        if Grec_PurchaseLine.FIND('-') then
                            repeat
                                Grec_MontantFacture += Grec_PurchaseLine."Line Amount";
                            until Grec_PurchaseLine.NEXT() = 0;

                        if Rec."BC6_Register amount" <> Grec_MontantFacture then
                            ERROR(Text007);

                        if not (COMPANYNAME = 'HEXATOURISME') then//modif JX-AUD du 24/04/2012
                        begin
                            if VerifierLigneRcpt() then
                                Post(CODEUNIT::"Purch.-Post (Yes/No)");
                        end else
                            if ApprovalMgt.PrePostApprovalCheckPurch(Rec) then
                                PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec, false);
                    end;
                }
                action("Impression test")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action("Valider et i&mprimer")
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                        PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                    begin
                        Grec_MontantFacture := 0;
                        //calcul du montant de la facture
                        Grec_PurchaseLine.SETFILTER(Grec_PurchaseLine."Document No.", Rec."No.");
                        if Grec_PurchaseLine.FIND('-') then
                            repeat
                                Grec_MontantFacture += Grec_PurchaseLine."Line Amount";
                            until Grec_PurchaseLine.NEXT() = 0;

                        if Rec."BC6_Register amount" <> Grec_MontantFacture then
                            ERROR(Text007);

                        if not (COMPANYNAME = 'HEXATOURISME') then begin
                            if VerifierLigneRcpt() then
                                Post(CODEUNIT::"Purch.-Post + Print");
                        end else
                            if ApprovalMgt.PrePostApprovalCheckPurch(Rec) then
                                PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec, false);
                    end;
                }
                action("Valider par l&ot")
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Invoices", true, true, Rec);
                        CurrPage.UPDATE(false);
                    end;
                }
                action("Supprimer de la file d'attente des travaux")
                {
                    Caption = 'Remove From Job Queue';
                    Enabled = false;
                    Image = RemoveLine;
                    Visible = JobQueueVisible;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.CancelBackgroundPosting();
                    end;
                }
            }
            group("Comptabilité")
            {
                Caption = 'Send mail';
                action("Envoi mail facture - Four non créé")
                {
                    Caption = 'Envoi mail facture - Four non créé';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CLEAR(Gform_FAPMail);
                        Gform_FAPMail.SETRECORD(Rec);
                        Gtext_ObjetMail := 'Fiche Fournisseur à créer + Devis à créer dans NAVISION';
                        Gtext_Param1 := '';
                        Gtext_Param2 := '';
                        Gtext_Param3 := '';
                        Gtext_Param1 := 'le fournisseur';
                        Gtext_Param2 := 'Buy-from Vendor No.';
                        Gtext_Param3 := 'n''a pas été créé.';
                        Gform_FAPMail.SetParam(Gtext_Param1, Gtext_Param2, Gtext_Param3, 1, Gtext_ObjetMail);
                        Gform_FAPMail.CAPTION := 'Envoi mail facture - Fourn non créé';
                        Gform_FAPMail.RUNMODAL();
                        //Fin Modif JX-AUD du 23/04/2013
                    end;
                }
                action("Envoi mail facture - DA à créer")
                {
                    Caption = 'Envoi mail facture - DA à créer';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CLEAR(Gform_FAPMail);
                        Gform_FAPMail.SETRECORD(Rec);
                        Gtext_ObjetMail := 'Devis à créer dans NAVISION';
                        Gtext_Param1 := '';
                        Gtext_Param2 := '';
                        Gtext_Param3 := '';
                        Gtext_Param1 := '';
                        Gtext_Param2 := '';
                        Gtext_Param3 := '';
                        Gform_FAPMail.SetParam(Gtext_Param1, Gtext_Param2, Gtext_Param3, 2, Gtext_ObjetMail);
                        Gform_FAPMail.CAPTION := 'Envoi mail facture - DA à créer';
                        //Gform_FAPMail.RUNMODAL;
                        Gform_FAPMail.RUNMODAL();
                        //Fin Modif JX-AUD du 23/04/2013
                    end;
                }
                action("Envoi mail facture - DA non envoyé en appro.")
                {
                    Caption = 'Envoi mail facture - DA non envoyé en appro.';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Modif JX-AUD du 23/04/2013
                        CLEAR(Gform_FAPMail);
                        Gform_FAPMail.SETRECORD(Rec);
                        Gtext_ObjetMail := 'Devis à envoyer en approbation dans NAVISION';
                        Gtext_Param1 := '';
                        Gtext_Param2 := '';
                        Gtext_Param3 := '';
                        Gtext_Param1 := 'le devis';
                        Gtext_Param2 := 'DAXXXXX';
                        Gtext_Param3 := 'n''a pas été envoyé en approbation';
                        Gform_FAPMail.SetParam(Gtext_Param1, Gtext_Param2, Gtext_Param3, 3, Gtext_ObjetMail);
                        Gform_FAPMail.CAPTION := 'Envoi mail facture - DA non envoyé en appro.';
                        Gform_FAPMail.RUNMODAL();
                        //Fin Modif JX-AUD du 23/04/2013
                    end;
                }
                action("Envoi mail facture - DA non approuvée")
                {
                    Caption = 'Envoi mail facture - DA non approuvée';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Modif JX-AUD du 23/04/2013
                        CLEAR(Gform_FAPMail);
                        Gform_FAPMail.SETRECORD(Rec);
                        Gtext_ObjetMail := 'Devis à approuver dans NAVISION';
                        Gtext_Param1 := '';
                        Gtext_Param2 := '';
                        Gtext_Param3 := '';
                        Gtext_Param1 := 'le devis';
                        Gtext_Param2 := 'DAXXXXX';
                        Gtext_Param3 := 'n''est pas approuvé';
                        Gform_FAPMail.SetParam(Gtext_Param1, Gtext_Param2, Gtext_Param3, 4, Gtext_ObjetMail);
                        Gform_FAPMail.CAPTION := 'Envoi mail facture - DA non approuvée';
                        Gform_FAPMail.RUNMODAL();
                        //Fin Modif JX-AUD du 23/04/2013
                    end;
                }
                action("Envoi mail facture - DA non tranform.")
                {
                    Caption = 'Envoi mail facture - DA non tranform.';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Modif JX-AUD du 23/04/2013
                        CLEAR(Gform_FAPMail);
                        Gform_FAPMail.SETRECORD(Rec);
                        Gtext_ObjetMail := 'Devis à transformer en BC et à réceptionner dans NAVISION';
                        Gtext_Param1 := '';
                        Gtext_Param2 := '';
                        Gtext_Param3 := '';
                        Gtext_Param1 := 'Le devis';
                        Gtext_Param2 := 'DAXXXXX';
                        Gtext_Param3 := 'n''a pas été transformé en Bon de commande';
                        Gform_FAPMail.SetParam(Gtext_Param1, Gtext_Param2, Gtext_Param3, 5, Gtext_ObjetMail);
                        Gform_FAPMail.CAPTION := 'Envoi mail facture - DA non tranform.';
                        Gform_FAPMail.RUNMODAL();
                        //Fin Modif JX-AUD du 23/04/2013
                    end;
                }
                action("Envoi mail facture - DA cplmt.")
                {
                    Caption = 'Send mail invoice';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Modif JX-AUD du 23/04/2013
                        CLEAR(Gform_FAPMail);
                        Gform_FAPMail.SETRECORD(Rec);
                        Gtext_ObjetMail := 'Devis complémentaire à créer dans NAVISION';
                        Gtext_Param1 := '';
                        Gtext_Param2 := '';
                        Gtext_Param3 := '';
                        Gtext_Param1 := 'BON DE COMMANDE';
                        Gtext_Param2 := 'CAXXXXX';
                        Gtext_Param3 := '= <MONTANT1> euros pour une FACTURE= <MONTANT2> euros d''où un écart de <MONTANT3> euros';
                        Gform_FAPMail.SetParam(Gtext_Param1, Gtext_Param2, Gtext_Param3, 6, Gtext_ObjetMail);
                        Gform_FAPMail.CAPTION := 'Envoi mail facture - DA cplmt.';
                        Gform_FAPMail.RUNMODAL();
                        //Fin Modif JX-AUD du 23/04/2013
                    end;
                }
                action("Envoi mail facture - BC à récept.")
                {
                    Caption = 'Envoi mail facture - BC à récept.';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Modif JX-AUD du 23/04/2013
                        CLEAR(Gform_FAPMail);
                        Gform_FAPMail.SETRECORD(Rec);
                        Gtext_ObjetMail := 'BC à réceptionner dans NAVISION';
                        Gtext_Param1 := '';
                        Gtext_Param2 := '';
                        Gtext_Param3 := '';
                        Gtext_Param1 := 'BON DE COMMANDE';
                        Gtext_Param2 := 'CAXXXXX';
                        Gtext_Param3 := 'non réceptionné';
                        Gform_FAPMail.SetParam(Gtext_Param1, Gtext_Param2, Gtext_Param3, 7, Gtext_ObjetMail);
                        Gform_FAPMail.CAPTION := 'Envoi mail facture - BC à récept.';
                        Gform_FAPMail.RUNMODAL();
                        //Fin Modif JX-AUD du 23/04/2013
                    end;
                }
                action("Envoi mail facture - Fact. à approuver")
                {
                    Caption = 'Envoi mail facture - Fact. à approuver';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Modif JX-AUD du 23/04/2013
                        CLEAR(Gform_FAPMail);
                        Gform_FAPMail.SETRECORD(Rec);
                        Gtext_ObjetMail := 'Facture à approuver dans NAVISION';
                        Gtext_Param1 := '';
                        Gtext_Param2 := '';
                        Gtext_Param3 := '';
                        Gtext_Param1 := '';
                        Gtext_Param2 := '';
                        Gtext_Param3 := '';
                        Gform_FAPMail.SetParam(Gtext_Param1, Gtext_Param2, Gtext_Param3, 8, Gtext_ObjetMail);
                        Gform_FAPMail.CAPTION := 'Envoi mail facture - Fact. à approuver';
                        Gform_FAPMail.RUNMODAL();
                        //Fin Modif JX-AUD du 23/04/2013
                    end;
                }
                action("Envoi mail facture - Factures Presta Timé")
                {
                    Caption = 'Envoi mail facture - Factures Presta Timé';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Modif JX-AUD du 23/04/2013
                        CLEAR(Gform_FAPMail);
                        Gform_FAPMail.SETRECORD(Rec);
                        Gtext_ObjetMail := 'Factures Presta Timé';
                        Gtext_Param1 := 'CAXXXXX';
                        Gtext_Param2 := '<NOMBRE1> jours pour une facture = <NOMBRE2> jours';
                        Gtext_Param3 := '';
                        Gtext_Param1 := '';
                        Gtext_Param2 := '';
                        Gtext_Param3 := '';
                        Gform_FAPMail.SetParam(Gtext_Param1, Gtext_Param2, Gtext_Param3, 9, Gtext_ObjetMail);
                        Gform_FAPMail.CAPTION := 'Envoi mail facture - Factures Presta Timé';
                        Gform_FAPMail.RUNMODAL();
                        //Fin Modif JX-AUD du 23/04/2013
                    end;
                }
                action(Historique)
                {
                    Caption = 'Historic';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Lrec_Historic: Record "BC6_VSC historic";
                        LForm_Historic: Page "BC6_VSC historic";
                    begin
                        //Début Ajout JX-XAD 20/11/2009
                        Lrec_Historic.SETFILTER(Lrec_Historic.Type, '%1|%2', Lrec_Historic.Type::Invoice, Lrec_Historic.Type::Receipt);
                        Lrec_Historic.SETFILTER(Lrec_Historic."No.", '%1', 'BC6 No.');
                        LForm_Historic.SETTABLEVIEW(Lrec_Historic);
                        LForm_Historic.RUNMODAL();
                        //Fin Ajout JX-XAD 20/11/2009
                    end;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD();
        exit(Rec.ConfirmDeletion());
    end;

    trigger OnInit()
    begin
        PurchHistoryBtn1Visible := true;
        PayToCommentBtnVisible := true;
        PayToCommentPictVisible := true;
        PurchHistoryBtnVisible := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();
    end;

    trigger OnOpenPage()
    begin
        if UserMgt.GetPurchasesFilter() <> '' then begin
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FILTERGROUP(0);
        end;

        //Début Modif JX-XAD du 11/06/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Assigned User ID", FunctionsMgt.jx_GetPurchasesFilter());
        Rec.FILTERGROUP(0);
        //Fin Modif JX-XAD du 11/06/2008
    end;

    var
        Grec_ApprovalEntry: Record "Approval Entry";
        Grec_RcptPurchLine: Record "Purch. Rcpt. Line";
        Grec_PurchaseLine: Record "Purchase Line";
        Grec_PurchPaySetup: Record "Purchases & Payables Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        CopyPurchDoc: Report "Copy Purchase Document";
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        FunctionsMgt: Codeunit "BC6_FunctionsMgt";
        PurchInfoPaneMgmt: Codeunit "BC6_FunctionsMgt";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        Gform_FAPMail: Page "BC6_New Mail FAP";
        ChangeExchangeRate: Page "Change Exchange Rate";
        [InDataSet]
        JobQueueVisible: Boolean;
        [InDataSet]
        PayToCommentBtnVisible: Boolean;
        [InDataSet]
        PayToCommentPictVisible: Boolean;
        [InDataSet]
        PurchHistoryBtn1Visible: Boolean;
        [InDataSet]

        PurchHistoryBtnVisible: Boolean;
        Grec_MontantApprobation: Decimal;
        Grec_MontantFacture: Decimal;
        Grec_MontantMax: Decimal;
        Gint_cptLine: Integer;
        Text004: label 'This invoice was recorded without reconciliation with a PO, you must submit it ... validation';
        Text005: label 'Validation is not possible without new approval.';
        Text006: label 'Validation is not possible because the status of your invoice is "%1".';
        Text007: label 'The total amount of the invoice excluding VAT is different from the amount ... save';
        Gtext_ObjetMail: Text[1024];
        Gtext_Param1: Text[1024];
        Gtext_Param2: Text[1024];
        Gtext_Param3: Text[1024];

    local procedure Post(PostingCodeunitID: Integer)
    begin
        Rec.SendToPostingOk(PostingCodeunitID);
        if Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting" then
            CurrPage.CLOSE();
        CurrPage.UPDATE(false);
    end;

    local procedure UpdateInfoPanel()
    var
        DifferBuyFromPayTo: Boolean;
    begin
        DifferBuyFromPayTo := 'Buy-from Vendor No.' <> 'Pay-to Vendor No.';
        PurchHistoryBtnVisible := DifferBuyFromPayTo;
        PayToCommentPictVisible := DifferBuyFromPayTo;
        PayToCommentBtnVisible := DifferBuyFromPayTo;

        PurchHistoryBtn1Visible := PurchInfoPaneMgmt.DocExist(Rec, 'Buy-from Vendor No.');
        if DifferBuyFromPayTo then
            PurchHistoryBtnVisible := PurchInfoPaneMgmt.DocExist(Rec, 'Pay-to Vendor No.')
    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
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
        CurrPage.PurchLines.PAGE.UpdateForm(true);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(true);
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE();
    end;

    local procedure CurrencyCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(true);
    end;

    procedure VerifierLigneRcpt(): Boolean
    begin
        Gint_cptLine := 0;
        Grec_MontantFacture := 0;
        Grec_MontantApprobation := 0;
        Grec_PurchPaySetup.GET('');
        Grec_MontantMax := Grec_PurchPaySetup."BC6_Max. Amount allowed";

        //Vérification si la facture est au statut lancé et vérification montant approbation ou facture réouverte
        if ((Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Open)) then begin
            //calcul du montant de la facture
            Grec_PurchaseLine.SETFILTER(Grec_PurchaseLine."Document No.", Rec."No.");
            if Grec_PurchaseLine.FIND('-') then
                //MESSAGE(FORMAT(Grec_PurchaseLine.COUNT));
                repeat
                    Grec_MontantFacture += Grec_PurchaseLine."Line Amount";
                until Grec_PurchaseLine.NEXT() = 0;

            //MESSAGE(FORMAT(Grec_MontantFacture));
            //calcul du montant des approbations
            Grec_ApprovalEntry.SETFILTER(Grec_ApprovalEntry."Table ID", '38');
            Grec_ApprovalEntry.SETFILTER(Grec_ApprovalEntry."Document No.", Rec."No.");
            Grec_ApprovalEntry.SETFILTER(Grec_ApprovalEntry."Document Type", FORMAT(Grec_ApprovalEntry."Document Type"::Invoice));
            Grec_ApprovalEntry.SETFILTER(Grec_ApprovalEntry.Status, FORMAT(Grec_ApprovalEntry.Status::Approved));

            if Grec_ApprovalEntry.FIND('-') then   //si statut ouvert et lignes approbation présentes
            begin
                if Grec_ApprovalEntry.FIND('+') then
                    //MESSAGE(FORMAT(Grec_ApprovalEntry."Sequence No."));
                    Grec_MontantApprobation += Grec_ApprovalEntry.Amount
                else begin
                    MESSAGE(Text005);
                    exit(false);
                end;

                //MESSAGE(FORMAT(Grec_MontantApprobation));
                if not (Grec_MontantFacture = Grec_MontantApprobation) then begin
                    MESSAGE(Text005);
                    exit(false);
                end else
                    exit(true);
            end;
        end;

        if ((Rec.Status = Rec.Status::"Pending Approval") or (Rec.Status = Rec.Status::"Pending Prepayment")) then begin
            MESSAGE(Text006, Rec.Status);
            exit(false);
        end;

        //MESSAGE(FORMAT(Grec_MontantMax));
        if Rec.Status = Rec.Status::Open then begin
            //MESSAGE(FORMAT(Grec_PurchPaySetup."Max. Amount allowed"));
            Grec_PurchaseLine.SETFILTER(Grec_PurchaseLine."Document No.", Rec."No.");
            if Grec_PurchaseLine.FIND('-') then
                //MESSAGE(FORMAT(Grec_PurchaseLine.COUNT));
                repeat

                    //MESSAGE(FORMAT(Grec_PurchaseLine.Type) + '  ' +Grec_PurchaseLine."No.");
                    if (((Grec_PurchaseLine.Type = Grec_PurchaseLine.Type::" ") and (Grec_PurchaseLine."No." = ''))
                    or ((Grec_PurchaseLine.Type <> Grec_PurchaseLine.Type::" ") and (Grec_PurchaseLine."No." = ''))) then begin
                        //MESSAGE('OK');
                    end else
                        //traiter si le numéro de reception est renseigné et qu'il existe bien dans les lignes de reception achat
                        if not Grec_RcptPurchLine.GET(Grec_PurchaseLine."Receipt No.", Grec_PurchaseLine."Receipt Line No.") then
                            //traiter si le montant est inférieur ou égal au montant de paramétrage achat
                            if Grec_PurchaseLine."Line Amount" > Grec_MontantMax then begin
                                //MESSAGE('Montant supérieur ' + FORMAT(Grec_PurchaseLine."Line Amount"));
                                MESSAGE(Text004);
                                Gint_cptLine += 1;
                                exit(false);
                            end else
                                //MESSAGE('Montant inférieur à 10 ' + FORMAT(Grec_PurchaseLine."Line Amount"));
                                if Gint_cptLine > 1 then begin
                                    MESSAGE(Text004);
                                    exit(false);
                                end;
                until Grec_PurchaseLine.NEXT() = 0;
        end;

        Rec.Status := Rec.Status::Released;
        Rec.MODIFY();

        exit(true);
    end;
}
