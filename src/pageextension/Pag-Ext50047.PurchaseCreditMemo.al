pageextension 50047 "BC6_PurchaseCreditMemo" extends "Purchase Credit Memo"
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

    //Unsupported feature: Property Modification (SourceTableView) on ""Purchase Credit Memo"(Page 52)".

    layout
    {
        modify("No.")
        {
            Importance = Promoted;
        }

        modify("Buy-from Contact")
        {
            Importance = Additional;
        }
        modify("Expected Receipt Date")
        {
            Importance = Promoted;
        }
        modify("Vendor Authorization No.")
        {
            Importance = Promoted;
        }

        modify(Status)
        {
            Importance = Promoted;
        }

        modify("Invoice Details")
        {
            Caption = 'Invoicing';
        }
        modify("Location Code")
        {
            Importance = Promoted;
        }
        modify("Shipping and Payment")
        {
            Caption = 'Shipping';
        }
        modify("Order Address Code")
        {
            QuickEntry = false;
        }

        modify("Pay-to Contact")
        {
            Importance = Additional;
        }

        modify(Control1904651607)
        {
            Visible = true;
        }
        modify(Control1903435607)
        {
            Visible = true;
        }

        modify(Control1905767507)
        {
            Visible = true;
        }
        modify("Buy-from Vendor No.")
        {
            Visible = false;
        }

        modify("Buy-from Vendor Name")
        {
            Visible = false;
        }

        modify("Posting Description")
        {
            Visible = false;
        }
        modify(Control88)
        {
            Visible = false;
        }
        modify("Buy-from County")
        {
            Visible = false;
        }

        modify("Buy-from Country/Region Code")
        {
            Visible = false;
        }

        modify("Posting Date")
        {
            Visible = false;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }

        modify("Payment Method Code")
        {
            Visible = false;
        }

        modify(Control71)
        {
            Visible = false;
        }
        modify(ShipToOptions)
        {
            Visible = false;
        }
        modify(Control69)
        {
            Visible = false;
        }

        modify(Control86)
        {
            Visible = false;
        }
        modify("Ship-to County")
        {
            Visible = false;
        }

        modify("Ship-to Country/Region Code")
        {
            Visible = false;
        }
        modify(Control84)
        {
            Visible = false;
        }
        modify("Pay-to County")
        {
            Visible = false;
        }

        modify("Pay-to Country/Region Code")
        {
            Visible = false;
        }

        modify("Attached Documents")
        {
            Visible = false;
        }
        modify(Control15)
        {
            Visible = false;
        }

        modify(IncomingDocAttachFactBox)
        {
            Visible = false;
        }

        modify(WorkflowStatus)
        {
            Visible = false;
        }

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
                Caption = 'Montants Document';
                Provider = PurchLines;
                SubPageLink = "Document Type" = field("Document Type"), "No." = field("Document No.");
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify(Statistics)
        {
            Promoted = true;
            PromotedCategory = Process;
        }
        modify(Vendor)
        {
            Visible = false;
        }
        addbefore(Dimensions)
        {
            action(BC6_vendor)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendor';
                Enabled = Rec."Buy-from Vendor No." <> '';
                Image = Vendor;
                Promoted = true;
                PromotedCategory = Category11;
                RunObject = page "Vendor List";
                RunPageLink = "No." = field("Buy-from Vendor No."),
                                  "Date Filter" = field("Date Filter");
                ShortCutKey = 'Shift+F7';
                ToolTip = 'View or edit detailed information about the vendor on the purchase document.';
            }
        }
        modify(Release)
        {
            Promoted = true;
            PromotedCategory = Process;
        }
        modify(SendApprovalRequest)
        {
            Caption = 'Send A&pproval Request';
        }
        modify(CancelApprovalRequest)
        {
            Caption = 'Cancel Approval Re&quest';
        }
        modify(Flow)
        {
            Caption = 'Post &Batch';
        }
        modify(Post)
        {
            Promoted = true;
            PromotedCategory = Process;
        }
        modify(PostAndPrint)
        {
            Promoted = true;
            PromotedCategory = Process;
        }
        modify(Approvals)
        {
            Visible = false;
        }
        modify(DocAttach)
        {
            Visible = false;
        }
        modify(Approval)
        {
            Visible = false;
        }
        modify(Approve)
        {
            Visible = false;
        }
        modify(Reject)
        {
            Visible = false;
        }
        modify(Delegate)
        {
            Visible = false;
        }
        modify(Comment)
        {
            Visible = false;
        }
        modify(IncomingDocument)
        {
            Visible = false;
        }
        modify(IncomingDocCard)
        {
            Visible = false;
        }
        modify(SelectIncomingDoc)
        {
            Visible = false;
        }
        modify(IncomingDocAttachFile)
        {
            Visible = false;
        }
        modify(RemoveIncomingDoc)
        {
            Visible = false;
        }
        modify(CreateFlow)
        {
            Visible = false;
        }
        modify(SeeFlows)
        {
            Visible = false;
        }
        modify(Preview)
        {
            Visible = false;
        }
        addfirst(Navigation)
        {
            group("BC6_Send mail")
            {
                Caption = 'Send mail';
                action("BC6_Send mail credit memo")
                {
                    Caption = 'Send mail credit memo';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Lrec_Historic: Record "BC6_VSC historic";
                        Lrec_UserSetup: Record "User Setup";
                        Ltxt_Email: Text[50];
                        Ltxt_subject: Text[100];
                        Ltxt_body: Text[1024];
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
                    Caption = 'Historic';
                    ApplicationArea = All;

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
        addafter(Dimensions)
        {
            action(BC6_Approbations)
            {
                Caption = 'Approvals';
                Image = Approvals;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                begin
                    ApprovalEntries.Setfilters(DATABASE::"Purchase Header", Rec."Document Type".AsInteger(), Rec."No.");
                    ApprovalEntries.RUN();
                end;
            }
        }
    }

    var
        UserMgt: Codeunit "BC6_FunctionsMgt";
        CU_VSC_Mail: Codeunit "BC6_VSC_Mail";
        CR: Char;
        LF: Char;
        Text001: label ' [NAV] Credit Memo No. ';
        Text002: label ' to validate';
        CRLF: Text[2];

    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Assigned User ID", UserMgt.jx_GetPurchasesFilter());
        Rec.FILTERGROUP(0);
    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        if Rec.GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
            if Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
                Rec.SETRANGE("Buy-from Vendor No.");
        CurrPage.UPDATE();
    end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE();
    end;
}
