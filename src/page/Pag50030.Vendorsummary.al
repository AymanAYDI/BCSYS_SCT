page 50030 "BC6_Vendor summary"
{
    // // Création LAB du 15/07/2010
    // // formulaire récapitulatif des fournisseurs
    // 
    // //MODIF JX-XAD 08/11/2010
    // Ajout d'un paramètres à la fonction GForm_Dupliquer.initialiser
    // 
    // //MODIF JX-AUD 08/04/2011
    // Limitation du champ No. du formulaire à 10 caractères
    // 
    // //MODIF JX-XAD 11/04/2011
    // Ajout de la fonctionnalité de duplication de RIB (duplique ou met à jour le RIB dans les autres sociétés)

    Caption = 'Vendor summary', Comment = 'FRA="Récapitulatif fournisseur"';
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = Vendor;
    ApplicationArea = All;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'General', Comment = 'FRA="Général"';
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
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Default Bank Account Code"; Rec."BC6_Default Bank Account Code")
                {
                    ApplicationArea = All;
                }
                field("Application Method"; Rec."Application Method")
                {
                    ApplicationArea = All;
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Primary Contact No."; Rec."Primary Contact No.")
                {
                    ApplicationArea = All;
                }
            }
            part(Control1000000006; "BC6 Default Dimensions subform")
            {
                SubPageLink = "Table ID" = CONST(23), "No." = FIELD("No.");
                ApplicationArea = All;
            }
            part(VendorBankAccountSubform; "BC6 Vendor Bank Acc. subform")
            {
                SubPageLink = "Vendor No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Fo&urnisseur")
            {
                Caption = 'Ven&dor', Comment = 'FRA="Fo&urnisseur"';
                action("&Ecritures comptables")
                {
                    Caption = 'Ledger E&ntries', Comment = 'FRA="&Ecritures comptables"';
                    Image = LedgerEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Vendor Ledger Entries";
                    RunPageLink = "Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Vendor No.");
                    ShortCutKey = 'Ctrl+F7';
                    ApplicationArea = All;
                }
                action("Co&mmentaires")
                {
                    Caption = 'Co&mments', Comment = 'FRA="Co&mmentaires"';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Vendor), "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("A&xes analytiques")
                {
                    Caption = 'Dimensions', Comment = 'FRA="A&xes analytiques"';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(23), "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;
                }
                action("Comptes &bancaires")
                {
                    Caption = 'Bank Accounts', Comment = 'FRA="Comptes &bancaires"';
                    Image = BankAccount;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Vendor Bank Account List";
                    RunPageLink = "Vendor No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Adresses de rè&glement")
                {
                    Caption = '&Payment Addresses', Comment = 'FRA="Adresses de rè&glement"';
                    Image = ContractPayment;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Payment Addresses";
                    RunPageLink = "Account Type" = CONST(Vendor), "Account No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(Statistiques)
                {
                    Caption = 'Statistics', Comment = 'FRA="Statistiques"';
                    Image = Statistics;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Vendor Statistics";
                    RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Dupliquer vers une autre société")
                {
                    Caption = 'Duplicate to another company', Comment = 'FRA="Dupliquer vers une autre société"';
                    Image = CopyCostBudget;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //DEBUT MODIF JX-XAD 03/04/2009
                        //GForm_Dupliquer.initialiser(Gopt_TypeFiche::Vendor,"No.");
                        GForm_Dupliquer.initialiser(Gopt_TypeFiche::Vendor, Rec."No.", '');   //MODIF JX-XAD 08/11/2010
                        GForm_Dupliquer.RUNMODAL();
                        CLEAR(GForm_Dupliquer);
                        //FIN MODIF JX-XAD 03/04/2009
                    end;
                }
                action("Dupliquer le compte bancaire vers une autre société")
                {
                    Caption = 'Duplicate the bank account to another company', Comment = 'FRA="Dupliquer le compte bancaire vers une autre société"';
                    Image = CopyGLtoCostBudget;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Lrec_VendorBankAccount: Record "Vendor Bank Account";
                    begin
                        //DEBUT MODIF JX-XAD 11/04/2011
                        CurrPage.VendorBankAccountSubform.PAGE.ReturnRecord(Lrec_VendorBankAccount);
                        GForm_Dupliquer.initialiser(Gopt_TypeFiche::VendorBankAccount, Rec."No.", Lrec_VendorBankAccount.Code);
                        GForm_Dupliquer.RUNMODAL();
                        CLEAR(GForm_Dupliquer);
                        //FIN MODIF JX-XAD 11/04/2011
                    end;
                }
            }
        }
    }
    var
        GForm_Dupliquer: Page "BC6_Duplicating List";
        Gopt_TypeFiche: Option ,Vendor,"G/L Account",Item,VendorBankAccount;
}

