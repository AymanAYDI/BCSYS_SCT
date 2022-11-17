pageextension 50020 "BC6_ChartofAccounts" extends "Chart of Accounts" //16
{
    // MODIF JX-XAD du 26/08/2008
    // Ajout de 5 champs liés à IRIS Finance. Ces champs sont utilisés dans le dataport de génération des écritures compta pour IRIS ainsi
    // que dans le report de synthèse de TVA fournisseurs.
    //
    // //Modif LAB du 01/07/09
    // //Ajout du champ "bloqué"
    //
    // MODIF JX-PBD du 04/03/15 Migration 2015 => Suppression des champs 50000 à 50004

    layout
    {
        addafter("VAT Bus. Posting Group")
        {
            field(BC6_Blocked; Rec.Blocked)
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
        addafter("Default IC Partner G/L Acc. No")
        {
            field(BC6_Rubrique; Rec."BC6_Rubrique")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addfirst("A&ccount")
        {
            action(BC6_Fiche)
            {
                Caption = 'Card';
                Image = EditLines;
                RunObject = page "Chart of Accounts";
                RunPageLink = "No." = field("No."), "Date Filter" = field("Date Filter"), "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = field("Global Dimension 2 Filter"), "Budget Filter" = field("Budget Filter"), "Business Unit Filter" = field("Business Unit Filter");
                ShortCutKey = 'Shift+F5';
                ApplicationArea = All;
            }
        }
    }
}
