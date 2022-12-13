pageextension 50010 "BC6_PostedPurchaseReceipt" extends "Posted Purchase Receipt" //136
{
    // Début Modif JX-XAD du 05/08/2008
    // Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
    // Ajout du champ "Code utilisateur"
    // 
    // ------------------------------ V1.2 ---------------------------
    // CREATION JX-XAD 26/02/2010
    // Gestion des contrats : ajout du bouton "Contrat"
    // 
    // MODIF JX-XAD 04/05/2010
    // Ajout du bouton "Modifier axes analytiques"
    // 
    // //Modif JX-AUD du 17/02/2012
    // //Ajout du Champs "Matricule" et traitement de celui-ci
    layout
    {
        addafter("No. Printed")
        {
            field("BC6_User ID"; Rec."User ID")
            {
                Caption = 'Code utilisateur :';
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Matricule No."; Rec."BC6_Matricule No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        moveafter("Buy-from Post Code"; "Buy-from City")
    }
}

