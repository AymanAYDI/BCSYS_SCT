page 50029 "BC6_Vendor List Recap"
{
    // // Modif LAB du 17/09/2009
    // // Ajout du champ solde
    // 
    // // Modif AUD du 07/06/2012
    // // Ajout du champ solde période
    // 
    // //Modif JX-AUD du 19/11/13
    // //Ajout du N° Siret

    Caption = 'Vendor List', Comment = 'FRA="Liste des fournisseurs"';
    CardPageID = "BC6_Vendor summary";
    Editable = false;
    PageType = List;
    SourceTable = Vendor;

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
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Registration No."; Rec."BC6_Registration No.")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Fin. Charge Terms Code"; Rec."Fin. Charge Terms Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Language Code"; Rec."Language Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                }
                field("Net Change"; Rec."Net Change")
                {
                    ApplicationArea = All;
                }
                field("Application Method"; Rec."Application Method")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                }
                field("Location Code2"; Rec."Location Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Base Calendar Code"; Rec."Base Calendar Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            //TODO: The Page '"Social Listening FactBox"' is not found
            // part(Control15; "Social Listening FactBox")
            // {
            //     SubPageLink = "Source Type" = CONST(Vendor), "Source No." = FIELD("No.");
            //     Visible = SocialListeningVisible;
            //     ApplicationArea = All;
            // }
            //TODO: The Page '"Social Listening Setup FactBox"' is not found
            // part(Control14; "Social Listening Setup FactBox")
            // {
            //     SubPageLink = "Source Type" = CONST(Vendor), "Source No." = FIELD("No.");
            //     UpdatePropagation = Both;
            //     Visible = SocialListeningSetupVisible;
            //     ApplicationArea = All;
            // }
            part(Control1901138007; "Vendor Details FactBox")
            {
                SubPageLink = "No." = FIELD("No."), "Currency Filter" = FIELD("Currency Filter"), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
                ApplicationArea = All;
            }
            part(Control1904651607; "Vendor Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("No."), "Currency Filter" = FIELD("Currency Filter"), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = true;
                ApplicationArea = All;
            }
            part(Control1903435607; "Vendor Hist. Buy-from FactBox")
            {
                SubPageLink = "No." = FIELD("No."), "Currency Filter" = FIELD("Currency Filter"), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = true;
                ApplicationArea = All;
            }
            part(Control1906949207; "Vendor Hist. Pay-to FactBox")
            {
                SubPageLink = "No." = FIELD("No."), "Currency Filter" = FIELD("Currency Filter"), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Control1900383207; Links)
            {
                Visible = true;
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
            group("Fo&urnisseur")
            {
                Caption = 'Ven&dor', Comment = 'FRA="Fo&urnisseur"';
                Image = Vendor;
                action(Fiche)
                {
                    Caption = 'Card', Comment = 'FRA="Fiche"';
                    Image = EditLines;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ShortCutKey = 'Shift+F5';
                    ApplicationArea = All;
                }
                group("Axes analytiques")
                {
                    Caption = 'Dimensions', Comment = 'FRA="Axes analytiques"';
                    Image = Dimensions;
                    action("Affectations - Simples")
                    {
                        Caption = 'Dimensions-Single', Comment = 'FRA="Affectations - Simples"';
                        Image = Dimensions;
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID" = CONST(23), "No." = FIELD("No.");
                        ShortCutKey = 'Shift+Ctrl+D';
                        ApplicationArea = All;
                    }
                    action("Affectations - &Multiples")
                    {
                        AccessByPermission = TableData Dimension = R;
                        Caption = 'Dimensions-&Multiple', Comment = 'FRA="Affectations - &Multiples"';
                        Image = DimensionSets;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            Vend: Record Vendor;
                            DefaultDimMultiple: Page "Default Dimensions-Multiple";
                        begin
                            CurrPage.SETSELECTIONFILTER(Vend);
                            DefaultDimMultiple.SetMultiRecord(Vend, Rec.FieldNo("No."));
                            DefaultDimMultiple.RUNMODAL();
                        end;
                    }
                }
                action("Comptes bancaires")
                {
                    Caption = 'Bank Accounts', Comment = 'FRA="Comptes bancaires"';
                    Image = BankAccount;
                    RunObject = Page "Vendor Bank Account List";
                    RunPageLink = "Vendor No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("C&ontact")
                {
                    AccessByPermission = TableData Contact = R;
                    Caption = 'C&ontact', Comment = 'FRA="C&ontact"';
                    Image = ContactPerson;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowContact();
                    end;
                }
                action("&Adresses de commande")
                {
                    Caption = 'Order &Addresses', Comment = 'FRA="&Adresses de commande"';
                    Image = Addresses;
                    RunObject = Page "Order Address List";
                    RunPageLink = "Vendor No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Co&mmentaires")
                {
                    Caption = 'Co&mments', Comment = 'FRA="Co&mmentaires"';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Vendor), "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("&Références externes")
                {
                    Caption = 'Cross Re&ferences', Comment = 'FRA="&Références externes"';
                    Image = Change;
                    RunObject = Page "Item References";
                    RunPageLink = "Reference Type" = CONST(Vendor), "Reference No." = FIELD("No.");
                    RunPageView = SORTING("Reference Type", "Reference Type No.");
                    ApplicationArea = All;
                }
            }
            group("Ac&hats")
            {
                Caption = '&Purchases', Comment = 'FRA="Ac&hats"';
                Image = Purchasing;
                action(Articles)
                {
                    Caption = 'Items', Comment = 'FRA="Articles"';
                    Image = Item;
                    RunObject = Page "Vendor Item Catalog";
                    RunPageLink = "Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Vendor No.");
                    ApplicationArea = All;
                }
                action("Remises &facture")
                {
                    Caption = 'Invoice &Discounts', Comment = 'FRA="Remises &facture"';
                    Image = CalculateInvoiceDiscount;
                    RunObject = Page "Vend. Invoice Discounts";
                    RunPageLink = Code = FIELD("Invoice Disc. Code");
                    ApplicationArea = All;
                }
                action(Prix)
                {
                    Caption = 'Prices', Comment = 'FRA="Prix"';
                    Image = Price;
                    RunObject = Page "Purchase Prices";
                    RunPageLink = "Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Vendor No.");
                    ApplicationArea = All;
                }
                action("Remises ligne")
                {
                    Caption = 'Line Discounts', Comment = 'FRA="Remises ligne"';
                    Image = LineDiscount;
                    RunObject = Page "Purchase Line Discounts";
                    RunPageLink = "Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Vendor No.");
                    ApplicationArea = All;
                }
                action("Pourcentages acom&pte")
                {
                    Caption = 'Prepa&yment Percentages', Comment = 'FRA="Pourcentages acom&pte"';
                    Image = PrepaymentPercentages;
                    RunObject = Page "Purchase Prepmt. Percentages";
                    RunPageLink = "Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Vendor No.");
                    ApplicationArea = All;
                }
                action("Codes achat fourn. s&td")
                {
                    Caption = 'S&td. Vend. Purchase Codes', Comment = 'FRA="Codes achat fourn. s&td"';
                    Image = CodesList;
                    RunObject = Page "Standard Vendor Purchase Codes";
                    RunPageLink = "Vendor No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
            group(Documents)
            {
                Caption = 'Documents', Comment = 'FRA="Documents"';
                Image = Administration;
                action("Demandes de prix")
                {
                    Caption = 'Quotes', Comment = 'FRA="Demandes de prix"';
                    Image = Quote;
                    RunObject = Page "Purchase Quotes";
                    RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Buy-from Vendor No.");
                    ApplicationArea = All;
                }
                action(Commandes)
                {
                    Caption = 'Orders', Comment = 'FRA="Commandes"';
                    Image = Document;
                    RunObject = Page "Purchase Order List";
                    RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Buy-from Vendor No.");
                    ApplicationArea = All;
                }
                action(Retours)
                {
                    Caption = 'Return Orders', Comment = 'FRA="Retours"';
                    Image = ReturnOrder;
                    RunObject = Page "Purchase Return Order List";
                    RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Buy-from Vendor No.");
                    ApplicationArea = All;
                }
                action("Commandes ouvertes")
                {
                    Caption = 'Blanket Orders', Comment = 'FRA="Commandes ouvertes"';
                    Image = BlanketOrder;
                    RunObject = Page "Blanket Purchase Orders";
                    RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Buy-from Vendor No.");
                    ApplicationArea = All;
                }
            }
            group(Historique)
            {
                Caption = 'History', Comment = 'FRA="Historique"';
                Image = History;
                action("É&critures comptables")
                {
                    Caption = 'Ledger E&ntries', Comment = 'FRA="É&critures comptables"';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Vendor Ledger Entries";
                    RunPageLink = "Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Vendor No.");
                    ShortCutKey = 'Ctrl+F7';
                    ApplicationArea = All;
                }
                action(Statistiques)
                {
                    Caption = 'Statistics', Comment = 'FRA="Statistiques"';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Vendor Statistics";
                    RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                    ApplicationArea = All;
                }
                action(Achats)
                {
                    Caption = 'Purchases', Comment = 'FRA="Achats"';
                    Image = Purchase;
                    RunObject = Page "Vendor Purchases";
                    RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ApplicationArea = All;
                }
                action("Statistiques écritures")
                {
                    Caption = 'Entry Statistics', Comment = 'FRA="Statistiques écritures"';
                    Image = EntryStatistics;
                    RunObject = Page "Vendor Entry Statistics";
                    RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ApplicationArea = All;
                }
                action("Statistiques par &devise")
                {
                    Caption = 'Statistics by C&urrencies', Comment = 'FRA="Statistiques par &devise"';
                    Image = Currencies;
                    RunObject = Page "Vend. Stats. by Curr. Lines";
                    RunPageLink = "Vendor Filter" = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Date Filter" = FIELD("Date Filter");
                    ApplicationArea = All;
                }
                action("&Ecritures traçabilité")
                {
                    Caption = 'Item &Tracking Entries', Comment = 'FRA="&Ecritures traçabilité"';
                    Image = ItemTrackingLedger;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
                    begin
                        ItemTrackingDocMgt.ShowItemTrackingForEntity(2, Rec."No.", '', '', '');
                    end;
                }
            }
        }
        area(creation)
        {
            action("Commande ouverte achat")
            {
                Caption = 'Blanket Purchase Order', Comment = 'FRA="Commande ouverte achat"';
                Image = BlanketOrder;
                Promoted = false;
                RunObject = Page "Blanket Purchase Order";
                RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Demande de prix")
            {
                Caption = 'Purchase Quote', Comment = 'FRA="Demande de prix"';
                Image = Quote;
                Promoted = false;
                RunObject = Page "Purchase Quote";
                RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Facture achat")
            {
                Caption = 'Purchase Invoice', Comment = 'FRA="Facture achat"';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page "Purchase Invoice";
                RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Commande achat")
            {
                Caption = 'Purchase Order', Comment = 'FRA="Commande achat"';
                Image = Document;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page "Purchase Order";
                RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Avoir achat")
            {
                Caption = 'Purchase Credit Memo', Comment = 'FRA="Avoir achat"';
                Image = CreditMemo;
                Promoted = false;
                RunObject = Page "Purchase Credit Memo";
                RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Retour achat")
            {
                Caption = 'Purchase Return Order', Comment = 'FRA="Retour achat"';
                Image = ReturnOrder;
                Promoted = false;
                RunObject = Page "Purchase Return Order";
                RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                RunPageMode = Create;
                ApplicationArea = All;
            }
        }
        area(processing)
        {
            action("Feuille paiement")
            {
                Caption = 'Payment Journal', Comment = 'FRA="Feuille paiement"';
                Image = PaymentJournal;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Payment Journal";
                ApplicationArea = All;
            }
            action("Feuille achat")
            {
                Caption = 'Purchase Journal', Comment = 'FRA="Feuille achat"';
                Image = Journals;
                Promoted = false;
                RunObject = Page "Purchase Journal";
                ApplicationArea = All;
            }
        }
        area(reporting)
        {
            group("Général")
            {
                Caption = 'General', Comment = 'FRA="Général"';
                action("Fourn. : Liste")
                {
                    Caption = 'Vendor - List', Comment = 'FRA="Fourn. : Liste"';
                    Image = "Report";
                    Promoted = false;
                    RunObject = Report "Vendor - List";
                    ApplicationArea = All;
                }
                action("Historique des transactions fournisseur")
                {
                    Caption = 'Vendor Register', Comment = 'FRA="Historique des transactions fournisseur"';
                    Image = "Report";
                    Promoted = false;
                    RunObject = Report "Vendor Register";
                    ApplicationArea = All;
                }
                action("Fourn. : Catalogue articles")
                {
                    Caption = 'Vendor Item Catalog', Comment = 'FRA="Fourn. : Catalogue articles"';
                    Image = "Report";
                    Promoted = false;
                    RunObject = Report "Vendor Item Catalog";
                    ApplicationArea = All;
                }
                action("Fournisseur - Étiquettes")
                {
                    Caption = 'Vendor - Labels', Comment = 'FRA="Fournisseur - Étiquettes"';
                    Image = "Report";
                    Promoted = false;
                    RunObject = Report "Vendor - Labels";
                    ApplicationArea = All;
                }
                action("Fourn. : Palmarès")
                {
                    Caption = 'Vendor - Top 10 List', Comment = 'FRA="Fourn. : Palmarès"';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Vendor - Top 10 List";
                    ApplicationArea = All;
                }
            }
            group(Action5)
            {
                Caption = 'Orders', Comment = 'FRA="Commandes"';
                Image = "Report";
                action("Fourn. : Liste des commandes")
                {
                    Caption = 'Vendor - Order Summary', Comment = 'FRA="Fourn. : Liste des commandes"';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Vendor - Order Summary";
                    ApplicationArea = All;
                }
                action("Fourn. : Détail des commandes")
                {
                    Caption = 'Vendor - Order Detail', Comment = 'FRA="Fourn. : Détail des commandes"';
                    Image = "Report";
                    Promoted = false;
                    RunObject = Report "Vendor - Order Detail";
                    ApplicationArea = All;
                }
            }
            group(Action7)
            {
                Caption = 'Purchase', Comment = 'FRA="Achats"';
                Image = Purchase;
                action("Fourn. : Liste des achats")
                {
                    Caption = 'Vendor - Purchase List', Comment = 'FRA="Fourn. : Liste des achats"';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Vendor - Purchase List";
                    ApplicationArea = All;
                }
                action("Achats d'articles par fournisseur")
                {
                    Caption = 'Vendor/Item Purchases', Comment = 'FRA="Achats d''articles par fournisseur"';
                    Image = "Report";
                    Promoted = false;
                    RunObject = Report "Vendor/Item Purchases";
                    ApplicationArea = All;
                }
                action("Statistiques achat")
                {
                    Caption = 'Purchase Statistics', Comment = 'FRA="Statistiques achat"';
                    Image = "Report";
                    Promoted = false;
                    RunObject = Report "Purchase Statistics";
                    ApplicationArea = All;
                }
            }
            group("Gestion financière")
            {
                Caption = 'Financial Management', Comment = 'FRA="Gestion financière"';
                Image = "Report";
                action("Paiements en attente")
                {
                    Caption = 'Payments on Hold', Comment = 'FRA="Paiements en attente"';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Payments on Hold";
                    ApplicationArea = All;
                }
                action("Fourn. : Échéancier")
                {
                    Caption = 'Vendor - Summary Aging', Comment = 'FRA="Fourn. : Échéancier"';
                    Image = "Report";
                    Promoted = false;
                    RunObject = Report "Vendor - Summary Aging";
                    ApplicationArea = All;
                }
                action("Comptabilité fournisseur âgée")
                {
                    Caption = 'Aged Accounts Payable', Comment = 'FRA="Comptabilité fournisseur âgée"';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Aged Accounts Payable";
                    ApplicationArea = All;
                }
                action("Fourn. : Détail écr. ouvertes")
                {
                    Caption = 'Vendor - Balance to Date', Comment = 'FRA="Fourn. : Détail écr. ouvertes"';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Vendor - Balance to Date";
                    ApplicationArea = All;
                }
                action("Fourn. : Balance")
                {
                    Caption = 'Vendor - Trial Balance', Comment = 'FRA="Fourn. : Balance"';
                    Image = "Report";
                    Promoted = false;
                    RunObject = Report "Vendor - Trial Balance";
                    ApplicationArea = All;
                }
                action("Fourn. : Grand livre fourn.")
                {
                    Caption = 'Vendor - Detail Trial Balance', Comment = 'FRA="Fourn. : Grand livre fourn."';
                    Image = "Report";
                    Promoted = false;
                    RunObject = Report "Vendor - Detail Trial Balance";
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetSocialListeningFactboxVisibility()
    end;

    trigger OnAfterGetRecord()
    begin
        SetSocialListeningFactboxVisibility()
    end;

    procedure GetSelectionFilter(): Text
    var
        Vend: Record Vendor;
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SETSELECTIONFILTER(Vend);
        EXIT(SelectionFilterManagement.GetSelectionFilterForVendor(Vend));
    end;

    procedure SetSelection(var Vend: Record Vendor)
    begin
        CurrPage.SETSELECTIONFILTER(Vend);
    end;

    local procedure SetSocialListeningFactboxVisibility()
    var
    //TODO: Codeunit 'Social Listening Management' is missing
    //SocialListeningMgt: Codeunit "Social Listening Management";
    begin
        //SocialListeningMgt.GetVendFactboxVisibility(Rec, SocialListeningSetupVisible, SocialListeningVisible);
    end;
}

