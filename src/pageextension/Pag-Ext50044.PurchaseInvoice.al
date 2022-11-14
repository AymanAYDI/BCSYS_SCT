pageextension 50044 "BC6_PurchaseInvoice" extends "Purchase Invoice"
{
    PromotedActionCategories = 'Gérer,Processus,Editions,Naviguer';
    layout
    {
        modify("Buy-from Contact No.")
        {
            Importance = Additional;
        }
        modify("Assigned User ID")
        {
            Editable = true;
        }
        modify("Order Address Code")
        {
            Importance = Additional;
        }
        modify("VAT Bus. Posting Group")
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
            field("BC6_Status Code"; Rec."BC6_Status Code")
            {
                Caption = 'Code statut';
                Lookup = true;
                LookupPageID = "BC6_FAP Status list";
                ApplicationArea = All;
            }
            field("BC6_Status description"; Rec."BC6_Status description")
            {
                Caption = 'Libellé statut';
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Free comment"; Rec."BC6_Free comment")
            {
                ApplicationArea = All;
            }
            field("BC6_Free comment CDG"; Rec."BC6_Free comment CDG")
            {
                ApplicationArea = All;
            }
            field("BC6_Register amount"; Rec."BC6_Register amount")
            {
                Caption = 'Montant à enregistrer';
                ApplicationArea = All;
            }
        }
        addafter("Document Date")
        {
            field("BC6_Invoice receipt date"; Rec."BC6_Invoice receipt date")
            {
                ApplicationArea = All;
            }
            field("BC6_Creation date"; Rec."BC6_Creation date")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Responsibility Center")
        {
            field("BC6_Document Prepaid"; Rec."BC6_Document Prepaid")
            {
                Importance = Additional;
                ApplicationArea = All;
            }
            field("BC6_Amount Prepaid"; Rec."BC6_Amount Prepaid")
            {
                Importance = Additional;
                ApplicationArea = All;
            }
            field("BC6_Document Type Prepaid"; Rec."BC6_Document Type Prepaid")
            {
                ApplicationArea = All;
            }
            field("BC6_Document No. Prepaid"; Rec."BC6_Document No. Prepaid")
            {
                ApplicationArea = All;
            }
            field("BC6_Original user"; Rec."BC6_Original user")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter(Status)
        {
            field(BC6_Litige; Rec."BC6_Litige")
            {
                ApplicationArea = All;
            }
            field("BC6_BC No."; Rec."BC6_BC No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Yooz No."; Rec."BC6_Yooz No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Yooz Token link"; Rec."BC6_Yooz Token link")
            {
                ExtendedDatatype = URL;
                ApplicationArea = All;
            }
        }
        addafter("Pay-to Contact")
        {
            field("BC6_Vendor Posting Group"; Rec."Vendor Posting Group")
            {
                ApplicationArea = All;
            }
            field("BC6_Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
            field("BC6_VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
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
        modify(Vendor)
        {
            Visible = false;
        }
        modify("Co&mments")
        {
            Visible = false;
        }
        modify("Re&lease")
        {
            Promoted = true;
            PromotedCategory = Process;
            PromotedIsBig = true;
        }
        modify(Reopen)
        {
            Promoted = true;
            PromotedCategory = Process;
            PromotedIsBig = true;
        }
        modify(CalculateInvoiceDiscount)
        {
            Visible = false;
        }
        modify(MoveNegativeLines)
        {
            Visible = false;
        }
        modify(SendApprovalRequest)
        {
            Promoted = true;
            PromotedIsBig = true;
            PromotedCategory = Process;
        }
        modify(CancelApprovalRequest)
        {
            Promoted = true;
            PromotedCategory = Process;
            PromotedIsBig = true;
        }
        modify(CopyDocument)
        {
            Visible = false;
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Post)
        {
            Promoted = true;
            PromotedCategory = Process;
        }
        modify(TestReport)
        {
            Visible = false;
        }
        modify(PostAndPrint)
        {
            Promoted = true;
            PromotedCategory = Process;
        }
        modify(PostBatch)
        {
            Visible = false;
        }
        modify(RemoveFromJobQueue)
        {
            Visible = JobQueueVisible;
            Enabled = false;
        }
        modify("&Invoice")
        {
            Visible = false;
        }
        modify(DocAttach)
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
        modify(IncomingDocEmailAttachment)
        {
            Visible = false;
        }
        modify(RemoveIncomingDoc)
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
        modify(GetRecurringPurchaseLines)
        {
            Visible = false;
        }
        modify(Approvals)
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
        addafter(Dimensions)
        {
            action(BC6_Approbations)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Visible = false;
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
        addfirst(Release)
        {
            action(BC6_statics)
            {
                Caption = 'Statistics';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F7';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.CalcInvDiscForHeader();
                    Commit();
                    PAGE.RunModal(PAGE::"Purchase Statistics", Rec);
                    PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                end;
            }
        }
        addafter(CalculateInvoiceDiscount)
        {
            separator(Action133)
            {
            }
            action("BC6_Get St&d. Vend. Purchase Codes")
            {
                Caption = 'Get St&d. Vend. Purchase Codes';
                Ellipsis = true;
                Image = VendorCode;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                var
                    StdVendPurchCode: Record "Standard Vendor Purchase Code";
                begin
                    StdVendPurchCode.InsertPurchLines(Rec);
                end;
            }
        }
        addafter(CancelApprovalRequest)
        {
            separator(Action144)
            {
            }
            action("BC6_Payer ce document")
            {
                Caption = 'Payer ce document';
                Image = VendorPayment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    lPaymentMgt: Codeunit "BC6_Vendor Payments";
                begin
                    lPaymentMgt.CreatePaymentDoc(Rec);
                end;
            }
        }
        addafter(RemoveFromJobQueue)
        {
            group("BC6_Send mail")
            {
                Caption = 'Send mail';
                action("Envoi mail facture - Four non créé")
                {
                    Caption = 'Envoi mail facture - Four non créé';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Modif JX-AUD du 23/04/2013
                        CLEAR(Gform_FAPMail);
                        Gform_FAPMail.SETRECORD(Rec);
                        Gtext_ObjetMail := 'Fiche Fournisseur à créer + Devis à créer dans NAVISION';
                        Gtext_Param1 := '';
                        Gtext_Param2 := '';
                        Gtext_Param3 := '';
                        Gtext_Param1 := 'le fournisseur';
                        Gtext_Param2 := Rec."Buy-from Vendor No.";
                        Gtext_Param3 := 'n''a pas été créé.';
                        Gform_FAPMail.SetParam(Gtext_Param1, Gtext_Param2, Gtext_Param3, 1, Gtext_ObjetMail);
                        Gform_FAPMail.CAPTION := 'Envoi mail facture - Fourn non créé';
                        Gform_FAPMail.RUNMODAL();
                        //Fin Modif JX-AUD du 23/04/2013
                    end;
                }
                action("Envoi mail facture - DA à créer")
                {
                    Caption = 'Envoi mail facture - DA à créer';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Modif JX-AUD du 23/04/2013
                        CLEAR(Gform_FAPMail);
                        Gform_FAPMail.SETRECORD(Rec);
                        Gtext_ObjetMail := 'Devis à créer dans NAVISION';
                        Gtext_Param1 := '';
                        Gtext_Param2 := '';
                        Gtext_Param3 := '';
                        Gtext_Param1 := '';
                        Gtext_Param2 := '';
                        Gtext_Param3 := '';
                        Gform_FAPMail.SetParam(Gtext_Param1, Gtext_Param2, Gtext_Param3, 2, Gtext_ObjetMail);
                        Gform_FAPMail.CAPTION := 'Envoi mail facture - DA à créer';
                        //Gform_FAPMail.RUNMODAL;
                        Gform_FAPMail.RUNMODAL();
                        //Fin Modif JX-AUD du 23/04/2013
                    end;
                }
                action("Envoi mail facture - DA non envoyé en appro.")
                {
                    Caption = 'Envoi mail facture - DA non envoyé en appro.';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Modif JX-AUD du 23/04/2013
                        CLEAR(Gform_FAPMail);
                        Gform_FAPMail.SETRECORD(Rec);
                        Gtext_ObjetMail := 'Devis à envoyer en approbation dans NAVISION';
                        Gtext_Param1 := '';
                        Gtext_Param2 := '';
                        Gtext_Param3 := '';
                        Gtext_Param1 := 'le devis';
                        Gtext_Param2 := 'DAXXXXX';
                        Gtext_Param3 := 'n''a pas été envoyé en approbation';
                        Gform_FAPMail.SetParam(Gtext_Param1, Gtext_Param2, Gtext_Param3, 3, Gtext_ObjetMail);
                        Gform_FAPMail.CAPTION := 'Envoi mail facture - DA non envoyé en appro.';
                        Gform_FAPMail.RUNMODAL();
                        //Fin Modif JX-AUD du 23/04/2013
                    end;
                }
                action("Envoi mail facture - DA non approuvée")
                {
                    Caption = 'Envoi mail facture - DA non approuvée';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Modif JX-AUD du 23/04/2013
                        CLEAR(Gform_FAPMail);
                        Gform_FAPMail.SETRECORD(Rec);
                        Gtext_ObjetMail := 'Devis à approuver dans NAVISION';
                        Gtext_Param1 := '';
                        Gtext_Param2 := '';
                        Gtext_Param3 := '';
                        Gtext_Param1 := 'le devis';
                        Gtext_Param2 := 'DAXXXXX';
                        Gtext_Param3 := 'n''est pas approuvé';
                        Gform_FAPMail.SetParam(Gtext_Param1, Gtext_Param2, Gtext_Param3, 4, Gtext_ObjetMail);
                        Gform_FAPMail.CAPTION := 'Envoi mail facture - DA non approuvée';
                        Gform_FAPMail.RUNMODAL();
                        //Fin Modif JX-AUD du 23/04/2013
                    end;
                }
                action("BC6_Envoi mail facture - DA non tranform.")
                {
                    Caption = 'Envoi mail facture - DA non tranform.';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Modif JX-AUD du 23/04/2013
                        CLEAR(Gform_FAPMail);
                        Gform_FAPMail.SETRECORD(Rec);
                        Gtext_ObjetMail := 'Devis à transformer en BC et à réceptionner dans NAVISION';
                        Gtext_Param1 := '';
                        Gtext_Param2 := '';
                        Gtext_Param3 := '';
                        Gtext_Param1 := 'Le devis';
                        Gtext_Param2 := 'DAXXXXX';
                        Gtext_Param3 := 'n''a pas été transformé en Bon de commande';
                        Gform_FAPMail.SetParam(Gtext_Param1, Gtext_Param2, Gtext_Param3, 5, Gtext_ObjetMail);
                        Gform_FAPMail.CAPTION := 'Envoi mail facture - DA non tranform.';
                        Gform_FAPMail.RUNMODAL();
                        //Fin Modif JX-AUD du 23/04/2013
                    end;
                }
                action("BC6_Send mail invoice")
                {
                    Caption = 'Send mail invoice';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Modif JX-AUD du 23/04/2013
                        CLEAR(Gform_FAPMail);
                        Gform_FAPMail.SETRECORD(Rec);
                        Gtext_ObjetMail := 'Devis complémentaire à créer dans NAVISION';
                        Gtext_Param1 := '';
                        Gtext_Param2 := '';
                        Gtext_Param3 := '';
                        Gtext_Param1 := 'BON DE COMMANDE';
                        Gtext_Param2 := 'CAXXXXX';
                        Gtext_Param3 := '= <MONTANT1> euros pour une FACTURE= <MONTANT2> euros d''où un écart de <MONTANT3> euros';
                        Gform_FAPMail.SetParam(Gtext_Param1, Gtext_Param2, Gtext_Param3, 6, Gtext_ObjetMail);
                        Gform_FAPMail.CAPTION := 'Envoi mail facture - DA cplmt.';
                        Gform_FAPMail.RUNMODAL();
                        //Fin Modif JX-AUD du 23/04/2013
                    end;
                }
                action("Envoi mail facture - BC à récept.")
                {
                    Caption = 'Envoi mail facture - BC à récept.';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Modif JX-AUD du 23/04/2013
                        CLEAR(Gform_FAPMail);
                        Gform_FAPMail.SETRECORD(Rec);
                        Gtext_ObjetMail := 'BC à réceptionner dans NAVISION';
                        Gtext_Param1 := '';
                        Gtext_Param2 := '';
                        Gtext_Param3 := '';
                        Gtext_Param1 := 'BON DE COMMANDE';
                        Gtext_Param2 := 'CAXXXXX';
                        Gtext_Param3 := 'non réceptionné';
                        Gform_FAPMail.SetParam(Gtext_Param1, Gtext_Param2, Gtext_Param3, 7, Gtext_ObjetMail);
                        Gform_FAPMail.CAPTION := 'Envoi mail facture - BC à récept.';
                        Gform_FAPMail.RUNMODAL();
                        //Fin Modif JX-AUD du 23/04/2013
                    end;
                }
                action("Envoi mail facture - Fact. à approuver")
                {
                    Caption = 'Envoi mail facture - Fact. à approuver';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Modif JX-AUD du 23/04/2013
                        CLEAR(Gform_FAPMail);
                        Gform_FAPMail.SETRECORD(Rec);
                        Gtext_ObjetMail := 'Facture à approuver dans NAVISION';
                        Gtext_Param1 := '';
                        Gtext_Param2 := '';
                        Gtext_Param3 := '';
                        Gtext_Param1 := '';
                        Gtext_Param2 := '';
                        Gtext_Param3 := '';
                        Gform_FAPMail.SetParam(Gtext_Param1, Gtext_Param2, Gtext_Param3, 8, Gtext_ObjetMail);
                        Gform_FAPMail.CAPTION := 'Envoi mail facture - Fact. à approuver';
                        //Gform_FAPMail.RUNMODAL;
                        Gform_FAPMail.RUNMODAL();
                        //Fin Modif JX-AUD du 23/04/2013
                    end;
                }
                action("Envoi mail facture - Factures Presta Timé")
                {
                    Caption = 'Envoi mail facture - Factures Presta Timé';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Modif JX-AUD du 23/04/2013
                        CLEAR(Gform_FAPMail);
                        Gform_FAPMail.SETRECORD(Rec);
                        Gtext_ObjetMail := 'Factures Presta Timé';
                        Gtext_Param2 := 'CAXXXXX';
                        Gtext_Param3 := '<NOMBRE1> jours pour une facture = <NOMBRE2> jours';
                        Gtext_Param1 := '';
                        Gform_FAPMail.SetParam(Gtext_Param1, Gtext_Param2, Gtext_Param3, 9, Gtext_ObjetMail);
                        Gform_FAPMail.CAPTION := 'Envoi mail facture - Factures Presta Timé';
                        //Gform_FAPMail.RUNMODAL;
                        Gform_FAPMail.RUNMODAL();
                        //Fin Modif JX-AUD du 23/04/2013
                    end;
                }
                action(BC6_Historique)
                {
                    Caption = 'Historic';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Lrec_Historic: Record "BC6_VSC historic";
                        LForm_Historic: Page "BC6_VSC historic";
                    begin
                        //Début Ajout JX-XAD 20/11/2009
                        Lrec_Historic.SETFILTER(Lrec_Historic.Type, '%1|%2', Lrec_Historic.Type::Invoice, Lrec_Historic.Type::Receipt);
                        Lrec_Historic.SETFILTER(Lrec_Historic."No.", '%1', Rec."No.");
                        LForm_Historic.SETTABLEVIEW(Lrec_Historic);
                        LForm_Historic.RUNMODAL();
                        //Fin Ajout JX-XAD 20/11/2009
                    end;
                }
            }
        }
        addbefore("Co&mments")
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
    }

    var
        Grec_ApprovalEntry: Record "Approval Entry";
        Grec_RcptPurchLine: Record "Purch. Rcpt. Line";
        Grec_PurchaseLine: Record "Purchase Line";
        Grec_PurchPaySetup: Record "Purchases & Payables Setup";
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        Gform_FAPMail: Page "BC6_New Mail FAP";
        [InDataSet]
        JobQueueVisible: Boolean;
        Grec_MontantApprobation: Decimal;
        Grec_MontantFacture: Decimal;
        Grec_MontantMax: Decimal;
        Gint_cptLine: Integer;
        Text004: label 'This invoice was recorded without reconciliation with a BC, you must submit it for validation';
        Text005: label 'Validation is not possible without new approval.';
        Text006: label 'Validation is not possible because the status of your invoice is "%1".';
        Gtext_ObjetMail: Text[1024];
        Gtext_Param1: Text[1024];
        Gtext_Param2: Text[1024];
        Gtext_Param3: Text[1024];

    var
        UserMgt: Codeunit "BC6_FunctionsMgt";

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

    procedure VerifierLigneRcpt(): Boolean
    begin
        //Modif JX-AUD du 25/10/11
        Gint_cptLine := 0;
        Grec_MontantFacture := 0;
        Grec_MontantApprobation := 0;
        Grec_PurchPaySetup.GET('');
        Grec_MontantMax := Grec_PurchPaySetup."BC6_Max. Amount allowed";

        //Vérification si la facture est au statut lancé et vérification montant approbation ou facture réouverte
        if ((Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Open)) then begin
            //calcul du montant de la facture
            Grec_PurchaseLine.SETFILTER(Grec_PurchaseLine."Document No.", Rec."No.");
            if Grec_PurchaseLine.FIND('-') then
                //MESSAGE(FORMAT(Grec_PurchaseLine.COUNT));
                repeat
                    Grec_MontantFacture += Grec_PurchaseLine."Line Amount";
                until Grec_PurchaseLine.NEXT() = 0;

            Grec_ApprovalEntry.SETFILTER(Grec_ApprovalEntry."Table ID", '38');
            Grec_ApprovalEntry.SETFILTER(Grec_ApprovalEntry."Document No.", Rec."No.");
            Grec_ApprovalEntry.SETFILTER(Grec_ApprovalEntry."Document Type", FORMAT(Grec_ApprovalEntry."Document Type"::Invoice));
            Grec_ApprovalEntry.SETFILTER(Grec_ApprovalEntry.Status, FORMAT(Grec_ApprovalEntry.Status::Approved));

            if Grec_ApprovalEntry.FIND('-') then   //si statut ouvert et lignes approbation présentes
            begin
                if Grec_ApprovalEntry.FIND('+') then
                    Grec_MontantApprobation += Grec_ApprovalEntry.Amount
                else begin
                    MESSAGE(Text005);
                    exit(false);
                end;

                if not (Grec_MontantFacture = Grec_MontantApprobation) then begin
                    MESSAGE(Text005);
                    exit(false);
                end else
                    exit(true);
            end;
        end;

        if ((Rec.Status = Rec.Status::"Pending Approval") or (Rec.Status = Rec.Status::"Pending Prepayment")) then begin
            MESSAGE(Text006, Rec.Status);
            exit(false);
        end;

        //MESSAGE(FORMAT(Grec_MontantMax));
        if Rec.Status = Rec.Status::Open then begin
            //MESSAGE(FORMAT(Grec_PurchPaySetup."Max. Amount allowed"));
            Grec_PurchaseLine.SETFILTER(Grec_PurchaseLine."Document No.", Rec."No.");
            if Grec_PurchaseLine.FIND('-') then
                //MESSAGE(FORMAT(Grec_PurchaseLine.COUNT));
                repeat

                    //MESSAGE(FORMAT(Grec_PurchaseLine.Type) + '  ' +Grec_PurchaseLine."No.");
                    if (((Grec_PurchaseLine.Type = Grec_PurchaseLine.Type::" ") and (Grec_PurchaseLine."No." = ''))
                    or ((Grec_PurchaseLine.Type <> Grec_PurchaseLine.Type::" ") and (Grec_PurchaseLine."No." = ''))) then begin
                        //MESSAGE('OK');
                    end else
                        //traiter si le numéro de reception est renseigné et qu'il existe bien dans les lignes de reception achat
                        if not Grec_RcptPurchLine.GET(Grec_PurchaseLine."Receipt No.", Grec_PurchaseLine."Receipt Line No.") then
                            //traiter si le montant est inférieur ou égal au montant de paramétrage achat
                            if Grec_PurchaseLine."Line Amount" > Grec_MontantMax then begin
                                //MESSAGE('Montant supérieur ' + FORMAT(Grec_PurchaseLine."Line Amount"));
                                MESSAGE(Text004);
                                Gint_cptLine += 1;
                                exit(false);
                            end else
                                //MESSAGE('Montant inférieur à 10 ' + FORMAT(Grec_PurchaseLine."Line Amount"));
                                if Gint_cptLine > 1 then begin
                                    MESSAGE(Text004);
                                    exit(false);
                                end;
                until Grec_PurchaseLine.NEXT() = 0;
        end;
        //Status := Status::Released;
        //Rec.MODIFY;
        exit(true);
        //Fin modif JX-AUd du 25/10/11
    end;
}
