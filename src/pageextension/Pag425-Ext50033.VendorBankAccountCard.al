pageextension 50033 "BC6_VendorBankAccountCard" extends "Vendor Bank Account Card" //425
{
    // //Modif LAB du 26/05/2010
    // //Ajout du champ Modification du RIB/IBAN
    // 
    // ---------------------------- V1.2 ----------------------------
    // 
    // //Ajout JX-XAD le 15/06/2010 (fait le 15/10/2010)
    // //Ajout de la fonction "Dupliquer" dans le menu Banque
    layout
    {
        addafter("RIB Checked")
        {
            field("BC6_Change RIB/IBAN"; Rec."BC6_Change RIB/IBAN")
            {
                ApplicationArea = All;
            }
        }
        moveafter(Contact; City)
    }
    actions
    {
        addfirst(navigation)
        {
            group("BC6_&Bank Acc.")
            {
                Caption = '&Bank Acc.', Comment = 'FRA="&Banque"';

                action("Dupliquer vers une autre société")
                {
                    Caption = 'Dupliquer vers une autre société';
                    ApplicationArea = All;
                    Image = Action;

                    trigger OnAction()
                    begin
                        //DEBUT MODIF JX-XAD 15/06/2010
                        GForm_Dupliquer.initialiser(Gopt_TypeFiche::VendorBankAccount, Rec."Vendor No.", Rec.Code);
                        GForm_Dupliquer.RUNMODAL();
                        CLEAR(GForm_Dupliquer);
                        //FIN MODIF JX-XAD 15/06/2010
                    end;
                }
            }
        }
    }

    var
        GForm_Dupliquer: Page "BC6_Duplicating List";
        Gopt_TypeFiche: Option ,Vendor,"G/L Account",Item,VendorBankAccount;
}

