page 50049 "BC6_VSC Bookkeeper Role Center"
{
    Caption = 'Role Center', Comment = 'FRA="Tableau de bord"';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                ShowCaption = false;
                part(Control1901197008; "BC6_VSC Bookkeeper Activities")
                {
                    ApplicationArea = All;
                }
                part("Société"; "BC6_Company Picture")
                {
                    Caption = 'Company Picture', Comment = 'FRA="Société"';
                    ApplicationArea = All;
                }
            }
            group(Control1900724708)
            {
                ShowCaption = false;
                part(Control17; "My Job Queue")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                part(Control1000000008; "My Customers")
                {
                    ApplicationArea = All;
                }
                part(Control1902476008; "My Vendors")
                {
                    ApplicationArea = All;
                }
                part(Control18; "Report Inbox Part")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                part(Control1903012608; "Copy Profile")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                systempart(Control1901377608; MyNotes)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Récapitulatif de déclaration de TVA")
            {
                Caption = 'Calc. and Post VAT Settlement';
                Image = "Report";
                RunObject = Report "BC6_VSC- Récap. Calc. Post VAT";
                ApplicationArea = All;
            }
            action("Calculer et valider décl. TVA")
            {
                Caption = 'Calc. and Post VAT Settlement', Comment = 'FRA="Calculer et valider décl. TVA"';
                Image = "Report";
                RunObject = Report "VSC- Calc. Post VAT Settlement";
                ApplicationArea = All;
            }

            action("Synthèse TVA fournisseurs")
            {
                Caption = 'VAT synthesis vendors', Comment = 'FRA="Synthèse TVA fournisseurs"';
                Image = "Report";
                RunObject = Report "BC6_VAT synthesis vendors";
                ApplicationArea = All;
            }
            action("Synthèse TVA clients")
            {
                Caption = 'VAT synthesis customers', Comment = 'FRA="Synthèse TVA clients"';
                Image = "Report";
                RunObject = Report "BC6_VAT synthesis customers";
                ApplicationArea = All;
            }
            action("Valeur comptable 01 VSC")
            {
                Caption = 'Valeur comptable 01 VSC', Comment = 'FRA="Valeur comptable 01 VSC"';
                Image = "Report";
                RunObject = Report "Fixed Asset - Book Value 1 VSC";
                ApplicationArea = All;
            }
            action("Calculer amortissement...")
            {
                Caption = 'Calculate Depreciation...', Comment = 'FRA="Calculer amortissement..."';
                Image = "Report";
                RunObject = report "Calculate Depreciation";
                ApplicationArea = All;
            }
            action(LISAM)
            {
                Caption = 'LISAM', Comment = 'FRA="LISAM"';
                Image = "Report";
                RunObject = report "BC6_LISAM";
                ApplicationArea = All;
            }
            action(ETAFI)
            {
                Caption = 'ETAFI', Comment = 'FRA="ETAFI"';
                Image = ImportExport;
                RunObject = report "BC6_Export ETAFI";
                ApplicationArea = All;
            }
            action("Solde BC Masse")
            {
                Caption = 'Solde BC Masse', Comment = 'FRA="Solde BC Masse"';
                Image = "Report";
                RunObject = report "BC6_Solde BC Masse";
                ApplicationArea = All;
            }
            action("Cash Pooling")
            {
                Caption = 'Cash Pooling', Comment = 'FRA="Cash Pooling"';
                Image = ImportExport;
                RunObject = xmlport "BC6_Cash Pooling";
                ApplicationArea = All;
            }
            action("Import Factures Ventes")
            {
                Caption = 'Import Factures Ventes', Comment = 'FRA="Import Factures Ventes"';
                Image = ImportExport;
                RunObject = xmlport "BC6_Import Factures Ventes";
                ApplicationArea = All;
            }
            action("Export Magnitude")
            {
                Caption = 'Export Magnitude', Comment = 'FRA="Export Magnitude"';
                Image = "Report";
                RunObject = report "BC6_Export Magnitude";
                ApplicationArea = All;
            }
            action("Clients : Écritures ouvertes")
            {
                Caption = 'Customer - Balance to Date', Comment = 'FRA="Clients : Écritures ouvertes"';
                Image = "Report";
                RunObject = report "Customer - Balance to Date";
                ApplicationArea = All;
            }
        }
        area(embedding)
        {
            action("Plan comptable")
            {
                Caption = 'Chart of Accounts', Comment = 'FRA="Plan comptable"';
                RunObject = page "Chart of Accounts";
                ApplicationArea = All;
            }
            action(Clients)
            {
                Caption = 'Customers', Comment = 'FRA="Clients"';
                Image = Customer;
                RunObject = page "Customer List";
                ApplicationArea = All;
            }
            action(Solde)
            {
                Caption = 'Balance', Comment = 'FRA="Solde"';
                Image = Balance;
                RunObject = page "Customer List";
                RunPageView = where("Balance (LCY)" = filter(<> 0));
                ApplicationArea = All;
            }
            action(Fournisseurs)
            {
                Caption = 'Vendors', Comment = 'FRA="Fournisseurs"';
                Image = Vendor;
                RunObject = page "Vendor List";
                ApplicationArea = All;
            }
            action(Action5)
            {
                Caption = 'Balance', Comment = 'FRA="Solde"';
                Image = Balance;
                RunObject = page "Vendor List";
                RunPageView = where("Balance (LCY)" = filter(<> 0));
                ApplicationArea = All;
            }
            action("Paiement en attente")
            {
                Caption = 'Payment on Hold', Comment = 'FRA="Paiement en attente"';
                RunObject = page "Vendor List";
                RunPageView = where(Blocked = filter(Payment));
                ApplicationArea = All;
            }
            action("Feuilles paiement")
            {
                Caption = 'Payment Journals', Comment = 'FRA="Feuilles paiement"';
                Image = Journals;
                RunObject = page "General Journal Batches";
                RunPageView = where("Template Type" = const(Payments), Recurring = const(false));
                ApplicationArea = All;
            }
            action("Feuilles comptabilité")
            {
                Caption = 'General Journals', Comment = 'FRA="Feuilles comptabilité"';
                Image = Journal;
                RunObject = page "General Journal Batches";
                RunPageView = where("Template Type" = const(General), Recurring = const(false));
                ApplicationArea = All;
            }
        }
        area(sections)
        {
            group("Comptabilité générale")
            {
                Caption = 'General Accounting', Comment = 'FRA="Comptabilité générale"';
                Image = Bank;
                action(Action1000000001)
                {
                    Caption = 'Chart of Accounts', Comment = 'FRA="Plan comptable"';
                    RunObject = page "Chart of Accounts";
                    ApplicationArea = All;
                }
                action(Action1000000013)
                {
                    Caption = 'General Journals', Comment = 'FRA="Feuilles comptabilité"';
                    Image = Journal;
                    RunObject = page "General Journal Batches";
                    RunPageView = where("Template Type" = const(General), Recurring = const(false));
                    ApplicationArea = All;
                }
                action(Immobilisations)
                {
                    Caption = 'Fixed Assets', Comment = 'FRA="Immobilisations"';
                    RunObject = page "Fixed Asset List";
                    ApplicationArea = All;
                }
                action(Devises)
                {
                    Caption = 'Currencies', Comment = 'FRA="Devises"';
                    Image = Currency;
                    RunObject = page Currencies;
                    ApplicationArea = All;
                }
            }
            group("Comptabilité Clients")
            {
                Caption = 'Customer Accounting', Comment = 'FRA="Comptabilité Clients"';
                Image = Marketing;
                action(Client)
                {
                    Caption = 'Customer', Comment = 'FRA="Client"';
                    Image = Customer;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = page "Customer List";
                    RunPageMode = Create;
                    ApplicationArea = All;
                }
                action("Facture vente")
                {
                    Caption = 'Sales Invoice', Comment = 'FRA="Facture vente"';
                    Image = Invoice;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = page "Sales Invoice List";
                    RunPageMode = Create;
                    ApplicationArea = All;
                }
                action("Avoir vente")
                {
                    Caption = 'Sales Credit Memo', Comment = 'FRA="Avoir vente"';
                    Image = CreditMemo;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = page "Sales Credit Memos";
                    RunPageMode = Create;
                    ApplicationArea = All;
                }
                action("Expéditions vente enregistrées")
                {
                    Caption = 'Posted Sales Shipments', Comment = 'FRA="Expéditions vente enregistrées"';
                    Image = PostedShipment;
                    RunObject = page "Posted Sales Shipments";
                    ApplicationArea = All;
                }
                action("Avoirs vente enregistrés")
                {
                    Caption = 'Posted Sales Credit Memos', Comment = 'FRA="Avoirs vente enregistrés"';
                    RunObject = page "Posted Sales Credit Memos";
                    ApplicationArea = All;
                }
                action("Feuilles règlement")
                {
                    Caption = 'Cash Receipt Journals', Comment = 'FRA="Feuilles règlement"';
                    Image = Journals;
                    RunObject = page "General Journal Batches";
                    RunPageView = where("Template Type" = const("Cash Receipts"), Recurring = const(false));
                    ApplicationArea = All;
                }
            }
            group("Comptabilité Fournisseurs")
            {
                Caption = 'Vendor Accounting', Comment = 'FRA="Comptabilité Fournisseurs"';
                Image = Purchasing;
                //TODO
                // action("Liste Récapitulatif Fournisseur")
                // {
                //     Caption = 'Vendor List Recap';
                //     RunObject = Page "BC6_Vendor List Recap";
                //     ApplicationArea = All;
                // }
                action(Fournisseur)
                {
                    Caption = 'Vendor', Comment = 'FRA="Fournisseur"';
                    Image = Vendor;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = page "Vendor List";
                    RunPageMode = Create;
                    ApplicationArea = All;
                }
                action(Devis)
                {
                    Caption = 'Purchase Quotes', Comment = 'FRA="Devis"';
                    RunObject = page "Purchase Quotes";
                    ApplicationArea = All;
                }
                //TODO
                // action("Commandes achat")
                // {
                //     Caption = 'Purchase Orders';
                //     RunObject = Page "BC6_Purchase Order List VSC";
                //     ApplicationArea = All;
                // }
                action("Facture achat")
                {
                    Caption = 'Purchase Invoice', Comment = 'FRA="Facture achat"';
                    Image = Invoice;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = page "Purchase Invoices";
                    RunPageMode = Create;
                    ApplicationArea = All;
                }
                action("Avoirs achat")
                {
                    Caption = 'Purchase Credit Memos', Comment = 'FRA="Avoirs achat"';
                    RunObject = page "Purchase Credit Memos";
                    ApplicationArea = All;
                }
                action("Factures achat enregistrées")
                {
                    Caption = 'Posted Purchase Invoices', Comment = 'FRA="Factures achat enregistrées"';
                    RunObject = page "Posted Purchase Invoices";
                    ApplicationArea = All;
                }
                action("Avoirs achat enregistrés")
                {
                    Caption = 'Posted Purchase Credit Memos', Comment = 'FRA="Avoirs achat enregistrés"';
                    RunObject = page "Posted Purchase Credit Memos";
                    ApplicationArea = All;
                }
                action(Action1000000038)
                {
                    Caption = 'Chart of Accounts', Comment = 'FRA="Plan comptable"';
                    RunObject = page "Chart of Accounts";
                    ApplicationArea = All;
                }
                action(Action1000000039)
                {
                    Caption = 'General Journals', Comment = 'FRA="Feuilles comptabilité"';
                    Image = Journal;
                    RunObject = page "General Journal Batches";
                    RunPageView = where("Template Type" = const(General), Recurring = const(false));
                    ApplicationArea = All;
                }
                action(Action1000000018)
                {
                    Caption = 'Payment Journals', Comment = 'FRA="Feuilles paiement"';
                    Image = Journals;
                    RunObject = page "General Journal Batches";
                    RunPageView = where("Template Type" = const(Payments), Recurring = const(false));
                    ApplicationArea = All;
                }
                action("Bordereaux de paiment")
                {
                    Caption = 'Bordereaux de paiment', Comment = 'FRA="Bordereaux de paiment"';
                    RunObject = page "Payment Slip List";
                    ApplicationArea = All;
                }
            }
        }
        area(creation)
        {
            action("&Client")
            {
                Caption = 'C&ustomer', Comment = 'FRA="&Client"';
                Image = Customer;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = page "Customer Card";
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Fiche fournisseur")
            {
                Caption = 'Vendor Card', Comment = 'FRA="Fiche fournisseur"';
                Image = Customer;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = page "Vendor Card";
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Fac&ture vente")
            {
                Caption = 'Sales &Invoice', Comment = 'FRA="Fac&ture vente"';
                Image = Invoice;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = page "Sales Invoice";
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Avoir &vente")
            {
                Caption = 'Sales Credit &Memo', Comment = 'FRA="Avoir &vente"';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = page "Sales Credit Memo";
                RunPageMode = Create;
                ApplicationArea = All;
            }
        }
    }
}
