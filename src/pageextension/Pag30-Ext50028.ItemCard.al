pageextension 50028 "BC6_ItemCard" extends "Item Card" //30
{
    // //Ajout JX-XAD le 03/04/2009
    // //Ajout de la fonction "Dupliquer" dans le menu Article
    // 
    // ---------------------------- V1.2 ----------------------------
    // 
    // //MODIF JX-XAD le 15/06/2010 (fait le 15/10/2010)
    // //Modification suite à l'ajout de la duplication de la fiche bancaire
    // 
    // //MODIF JX-AUD le 20/08/2012
    // //Mise en place de l'unité 'EUROS' par défaut
    layout
    {
    }
    actions
    {
        addafter(Identifiers)
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
                    GForm_Dupliquer.initialiser(Gopt_TypeFiche::Item, Rec."No.", '');
                    GForm_Dupliquer.RUNMODAL();
                    CLEAR(GForm_Dupliquer);
                end;
            }
        }
    }

    var
        Grec_ItemUnitOfMeasure: Record "Item Unit of Measure";
        GForm_Dupliquer: Page "BC6_Duplicating List";
        Gopt_TypeFiche: Option ,Vendor,"G/L Account",Item,VendorBankAccount;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //MODIF JX-AUD le 20/08/2012
        Grec_ItemUnitOfMeasure.INIT();
        Grec_ItemUnitOfMeasure."Item No." := Rec."No.";
        Grec_ItemUnitOfMeasure.Code := 'EUROS';
        Grec_ItemUnitOfMeasure."Qty. per Unit of Measure" := 1;
        Grec_ItemUnitOfMeasure.INSERT();
        Rec."Base Unit of Measure" := 'EUROS';
        //MODIF JX-AUD le 20/08/2012
    end;
}

