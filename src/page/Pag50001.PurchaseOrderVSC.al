page 50001 "BC6_Purchase Order VSC"
{
    // Début Modif JX-XAD du 11/06/2008
    // Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
    // Ajout du champ "Code utilisateur affecté" sur l'en-tête du formulaire
    // 
    // //modifcation AUD le 08/04/2009
    // //mise en commentaire du code 
    // 
    // Modif JX-XAD du 15/05/2009
    // Appel du dataport 50011 depuis le bouton dem. prix ==> Annuler réceptions et modifier quantités
    // 
    // ---------------------------------------- V1.2 ----------------------------------------
    // AJOUT JX-XAD 24/12/2009
    // Nouvelle fonction dans le bouton Commande : "Liste des factures associées"
    // Ce bouton fait appel à un formulaire qui affiche toutes les factures (en cours et enregistrées)
    // liées à la commande.
    // 
    // MODIF JX-XAD 25/02/2010
    // Gestion des contrats : ajout d'un bouton pour accéder au contrat + un bouton imprimer contrat
    // 
    // 
    // //Modif JX-AUD du 17/02/2012
    // //Ajout du Champs "Matricule" et traitement de celui-ci
    // 
    // //Modif JX-AUD du 29/01/2013
    // //Vérification de la saisie des axes analytiques 0 à 3
    // 
    // //Modif JX-AUD du 22/03/2013
    // //Modification du libellé du menu Validation-->Valider par Validation-->Réceptionner
    // //Ajout du bouton Receptionner

    Caption = 'Purchase Order', Comment = 'FRA="Commande achat"';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'Gérer,Processus,Editions,Naviguer';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Order));

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
                    Importance = Standard;
                    ApplicationArea = All;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Address"; Rec."buy-from Address")
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
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    ApplicationArea = All;
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = All;
                }
                field("Matricule No."; Rec."BC6_Matricule No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Quote No."; Rec."Quote No.")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Vendor Order No."; Rec."Vendor Order No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
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
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Receipt Status"; Rec."BC6_Receipt Status")
                {
                    Editable = false;
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
            part(PurchLines; "BC6 Purchase Order Subform VSC")
            {
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
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
                field("BC6 Due Date"; Rec."Due Date")
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
                field("BC6 Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("BC6 Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("BC6 Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("BC6 Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code/City', Comment = 'FRA="CP/Ville destinataire"';
                    ApplicationArea = All;
                }
                field("BC6 Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("BC6 Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                }
                field("BC6 Import Vendor Email"; Rec."BC6_Import Vendor Email")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("BC6 Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("BC6 Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                }
                field("BC6 Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("BC6 Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    ApplicationArea = All;
                }
                field("BC6 Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("BC6 Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("BC6 Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("BC6 Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("BC6 Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                }
            }
            group(International)
            {
                Caption = 'Foreign Trade', Comment = 'FRA="International"';
                field("BC6 Currency Code"; Rec."Currency Code")
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
                field("BC6 Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("BC6 Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("BC6 Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                }
                field("BC6 Entry Point"; Rec."Entry Point")
                {
                    ApplicationArea = All;
                }
                field("BC6 Area"; Rec."Area")
                {
                    ApplicationArea = All;
                }
            }
            group(Acompte)
            {
                Caption = 'Prepayment', Comment = 'FRA="Acompte"';
                field("Prepayment %"; Rec."Prepayment %")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Prepayment37OnAfterValidate();
                    end;
                }
                field("Compress Prepayment"; Rec."Compress Prepayment")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Payment Terms Code"; Rec."Prepmt. Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Due Date"; Rec."Prepayment Due Date")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Payment Discount %"; Rec."Prepmt. Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Pmt. Discount Date"; Rec."Prepmt. Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor Cr. Memo No."; Rec."Vendor Cr. Memo No.")
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
                SubPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("Document No.");
                ApplicationArea = All;
            }
            part(Control1000000019; "Item Replenishment FactBox")
            {
                Provider = PurchLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
                ApplicationArea = All;
            }
            part(Control1000000018; "Approval FactBox")
            {
                SubPageLink = "Table ID" = CONST(38), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                Visible = false;
                ApplicationArea = All;
            }
            part(Control1000000017; "Vendor Details FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = false;
                ApplicationArea = All;
            }
            part(Control1000000016; "Vendor Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = true;
                ApplicationArea = All;
            }
            part(Control1000000015; "Vendor Hist. Buy-from FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = true;
                ApplicationArea = All;
            }
            part(Control1000000014; "Vendor Hist. Pay-to FactBox")
            {
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = false;
                ApplicationArea = All;
            }
            part(Control1000000013; "Purchase Line FactBox")
            {
                Provider = PurchLines;
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No."), "Line No." = FIELD("Line No.");
                ApplicationArea = All;
            }
            systempart(Control1000000012; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Control1000000003; Notes)
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
            group("&Commande")
            {
                Caption = 'O&rder', Comment = 'FRA="&Commande"';
                action(Statistiques)
                {
                    Caption = 'Statistics', Comment = 'FRA="Statistiques"';
                    Image = Statistics;
                    ShortCutKey = 'F7';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        PurchSetup.GET();
                        IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
                            CurrPage.PurchLines.PAGE.CalcInvDisc();
                            COMMIT();
                        END;
                        PAGE.RUNMODAL(PAGE::"Purchase Order Statistics", Rec);
                    end;
                }
            }
            action(Fiche)
            {
                Caption = 'Card', Comment = 'FRA="Fiche"';
                Image = EditLines;
                RunObject = Page "Vendor List";
                RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                ShortCutKey = 'Shift+F5';
                Visible = false;
                ApplicationArea = All;
            }
            action("Co&mmentaires")
            {
                Caption = 'Co&mments', Comment = 'FRA="Co&mmentaires"';
                Image = ViewComments;
                RunObject = Page "Purch. Comment Sheet";
                RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No."), "Document Line No." = CONST(0);
                Visible = false;
                ApplicationArea = All;
            }
            action("F&actures")
            {
                Caption = 'Invoices', Comment = 'FRA="F&actures"';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Posted Purchase Invoices";
                RunPageLink = "Order No." = FIELD("No.");
                RunPageView = SORTING("Order No.");
                ApplicationArea = All;
            }
            action("Bons de réception")
            {
                Caption = 'Receipts', Comment = 'FRA="Bons de réception"';
                Image = PostedReceipts;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Posted Purchase Receipts";
                RunPageLink = "Order No." = FIELD("No.");
                RunPageView = SORTING("Order No.");
                ApplicationArea = All;
            }
            action("Factures acom&pte")
            {
                Caption = 'Prepa&yment Invoices', Comment = 'FRA="Factures acom&pte"';
                Image = Invoice;
                RunObject = Page "Posted Purchase Invoices";
                RunPageLink = "Prepayment Order No." = FIELD("No.");
                RunPageView = SORTING("Prepayment Order No.");
                Visible = false;
                ApplicationArea = All;
            }
            action("A&voirs acompte")
            {
                Caption = 'Prepayment Credi&t Memos', Comment = 'FRA="A&voirs acompte"';
                RunObject = Page "Posted Purchase Credit Memos";
                RunPageLink = "Prepayment Order No." = FIELD("No.");
                RunPageView = SORTING("Prepayment Order No.");
                Visible = false;
                Image = CreditMemo;
                ApplicationArea = All;
            }
            action(Dimensions)
            {
                Caption = 'Dimensions', Comment = 'FRA="A&xes analytiques"';
                Image = Dimensions;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.ShowDocDim();
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals', Comment = 'FRA="Approbations"';
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
            action("Whse. Receipt Lines")
            {
                Caption = 'Whse. Receipt Lines', Comment = 'FRA="Lignes réception mag."';
                RunObject = Page "Whse. Receipt Lines";
                RunPageLink = "Source Type" = CONST(39), "Source Subtype" = FIELD("Document Type"), "Source No." = FIELD("No.");
                RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                Visible = false;
                Image = ReceiptLines;
                ApplicationArea = All;
            }
            action("In&vt. Put-away/Pick Lines")
            {
                Caption = 'In&vt. Put-away/Pick Lines', Comment = 'FRA="Lignes prélè&v./rangement stock"';
                RunObject = Page "Warehouse Activity List";
                RunPageLink = "Source Document" = CONST("Purchase Order"), "Source No." = FIELD("No.");
                RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                Visible = false;
                Image = Action;
                ApplicationArea = All;
            }
            action("Invoices related to ordering")
            {
                Caption = 'Invoices related to ordering', Comment = 'FRA="Listes des factures associées"';
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
            group("Dr&op Shipment")
            {
                Caption = 'Dr&op Shipment', Comment = 'FRA="Livraison &directe"';
                Visible = false;
                action("Ex&traire commande vente")
                {
                    Caption = 'Get &Sales Order', Comment = 'FRA="Ex&traire commande vente"';
                    RunObject = Codeunit "Purch.-Get Drop Shpt.";
                    Visible = false;
                    Image = Action;
                    ApplicationArea = All;
                }
            }
            group("Speci&al Order")
            {
                Caption = 'Speci&al Order', Comment = 'FRA="C&ommande spéciale"';
                Visible = false;
                action(Action187)
                {
                    Caption = 'Get &Sales Order', Comment = 'FRA="Ex&traire commande vente"';
                    Visible = false;
                    Image = Action;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        PurchHeader: Record "Purchase Header";
                        DistIntegration: Codeunit "Dist. Integration";
                    begin
                        PurchHeader.COPY(Rec);
                        DistIntegration.GetSpecialOrders(PurchHeader);
                        Rec := PurchHeader;
                    end;
                }
            }
        }

        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions', Comment = 'FRA="Fonction&s"';
                action("Get St&d. Vend. Purchase Codes")
                {
                    Caption = 'Get St&d. Vend. Purchase Codes', Comment = 'FRA="Extraire codes &achat fourn. std"';
                    Ellipsis = true;
                    Visible = false;
                    Image = Action;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        StdVendPurchCode: Record "Standard Vendor Purchase Code";
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost', Comment = 'FRA="&Réceptionner"';
                    Ellipsis = true;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                        lReleaseDoc: Codeunit "BC6_FunctionsMgt";
                    begin
                        VerifSaisieAxesAnalytiques();
                        PostDocument(CODEUNIT::"Purch.-Post (Yes/No)", "Navigate After Posting"::"Posted Document");
                        lReleaseDoc.FctReceiptStatus(Rec);
                        Rec.MODIFY();
                    end;
                }
                action(Release)
                {
                    Caption = 'Re&lease', Comment = 'FRA="Lancer"';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
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
                    end;
                }
                action("Copy Document")
                {
                    Caption = 'Copy Document', Comment = 'FRA="Copier &document"';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL();
                        CLEAR(CopyPurchDoc);
                    end;
                }
                action("&Print")
                {
                    Caption = '&Print', Comment = 'FRA="&Imprimer"';
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
                action("Archi&ve Document")
                {
                    Caption = 'Archi&ve Document', Comment = 'FRA="Archi&ver document"';
                    Visible = false;
                    ApplicationArea = All;
                    Image = Archive;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Move Negative Lines")
                {
                    Caption = 'Move Negative Lines', Comment = 'FRA="Déplacer lignes &négatives"';
                    Ellipsis = true;
                    Visible = false;
                    Image = Action;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegPurchLines);
                        MoveNegPurchLines.SetPurchHeader(Rec);
                        MoveNegPurchLines.RUNMODAL();
                        MoveNegPurchLines.ShowDocument();
                    end;
                }
                action("Create &Whse. Receipt")
                {
                    Caption = 'Create &Whse. Receipt', Comment = 'FRA="Créer &réception magasin"';
                    Visible = false;
                    Image = Action;
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
                action("Create Inventor&y Put-away / Pick")
                {
                    Caption = 'Create Inventor&y Put-away / Pick', Comment = 'FRA="Créer prélèv./rangement stoc&k"';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.CreateInvtPutAwayPick();

                        IF NOT Rec.FIND('=><') THEN
                            Rec.INIT();
                    end;
                }
                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request', Comment = 'FRA="Envoyer demande d''approbation"';
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
                    Caption = 'Cancel Approval Re&quest', Comment = 'FRA="Annuler l''approbation"';
                    Image = CancelApprovalRequest;
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
                action("Send IC Purchase Order")
                {
                    Caption = 'Send IC Purchase Order', Comment = 'FRA="Envoyer commande achat IC"';
                    Visible = false;
                    Image = Action;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                        ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                        PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                    begin
                        if ApprovalMgt.PrePostApprovalCheckPurch(Rec) then
                            PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec, true);
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
                Caption = 'P&osting', Comment = 'FRA="&Validation"';
                action("Test Report")
                {
                    Caption = 'Test Report', Comment = 'FRA="Impression test"';
                    Ellipsis = true;
                    Image = TestReport;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print', Comment = 'FRA="Valider et i&mprimer"';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F11';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        VerifSaisieAxesAnalytiques();
                        PostDocument(CODEUNIT::"Purch.-Post + Print", "Navigate After Posting"::"Do Nothing");
                    end;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch', Comment = 'FRA="Valider par l&ot"';
                    Ellipsis = true;
                    Image = PostBatch;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Orders", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                group("Prepa&yment")
                {
                    Caption = 'Prepa&yment', Comment = 'FRA="Acom&pte"';
                    Visible = false;
                    action("Prepayment Test &Report")
                    {
                        Caption = 'Prepayment Test &Report', Comment = 'FRA="Impression &test acompte"';
                        Ellipsis = true;
                        Visible = false;
                        Image = Report;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            ReportPrint.PrintPurchHeaderPrepmt(Rec);
                        end;
                    }
                    action("Post Prepayment &Invoice")
                    {
                        Caption = 'Post Prepayment &Invoice', Comment = 'FRA="Valider &facture acompte"';
                        Ellipsis = true;
                        Visible = false;
                        Image = Post;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            SalesHeader: Record "Sales Header";
                            ApprovalMgt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            if ApprovalMgt.PrePostApprovalCheckPurch(Rec) then
                                PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec, false);
                        end;
                    }
                    action("Post and Print Prepmt. Invoic&e")
                    {
                        Caption = 'Post and Print Prepmt. Invoic&e', Comment = 'FRA="Valider et imprimer factur&e acompte"';
                        Ellipsis = true;
                        Image = Post;
                        Visible = false;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            SalesHeader: Record "Sales Header";
                            ApprovalMgt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            if ApprovalMgt.PrePostApprovalCheckPurch(Rec) then
                                PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec, false);
                        end;
                    }
                    action("Post Prepayment &Credit Memo")
                    {
                        Caption = 'Post Prepayment &Credit Memo', Comment = 'FRA="Valider &avoir acompte"';
                        Ellipsis = true;
                        Visible = false;
                        Image = Action;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            SalesHeader: Record "Sales Header";
                            ApprovalMgt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            if ApprovalMgt.PrePostApprovalCheckPurch(Rec) then
                                PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec, false);
                        end;
                    }
                    action("Post and Print Prepmt. Cr. Mem&o")
                    {
                        Caption = 'Post and Print Prepmt. Cr. Mem&o', Comment = 'FRA="Valider et imprimer av&oir acompte"';
                        Ellipsis = true;
                        Visible = false;
                        Image = Action;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            SalesHeader: Record "Sales Header";
                            ApprovalMgt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            if ApprovalMgt.PrePostApprovalCheckPurch(Rec) then
                                PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec, false);
                        end;
                    }
                }
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
    var
        UserSetup: Record "User Setup";
        FunctionsMgt: Codeunit "BC6_FunctionsMgt";
        CodeService: Code[20];
        UserList: Text[200];
    begin
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FILTERGROUP(0);
        END;
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Assigned User ID", FunctionsMgt.jx_GetPurchasesFilter());
        Rec.FILTERGROUP(0);
    end;

    var
        Grec_Dimension: Record Dimension;
        Grec_DimSetEntry: Record "Dimension Set Entry";
        Grecord_GeneralLedgerSetup: Record "General Ledger Setup";
        Grec_PurchaseLine: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
        CopyPurchDoc: Report "Copy Purchase Document";
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        ArchiveManagement: Codeunit ArchiveManagement;
        PurchInfoPaneMgmt: Codeunit "BC6_FunctionsMgt";
        DocPrintENU: Codeunit "BC6_PrintOrderVSC";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        ChangeExchangeRate: Page "Change Exchange Rate";
        DocumentIsPosted: Boolean;
        [InDataSet]
        PayToCommentBtnVisible: Boolean;
        [InDataSet]
        PayToCommentPictVisible: Boolean;
        [InDataSet]
        PurchHistoryBtn1Visible: Boolean;
        [InDataSet]
        PurchHistoryBtnVisible: Boolean;
        //Gcu_ContractManagement: Codeunit "BC6 Contract management";
        Gcode_Axe1: Code[20];
        Gcode_Axe2: Code[20];
        Gcode_Axe3: Code[20];
        Gcode_Axe4: Code[20];
        OpenPostedPurchaseOrderQst: Label 'The order is posted as number %1 and moved to the Posted Purchase Invoices window.\\Do you want to open the posted invoice?', Comment = 'FRA="La commande est validée sous le numéro %1 et déplacée vers la fenêtre Factures d''achat validées.\\Voulez-vous ouvrir la facture validée ?"';
        Gtext_Axe1: Text[50];
        Gtext_Axe2: Text[50];
        Gtext_Axe3: Text[50];
        Gtext_Axe4: Text[50];

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

    procedure VerifSaisieAxesAnalytiques()
    begin
        if Grecord_GeneralLedgerSetup.FIND('-') then begin
            Gcode_Axe1 := Grecord_GeneralLedgerSetup."Shortcut Dimension 3 Code";//Axe 0
            IF Grec_Dimension.GET(Gcode_Axe1) THEN Gtext_Axe1 := Grec_Dimension.Name;
            Gcode_Axe2 := Grecord_GeneralLedgerSetup."Shortcut Dimension 4 Code";// Axe 1
            IF Grec_Dimension.GET(Gcode_Axe2) THEN Gtext_Axe2 := Grec_Dimension.Name;
            Gcode_Axe3 := Grecord_GeneralLedgerSetup."Shortcut Dimension 5 Code";// Axe 2
            IF Grec_Dimension.GET(Gcode_Axe3) THEN Gtext_Axe3 := Grec_Dimension.Name;
            Gcode_Axe4 := Grecord_GeneralLedgerSetup."Shortcut Dimension 6 Code";// Axe 3
            IF Grec_Dimension.GET(Gcode_Axe4) THEN Gtext_Axe4 := Grec_Dimension.Name;
        end;

        IF Rec."Document Type" = Rec."Document Type"::Quote THEN//DA
        BEGIN
            Grec_PurchaseLine.SETFILTER("Document No.", Rec."No.");
            IF Grec_PurchaseLine.FIND('-') THEN
                REPEAT
                    IF Grec_PurchaseLine.Type <> Grec_PurchaseLine.Type::" " THEN BEGIN
                        IF Gcode_Axe1 <> '' THEN
                            IF NOT Grec_DimSetEntry.GET(Grec_PurchaseLine."Dimension Set ID", Gcode_Axe1) THEN
                                ERROR('Vous devez saisir l''axe analytique ' + FORMAT(Gtext_Axe1) + ' sur la ligne ' + FORMAT(Grec_PurchaseLine."Line No."));
                        IF Gcode_Axe2 <> '' THEN
                            IF NOT Grec_DimSetEntry.GET(Grec_PurchaseLine."Dimension Set ID", Gcode_Axe2) THEN
                                ERROR('Vous devez saisir l''axe analytique ' + FORMAT(Gtext_Axe2) + ' sur la ligne ' + FORMAT(Grec_PurchaseLine."Line No."));
                        IF Gcode_Axe3 <> '' THEN
                            IF NOT Grec_DimSetEntry.GET(Grec_PurchaseLine."Dimension Set ID", Gcode_Axe3) THEN
                                ERROR('Vous devez saisir l''axe analytique ' + FORMAT(Gtext_Axe3) + ' sur la ligne ' + FORMAT(Grec_PurchaseLine."Line No."));
                        IF Gcode_Axe4 <> '' THEN
                            IF NOT Grec_DimSetEntry.GET(Grec_PurchaseLine."Dimension Set ID", Gcode_Axe4) THEN
                                ERROR('Vous devez saisir l''axe analytique ' + FORMAT(Gtext_Axe4) + ' sur la ligne ' + FORMAT(Grec_PurchaseLine."Line No."));
                    END;
                UNTIL Grec_PurchaseLine.NEXT() = 0;
        END;

        IF Rec."Document Type" = Rec."Document Type"::Order THEN//Commande
        BEGIN
            Grec_PurchaseLine.SETFILTER("Document No.", Rec."No.");
            IF Grec_PurchaseLine.FIND('-') THEN
                REPEAT
                    IF Grec_PurchaseLine.Type <> Grec_PurchaseLine.Type::" " THEN BEGIN
                        IF Gcode_Axe1 <> '' THEN
                            IF NOT Grec_DimSetEntry.GET(Grec_PurchaseLine."Dimension Set ID", Gcode_Axe1) THEN
                                ERROR('Vous devez saisir l''axe analytique ' + FORMAT(Gtext_Axe1) + ' sur la ligne ' + FORMAT(Grec_PurchaseLine."Line No."));
                        IF Gcode_Axe2 <> '' THEN
                            IF NOT Grec_DimSetEntry.GET(Grec_PurchaseLine."Dimension Set ID", Gcode_Axe2) THEN
                                ERROR('Vous devez saisir l''axe analytique ' + FORMAT(Gtext_Axe2) + ' sur la ligne ' + FORMAT(Grec_PurchaseLine."Line No."));
                        IF Gcode_Axe3 <> '' THEN
                            IF NOT Grec_DimSetEntry.GET(Grec_PurchaseLine."Dimension Set ID", Gcode_Axe3) THEN
                                ERROR('Vous devez saisir l''axe analytique ' + FORMAT(Gtext_Axe3) + ' sur la ligne ' + FORMAT(Grec_PurchaseLine."Line No."));
                        IF Gcode_Axe4 <> '' THEN
                            IF NOT Grec_DimSetEntry.GET(Grec_PurchaseLine."Dimension Set ID", Gcode_Axe4) THEN
                                ERROR('Vous devez saisir l''axe analytique ' + FORMAT(Gtext_Axe4) + ' sur la ligne ' + FORMAT(Grec_PurchaseLine."Line No."));
                    END;
                UNTIL Grec_PurchaseLine.NEXT() = 0;
        END;
    end;

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
        CurrPage.PurchLines.PAGE.UpdateForm(true);
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE();
    end;

    local procedure CurrencyCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure Prepayment37OnAfterValidate()
    begin
        CurrPage.UPDATE();
    end;

    local procedure PostDocument(PostingCodeunitID: Integer; Navigate: Enum "Navigate After Posting")
    var
        PurchaseHeader: Record "Purchase Header";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
        InstructionMgt: Codeunit "Instruction Mgt.";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        IsHandled: Boolean;
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


