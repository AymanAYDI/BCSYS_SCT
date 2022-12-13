pageextension 50026 "BC6_VendorList" extends "Vendor List" //27
{
    // // Modif LAB du 17/09/2009
    // // Ajout du champ solde
    // 
    // // Modif AUD du 07/06/2012
    // // Ajout du champ solde période
    // 
    // //Modif JX-AUD du 19/11/13
    // //Ajout du N° Siret
    layout
    {
        addafter(Name)
        {
            field("BC6_Registration No."; Rec."BC6_Registration No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Location Code")
        {
            field(BC6_Address; Rec.Address)
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("BC6_Address 2"; Rec."Address 2")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field(BC6_City; Rec.City)
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
        addafter("Last Date Modified")
        {
            field(BC6_Balance; Rec.Balance)
            {
                ApplicationArea = All;
            }
            field("BC6_Net Change"; Rec."Net Change")
            {
                ApplicationArea = All;
            }
        }
        addafter("Base Calendar Code")
        {
            field("BC6_E-Mail"; Rec."E-Mail")
            {
                Visible = false;
            }
        }
        moveafter(Blocked; "Language Code")
        moveafter("Application Method"; "Search Name")
    }
    actions
    {
        addfirst("Ven&dor")
        {
            action(BC6_Card)
            {
                Caption = 'Card', Comment = 'FRA="Fiche"';
                RunObject = Page "Vendor Card";
                RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                 "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Image = EditLines;
                ApplicationArea = All;
            }
        }


        modify(NewBlanketPurchaseOrder)
        {
            Visible = false;
        }
        modify(NewPurchaseQuote)
        {
            Caption = 'Purchase Quote', Comment = 'FRA="Devis"';
            Promoted = true;
        }
        modify(NewPurchaseInvoice)
        {
            Visible = false;
        }
        modify(NewPurchaseOrder)
        {
            Visible = false;
        }
        modify(NewPurchaseCrMemo)
        {
            Visible = false;
        }
        modify(NewPurchaseReturnOrder)
        {
            Visible = false;
        }
    }
}

