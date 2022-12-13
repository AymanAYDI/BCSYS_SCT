pageextension 50005 "BC6_UserSetup" extends "User Setup" //119
{
    layout
    {
        modify("Register Time")
        {
            Visible = false;
        }
        addafter("Service Resp. Ctr. Filter")
        {
            field("Droits accès doc. achat"; Rec."BC6_Droits acces doc. achat")
            {
                Caption = 'Access rights to purchase documents', Comment = 'FRA="Droits accès doc. achat"';
                ApplicationArea = All;
            }
            field(BC6_Service; Rec."BC6_Service")
            {
                Caption = 'Service', Comment = 'FRA="Service"';
                ApplicationArea = All;
            }
            field(BC6_Nom; Rec."BC6_Nom")
            {
                Caption = 'Nom (signature)', Comment = 'FRA="Nom (signature)"';
                ApplicationArea = All;
            }
            field(BC6_Fonction; Rec."BC6_Fonction")
            {
                Caption = 'Fonction (signature)', Comment = 'FRA="Fonction (signature)"';
                ApplicationArea = All;
            }
            field(BC6_Picture; Rec."BC6_Picture")
            {
                Caption = 'Signature (image bmp)', Comment = 'FRA="Signature (image bmp)"';
                ApplicationArea = All;
            }
            field("BC6_Register Time"; Rec."Register Time")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addfirst(navigation)
        {
            group("BC6_&Signature")
            {
                Caption = '&Signature', Comment = 'FRA="&Signature"';

                action("Gérer la signature")
                {
                    Caption = 'Gérer la signature', Comment = 'FRA="Gérer la signature"';
                    Image = Default;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = page "BC6_User Setup Card";
                    RunPageLink = "User ID" = field("User ID");
                    ApplicationArea = All;
                }
                action("BC6_Supprimer la signature")
                {
                    Caption = 'Delete', Comment = 'FRA="Supprimer la signature"';
                    Image = Delete;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()

                    begin
                        if CONFIRM(Text002, false) then begin
                            CLEAR(Rec."BC6_Picture");
                            CurrPage.SAVERECORD();
                        end;
                    end;
                }
                action("BC6_&Duplication/Suppression utilisateur")
                {
                    Caption = 'Duplication/Deletion user', Comment = 'FRA="&Duplication/Suppression utilisateur"';
                    Image = CopyFromChartOfAccounts;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //DEBUT MODIF JX-AUD 07/04/2014
                        GForm_Duplicating.initialiser(Gopt_TypeFiche::User, Rec."User ID", '');
                        GForm_Duplicating.RUNMODAL();
                        CLEAR(GForm_Duplicating);
                        //DEBUT MODIF JX-AUD 07/04/2014
                    end;
                }
                action("&Appliquer périodes validation")
                {
                    Caption = 'Apply validation period', Comment = 'FRA="&Appliquer périodes validation"';
                    Image = Apply;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //MODIF JX- AUD du 28/03/14
                        if CONFIRM(STRSUBSTNO(Text003, Rec."Allow Posting From", Rec."Allow Posting To")) then
                            Gcu_DuplicatingRecords.CopierPeriodesValidation(Rec."Allow Posting From", Rec."Allow Posting To");
                        //Fin MODIF JX- AUD du 28/03/14
                    end;
                }
            }
        }
    }
    var

        Gcu_DuplicatingRecords: Codeunit "BC6_Duplicating records";
        GForm_Duplicating: Page "BC6_Duplicating List";
        Text002: label 'Do you want to delete the picture?', Comment = 'FRA="Souhaitez-vous supprimer l''image ?"';
        Text003: label '"Are you sure you want to validate \\ "Start validation period" = %1 \ "End validation period" = %2 \\ on all users and companies? \\ A confirmation message will appear for each company'; //,Comment = 'FRA="Souhaitez-vous vraiment valider \\"Début période validation" = %1 \ "Fin période validation" = %2 \\ sur tous les utilisateurs et sur les sociétés ?\\Un message de confirmation va apparaŒtre pour chacune des sociétés"';
        Gopt_TypeFiche: Option ,Vendor,"G/L Account",Item,VendorBankAccount,User;
}
