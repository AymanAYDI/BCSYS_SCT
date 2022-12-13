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
                Caption = 'Card', Comment = 'FRA="Fiche"';
                Image = EditLines;
                RunObject = page "Posted Purchase Credit Memos";
                RunPageLink = "No." = field("No.");
                ShortCutKey = 'Shift+F5';
                ApplicationArea = All;
            }
        }
    }
    trigger OnOpenPage()
    var
        FunctionsMgt: Codeunit BC6_FunctionsMgt;
    begin
        //D‚but Modif JX-XAD du 05/08/2008
        //Filtrer sur le (ou les) utilisateur(s) li‚s au droit de l'utilisateur courant (voir table des paramŠtres utilisateur)
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("User ID", FunctionsMgt.jx_GetPurchasesFilter());
        Rec.FILTERGROUP(0);
        //Fin Modif JX-XAD du 05/08/2008
    end;
}
