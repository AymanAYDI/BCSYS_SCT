page 50049 "BC6_VSC Bookkeeper Role Center"
{
    Caption = 'Role Center';
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
                    Caption = 'Company Picture';
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
            action("Calculer amortissement...")
            {
                Caption = 'Calculate Depreciation...';
                Image = "Report";
                RunObject = report "Calculate Depreciation";
                ApplicationArea = All;
            }
            action(LISAM)
            {
                Caption = 'LISAM';
                Image = "Report";
                RunObject = report "BC6_LISAM";
                ApplicationArea = All;
            }
            action(ETAFI)
            {
                Caption = 'ETAFI';
                Image = ImportExport;
                RunObject = report "BC6_Export ETAFI";
                ApplicationArea = All;
            }
            action("Solde BC Masse")
            {
                Caption = 'Solde BC Masse';
                Image = "Report";
                RunObject = report "BC6_Solde BC Masse";
                ApplicationArea = All;
            }
            action("Cash Pooling")
            {
                Caption = 'Cash Pooling';
                Image = ImportExport;
                RunObject = xmlport "BC6_Cash Pooling";
                ApplicationArea = All;
            }
            action("Import Factures Ventes")
            {
                Caption = 'Import Factures Ventes';
                Image = ImportExport;
                RunObject = xmlport "BC6_Import Factures Ventes";
                ApplicationArea = All;
            }
            action("Export Magnitude")
            {
                Caption = 'Export Magnitude';
                Image = "Report";
                RunObject = report "BC6_Export Magnitude";
                ApplicationArea = All;
            }
            action("Clients : Écritures ouvertes")
            {
                Caption = 'Customer - Balance to Date';
                Image = "Report";
                RunObject = report "Customer - Balance to Date";
                ApplicationArea = All;
            }
        }
        area(embedding)
        {
            action("Plan comptable")
            {
                Caption = 'Chart of Accounts';
                RunObject = page "Chart of Accounts";
                ApplicationArea = All;
            }
            action(Clients)
            {
                Caption = 'Customers';
                Image = Customer;
                RunObject = page "Customer List";
                ApplicationArea = All;
            }
            action(Solde)
            {
                Caption = 'Balance';
                Image = Balance;
                RunObject = page "Customer List";
                RunPageView = where("Balance (LCY)" = filter(<> 0));
                ApplicationArea = All;
            }
            action(Fournisseurs)
            {
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = page "Vendor List";
                ApplicationArea = All;
            }
            action(Action5)
            {
                Caption = 'Balance';
                Image = Balance;
                RunObject = page "Vendor List";
                RunPageView = where("Balance (LCY)" = filter(<> 0));
                ApplicationArea = All;
            }
            action("Paiement en attente")
            {
                Caption = 'Payment on Hold';
                RunObject = page "Vendor List";
                RunPageView = where(Blocked = filter(Payment));
                ApplicationArea = All;
            }
            action("Feuilles paiement")
            {
                Caption = 'Payment Journals';
                Image = Journals;
                RunObject = page "General Journal Batches";
                RunPageView = where("Template Type" = const(Payments), Recurring = const(false));
                ApplicationArea = All;
            }
            action("Feuilles comptabilité")
            {
                Caption = 'General Journals';
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
                Caption = 'General Accounting';
                Image = Bank;
                action(Action1000000001)
                {
                    Caption = 'Chart of Accounts';
                    RunObject = page "Chart of Accounts";
                    ApplicationArea = All;
                }
                action(Action1000000013)
                {
                    Caption = 'General Journals';
                    Image = Journal;
                    RunObject = page "General Journal Batches";
                    RunPageView = where("Template Type" = const(General), Recurring = const(false));
                    ApplicationArea = All;
                }
                action(Immobilisations)
                {
                    Caption = 'Fixed Assets';
                    RunObject = page "Fixed Asset List";
                    ApplicationArea = All;
                }
                action(Devises)
                {
                    Caption = 'Currencies';
                    Image = Currency;
                    RunObject = page Currencies;
                    ApplicationArea = All;
                }
            }
            group("Comptabilité Clients")
            {
                Caption = 'Customer Accounting';
                Image = Marketing;
                action(Client)
                {
                    Caption = 'Customer';
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
                    Caption = 'Sales Invoice';
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
                    Caption = 'Sales Credit Memo';
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
                    Caption = 'Posted Sales Shipments';
                    Image = PostedShipment;
                    RunObject = page "Posted Sales Shipments";
                    ApplicationArea = All;
                }
                action("Avoirs vente enregistrés")
                {
                    Caption = 'Posted Sales Credit Memos';
                    RunObject = page "Posted Sales Credit Memos";
                    ApplicationArea = All;
                }
                action("Feuilles règlement")
                {
                    Caption = 'Cash Receipt Journals';
                    Image = Journals;
                    RunObject = page "General Journal Batches";
                    RunPageView = where("Template Type" = const("Cash Receipts"), Recurring = const(false));
                    ApplicationArea = All;
                }
            }
            group("Comptabilité Fournisseurs")
            {
                Caption = 'Vendor Accounting';
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
                    Caption = 'Vendor';
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
                    Caption = 'Purchase Quotes';
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
                    Caption = 'Purchase Invoice';
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
                    Caption = 'Purchase Credit Memos';
                    RunObject = page "Purchase Credit Memos";
                    ApplicationArea = All;
                }
                action("Factures achat enregistrées")
                {
                    Caption = 'Posted Purchase Invoices';
                    RunObject = page "Posted Purchase Invoices";
                    ApplicationArea = All;
                }
                action("Avoirs achat enregistrés")
                {
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = page "Posted Purchase Credit Memos";
                    ApplicationArea = All;
                }
                action(Action1000000038)
                {
                    Caption = 'Chart of Accounts';
                    RunObject = page "Chart of Accounts";
                    ApplicationArea = All;
                }
                action(Action1000000039)
                {
                    Caption = 'General Journals';
                    Image = Journal;
                    RunObject = page "General Journal Batches";
                    RunPageView = where("Template Type" = const(General), Recurring = const(false));
                    ApplicationArea = All;
                }
                action(Action1000000018)
                {
                    Caption = 'Payment Journals';
                    Image = Journals;
                    RunObject = page "General Journal Batches";
                    RunPageView = where("Template Type" = const(Payments), Recurring = const(false));
                    ApplicationArea = All;
                }
                action("Bordereaux de paiment")
                {
                    Caption = 'Bordereaux de paiment';
                    RunObject = page "Payment Slip List";
                    ApplicationArea = All;
                }
            }
        }
        area(creation)
        {
            action("&Client")
            {
                Caption = 'C&ustomer';
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
                Caption = 'Vendor Card';
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
                Caption = 'Sales &Invoice';
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
                Caption = 'Sales Credit &Memo';
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
