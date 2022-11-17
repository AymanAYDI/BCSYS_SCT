pageextension 50019 "BC6_PostedPurchaseCreditMemos" extends "Posted Purchase Credit Memos" //147
{
    // //Modif JX-AUD du 10/07/2013
    // //Ajout du champ Litige
    // // Modif JX-ABE du 14/09/2016
    // // modifier "l'extended datatype" du champ "Yooz Tooken link" en URL
    layout
    {
        addafter("No.")
        {
            field(BC6_Litige; Rec."BC6_Litige")
            {
                ApplicationArea = All;
            }
        }
        addafter("Applies-to Doc. Type")
        {
            field("BC6_BC No."; Rec."BC6_BC No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Yooz No."; Rec."BC6_Yooz No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Yooz Token link"; Rec."BC6_Yooz Token link")
            {
                Editable = false;
                ExtendedDatatype = URL;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addfirst("&Cr. Memo")
        {
            action(BC6_Fiche)
            {
                Caption = 'Card';
                Image = EditLines;
                RunObject = page "Posted Purchase Credit Memos";
                RunPageLink = "No." = field("No.");
                ShortCutKey = 'Shift+F5';
                ApplicationArea = All;
            }
        }
    }
}
