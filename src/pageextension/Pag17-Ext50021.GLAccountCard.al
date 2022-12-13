pageextension 50021 "BC6_GLAccountCard" extends "G/L Account Card" //17
{
    // MODIF JX-XAD du 25/08/2008
    // Ajout de 5 champs liés à IRIS Finance. Ces champs sont utilisés dans le dataport de génération des écritures compta pour IRIS ainsi
    // que dans le report de synthèse de TVA fournisseurs.
    //
    // //Ajout JX-XAD le 03/04/2009
    // //Ajout de la fonction "Dupliquer" dans le menu Compte
    //
    // ---------------------------- V1.2 ----------------------------
    //
    // //MODIF JX-XAD 15/06/2010 (fait le 15/10/2010 dans Nav 2009)
    // //Modification suite à l'ajout de la duplication de la fiche bancaire
    //
    // //MODIF JX-AUD 08/04/2011
    // //Limitation du champ No. dur formulaire à 8 caractères
    //
    // MODIF JX-PBD du 04/03/15 Migration 2015 => Suppression des champs iris et rubrique
    actions
    {
        addafter("Apply Entries")
        {
            action("Dupliquer vers une autre société")
            {
                Caption = 'Duplicate to another company', Comment = 'FRA="Dupliquer vers une autre société"';
                Image = CopyFromChartOfAccounts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //DEBUT MODIF JX-XAD 03/04/2009
                    //DEBUT MODIF JX-XAD le 15/06/2010
                    //GForm_Dupliquer.initialiser(Gopt_TypeFiche::"G/L Account","No.");
                    GForm_Dupliquer.initialiser(Gopt_TypeFiche::"G/L Account", Rec."No.", '');
                    //FIN MODIF JX-XAD le 15/06/2010
                    GForm_Dupliquer.RUNMODAL();
                    CLEAR(GForm_Dupliquer);
                    //FIN MODIF JX-XAD 03/04/2009
                end;
            }
        }
    }

    var
        GForm_Dupliquer: Page "BC6_Duplicating List";
        Gopt_TypeFiche: Option ,Vendor,"G/L Account",Item,VendorBankAccount;
}
