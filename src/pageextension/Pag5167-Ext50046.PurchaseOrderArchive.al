pageextension 50046 "BC6_PurchaseOrderArchive" extends "Purchase Order Archive" //5167
{
    // Début Modif JX-XAD du 05/08/2008
    // Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
    //
    // ------------------------------ V1.2 ---------------------------
    // CREATION JX-XAD 26/02/2010
    // Gestion des contrats : ajout du bouton "Contrat"
    //
    // //Modif JX-AUD du 17/02/2012
    // //Ajout du Champs "Matricule" et traitement de celui-ci
    layout
    {
        addafter("Buy-from Contact")
        {
            field("BC6_Matricule No."; Rec."BC6_Matricule No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify(Card)
        {
            Visible = false;
        }
        addbefore("Dimensions")
        {
            action(BC6_Card)
            {
                RunObject = page "Vendor List";
                RunPageLink = "No." = field("Buy-from Vendor No.");
                Image = EditLines;
                ShortCutKey = 'Shift+F7';
                ApplicationArea = Suite;
                Caption = 'Card', Comment = 'FRA="Fiche"';
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
