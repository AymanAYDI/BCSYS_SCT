page 50043 "BC6 Purchase Role Center VSC"
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
                part(Control1901197008; "BC6 Purchase Activities VSC")
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
                part(Control1902476008; "My Vendors")
                {
                    ApplicationArea = All;
                }
                part(Control18; "Report Inbox Part")
                {
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
        area(reporting)
        {
            action("Co&mptabilité fournisseur âgée")
            {
                Caption = 'Aged Accou&nts Payable', Comment = 'FRA="Co&mptabilité fournisseur âgée"';
                Image = "Report";
                RunObject = Report "Aged Accounts Payable";
                ApplicationArea = All;
            }
            action("Journal comptes fournisseurs")
            {
                Caption = 'Vendor Journal', Comment = 'FRA="Journal comptes fournisseurs"';
                Image = "Report";
                RunObject = Report "Vendor Journal";
                ApplicationArea = All;
            }
            action("Journal comptes bancaires")
            {
                Caption = 'Bank Account Journal', Comment = 'FRA="Journal comptes bancaires"';
                Image = "Report";
                RunObject = Report "Bank Account Journal";
                ApplicationArea = All;
            }
            action("Rapprochement cpta. gén./fourn.")
            {
                Caption = 'GL/Vend. Ledger Reconciliation', Comment = 'FRA="Rapprochement cpta. gén./fourn."';
                Image = "Report";
                RunObject = Report "GL/Vend. Ledger Reconciliation";
                ApplicationArea = All;
            }
        }
        area(embedding)
        {
            action(Fournisseurs)
            {
                Caption = 'Vendors', Comment = 'FRA="Fournisseurs"';
                Image = Vendor;
                RunObject = Page "Vendor List";
                ApplicationArea = All;
            }
            action(Devis)
            {
                Caption = 'Devis', Comment = 'FRA="Devis"';
                RunObject = Page "Purchase Quotes";
                ApplicationArea = All;
            }
            action("Commandes achat")
            {
                Caption = 'Purchase Orders', Comment = 'FRA="Commandes achat"';
                RunObject = Page "BC6_Purchase Order List VSC";
                ApplicationArea = All;
            }
            action("Factures achat")
            {
                Caption = 'Purchase Invoices', Comment = 'FRA="Factures achat"';
                RunObject = Page "BC6 Purchase Invoices List VSC";
                ApplicationArea = All;
            }
            action("Avoirs achat")
            {
                Caption = 'Avoirs achat', Comment = 'FRA="Avoirs achat"';
                RunObject = Page "Purchase Credit Memos";
                ApplicationArea = All;
            }
            action("Ecritures approbation")
            {
                Caption = 'Ecritures approbation', Comment = 'FRA="Ecritures approbation"';
                RunObject = Page "Approval Entries";
                ApplicationArea = All;
            }
            action("Ecritures demande d'approbation")
            {
                Caption = 'Ecritures demande d''approbation', Comment = 'FRA="Ecritures demande d''approbation"';
                RunObject = Page "Approval Request Entries";
                ApplicationArea = All;
            }
        }
        area(sections)
        {
            group(Approbations)
            {
                Caption = 'Approbations', Comment = 'FRA="Approbations"';
                action("Écritures approbation")
                {
                    Caption = 'Écritures approbation', Comment = 'FRA="Écritures approbation"';
                    RunObject = Page "Approval Entries";
                    ApplicationArea = All;
                }
                action("Écritures approbation enreg.")
                {
                    Caption = 'Écritures approbation enreg.', Comment = 'FRA="Écritures approbation enreg."';
                    RunObject = Page "Posted Approval Entries";
                    ApplicationArea = All;
                }
            }
            group("Documents validés")
            {
                Caption = 'Posted Documents', Comment = 'FRA="Documents validés"';
                Image = FiledPosted;
                action("Réceptions achat enregistrées")
                {
                    Caption = 'Posted Purchase Receipts', Comment = 'FRA="Réceptions achat enregistrées"';
                    RunObject = Page "Posted Purchase Receipts";
                    ApplicationArea = All;
                }
                action("Factures achat enregistrées")
                {
                    Caption = 'Posted Purchase Invoices', Comment = 'FRA="Factures achat enregistrées"';
                    RunObject = Page "Posted Purchase Invoices";
                    ApplicationArea = All;
                }
                action("Expéditions retour enreg.")
                {
                    Caption = 'Posted Return Shipments', Comment = 'FRA="Expéditions retour enreg."';
                    RunObject = Page "Posted Return Shipments";
                    ApplicationArea = All;
                }
                action("Avoirs achat enregistrés")
                {
                    Caption = 'Posted Purchase Credit Memos', Comment = 'FRA="Avoirs achat enregistrés"';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ApplicationArea = All;
                }
            }
        }
        area(creation)
        {
            action("&Fournisseur")
            {
                Caption = '&Vendor', Comment = 'FRA="&Fournisseur"';
                Enabled = false;
                Image = Vendor;
                RunObject = Page "BC6_Vendor summary";
                RunPageMode = Create;
                Visible = false;
                ApplicationArea = All;
            }
            action("&Devis")
            {
                Caption = '&Purchase Invoice', Comment = 'FRA="&Devis"';
                Image = Invoice;
                RunObject = Page "Purchase Quote";
                RunPageMode = Create;
                ApplicationArea = All;
            }
        }
        area(processing)
        {
            action("Navig&uer")
            {
                Caption = 'Navi&gate', Comment = 'FRA="Navig&uer"';
                Image = Navigate;
                RunObject = Page Navigate;
                ApplicationArea = All;
            }
        }
    }
}

