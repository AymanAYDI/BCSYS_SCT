pageextension 50017 "BC6_PostedPurchaseReceipts" extends "Posted Purchase Receipts" //145
{
    layout
    {

        addafter("Buy-from Vendor Name")
        {
            field("BC6_Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addfirst("&Receipt")
        {
            action(BC6_Fiche)
            {
                Caption = 'Card', Comment = 'FRA="Fiche"';
                Image = EditLines;
                RunObject = Page "Posted Purchase Receipts";
                RunPageLink = "No." = FIELD("No.");
                ShortCutKey = 'Shift+F5';
                ApplicationArea = All;
            }
        }
    }
    var
        FunctionsMgt: Codeunit "BC6_FunctionsMgt";

    trigger OnOpenPage()
    begin
        //Début Modif JX-XAD du 05/08/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("User ID", FunctionsMgt.jx_GetPurchasesFilter());
        Rec.FILTERGROUP(0);
        //Fin Modif JX-XAD du 05/08/2008

    end;
}

