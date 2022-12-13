pageextension 50048 "BC6_PurchaseList" extends "Purchase List" //53
{
    // Modif JX-LAB du 18/09/2008
    // ajout du champ "statut"
    //
    // //Modif JX-AUD du 23/04/2013
    // //Ajout du champ Commentaire et libre
    // //Ajout Description Statut FAP
    // //Ajout du champ Montant à enregistrer
    //
    // //Modif JX-AUD du 10/07/2013
    // //Ajout de la de la colonne Litige
    layout
    {
        addafter("No.")
        {
            field(BC6_Litige; Rec."BC6_Litige")
            {
                ApplicationArea = All;
            }
        }
        addafter("Buy-from Vendor Name")
        {
            field("BC6_Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
            field("BC6_Free comment"; Rec."BC6_Free comment")
            {
                ApplicationArea = All;
            }
            field("BC6_Status description"; Rec."BC6_Status description")
            {
                Caption = 'FAP status description', Comment = 'FRA="Libellé statut FAP"';
                ApplicationArea = All;
            }
            field("BC6_Register amount"; Rec."BC6_Register amount")
            {
                ApplicationArea = All;
            }
            field(BC6_Status; Rec.Status)
            {
                ApplicationArea = All;
            }
            field("BC6_Matricule No."; Rec."BC6_Matricule No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Quote No."; Rec."Quote No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Document Date"; Rec."Document Date")
            {
                ApplicationArea = All;
            }
            field("BC6_Lines Amount"; Rec."BC6_Lines Amount")
            {
                ApplicationArea = All;
            }
        }
    }
    var
        UserMgt: Codeunit "BC6_FunctionsMgt";

    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Assigned User ID", UserMgt.jx_GetPurchasesFilter());
        Rec.FILTERGROUP(0);
    end;
}
