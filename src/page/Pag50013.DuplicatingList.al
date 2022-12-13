page 50013 "BC6_Duplicating List"
{
    Caption = 'Duplicating List', Comment = 'FRA="Liste de duplication"';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "BC6_Duplicating list";

    layout
    {
        area(content)
        {
            field(COMPANYNAME; COMPANYNAME)
            {
                Editable = false;
                Style = Standard;
                StyleExpr = true;
                ApplicationArea = All;
            }
            label(Control1000000011)
            {
                CaptionClass = FORMAT(text006 + ' ' + Gtxt_TypeFiche + ' ' + Gcode_Fiche);
                Editable = false;
                ShowCaption = false;
            }
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Name; Rec.Name)
                {
                    Caption = 'Company', Comment = 'FRA="Société"';
                    ApplicationArea = All;
                }
                field(Duplication; Rec.Duplication)
                {
                    Caption = 'Dupliacate to', Comment = 'FRA="Dupliquer vers"';
                    ApplicationArea = All;
                }
                field(Dimension; Rec.Dimension)
                {
                    Caption = 'With dimensions', Comment = 'FRA="Avec l''analytique"';
                    Visible = DimensionVisible;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Valider duplication")
            {
                Caption = 'Validate duplication', Comment = 'FRA="Valider duplication"';
                Image = PostponedInteractions;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Lint_DuplicationNumber: Integer;
                    Ltxt_Duplication: Text[1024];
                    Ltxt_Echec: Text[1024];
                begin
                    Lint_DuplicationNumber := Gcu_DuplicatingRecords.Dupliquer(Gopt_TypeFiche, Gcode_Fiche, Gcode_Fiche2);

                    //**** Traitement du message final récapitulatif *****
                    if Lint_DuplicationNumber = 0 then
                        MESSAGE(text001)
                    else begin
                        Ltxt_Duplication := text007;
                        case Gopt_TypeFiche of
                            Gopt_TypeFiche::Vendor:
                                Ltxt_Duplication := text007 + Text019;
                            Gopt_TypeFiche::VendorBankAccount:
                                Ltxt_Duplication := text007 + Text020;
                        end;
                        Ltxt_Duplication := ' ' + Gcode_Fiche + ' ' + text009 + '\\';
                        Ltxt_Echec := '';
                        if Rec.FIND('-') then
                            repeat
                                if Rec.Duplication then
                                    if Rec.Echec then
                                        Ltxt_Echec += Rec.Name + '\'
                                    else begin
                                        Ltxt_Duplication += Rec.Name;
                                        Ltxt_Duplication += '\';
                                    end;
                            until Rec.NEXT() = 0;
                        if Ltxt_Echec <> '' then
                            Ltxt_Echec := '\' + text008 + '\\' + Ltxt_Echec;
                        MESSAGE(Ltxt_Duplication + Ltxt_Echec);
                    end;

                    CurrPage.CLOSE();
                end;
            }
            action("Sélection toutes sociétés")
            {
                Caption = 'Sélection toutes sociétés', Comment = 'FRA="Sélection toutes sociétés"';
                Image = SelectEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //DEBUT MODIF JX-XAD 07/06/2011
                    Rec.SelectAll(Gbool_SelectAll);
                    if Gopt_TypeFiche <> Gopt_TypeFiche::User then //JX-AUD 07/04/14
                        Rec.SelectAllWithDim(Gbool_SelectAllWithDim);
                    //FIN MODIF JX-XAD 07/06/2011
                end;
            }
            action("Valider suppression")
            {
                Caption = 'Validate deletion', Comment = 'FRA="Valider suppression"';
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Lint_DuplicationNumber: Integer;
                    Ltxt_Duplication: Text[1024];
                    Ltxt_Echec: Text[1024];
                begin
                    //DEBUT MODIF JX-AUD du 07/04/14
                    if Gopt_TypeFiche <> Gopt_TypeFiche::User then ERROR(text016);

                    Gopt_TypeFiche := Gopt_TypeFiche::UserDelete;

                    Lint_DuplicationNumber := Gcu_DuplicatingRecords.Dupliquer(Gopt_TypeFiche, Gcode_Fiche, Gcode_Fiche2);

                    //**** Traitement du message final récapitulatif *****
                    if Lint_DuplicationNumber = 0 then
                        MESSAGE(text001)
                    else begin
                        Ltxt_Duplication := text007 + ' ' + Gcode_Fiche + ' ' + text017 + '\\';
                        Ltxt_Echec := '';
                        if Rec.FIND('-') then
                            repeat
                                if Rec.Duplication then
                                    if Rec.Echec then
                                        Ltxt_Echec += Rec.Name + '\'
                                    else begin
                                        Ltxt_Duplication += Rec.Name;
                                        Ltxt_Duplication += '\';
                                    end;
                            until Rec.NEXT() = 0;
                        if Ltxt_Echec <> '' then
                            Ltxt_Echec := '\' + text018 + '\\' + Ltxt_Echec;
                        MESSAGE(Ltxt_Duplication + Ltxt_Echec);
                    end;

                    Gcu_DuplicatingRecords.DeleteUserActualSociety(Gcode_Fiche);
                    CurrPage.CLOSE();

                    //FIN MODIF JX-AUD du 07/04/14
                end;
            }
            action(Annuler)
            {
                Caption = 'Cancel', Comment = 'FRA="Annuler"';
                Image = CancelAllLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.CLOSE();
                end;
            }
        }
    }

    trigger OnInit()
    begin
        DimensionVisible := true;
        Gbool_SelectAll := true;
        Gbool_SelectAllWithDim := true;
    end;

    trigger OnOpenPage()
    begin
        case Gopt_TypeFiche of
            Gopt_TypeFiche::Vendor:
                Gtxt_TypeFiche := text011;
            Gopt_TypeFiche::"G/L Account":
                Gtxt_TypeFiche := text012;
            Gopt_TypeFiche::Item:
                Gtxt_TypeFiche := text013;
            Gopt_TypeFiche::VendorBankAccount:
                begin
                    Gtxt_TypeFiche := text014;
                    DimensionVisible := false;
                end;
            //MODIF JX-AUD du 07/04/2014
            Gopt_TypeFiche::User:
                begin
                    Gtxt_TypeFiche := text015;
                    DimensionVisible := false;
                end;
            //FIN MODIF JX-AUD du 07/04/2014
            else
                ERROR(text010);
        end;

        Gcu_DuplicatingRecords.Initialiser();
    end;

    var
        Gcu_DuplicatingRecords: Codeunit "BC6_Duplicating records";

        [InDataSet]
        DimensionVisible: Boolean;
        Gbool_SelectAll: Boolean;
        Gbool_SelectAllWithDim: Boolean;
        Gcode_Fiche: Code[50];
        Gcode_Fiche2: Code[50];
        text001: label 'Transaction canceled', Comment = 'FRA="Opération annulée"';
        text006: label 'Duplicate card', Comment = 'FRA="Dupliquer fiche"';
        text007: label 'The card', Comment = 'FRA="La fiche"';
        text008: label 'Duplication has failed in :', Comment = 'FRA="La duplication a échoué dans :"';
        text009: label 'has been duplicated in the following company :', Comment = 'FRA="a été dupliquée dans la (ou les) société(s) suivante(s) :"';
        text010: label 'This form must be launched from a sheet supplier, a general account, an article or a bank account!', Comment = 'FRA="Ce formulaire doit être lancé depuis une fiche fournisseur, un compte général, un article, un compte bancaire ou la liste des paramètres utilisateurs !"';
        text011: label 'Vendor', Comment = 'FRA="fournisseur"';
        text012: label 'item', Comment = 'FRA="article"';
        text013: label 'G/L account', Comment = 'FRA="compte général"';
        text014: label 'bank account', Comment = 'FRA="compte bancaire"';
        text015: label 'user', Comment = 'FRA="utilisateur"';
        text016: label 'This button does not apply to your treatment', Comment = 'FRA="Ce bouton ne s''applique pas pour votre traitement"';
        text017: label 'has been duplicated in the following company :', Comment = 'FRA="a été supprimée dans la (ou les) société(s) suivante(s) :"';
        text018: label 'Duplication has failed in :', Comment = 'FRA="La suppression a échoué dans :"';
        Text019: label 'Provider', Comment = 'FRA="Fournisseur"';
        Text020: label 'Bank account', Comment = 'FRA="Compte bancaire"';
        Gopt_TypeFiche: Option ,Vendor,"G/L Account",Item,VendorBankAccount,User,UserDelete,UserDeleteActualSociety;
        Gtxt_TypeFiche: Text[30];

    procedure initialiser(Lopt_TypeFiche: Option ,Vendor,"G/L Account",Item; Lcode_Fiche: Code[50]; Lcode_Fiche2: Code[50])
    begin
        Gopt_TypeFiche := Lopt_TypeFiche;
        Gcode_Fiche := Lcode_Fiche;
        Gcode_Fiche2 := Lcode_Fiche2
    end;
}
