report 50012 "BC6_Relevé Fournisseurs"
{
    // CREATION JX-XAD LE 01/09/2008
    // Cet état, prévu pour être utilisé lors des relances fournisseurs, doit faire apparaître, par fournisseur :
    // - Les commandes en cours non facturées : lancées et réceptionnées.
    // - Les factures enregistrées : non approuvées, approuvées, approuvées et en cours de règlement, approuvées et réglées.
    // 
    // //Modif LAB du 15/12/08
    // //Ajout du numéro de facture NAV sur lignes factures en cours de saisie et en cours d'approbation
    // 
    // //modif AUD du 22/04/2009
    // //traduction des champs Anglais/Français
    // 
    // AJOUT JX-XAD le 06/01/2010
    // Ajout de la colonne N° Commande et mise en format paysage
    // Appel aux fonctions du codeunit 50004 dans les sections "Factures approuvées", "Facture non approuvées",
    // "Ecritures fournisseur 3" et "Ecritures fournisseur 4".
    // 
    // AJOUT JX-XAD le 15/02/2010
    // Ajout des mêmes écritures pour les avoirs que pour les factures
    // 
    // MODIF JX-XAD le 17/03/2010
    // Les dates de factures et d'avoirs doivent correspondre à la date de document et non à la date de compta.
    // 
    // //JX-AUD du 13/05/2013
    // //Agrandissement logo
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/RelevéFournisseurs.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Relevé Fournisseurs';
    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(Text003_____Gtxt_FournisseurFilter; Text003 + ' ' + Gtxt_FournisseurFilter)
            {
            }
            column(Text002; Text002)
            {
            }
            column("USERID"; USERID)
            {
            }
            column(FORMAT_TODAY_; FORMAT(TODAY))
            {
            }
            column(Text004_____FORMAT_TIME_; Text004 + ' ' + FORMAT(TIME))
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(Fournisseur_Fournisseur__No__; Vendor."No.")
            {
            }
            column(Fournisseur_Fournisseur_Name; Vendor.Name)
            {
            }
            column(Gdec_TotalFactApprTTC_Gdec_MontantFactEnreg1TTC; Gdec_TotalFactApprTTC + Gdec_MontantFactEnreg1TTC)
            {
            }
            column(Reminder_of_the_selectionCaption; Reminder_of_the_selectionCaptionLbl)
            {
            }
            column(Date__Caption; Date__CaptionLbl)
            {
            }
            column(User__Caption; User__CaptionLbl)
            {
            }
            column(Vendor__Caption; Vendor__CaptionLbl)
            {
            }
            column(Total_payment_amount_including_VATCaption; Total_payment_amount_including_VATCaptionLbl)
            {
            }
            column(bLigRecep; bLigRecep)
            {
            }
            column(bFacNonApp; bFacNonApp)
            {
            }
            column(bFacApp; bFacApp)
            {
            }
            column(bEcrFrs3; bEcrFrs3)
            {
            }
            column(bEcrFrs4; bEcrFrs4)
            {
            }
            column(bAvNonApp; bAvNonApp)
            {
            }
            column(bAvApp; bAvApp)
            {
            }
            column(bEcrFrs5; bEcrFrs5)
            {
            }
            column(bEcrFrs6; bEcrFrs6)
            {
            }
            dataitem("Cdes en cours non facturées"; 2000000026)
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                PrintOnlyIfDetail = true;
                column(CURRENT_ORDERS_NOT_INVOICEDCaption; CURRENT_ORDERS_NOT_INVOICEDCaptionLbl)
                {
                }
                column("Cdes_en_cours_non_facturées_Number"; Number)
                {
                }
                dataitem("Commande réceptionnée"; 38)
                {
                    DataItemLink = "Pay-to Vendor No." = FIELD("No.");
                    DataItemLinkReference = Vendor;
                    DataItemTableView = SORTING("Document Type", "Buy-from Vendor No.", "No.") WHERE("Document Type" = CONST(Order));
                    PrintOnlyIfDetail = true;
                    column("Gdec_MontantTotalRéception"; Gdec_MontantTotalRéception)
                    {
                    }
                    column(Orders_receivedCaption; Orders_receivedCaptionLbl)
                    {
                    }
                    column(AmountCaption; AmountCaptionLbl)
                    {
                    }
                    column(Receipt_DateCaption; Receipt_DateCaptionLbl)
                    {
                    }
                    column(Item_descriptionCaption; Item_descriptionCaptionLbl)
                    {
                    }
                    column(Order_No_Caption; Order_No_CaptionLbl)
                    {
                    }
                    column(HT_Total_AmountCaption; HT_Total_AmountCaptionLbl)
                    {
                    }
                    column("Commande_réceptionnée_Document_Type"; "Document Type")
                    {
                    }
                    column("Commande_réceptionnée_No_"; "No.")
                    {
                    }
                    column("Commande_réceptionnée_Pay_to_Vendor_No_"; "Pay-to Vendor No.")
                    {
                    }
                    dataitem("Purch. Rcpt. Line"; 121)
                    {
                        DataItemLink = "Order No." = FIELD("No.");
                        DataItemTableView = SORTING("Order No.", "Order Line No.") WHERE("Qty. Rcd. Not Invoiced" = FILTER(<> 0));
                        column("Lignes_réceptionnées__Lignes_réceptionnées__Description"; "Purch. Rcpt. Line".Description)
                        {
                        }
                        column("Lignes_réceptionnées__Lignes_réceptionnées___Posting_Date_"; "Purch. Rcpt. Line"."Posting Date")
                        {
                        }
                        column("Gdec_MontantLigneRéception"; Gdec_MontantLigneRéception)
                        {
                        }
                        column("Commande_réceptionnée___No__"; "Commande réceptionnée"."No.")
                        {
                        }
                        column("Lignes_réceptionnées_Document_No_"; "Document No.")
                        {
                        }
                        column("Lignes_réceptionnées_Line_No_"; "Line No.")
                        {
                        }
                        column("Lignes_réceptionnées_Order_No_"; "Order No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            Gdec_MontantLigneRéception := "Purch. Rcpt. Line"."Direct Unit Cost" * "Purch. Rcpt. Line"."Qty. Rcd. Not Invoiced";
                            Gdec_MontantTotalRéception += Gdec_MontantLigneRéception;
                        end;
                    }

                    trigger OnPreDataItem()
                    begin
                        Gdec_MontantTotalRéception := 0;
                    end;
                }
            }
            dataitem("Factures en cours"; 2000000026)
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                PrintOnlyIfDetail = true;
                column(CURRENT_INVOICESCaption; CURRENT_INVOICESCaptionLbl)
                {
                }
                column(Factures_en_cours_Number; Number)
                {
                }
                dataitem("Factures non approuvées"; 38)
                {
                    DataItemLink = "Pay-to Vendor No." = FIELD("No.");
                    DataItemLinkReference = Vendor;
                    DataItemTableView = SORTING("Document Type", "Buy-from Vendor No.", "No.") WHERE("Document Type" = CONST(Invoice), Status = FILTER(Open | "Pending Approval"));
                    column("Factures_non_approuvées__Factures_non_approuvées___Due_Date_"; "Factures non approuvées"."Due Date")
                    {
                    }
                    column(Gdec_TotalTTCDocument; Gdec_TotalTTCDocument)
                    {
                    }
                    column(Gdec_TotalHTDocument; Gdec_TotalHTDocument)
                    {
                    }
                    column("Factures_non_approuvées__Factures_non_approuvées___Vendor_Invoice_No__"; "Factures non approuvées"."Vendor Invoice No.")
                    {
                    }
                    column("Factures_non_approuvées__Factures_non_approuvées___Document_Date_"; "Factures non approuvées"."Document Date")
                    {
                    }
                    column("Factures_non_approuvées__Factures_non_approuvées__Status"; "Factures non approuvées".Status)
                    {
                    }
                    column(Gtext_DateTransmApprob; Gtext_DateTransmApprob)
                    {
                    }
                    column(Gtext_IdApprobateur; Gtext_IdApprobateur)
                    {
                    }
                    column("Factures_non_approuvées__No__"; "No.")
                    {
                    }
                    column(Gtxt_ListeCommandes; Gtxt_ListeCommandes)
                    {
                    }
                    column(Gdec_TotalFactNonApprTTC; Gdec_TotalFactNonApprTTC)
                    {
                    }
                    column(Invoices_entered_not_approvedCaption; Invoices_entered_not_approvedCaptionLbl)
                    {
                    }
                    column(Inv__DateCaption; Inv__DateCaptionLbl)
                    {
                    }
                    column(Invoice_No_Caption; Invoice_No_CaptionLbl)
                    {
                    }
                    column(AmountCaption_Control1000000037; AmountCaption_Control1000000037Lbl)
                    {
                    }
                    column(Amount_incl__VATCaption; Amount_incl__VATCaptionLbl)
                    {
                    }
                    column(Due_DateCaption; Due_DateCaptionLbl)
                    {
                    }
                    column(Transmission_date_to_the_approverCaption; Transmission_date_to_the_approverCaptionLbl)
                    {
                    }
                    column(ApproverCaption; ApproverCaptionLbl)
                    {
                    }
                    column(StatusCaption; StatusCaptionLbl)
                    {
                    }
                    column(Inv__NAVCaption; Inv__NAVCaptionLbl)
                    {
                    }
                    column(Order_No_Caption_Control1000000107; Order_No_Caption_Control1000000107Lbl)
                    {
                    }
                    column(TTC_Total_AmountCaption; TTC_Total_AmountCaptionLbl)
                    {
                    }
                    column("Factures_non_approuvées_Document_Type"; "Document Type")
                    {
                    }
                    column("Factures_non_approuvées_Pay_to_Vendor_No_"; "Pay-to Vendor No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        Gdec_TotalHTDocument := 0;
                        Gdec_TotalTTCDocument := 0;

                        // Calcul du montant total de la commande. Ce calcul doit être fait si les commandes ou factures se sont pas en statut Lancé
                        Grec_PurchaseLine.RESET();
                        Grec_PurchaseLine.SETFILTER(Grec_PurchaseLine."Document Type", '%1', "Factures non approuvées"."Document Type");
                        Grec_PurchaseLine.SETFILTER(Grec_PurchaseLine."Document No.", '%1', "Factures non approuvées"."No.");
                        IF Grec_PurchaseLine.FIND('-') THEN
                            REPEAT
                                Gdec_TotalHTDocument += Grec_PurchaseLine."Line Amount";
                                Gdec_TotalTTCDocument += Grec_PurchaseLine."Line Amount" + (Grec_PurchaseLine."Line Amount" * Grec_PurchaseLine."VAT %" / 100);
                            UNTIL Grec_PurchaseLine.NEXT() = 0;
                        Gdec_TotalFactNonApprTTC += Gdec_TotalTTCDocument;

                        Gtext_DateTransmApprob := '';
                        Gtext_IdApprobateur := '';
                        Grec_ApprovalEntry.SETFILTER(Grec_ApprovalEntry."Document No.", '%1', "Factures non approuvées"."No.");
                        Grec_ApprovalEntry.SETFILTER(Grec_ApprovalEntry.Status, '%1', Grec_ApprovalEntry.Status::Open);
                        IF Grec_ApprovalEntry.FIND('-') THEN BEGIN
                            Gtext_DateTransmApprob := FORMAT(Grec_ApprovalEntry."Date-Time Sent for Approval");
                            Gtext_IdApprobateur := FORMAT(Grec_ApprovalEntry."Approver ID");
                        END;

                        //DEBUT AJOUT JX-XAD le 06/01/2010
                        //Recherche des commandes liées à la facture
                        Gint_NbOrders := Gcu_linksBetweenDocuments.SearchOrdersFAP("Factures non approuvées"."No.", Gcode_Order);
                        Gtxt_ListeCommandes := '';

                        FOR i := 1 TO Gint_NbOrders DO BEGIN
                            IF i > 1 THEN
                                Gtxt_ListeCommandes += ' / ';
                            Gtxt_ListeCommandes += Gcode_Order[i];
                        END;
                        //FIN AJOUT JX-XAD le 06/01/2010
                    end;
                }
                dataitem("Factures approuvées"; 38)
                {
                    DataItemLink = "Pay-to Vendor No." = FIELD("No.");
                    DataItemLinkReference = Vendor;
                    DataItemTableView = SORTING("Document Type", "Buy-from Vendor No.", "No.") WHERE("Document Type" = FILTER(Invoice), Status = FILTER(Released));
                    column("Factures_approuvées__Factures_approuvées___Document_Date_"; "Factures approuvées"."Document Date")
                    {
                    }
                    column("Factures_approuvées__Factures_approuvées___Vendor_Invoice_No__"; "Factures approuvées"."Vendor Invoice No.")
                    {
                    }
                    column("Factures_approuvées__Factures_approuvées__Amount"; "Factures approuvées".Amount)
                    {
                    }
                    column("Factures_approuvées__Factures_approuvées___Amount_Including_VAT_"; "Factures approuvées"."Amount Including VAT")
                    {
                    }
                    column("Factures_approuvées__Factures_approuvées___Due_Date_"; "Factures approuvées"."Due Date")
                    {
                    }
                    column(Gtext_DateApprob; Gtext_DateApprob)
                    {
                    }
                    column(Gtext_IdApprobateur_Control1000000065; Gtext_IdApprobateur)
                    {
                    }
                    column("Factures_approuvées__No__"; "No.")
                    {
                    }
                    column(Gtxt_ListeCommandes_Control1000000114; Gtxt_ListeCommandes)
                    {
                    }
                    column(Gdec_TotalFactApprTTC; Gdec_TotalFactApprTTC)
                    {
                    }
                    column(Invoices_entered_and_approvedCaption; Invoices_entered_and_approvedCaptionLbl)
                    {
                    }
                    column(Inv__DateCaption_Control1000000042; Inv__DateCaption_Control1000000042Lbl)
                    {
                    }
                    column(No__InvoiceCaption; No__InvoiceCaptionLbl)
                    {
                    }
                    column(AmountCaption_Control1000000049; AmountCaption_Control1000000049Lbl)
                    {
                    }
                    column(Amount_incl__VATCaption_Control1000000050; Amount_incl__VATCaption_Control1000000050Lbl)
                    {
                    }
                    column(Due_DateCaption_Control1000000051; Due_DateCaption_Control1000000051Lbl)
                    {
                    }
                    column(Approval_dateCaption; Approval_dateCaptionLbl)
                    {
                    }
                    column(ApproverCaption_Control1000000053; ApproverCaption_Control1000000053Lbl)
                    {
                    }
                    column(Inv__NAVCaption_Control1000000106; Inv__NAVCaption_Control1000000106Lbl)
                    {
                    }
                    column(Order_No_Caption_Control1000000111; Order_No_Caption_Control1000000111Lbl)
                    {
                    }
                    column(TTC_Total_AmountCaption_Control1000000022; TTC_Total_AmountCaption_Control1000000022Lbl)
                    {
                    }
                    column("Factures_approuvées_Document_Type"; "Document Type")
                    {
                    }
                    column("Factures_approuvées_Pay_to_Vendor_No_"; "Pay-to Vendor No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        "Factures approuvées".CALCFIELDS("Factures approuvées".Amount);
                        "Factures approuvées".CALCFIELDS("Factures approuvées"."Amount Including VAT");

                        Gdec_TotalFactApprHT += "Factures approuvées".Amount;
                        Gdec_TotalFactApprTTC += "Factures approuvées"."Amount Including VAT";

                        Gtext_DateApprob := '';
                        Gtext_IdApprobateur := '';
                        Grec_ApprovalEntry.RESET();
                        Grec_ApprovalEntry.SETFILTER(Grec_ApprovalEntry."Document No.", "Factures approuvées"."No.");
                        Grec_ApprovalEntry.SETFILTER(Grec_ApprovalEntry.Status, '%1', Grec_ApprovalEntry.Status::Approved);
                        IF Grec_ApprovalEntry.FIND('+') THEN BEGIN
                            Gtext_IdApprobateur := FORMAT(Grec_ApprovalEntry."Approver ID");
                            Gtext_DateApprob := FORMAT(Grec_ApprovalEntry."Last Date-Time Modified");
                        END;

                        //DEBUT AJOUT JX-XAD le 06/01/2010
                        //Recherche des commandes liées à la facture
                        Gint_NbOrders := Gcu_linksBetweenDocuments.SearchOrdersFAP("Factures approuvées"."No.", Gcode_Order);
                        Gtxt_ListeCommandes := '';

                        FOR i := 1 TO Gint_NbOrders DO BEGIN
                            IF i > 1 THEN
                                Gtxt_ListeCommandes += ' / ';
                            Gtxt_ListeCommandes += Gcode_Order[i];
                        END;
                        //FIN AJOUT JX-XAD le 06/01/2010
                    end;
                }
            }
            dataitem("Factures enregistrées"; 2000000026)
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                PrintOnlyIfDetail = true;
                column(POSTED_INVOICESCaption; POSTED_INVOICESCaptionLbl)
                {
                }
                column("Factures_enregistrées_Number"; Number)
                {
                }
                dataitem("Factures en cours de régl."; 122)
                {
                    DataItemLink = "Pay-to Vendor No." = FIELD("No.");
                    DataItemLinkReference = Vendor;
                    DataItemTableView = SORTING("No.");
                    PrintOnlyIfDetail = true;
                    column(Gdec_MontantFactEnreg1TTC; Gdec_MontantFactEnreg1TTC)
                    {
                    }
                    column(AmountCaption_Control1000000069; AmountCaption_Control1000000069Lbl)
                    {
                    }
                    column(Invoices_approved_being_resolvedCaption; Invoices_approved_being_resolvedCaptionLbl)
                    {
                    }
                    column(Inv__DateCaption_Control1000000067; Inv__DateCaption_Control1000000067Lbl)
                    {
                    }
                    column(No__InvoiceCaption_Control1000000068; No__InvoiceCaption_Control1000000068Lbl)
                    {
                    }
                    column(Amount_incl__VATCaption_Control1000000070; Amount_incl__VATCaption_Control1000000070Lbl)
                    {
                    }
                    column(Due_DateCaption_Control1000000071; Due_DateCaption_Control1000000071Lbl)
                    {
                    }
                    column(Default_RIBCaption; Default_RIBCaptionLbl)
                    {
                    }
                    column(Slip_dateCaption; Slip_dateCaptionLbl)
                    {
                    }
                    column(Order_No_Caption_Control1000000112; Order_No_Caption_Control1000000112Lbl)
                    {
                    }
                    column(TTC_Total_AmountCaption_Control1000000035; TTC_Total_AmountCaption_Control1000000035Lbl)
                    {
                    }
                    column("Factures_en_cours_de_régl__No_"; "No.")
                    {
                    }
                    column("Factures_en_cours_de_régl__Pay_to_Vendor_No_"; "Pay-to Vendor No.")
                    {
                    }
                    dataitem("Ecriture fournisseur 3"; 25)
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Factures en cours de régl.";
                        DataItemTableView = SORTING("Document No.") WHERE("Document Type" = CONST(Invoice), Open = CONST(true));
                        PrintOnlyIfDetail = false;
                        column("Factures_en_cours_de_régl____Due_Date_"; "Factures en cours de régl."."Due Date")
                        {
                        }
                        column("Factures_en_cours_de_régl____Amount_Including_VAT_"; "Factures en cours de régl."."Amount Including VAT")
                        {
                        }
                        column("Factures_en_cours_de_régl___Amount"; "Factures en cours de régl.".Amount)
                        {
                        }
                        column("Factures_en_cours_de_régl____Vendor_Invoice_No__"; "Factures en cours de régl."."Vendor Invoice No.")
                        {
                        }
                        column("Factures_en_cours_de_régl____Document_Date_"; "Factures en cours de régl."."Document Date")
                        {
                        }
                        column(Gtxt_RIB; Gtxt_RIB)
                        {
                        }
                        column(Gtxt_DateBordereau; Gtxt_DateBordereau)
                        {
                        }
                        column(Gtxt_ListeCommandes_Control1000000115; Gtxt_ListeCommandes)
                        {
                        }
                        column(Ecriture_fournisseur_3_Entry_No_; "Entry No.")
                        {
                        }
                        column(Ecriture_fournisseur_3_Document_No_; "Document No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            "Factures en cours de régl.".CALCFIELDS("Factures en cours de régl.".Amount);
                            "Factures en cours de régl.".CALCFIELDS("Factures en cours de régl."."Amount Including VAT");

                            Gtxt_RIB := '';
                            Grec_VendorBankAccount.RESET();
                            //Grec_VendorBankAccount.SETFILTER(Grec_VendorBankAccount."Vendor No.",'%1',Fournisseur."Default Bank Account Code");
                            //IF Grec_VendorBankAccount.FIND('-') THEN
                            IF Grec_VendorBankAccount.GET("Ecriture fournisseur 3"."Vendor No.", Vendor."BC6_Default Bank Account Code") THEN
                                Gtxt_RIB := FORMAT(Grec_VendorBankAccount."Bank Branch No.") + ' ' + FORMAT(Grec_VendorBankAccount."Agency Code") + ' '
                                            + FORMAT(Grec_VendorBankAccount."Bank Account No.") + ' ' + FORMAT(Grec_VendorBankAccount."RIB Key");

                            Gtxt_DateBordereau := '';
                            Grec_PaymentLine.RESET();
                            Grec_PaymentLine.SETFILTER(Grec_PaymentLine."Applies-to ID", '%1', "Ecriture fournisseur 3"."Applies-to ID");
                            IF Grec_PaymentLine.FIND('-') THEN
                                IF Grec_PaymentHeader.GET(Grec_PaymentLine."No.") THEN
                                    Gtxt_DateBordereau := FORMAT(Grec_PaymentHeader."Document Date");

                            IF Gtxt_DateBordereau = '' THEN BEGIN
                                Grec_ArchivePaymentLine.RESET();
                                Grec_ArchivePaymentLine.SETFILTER(Grec_ArchivePaymentLine."Applies-to ID", '%1', "Ecriture fournisseur 3"."Applies-to ID");
                                IF Grec_ArchivePaymentLine.FIND('-') THEN
                                    IF Grec_ArchivePaymentHeader.GET(Grec_ArchivePaymentLine."No.") THEN
                                        Gtxt_DateBordereau := FORMAT(Grec_ArchivePaymentHeader."Document Date");
                            END;

                            Gdec_MontantFactEnreg1TTC += "Factures en cours de régl."."Amount Including VAT";

                            //DEBUT AJOUT JX-XAD le 08/01/2010
                            //Recherche des commandes liées à la facture
                            Gint_NbOrders := Gcu_linksBetweenDocuments.SearchOrdersFA("Factures en cours de régl."."No.", Gcode_Order);
                            Gtxt_ListeCommandes := '';

                            FOR i := 1 TO Gint_NbOrders DO BEGIN
                                IF i > 1 THEN
                                    Gtxt_ListeCommandes += ' / ';
                                Gtxt_ListeCommandes += Gcode_Order[i];
                            END;
                            //FIN AJOUT JX-XAD le 08/01/2010
                        end;
                    }

                }
                dataitem("Factures réglées"; 122)
                {
                    DataItemLink = "Pay-to Vendor No." = FIELD("No.");
                    DataItemLinkReference = Vendor;
                    DataItemTableView = SORTING("No.");
                    PrintOnlyIfDetail = true;
                    column(Gdec_MontantFactEnreg2TTC; Gdec_MontantFactEnreg2TTC)
                    {
                    }
                    column(Invoices_approved_and_resolvedCaption; Invoices_approved_and_resolvedCaptionLbl)
                    {
                    }
                    column(AmountCaption_Control1000000081; AmountCaption_Control1000000081Lbl)
                    {
                    }
                    column(Inv__DateCaption_Control1000000082; Inv__DateCaption_Control1000000082Lbl)
                    {
                    }
                    column(No__InvoiceCaption_Control1000000083; No__InvoiceCaption_Control1000000083Lbl)
                    {
                    }
                    column(Payment_DateCaption; Payment_DateCaptionLbl)
                    {
                    }
                    column(Payment_MethodCaption; Payment_MethodCaptionLbl)
                    {
                    }
                    column(RIBCaption; RIBCaptionLbl)
                    {
                    }
                    column(Amount_incl__VATCaption_Control1000000084; Amount_incl__VATCaption_Control1000000084Lbl)
                    {
                    }
                    column(Order_No_Caption_Control1000000113; Order_No_Caption_Control1000000113Lbl)
                    {
                    }
                    column(TTC_Total_AmountCaption_Control1000000072; TTC_Total_AmountCaption_Control1000000072Lbl)
                    {
                    }
                    column("Factures_réglées_No_"; "No.")
                    {
                    }
                    column("Factures_réglées_Pay_to_Vendor_No_"; "Pay-to Vendor No.")
                    {
                    }
                    dataitem("Ecriture fournisseur 4"; 25)
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemTableView = SORTING("Document No.") WHERE("Document Type" = CONST(Invoice), Open = CONST(false));
                        PrintOnlyIfDetail = false;
                        column("Factures_réglées___Payment_Method_Code_"; "Factures réglées"."Payment Method Code")
                        {
                        }
                        column("Factures_réglées___Amount_Including_VAT_"; "Factures réglées"."Amount Including VAT")
                        {
                        }
                        column("Factures_réglées__Amount"; "Factures réglées".Amount)
                        {
                        }
                        column("Factures_réglées___Vendor_Invoice_No__"; "Factures réglées"."Vendor Invoice No.")
                        {
                        }
                        column("Factures_réglées___Document_Date_"; "Factures réglées"."Document Date")
                        {
                        }
                        column("Gtxt_DateRèglement"; Gtxt_DateRèglement)
                        {
                        }
                        column(Gtxt_RIB_Control1000000098; Gtxt_RIB)
                        {
                        }
                        column(Gtxt_ListeCommandes_Control1000000116; Gtxt_ListeCommandes)
                        {
                        }
                        column(Ecriture_fournisseur_4_Entry_No_; "Entry No.")
                        {
                        }
                        column(Ecriture_fournisseur_4_Document_No_; "Document No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            "Factures réglées".CALCFIELDS("Factures réglées".Amount);
                            "Factures réglées".CALCFIELDS("Factures réglées"."Amount Including VAT");

                            // Recherche de la date de règlement et du RIB
                            Gtxt_RIB := '';
                            Gtxt_DateRèglement := '';

                            Grec_ArchivePaymentLine.RESET();

                            IF Grec_VendorLedgerEntry.GET("Ecriture fournisseur 4"."Closed by Entry No.") THEN
                                Gtxt_DateRèglement := FORMAT(Grec_VendorLedgerEntry."Posting Date");

                            Gdec_MontantFactEnreg2TTC += "Factures réglées"."Amount Including VAT";

                            //DEBUT AJOUT JX-XAD le 08/01/2010
                            //Recherche des commandes liées à la facture
                            Gint_NbOrders := Gcu_linksBetweenDocuments.SearchOrdersFA("Factures réglées"."No.", Gcode_Order);
                            Gtxt_ListeCommandes := '';

                            FOR i := 1 TO Gint_NbOrders DO BEGIN
                                IF i > 1 THEN
                                    Gtxt_ListeCommandes += ' / ';
                                Gtxt_ListeCommandes += Gcode_Order[i];
                            END;
                            //FIN AJOUT JX-XAD le 08/01/2010
                        end;
                    }
                }
            }
            dataitem("Avoirs en cours"; 2000000026)
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                PrintOnlyIfDetail = true;
                column(CURRENT_CREDIT_MEMOCaption; CURRENT_CREDIT_MEMOCaptionLbl)
                {
                }
                column(Avoirs_en_cours_Number; Number)
                {
                }
                dataitem("Avoirs non approuvés"; 38)
                {
                    DataItemLink = "Pay-to Vendor No." = FIELD("No.");
                    DataItemLinkReference = Vendor;
                    DataItemTableView = SORTING("Document Type", "Buy-from Vendor No.", "No.") WHERE("Document Type" = CONST("Credit Memo"), Status = FILTER(Open | "Pending Approval"));
                    column("Avoirs_non_approuvés__Avoirs_non_approuvés__Status"; "Avoirs non approuvés".Status)
                    {
                    }
                    column(Gtext_IdApprobateur_Control1000000121; Gtext_IdApprobateur)
                    {
                    }
                    column(Gtext_DateTransmApprob_Control1000000122; Gtext_DateTransmApprob)
                    {
                    }
                    column("Avoirs_non_approuvés__Avoirs_non_approuvés___Due_Date_"; "Avoirs non approuvés"."Due Date")
                    {
                    }
                    column(Gdec_TotalTTCDocument_Control1000000124; Gdec_TotalTTCDocument)
                    {
                    }
                    column(Gdec_TotalHTDocument_Control1000000125; Gdec_TotalHTDocument)
                    {
                    }
                    column("Avoirs_non_approuvés__Avoirs_non_approuvés___No__"; "Avoirs non approuvés"."No.")
                    {
                    }
                    column("Avoirs_non_approuvés__Avoirs_non_approuvés___Vendor_Cr__Memo_No__"; "Avoirs non approuvés"."Vendor Cr. Memo No.")
                    {
                    }
                    column("Avoirs_non_approuvés__Avoirs_non_approuvés___Document_Date_"; "Avoirs non approuvés"."Document Date")
                    {
                    }
                    column(Gdec_TotalAvoirNonApprTTC; Gdec_TotalAvoirNonApprTTC)
                    {
                    }
                    column(StatusCaption_Control1000000133; StatusCaption_Control1000000133Lbl)
                    {
                    }
                    column(ApproverCaption_Control1000000134; ApproverCaption_Control1000000134Lbl)
                    {
                    }
                    column(Transmission_date_to_the_approverCaption_Control1000000135; Transmission_date_to_the_approverCaption_Control1000000135Lbl)
                    {
                    }
                    column(Due_DateCaption_Control1000000136; Due_DateCaption_Control1000000136Lbl)
                    {
                    }
                    column(Amount_incl__VATCaption_Control1000000137; Amount_incl__VATCaption_Control1000000137Lbl)
                    {
                    }
                    column(AmountCaption_Control1000000138; AmountCaption_Control1000000138Lbl)
                    {
                    }
                    column(Credit_Memo_NAVCaption; Credit_Memo_NAVCaptionLbl)
                    {
                    }
                    column(Credit_Memo_No_Caption; Credit_Memo_No_CaptionLbl)
                    {
                    }
                    column(Credit_memo_entered_not_approvedCaption; Credit_memo_entered_not_approvedCaptionLbl)
                    {
                    }
                    column(CM_DateCaption; CM_DateCaptionLbl)
                    {
                    }
                    column(TTC_Total_AmountCaption_Control1000000130; TTC_Total_AmountCaption_Control1000000130Lbl)
                    {
                    }
                    column("Avoirs_non_approuvés_Document_Type"; "Document Type")
                    {
                    }
                    column("Avoirs_non_approuvés_Pay_to_Vendor_No_"; "Pay-to Vendor No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        Gdec_TotalHTDocument := 0;
                        Gdec_TotalTTCDocument := 0;

                        // Calcul du montant total de la commande. Ce calcul doit être fait si les commandes ou factures se sont pas en statut Lancé
                        Grec_PurchaseLine.RESET();
                        Grec_PurchaseLine.SETFILTER(Grec_PurchaseLine."Document Type", '%1', "Avoirs non approuvés"."Document Type");
                        Grec_PurchaseLine.SETFILTER(Grec_PurchaseLine."Document No.", '%1', "Avoirs non approuvés"."No.");
                        IF Grec_PurchaseLine.FIND('-') THEN
                            REPEAT
                                Gdec_TotalHTDocument += Grec_PurchaseLine."Line Amount";
                                Gdec_TotalTTCDocument += Grec_PurchaseLine."Line Amount" + (Grec_PurchaseLine."Line Amount" * Grec_PurchaseLine."VAT %" / 100);
                            UNTIL Grec_PurchaseLine.NEXT() = 0;
                        Gdec_TotalAvoirNonApprTTC += Gdec_TotalTTCDocument;

                        Gtext_DateTransmApprob := '';
                        Gtext_IdApprobateur := '';
                        Grec_ApprovalEntry.SETFILTER(Grec_ApprovalEntry."Document No.", '%1', "Avoirs non approuvés"."No.");
                        Grec_ApprovalEntry.SETFILTER(Grec_ApprovalEntry.Status, '%1', Grec_ApprovalEntry.Status::Open);
                        IF Grec_ApprovalEntry.FIND('-') THEN BEGIN
                            Gtext_DateTransmApprob := FORMAT(Grec_ApprovalEntry."Date-Time Sent for Approval");
                            Gtext_IdApprobateur := FORMAT(Grec_ApprovalEntry."Approver ID");
                        END;
                    end;
                }
                dataitem("Avoirs approuvés"; 38)
                {
                    DataItemLink = "Pay-to Vendor No." = FIELD("No.");
                    DataItemLinkReference = Vendor;
                    DataItemTableView = SORTING("Document Type", "Buy-from Vendor No.", "No.") WHERE("Document Type" = FILTER("Credit Memo"), Status = CONST(Released));
                    PrintOnlyIfDetail = false;
                    column("Avoirs_approuvés__Avoirs_approuvés___Due_Date_"; "Avoirs approuvés"."Due Date")
                    {
                    }
                    column("Avoirs_approuvés__Avoirs_approuvés___No__"; "Avoirs approuvés"."No.")
                    {
                    }
                    column("Avoirs_approuvés__Avoirs_approuvés___Vendor_Cr__Memo_No__"; "Avoirs approuvés"."Vendor Cr. Memo No.")
                    {
                    }
                    column("Avoirs_approuvés__Avoirs_approuvés___Document_Date_"; "Avoirs approuvés"."Document Date")
                    {
                    }
                    column(Gtext_DateApprob_Control1000000162; Gtext_DateApprob)
                    {
                    }
                    column(Gtext_IdApprobateur_Control1000000163; Gtext_IdApprobateur)
                    {
                    }
                    column("Avoirs_approuvés__Avoirs_approuvés__Amount"; "Avoirs approuvés".Amount)
                    {
                    }
                    column("Avoirs_approuvés__Avoirs_approuvés___Amount_Including_VAT_"; "Avoirs approuvés"."Amount Including VAT")
                    {
                    }
                    column(Gdec_TotalAvoirApprTTC; Gdec_TotalAvoirApprTTC)
                    {
                    }
                    column(ApproverCaption_Control1000000102; ApproverCaption_Control1000000102Lbl)
                    {
                    }
                    column(Approval_dateCaption_Control1000000144; Approval_dateCaption_Control1000000144Lbl)
                    {
                    }
                    column(Due_DateCaption_Control1000000145; Due_DateCaption_Control1000000145Lbl)
                    {
                    }
                    column(Amount_incl__VATCaption_Control1000000146; Amount_incl__VATCaption_Control1000000146Lbl)
                    {
                    }
                    column(AmountCaption_Control1000000147; AmountCaption_Control1000000147Lbl)
                    {
                    }
                    column(Credit_Memo_NAVCaption_Control1000000148; Credit_Memo_NAVCaption_Control1000000148Lbl)
                    {
                    }
                    column(Credit_memo_entered_and_approvedCaption; Credit_memo_entered_and_approvedCaptionLbl)
                    {
                    }
                    column(Credit_memo_No_Caption_Control1000000150; Credit_memo_No_Caption_Control1000000150Lbl)
                    {
                    }
                    column(CM_DateCaption_Control1000000151; CM_DateCaption_Control1000000151Lbl)
                    {
                    }
                    column(TTC_Total_AmountCaption_Control1000000165; TTC_Total_AmountCaption_Control1000000165Lbl)
                    {
                    }
                    column("Avoirs_approuvés_Document_Type"; "Document Type")
                    {
                    }
                    column("Avoirs_approuvés_Pay_to_Vendor_No_"; "Pay-to Vendor No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        "Avoirs approuvés".CALCFIELDS("Avoirs approuvés".Amount);
                        "Avoirs approuvés".CALCFIELDS("Avoirs approuvés"."Amount Including VAT");

                        Gdec_TotalAvoirApprHT += "Avoirs approuvés".Amount;
                        Gdec_TotalAvoirApprTTC += "Avoirs approuvés"."Amount Including VAT";

                        Gtext_DateApprob := '';
                        Gtext_IdApprobateur := '';
                        Grec_ApprovalEntry.RESET();
                        Grec_ApprovalEntry.SETFILTER(Grec_ApprovalEntry."Document No.", "Avoirs approuvés"."No.");
                        Grec_ApprovalEntry.SETFILTER(Grec_ApprovalEntry.Status, '%1', Grec_ApprovalEntry.Status::Approved);
                        IF Grec_ApprovalEntry.FIND('+') THEN BEGIN
                            Gtext_IdApprobateur := FORMAT(Grec_ApprovalEntry."Approver ID");
                            Gtext_DateApprob := FORMAT(Grec_ApprovalEntry."Last Date-Time Modified");
                        END;
                    end;
                }
            }
            dataitem("Avoirs enregistrés"; 2000000026)
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                PrintOnlyIfDetail = true;
                column(POSTED_CREDIT_MEMOCaption; POSTED_CREDIT_MEMOCaptionLbl)
                {
                }
                column("Avoirs_enregistrés_Number"; Number)
                {
                }
                dataitem("Avoirs non soldés"; 124)
                {
                    DataItemLink = "Pay-to Vendor No." = FIELD("No.");
                    DataItemLinkReference = Vendor;
                    DataItemTableView = SORTING("No.");
                    PrintOnlyIfDetail = true;
                    column(Gdec_MontantAvoirEnreg1TTC; Gdec_MontantAvoirEnreg1TTC)
                    {
                    }
                    column(Slip_dateCaption_Control1000000158; Slip_dateCaption_Control1000000158Lbl)
                    {
                    }
                    column(Default_RIBCaption_Control1000000167; Default_RIBCaption_Control1000000167Lbl)
                    {
                    }
                    column(Due_DateCaption_Control1000000168; Due_DateCaption_Control1000000168Lbl)
                    {
                    }
                    column(Amount_incl__VATCaption_Control1000000169; Amount_incl__VATCaption_Control1000000169Lbl)
                    {
                    }
                    column(Credit_memo_approved_being_resolvedCaption; Credit_memo_approved_being_resolvedCaptionLbl)
                    {
                    }
                    column(AmountCaption_Control1000000171; AmountCaption_Control1000000171Lbl)
                    {
                    }
                    column(CM_DateCaption_Control1000000174; CM_DateCaption_Control1000000174Lbl)
                    {
                    }
                    column(Credit_Memo_No_Caption_Control1000000175; Credit_Memo_No_Caption_Control1000000175Lbl)
                    {
                    }
                    column(TTC_Total_AmountCaption_Control1000000185; TTC_Total_AmountCaption_Control1000000185Lbl)
                    {
                    }
                    column("Avoirs_non_soldés_No_"; "No.")
                    {
                    }
                    column("Avoirs_non_soldés_Pay_to_Vendor_No_"; "Pay-to Vendor No.")
                    {
                    }
                    dataitem("Ecriture fournisseur 5"; 25)
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemTableView = SORTING("Document No.") WHERE("Document Type" = CONST("Credit Memo"), Open = CONST(true));
                        PrintOnlyIfDetail = false;
                        column(Gtxt_DateBordereau_Control1000000177; Gtxt_DateBordereau)
                        {
                        }
                        column(Gtxt_RIB_Control1000000178; Gtxt_RIB)
                        {
                        }
                        column("Avoirs_non_soldés___Due_Date_"; "Avoirs non soldés"."Due Date")
                        {
                        }
                        column("Avoirs_non_soldés___Amount_Including_VAT_"; "Avoirs non soldés"."Amount Including VAT")
                        {
                        }
                        column("Avoirs_non_soldés__Amount"; "Avoirs non soldés".Amount)
                        {
                        }
                        column("Avoirs_non_soldés___Vendor_Cr__Memo_No__"; "Avoirs non soldés"."Vendor Cr. Memo No.")
                        {
                        }
                        column("Avoirs_non_soldés___Document_Date_"; "Avoirs non soldés"."Document Date")
                        {
                        }
                        column(Ecriture_fournisseur_5_Entry_No_; "Entry No.")
                        {
                        }
                        column(Ecriture_fournisseur_5_Document_No_; "Document No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            "Avoirs non soldés".CALCFIELDS("Avoirs non soldés".Amount);
                            "Avoirs non soldés".CALCFIELDS("Avoirs non soldés"."Amount Including VAT");

                            Gtxt_RIB := '';
                            Grec_VendorBankAccount.RESET();
                            //Grec_VendorBankAccount.SETFILTER(Grec_VendorBankAccount."Vendor No.",'%1',Fournisseur."Default Bank Account Code");
                            //IF Grec_VendorBankAccount.FIND('-') THEN
                            IF Grec_VendorBankAccount.GET("Ecriture fournisseur 5"."Vendor No.", Vendor."BC6_Default Bank Account Code") THEN
                                Gtxt_RIB := FORMAT(Grec_VendorBankAccount."Bank Branch No.") + ' ' + FORMAT(Grec_VendorBankAccount."Agency Code") + ' '
                                            + FORMAT(Grec_VendorBankAccount."Bank Account No.") + ' ' + FORMAT(Grec_VendorBankAccount."RIB Key");

                            Gtxt_DateBordereau := '';
                            Grec_PaymentLine.RESET();
                            Grec_PaymentLine.SETFILTER(Grec_PaymentLine."Applies-to ID", '%1', "Ecriture fournisseur 3"."Applies-to ID");
                            IF Grec_PaymentLine.FIND('-') THEN
                                IF Grec_PaymentHeader.GET(Grec_PaymentLine."No.") THEN
                                    Gtxt_DateBordereau := FORMAT(Grec_PaymentHeader."Document Date");

                            IF Gtxt_DateBordereau = '' THEN BEGIN
                                Grec_ArchivePaymentLine.RESET();
                                Grec_ArchivePaymentLine.SETFILTER(Grec_ArchivePaymentLine."Applies-to ID", '%1', "Ecriture fournisseur 5"."Applies-to ID");
                                IF Grec_ArchivePaymentLine.FIND('-') THEN
                                    IF Grec_ArchivePaymentHeader.GET(Grec_ArchivePaymentLine."No.") THEN
                                        Gtxt_DateBordereau := FORMAT(Grec_ArchivePaymentHeader."Document Date");
                            END;

                            Gdec_MontantAvoirEnreg1TTC += "Avoirs non soldés"."Amount Including VAT";
                        end;
                    }
                }
                dataitem("Avoirs soldés"; 124)
                {
                    DataItemLink = "Pay-to Vendor No." = FIELD("No.");
                    DataItemLinkReference = Vendor;
                    DataItemTableView = SORTING("No.");
                    PrintOnlyIfDetail = true;
                    column(Gdec_MontantAvoirEnreg2TTC; Gdec_MontantAvoirEnreg2TTC)
                    {
                    }
                    column(Credit_memo_approved_and_resolvedCaption; Credit_memo_approved_and_resolvedCaptionLbl)
                    {
                    }
                    column(Amount_incl__VATCaption_Control1000000189; Amount_incl__VATCaption_Control1000000189Lbl)
                    {
                    }
                    column(AmountCaption_Control1000000190; AmountCaption_Control1000000190Lbl)
                    {
                    }
                    column(Credit_Memo_No_Caption_Control1000000191; Credit_Memo_No_Caption_Control1000000191Lbl)
                    {
                    }
                    column(CM_DateCaption_Control1000000192; CM_DateCaption_Control1000000192Lbl)
                    {
                    }
                    column(Payment_DateCaption_Control1000000193; Payment_DateCaption_Control1000000193Lbl)
                    {
                    }
                    column(Payment_MethodCaption_Control1000000194; Payment_MethodCaption_Control1000000194Lbl)
                    {
                    }
                    column(RIBCaption_Control1000000195; RIBCaption_Control1000000195Lbl)
                    {
                    }
                    column(TTC_Total_AmountCaption_Control1000000173; TTC_Total_AmountCaption_Control1000000173Lbl)
                    {
                    }
                    column("Avoirs_soldés_No_"; "No.")
                    {
                    }
                    column("Avoirs_soldés_Pay_to_Vendor_No_"; "Pay-to Vendor No.")
                    {
                    }
                    dataitem("Ecriture fournisseur 6"; 25)
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemTableView = SORTING("Document No.") WHERE("Document Type" = CONST("Credit Memo"), Open = CONST(false));
                        PrintOnlyIfDetail = false;
                        column(Gtxt_RIB_Control1000000101; Gtxt_RIB)
                        {
                        }
                        column("Avoirs_soldés___Payment_Method_Code_"; "Avoirs soldés"."Payment Method Code")
                        {
                        }
                        column("Gtxt_DateRèglement_Control1000000132"; Gtxt_DateRèglement)
                        {
                        }
                        column("Avoirs_soldés___Amount_Including_VAT_"; "Avoirs soldés"."Amount Including VAT")
                        {
                        }
                        column("Avoirs_soldés__Amount"; "Avoirs soldés".Amount)
                        {
                        }
                        column("Avoirs_soldés___Vendor_Cr__Memo_No__"; "Avoirs soldés"."Vendor Cr. Memo No.")
                        {
                        }
                        column("Avoirs_soldés___Document_Date_"; "Avoirs soldés"."Document Date")
                        {
                        }
                        column(Ecriture_fournisseur_6_Entry_No_; "Entry No.")
                        {
                        }
                        column(Ecriture_fournisseur_6_Document_No_; "Document No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            "Avoirs soldés".CALCFIELDS("Avoirs soldés".Amount);
                            "Avoirs soldés".CALCFIELDS("Avoirs soldés"."Amount Including VAT");

                            // Recherche de la date de règlement et du RIB
                            Gtxt_RIB := '';
                            Gtxt_DateRèglement := '';

                            Grec_ArchivePaymentLine.RESET();


                            IF Grec_VendorLedgerEntry.GET("Ecriture fournisseur 6"."Closed by Entry No.") THEN
                                Gtxt_DateRèglement := FORMAT(Grec_VendorLedgerEntry."Posting Date");

                            Gdec_MontantAvoirEnreg2TTC += "Avoirs soldés"."Amount Including VAT";
                        end;
                    }
                }
            }
            trigger OnAfterGetRecord()
            begin
                Gdec_TotalFactApprTTC := 0;
                Gdec_MontantFactEnreg1TTC := 0;

                bLigRecep := 0;
                bFacNonApp := 0;
                bFacApp := 0;
                bEcrFrs3 := 0;
                bEcrFrs4 := 0;
                bAvNonApp := 0;
                bAvApp := 0;
                bEcrFrs5 := 0;
                bEcrFrs6 := 0;

                CdeRecep.RESET();
                CdeRecep.SETCURRENTKEY("Document Type", "Buy-from Vendor No.");
                CdeRecep.SETRANGE("Document Type", CdeRecep."Document Type"::Order);
                CdeRecep.SETRANGE("Buy-from Vendor No.", "No.");
                IF CdeRecep.FINDFIRST() THEN
                    REPEAT
                        LigRecep.RESET();
                        LigRecep.SETRANGE("Document Type", LigRecep."Document Type"::Order);
                        LigRecep.SETRANGE("Document No.", CdeRecep."No.");
                        LigRecep.SETFILTER("Qty. Rcd. Not Invoiced", '<>%1', 0);
                        IF LigRecep.FINDFIRST() THEN
                            REPEAT
                                bLigRecep := 1;
                            UNTIL (LigRecep.NEXT() = 0) OR (bLigRecep <> 0)
                    UNTIL (CdeRecep.NEXT() = 0) OR (bLigRecep <> 0);

                FacNonApp.RESET();
                FacNonApp.SETRANGE("Document Type", FacNonApp."Document Type"::Invoice);
                FacNonApp.SETRANGE("Pay-to Vendor No.", "No.");
                FacNonApp.SETFILTER(Status, '%1|%2', FacNonApp.Status::Open, FacNonApp.Status::"Pending Approval");
                bFacNonApp := FacNonApp.COUNT;

                FacApp.RESET();
                FacApp.SETRANGE("Document Type", FacApp."Document Type"::Invoice);
                FacApp.SETRANGE("Pay-to Vendor No.", "No.");
                FacApp.SETRANGE(Status, FacApp.Status::Released);
                bFacApp := FacApp.COUNT;

                AvNonApp.RESET();
                AvNonApp.SETRANGE("Document Type", AvNonApp."Document Type"::"Credit Memo");
                AvNonApp.SETRANGE("Pay-to Vendor No.", "No.");
                AvNonApp.SETFILTER(Status, '%1|%2', AvNonApp.Status::Open, AvNonApp.Status::"Pending Approval");
                bAvNonApp := AvNonApp.COUNT;

                AvApp.RESET();
                AvApp.SETRANGE("Document Type", AvApp."Document Type"::"Credit Memo");
                AvApp.SETRANGE("Pay-to Vendor No.", "No.");
                AvApp.SETRANGE(Status, AvApp.Status::Released);
                bAvApp := AvApp.COUNT;

                VendLedger3.RESET();
                VendLedger3.SETCURRENTKEY("Document Type", "Vendor No.", "Posting Date", "Currency Code");
                VendLedger3.SETRANGE("Document Type", VendLedger3."Document Type"::Invoice);
                VendLedger3.SETRANGE("Vendor No.", "No.");
                VendLedger3.SETRANGE(Open, TRUE);
                bEcrFrs3 := VendLedger3.COUNT;

                VendLedger4.RESET();
                VendLedger4.SETCURRENTKEY("Document Type", "Vendor No.", "Posting Date", "Currency Code");
                VendLedger4.SETRANGE("Document Type", VendLedger4."Document Type"::Invoice);
                VendLedger4.SETRANGE("Vendor No.", "No.");
                VendLedger4.SETRANGE(Open, FALSE);
                bEcrFrs4 := VendLedger4.COUNT;

                VendLedger5.RESET();
                VendLedger5.SETCURRENTKEY("Document Type", "Vendor No.", "Posting Date", "Currency Code");
                VendLedger5.SETRANGE("Document Type", VendLedger5."Document Type"::"Credit Memo");
                VendLedger5.SETRANGE("Vendor No.", "No.");
                VendLedger5.SETRANGE(Open, TRUE);
                bEcrFrs5 := VendLedger5.COUNT;

                VendLedger6.RESET();
                VendLedger6.SETCURRENTKEY("Document Type", "Vendor No.", "Posting Date", "Currency Code");
                VendLedger6.SETRANGE("Document Type", VendLedger6."Document Type"::"Credit Memo");
                VendLedger6.SETRANGE("Vendor No.", "No.");
                VendLedger6.SETRANGE(Open, FALSE);
                bEcrFrs6 := VendLedger6.COUNT;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET();
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);

                Gtxt_FournisseurFilter := Vendor.GETFILTER(Vendor."No.");
            end;
        }
    }
    var
        Grec_ApprovalEntry: Record "Approval Entry";
        CompanyInfo: Record "Company Information";
        Grec_PaymentHeader: Record "Payment Header";
        Grec_ArchivePaymentHeader: Record "Payment Header Archive";
        Grec_PaymentLine: Record "Payment Line";
        Grec_ArchivePaymentLine: Record "Payment Line Archive";
        AvApp: Record "Purchase Header";
        AvNonApp: Record "Purchase Header";
        CdeRecep: Record "Purchase Header";
        FacApp: Record "Purchase Header";
        FacNonApp: Record "Purchase Header";
        Grec_PurchaseLine: Record "Purchase Line";
        LigRecep: Record "Purchase Line";
        Grec_VendorBankAccount: Record "Vendor Bank Account";
        Grec_VendorLedgerEntry: Record "Vendor Ledger Entry";
        VendLedger3: Record "Vendor Ledger Entry";
        VendLedger4: Record "Vendor Ledger Entry";
        VendLedger5: Record "Vendor Ledger Entry";
        VendLedger6: Record "Vendor Ledger Entry";
        Gcu_linksBetweenDocuments: Codeunit "BC6_links between documents";
        Gcode_Order: array[100] of Code[20];
        Gdec_MontantAvoirEnreg1TTC: Decimal;
        Gdec_MontantAvoirEnreg2TTC: Decimal;
        Gdec_MontantFactEnreg1TTC: Decimal;
        Gdec_MontantFactEnreg2TTC: Decimal;
        "Gdec_MontantLigneRéception": Decimal;
        "Gdec_MontantTotalRéception": Decimal;
        Gdec_TotalAvoirApprHT: Decimal;
        Gdec_TotalAvoirApprTTC: Decimal;
        Gdec_TotalAvoirNonApprTTC: Decimal;
        Gdec_TotalFactApprHT: Decimal;
        Gdec_TotalFactApprTTC: Decimal;
        Gdec_TotalFactNonApprTTC: Decimal;
        Gdec_TotalHTDocument: Decimal;
        Gdec_TotalTTCDocument: Decimal;
        bAvApp: Integer;
        bAvNonApp: Integer;
        bEcrFrs3: Integer;
        bEcrFrs4: Integer;
        bEcrFrs5: Integer;
        bEcrFrs6: Integer;
        bFacApp: Integer;
        bFacNonApp: Integer;
        bLigRecep: Integer;
        Gint_NbOrders: Integer;
        i: Integer;
        Amount_incl__VATCaption_Control1000000050Lbl: Label 'Amount incl. VAT', Comment = 'FRA="Montant TTC"';
        Amount_incl__VATCaption_Control1000000070Lbl: Label 'Amount incl. VAT', Comment = 'FRA="Montant TTC"';
        Amount_incl__VATCaption_Control1000000084Lbl: Label 'Amount incl. VAT', Comment = 'FRA="Montant TTC"';
        Amount_incl__VATCaption_Control1000000137Lbl: Label 'Amount incl. VAT', Comment = 'FRA="Montant TTC"';
        Amount_incl__VATCaption_Control1000000146Lbl: Label 'Amount incl. VAT', Comment = 'FRA="Montant TTC"';
        Amount_incl__VATCaption_Control1000000169Lbl: Label 'Amount incl. VAT', Comment = 'FRA="Montant TTC"';
        Amount_incl__VATCaption_Control1000000189Lbl: Label 'Amount incl. VAT', Comment = 'FRA="Montant TTC"';
        Amount_incl__VATCaptionLbl: Label 'Amount incl. VAT', Comment = 'FRA="Montant TTC"';
        AmountCaption_Control1000000037Lbl: Label 'Amount', Comment = 'FRA="Montant HT"';
        AmountCaption_Control1000000049Lbl: Label 'Amount', Comment = 'FRA="Montant HT"';
        AmountCaption_Control1000000069Lbl: Label 'Amount', Comment = 'FRA="Montant HT"';
        AmountCaption_Control1000000081Lbl: Label 'Amount', Comment = 'FRA="Montant HT"';
        AmountCaption_Control1000000138Lbl: Label 'Amount', Comment = 'FRA="Montant HT"';
        AmountCaption_Control1000000147Lbl: Label 'Amount', Comment = 'FRA="Montant HT"';
        AmountCaption_Control1000000171Lbl: Label 'Amount', Comment = 'FRA="Montant HT"';
        AmountCaption_Control1000000190Lbl: Label 'Amount', Comment = 'FRA="Montant HT"';
        AmountCaptionLbl: Label 'Amount', Comment = 'FRA="Montant HT"';
        Approval_dateCaption_Control1000000144Lbl: Label 'Approval date', Comment = 'FRA="Date d''approbation"';
        Approval_dateCaptionLbl: Label 'Approval date', Comment = 'FRA="Date d''approbation"';
        ApproverCaption_Control1000000053Lbl: Label 'Approver', Comment = 'FRA="Approbateur"';
        ApproverCaption_Control1000000102Lbl: Label 'Approver', Comment = 'FRA="Approbateur"';
        ApproverCaption_Control1000000134Lbl: Label 'Approver', Comment = 'FRA="Approbateur"';
        ApproverCaptionLbl: Label 'Approver', Comment = 'FRA="Approbateur"';
        CM_DateCaption_Control1000000151Lbl: Label 'CM Date', Comment = 'FRA="Date avoir"';
        CM_DateCaption_Control1000000174Lbl: Label 'CM Date', Comment = 'FRA="Date avoir"';
        CM_DateCaption_Control1000000192Lbl: Label 'CM Date', Comment = 'FRA="Date avoir"';
        CM_DateCaptionLbl: Label 'CM Date', Comment = 'FRA="Date avoir"';
        Credit_memo_approved_and_resolvedCaptionLbl: Label 'Credit memo approved and resolved', Comment = 'FRA="Avoirs saisis approuvés et soldés"';
        Credit_memo_approved_being_resolvedCaptionLbl: Label 'Credit memo approved being resolved', Comment = 'FRA="Avoirs saisis approuvés et soldés"';
        Credit_memo_entered_and_approvedCaptionLbl: Label 'Credit memo entered and approved', Comment = 'FRA="Avoirs saisis approuvés et soldés"';
        Credit_memo_entered_not_approvedCaptionLbl: Label 'Credit memo entered not approved', Comment = 'FRA="Avoirs saisis approuvés et soldés"';
        Credit_Memo_NAVCaption_Control1000000148Lbl: Label 'Credit Memo NAV', Comment = 'FRA="Avoir NAV"';
        Credit_Memo_NAVCaptionLbl: Label 'Credit Memo NAV', Comment = 'FRA="Avoir NAV"';
        Credit_memo_No_Caption_Control1000000150Lbl: Label 'Credit memo No.', Comment = 'FRA="N° avoir"';
        Credit_Memo_No_Caption_Control1000000175Lbl: Label 'Credit Memo No.', Comment = 'FRA="N° avoir"';
        Credit_Memo_No_Caption_Control1000000191Lbl: Label 'Credit Memo No.', Comment = 'FRA="N° avoir"';
        Credit_Memo_No_CaptionLbl: Label 'Credit Memo No.', Comment = 'FRA="N° avoir"';
        CURRENT_CREDIT_MEMOCaptionLbl: Label 'CURRENT CREDIT MEMO', Comment = 'FRA="AVOIRS EN COURS"';
        CURRENT_INVOICESCaptionLbl: Label 'CURRENT INVOICES', Comment = 'FRA="FACTURES EN COURS"';
        CURRENT_ORDERS_NOT_INVOICEDCaptionLbl: Label 'CURRENT ORDERS NOT INVOICED', Comment = 'FRA="COMMANDES EN COURS NON FACTUREES"';
        Date__CaptionLbl: Label 'Date :';
        Default_RIBCaption_Control1000000167Lbl: Label 'Default RIB', Comment = 'FRA="RIB par défaut"';
        Default_RIBCaptionLbl: Label 'Default RIB', Comment = 'FRA="RIB par défaut"';
        Due_DateCaption_Control1000000051Lbl: Label 'Due Date', Comment = 'FRA="Date d''échéance"';
        Due_DateCaption_Control1000000071Lbl: Label 'Due Date', Comment = 'FRA="Date d''échéance"';
        Due_DateCaption_Control1000000136Lbl: Label 'Due Date', Comment = 'FRA="Date d''échéance"';
        Due_DateCaption_Control1000000145Lbl: Label 'Due Date', Comment = 'FRA="Date d''échéance"';
        Due_DateCaption_Control1000000168Lbl: Label 'Due Date', Comment = 'FRA="Date d''échéance"';
        Due_DateCaptionLbl: Label 'Due Date', Comment = 'FRA="Date d''échéance"';
        HT_Total_AmountCaptionLbl: Label 'HT Total Amount', Comment = 'FRA="Montant Total HT"';
        Inv__DateCaption_Control1000000042Lbl: Label 'Inv. Date', Comment = 'FRA="Date fact."';
        Inv__DateCaption_Control1000000067Lbl: Label 'Inv. Date', Comment = 'FRA="Date fact."';
        Inv__DateCaption_Control1000000082Lbl: Label 'Inv. Date', Comment = 'FRA="Date fact."';
        Inv__DateCaptionLbl: Label 'Inv. Date', Comment = 'FRA="Date fact."';
        Inv__NAVCaption_Control1000000106Lbl: Label 'Inv. NAV', Comment = 'FRA="Fact. NAV"';
        Inv__NAVCaptionLbl: Label 'Inv. NAV', Comment = 'FRA="Fact. NAV"';
        Invoice_No_CaptionLbl: Label 'Invoice No.', Comment = 'FRA="N° facture"';
        Invoices_approved_and_resolvedCaptionLbl: Label 'Invoices approved and resolved', Comment = 'FRA="Factures saisies approuvées et réglées"';
        Invoices_approved_being_resolvedCaptionLbl: Label 'Invoices approved being resolved', Comment = 'FRA="Factures saisies approuvées en cours de règlement"';
        Invoices_entered_and_approvedCaptionLbl: Label 'Invoices entered and approved', Comment = 'FRA="Factures saisies approuvées"';
        Invoices_entered_not_approvedCaptionLbl: Label 'Invoices entered not approved', Comment = 'FRA="Factures saisies non approuvées"';
        Item_descriptionCaptionLbl: Label 'Item description', Comment = 'FRA="Désignation de l''article"';
        No__InvoiceCaption_Control1000000068Lbl: Label 'No. Invoice', Comment = 'FRA="N° facture"';
        No__InvoiceCaption_Control1000000083Lbl: Label 'No. Invoice', Comment = 'FRA="N° facture"';
        No__InvoiceCaptionLbl: Label 'No. Invoice', Comment = 'FRA="N° facture"';
        Order_No_Caption_Control1000000107Lbl: Label 'Order No.', Comment = 'FRA="N° Commande"';
        Order_No_Caption_Control1000000111Lbl: Label 'Order No.', Comment = 'FRA="N° Commande"';
        Order_No_Caption_Control1000000112Lbl: Label 'Order No.', Comment = 'FRA="N° Commande"';
        Order_No_Caption_Control1000000113Lbl: Label 'Order No.', Comment = 'FRA="N° Commande"';
        Order_No_CaptionLbl: Label 'Order No.', Comment = 'FRA="N° Commande"';
        Orders_receivedCaptionLbl: Label 'Orders received', Comment = 'FRA="Commandes réceptionnées"';
        Payment_DateCaption_Control1000000193Lbl: Label 'Payment Date', Comment = 'FRA="Date de règlement"';
        Payment_DateCaptionLbl: Label 'Payment Date', Comment = 'FRA="Date de règlement"';
        Payment_MethodCaption_Control1000000194Lbl: Label 'Payment Method', Comment = 'FRA="Mode de règlement"';
        Payment_MethodCaptionLbl: Label 'Payment Method', Comment = 'FRA="Mode de règlement"';
        POSTED_CREDIT_MEMOCaptionLbl: Label 'POSTED CREDIT MEMO', Comment = 'FRA="AVOIRS ENREGISTRES"';
        POSTED_INVOICESCaptionLbl: Label 'POSTED INVOICES', Comment = 'FRA="FACTURES ENREGISTREES"';
        Receipt_DateCaptionLbl: Label 'Receipt Date', Comment = 'FRA="Date de réception"';
        Reminder_of_the_selectionCaptionLbl: Label 'Reminder of the selection', Comment = 'FRA="Rappel de la sélection"';
        RIBCaption_Control1000000195Lbl: Label 'RIB';
        RIBCaptionLbl: Label 'RIB';
        Slip_dateCaption_Control1000000158Lbl: Label 'Slip date', Comment = 'FRA="Date de bordereau"';
        Slip_dateCaptionLbl: Label 'Slip date', Comment = 'FRA="Date de bordereau"';
        StatusCaption_Control1000000133Lbl: Label 'Status', Comment = 'FRA="Statut"';
        StatusCaptionLbl: Label 'Status', Comment = 'FRA="Statut"';
        TEXT001: Label 'Page %1';
        Text002: Label 'Vendor Statement', Comment = 'FRA="Relevé Fournisseur"';
        Text003: Label 'Vendor :', Comment = 'FRA="Fournisseur :"';
        Text004: Label 'at', Comment = 'FRA="à"';
        Total_payment_amount_including_VATCaptionLbl: Label 'Total payment amount including VAT', Comment = 'FRA="Montant Total TTC A REGLER"';
        Transmission_date_to_the_approverCaption_Control1000000135Lbl: Label 'Transmission date to the approver', Comment = 'FRA="Date de transmission à l''approbateur"';
        Transmission_date_to_the_approverCaptionLbl: Label 'Transmission date to the approver', Comment = 'FRA="Date de transmission à l''approbateur"';
        TTC_Total_AmountCaption_Control1000000022Lbl: Label 'TTC Total Amount', Comment = 'FRA="Montant Total TTC"';
        TTC_Total_AmountCaption_Control1000000035Lbl: Label 'TTC Total Amount', Comment = 'FRA="Montant Total TTC"';
        TTC_Total_AmountCaption_Control1000000072Lbl: Label 'TTC Total Amount', Comment = 'FRA="Montant Total TTC"';
        TTC_Total_AmountCaption_Control1000000130Lbl: Label 'TTC Total Amount', Comment = 'FRA="Montant Total TTC"';
        TTC_Total_AmountCaption_Control1000000165Lbl: Label 'TTC Total Amount', Comment = 'FRA="Montant Total TTC"';
        TTC_Total_AmountCaption_Control1000000173Lbl: Label 'TTC Total Amount', Comment = 'FRA="Montant Total TTC"';
        TTC_Total_AmountCaption_Control1000000185Lbl: Label 'TTC Total Amount', Comment = 'FRA="Montant Total TTC"';
        TTC_Total_AmountCaptionLbl: Label 'TTC Total Amount', Comment = 'FRA="Montant Total TTC"';
        User__CaptionLbl: Label 'User :', Comment = 'FRA="Utilisateur :"';
        Vendor__CaptionLbl: Label 'Vendor :', Comment = 'FRA="Fournisseur :"';
        Gtext_DateApprob: Text[30];
        Gtext_DateTransmApprob: Text[30];
        Gtext_IdApprobateur: Text[30];
        Gtxt_DateBordereau: Text[30];
        "Gtxt_DateRèglement": Text[30];
        Gtxt_FournisseurFilter: Text[50];
        Gtxt_RIB: Text[50];
        Gtxt_ListeCommandes: Text[1024];
}

