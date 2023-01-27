pageextension 50047 "BC6_PurchaseCreditMemo" extends "Purchase Credit Memo" //52
{
    // NAVW16.00.01,JX-VSC1.0-XAD,JX-VSC1.1-XAD,JX-VSC1.2-XAD,JX-VSC1.3-XAD
    //
    // Modif JX-XAD du 11/06/2008
    // Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
    //
    // ---------------------------------- V1.1 ---------------------------------
    //
    // Modif JX-XAD du 04/08/2009
    // Ajout des champs "Groupe compta fournisseur", "Groupe compta marché " et "Groupe compta marché TVA" dans l'onglet Facturation
    //
    // ------------------------------------ V1.2 ------------------------------------
    //
    // Modif JX-XAD du 15/01/2010
    // Ajout des champs :
    // - Utilisateur initial
    // - Date de création
    // - Date de réception facture
    // Ajout du bouton "Historique" dans le menu du bouton Facture
    // Ajout d'un bouton "Envoi mail avoir" qui envoie un résumé de la facture par mail
    // (ces fonctionnalités sont une mise à jour des mêmes fonctionnalités de la facture : voir form 51)
    //
    // // modif LAB du 16/12/2009
    // // Modification de l'objet du mail
    // // échange de place entre la date de réception de la facture et la date de création
    // // ajout de la gestion du code utilisateur affecté sur l'historique envoi email
    //
    // // modif LAB du 29/12/2009
    // // Passage variable Ltxt_subject de 50 à 100
    //
    // MODIF JX-XAD du 15/01/2010
    // Ajout du bouton "Envoi mail" avec les fonctionnalité "Envoi mail avoir" et "Historique"
    //
    // // Modif LAB du 12/02/2010
    // // Ajout utilisateur affecté vers codeunit VSC Mail
    //
    // MODIF JX-XAD 06/08/2010 Suite migration
    // Mise à jour de la disposition des champs sur le formulaire
    //
    // //Modif JX-AUD du 17/02/2012
    // //Ajout du Champs "Matricule" et traitement de celui-ci
    //
    // //Modif JX-AUD du 10/07/2013
    // //Ajout du champ Litige
    // //Appel de la nouvelle méthode par SMTP pour l'envoi du mail

    layout
    {
        addafter("Buy-from Contact")
        {
            field("BC6_Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
            field("BC6_Matricule No."; Rec."BC6_Matricule No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(BC6_Litige; Rec."BC6_Litige")
            {
                ApplicationArea = All;
            }
        }
        addafter(Status)
        {
            field("BC6_BC No."; Rec."BC6_BC No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Yooz No."; Rec."BC6_Yooz No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Yooz Token link"; Rec."BC6_Yooz Token link")
            {
                ApplicationArea = All;
            }
        }
        addafter("Prices Including VAT")
        {
            field("BC6_Vendor Posting Group2"; Rec."Vendor Posting Group")
            {
                ApplicationArea = All;
            }
            field("BC6_Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
        }
        addfirst(FactBoxes)
        {
            part("Montants Document"; "BC6_Purchase Doc. Factbox")
            {
                Caption = 'Montants Document', Comment = 'FRA="Montants Document"';
                Provider = PurchLines;
                SubPageLink = "Document Type" = field("Document Type"), "No." = field("Document No.");
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify(Vendor)
        {
            Visible = false;
        }
        addbefore(Dimensions)
        {
            action(BC6_vendor)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendor', Comment = 'FRA="Fournisseur"';
                Enabled = Rec."Buy-from Vendor No." <> '';
                Image = Vendor;
                Promoted = true;
                RunObject = page "Vendor List";
                RunPageLink = "No." = field("Buy-from Vendor No."),
                                  "Date Filter" = field("Date Filter");
                ShortCutKey = 'Shift+F7';
            }
        }
        modify(SendApprovalRequest)
        {
            Caption = 'Send A&pproval Request', Comment = 'FRA="Approbation d''avoir"';
        }
        modify(CancelApprovalRequest)
        {
            Caption = 'Cancel Approval Re&quest', Comment = 'FRA="Annuler l''approbation"';
        }
        addfirst(Navigation)
        {
            group("BC6_Send mail")
            {
                Caption = 'Send mail', Comment = 'FRA="Envoi mail"';
                action("BC6_Send mail credit memo")
                {
                    Caption = 'Send mail credit memo', Comment = 'FRA="Envoi mail avoir"';
                    ApplicationArea = All;
                    Image = SendMail;

                    trigger OnAction()
                    var
                        Lrec_Historic: Record "BC6_VSC historic";
                        Lrec_UserSetup: Record "User Setup";
                        Ltxt_Email: Text[50];
                        Ltxt_subject: Text[100];
                        Ltxt_body: Text[260];
                    begin
                        //Début Ajout JX-XAD le 15/01/2010
                        Lrec_Historic.INIT();
                        Lrec_Historic.Type := Lrec_Historic.Type::"Credit Memo";
                        Lrec_Historic."No." := Rec."No.";
                        Lrec_Historic."Date time" := CURRENTDATETIME;
                        Lrec_Historic.Description := CurrPage.PurchLines.PAGE.JX_InsertDescriptInHisto();
                        Lrec_Historic."User ID" := USERID;

                        // modif LAB du 16/12/2009
                        // ajout de la gestion du code utilisateur affecté sur l'historique envoi email

                        Lrec_Historic."Assigned User ID" := Rec."Assigned User ID";

                        //fin modif LAB du 16/12/2009BC6

                        Lrec_Historic.INSERT();

                        CR := 13;
                        LF := 10;
                        CRLF := FORMAT(CR, 0, '<CHAR>') + FORMAT(LF, 0, '<CHAR>');
                        Ltxt_subject := '* ' + Rec."Buy-from Vendor Name" + Text001 + Rec."No." + Text002;
                        Ltxt_body := 'Avoir';
                        Ltxt_Email := '';
                        if Lrec_UserSetup.GET(Rec."Assigned User ID") then
                            Ltxt_Email := Lrec_UserSetup."E-Mail";
                        CU_VSC_Mail.NewMessageAvoir(Ltxt_Email, '', Ltxt_subject, Ltxt_body, '', true, Rec, Rec."No.", Rec."Assigned User ID");
                    end;
                }
                action(BC6_Historic)
                {
                    Caption = 'Historic', Comment = 'FRA="Historique"';
                    ApplicationArea = All;
                    Image = History;

                    trigger OnAction()
                    var
                        Lrec_Historic: Record "BC6_VSC historic";
                        LForm_Historic: Page "BC6_VSC historic";
                    begin
                        //Début Ajout JX-XAD 15/01/2010
                        Lrec_Historic.SETFILTER(Lrec_Historic.Type, '%1', Lrec_Historic.Type::"Credit Memo");
                        Lrec_Historic.SETFILTER(Lrec_Historic."No.", '%1', Rec."No.");
                        LForm_Historic.SETTABLEVIEW(Lrec_Historic);
                        LForm_Historic.RUNMODAL();
                        //Fin Ajout JX-XAD 15/01/2010
                    end;
                }
            }
        }
    }

    var
        UserMgt: Codeunit "BC6_FunctionsMgt";
        CU_VSC_Mail: Codeunit "BC6_VSC_Mail";
        CR: Char;
        LF: Char;
        Text001: label '[NAV] Credit Memo No. ', Comment = 'FRA=" [NAV] Avoir N°"';
        Text002: label 'to validate', Comment = 'FRA=" à valider"';
        CRLF: Text[2];

    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Assigned User ID", UserMgt.jx_GetPurchasesFilter());
        Rec.FILTERGROUP(0);
    end;
}
