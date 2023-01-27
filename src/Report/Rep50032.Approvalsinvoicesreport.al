report 50032 "BC6_Approvals invoices report"
{
    // // Création JALIX - LAB du 23/10/2009
    // // Etat de contrôle des factures et approbations
    // 
    // MODIF JX-XAD du 30/11/2009
    // Compteur de jours
    // Récupération du n° commande
    // Ajout des colonnes Creation date et Reception Invoice date
    // Approbateur ID
    // Date de mise à disposition
    // Récupération du n° virement quand facture payée + ajout de deux lignes : Prépa RGLT et Validation RGLT
    // 
    // //JX-AUD du 13/05/2013
    // //Agrandissement logo
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/Approvalsinvoicesreport.rdl';
    Caption = 'Approval invoice report', Comment = 'FRA="Etat des approbations de factures"';

    dataset
    {
        dataitem("Purchase Header"; 38)
        {
            DataItemTableView = SORTING("Document Type", "No.") ORDER(Ascending) WHERE("Document Type" = CONST(Invoice));
            RequestFilterFields = "Buy-from Vendor No.", "No.";
            column(STRSUBSTNO_Text1000000001_FORMAT_CurrReport_PAGENO__; STRSUBSTNO(Text1000000001, FORMAT(CurrReport)))
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(Purchase_Header__No__; "No.")
            {
            }
            column(Purchase_Header__Buy_from_Vendor_No__; "Buy-from Vendor No.")
            {
            }
            column(Purchase_Header__Lines_Amount_; "BC6_Lines Amount")
            {
            }
            column(Purchase_Header__Vendor_Invoice_No__; "Vendor Invoice No.")
            {
            }
            column(gtextOrderNo; gtextOrderNo)
            {
            }
            column(Purchase_Header__Document_Date_; "Document Date")
            {
            }
            column(Purchase_Header__Due_Date_; "Due Date")
            {
            }
            column(Purchase_Header__Buy_from_Vendor_Name_; "Buy-from Vendor Name")
            {
            }
            column(Purchase_Header__Invoice_receipt_date_; "BC6_Invoice receipt date")
            {
            }
            column(Purchase_Header__Creation_date_; "BC6_Creation date")
            {
            }
            column(gInt_NbDays; gInt_NbDays)
            {
            }
            column(Purchase_Header__Purchase_Header___Original_user_; "Purchase Header"."BC6_Original user")
            {
            }
            column(gdate_available; gdate_available)
            {
            }
            column(gInt_NbTotalDays; gInt_NbTotalDays)
            {
            }
            column(Current_approvals_invoices_reportCaption; Current_approvals_invoices_reportCaptionLbl)
            {
            }
            column(Purchase_Header__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Approval_Entry__Approver_ID_Caption; "Approval Entry".FIELDCAPTION("Approver ID"))
            {
            }
            column(Last_date_modifiedCaption; Last_date_modifiedCaptionLbl)
            {
            }
            column(Purchase_Header__Buy_from_Vendor_No__Caption; FIELDCAPTION("Buy-from Vendor No."))
            {
            }
            column(Amount_without_VATCaption; Amount_without_VATCaptionLbl)
            {
            }
            column(Purchase_Header__Vendor_Invoice_No__Caption; FIELDCAPTION("Vendor Invoice No."))
            {
            }
            column(Order_No_Caption; Order_No_CaptionLbl)
            {
            }
            column(Purchase_Header__Document_Date_Caption; FIELDCAPTION("Document Date"))
            {
            }
            column(Purchase_Header__Due_Date_Caption; FIELDCAPTION("Due Date"))
            {
            }
            column(Approval_Entry_StatusCaption; "Approval Entry".FIELDCAPTION(Status))
            {
            }
            column(Purchase_Header__Buy_from_Vendor_Name_Caption; FIELDCAPTION("Buy-from Vendor Name"))
            {
            }
            column(PayrollCaption; PayrollCaptionLbl)
            {
            }
            column(Invoice_receipt__dateCaption; Invoice_receipt__dateCaptionLbl)
            {
            }
            column(Creation_dateCaption; Creation_dateCaptionLbl)
            {
            }
            column(Nb_of_daysCaption; Nb_of_daysCaptionLbl)
            {
            }
            column(Total_daysCaption; Total_daysCaptionLbl)
            {
            }
            column(date_of_availabilityCaption; date_of_availabilityCaptionLbl)
            {
            }
            column(NoCaption; NoCaptionLbl)
            {
            }
            column(Purchase_Header_Document_Type; "Document Type")
            {
            }
            dataitem("Approval Entry"; 454)
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Table ID", "Document Type", "Document No.", "Sequence No.") ORDER(Ascending);
                column(Approval_Entry__Approver_ID_; "Approver ID")
                {
                }
                column(Approval_Entry__Last_Date_Time_Modified_; "Last Date-Time Modified")
                {
                }
                column(Approval_Entry_Status; Status)
                {
                }
                column(Approval_Entry__Document_No__; "Document No.")
                {
                }
                column(gInt_NbDays_Control1000000052; gInt_NbDays)
                {
                }
                column(gInt_NbTotalDays_Control1000000074; gInt_NbTotalDays)
                {
                }
                column(Approval_Entry_Table_ID; "Table ID")
                {
                }
                column(Approval_Entry_Document_Type; "Document Type")
                {
                }
                column(Approval_Entry_Sequence_No_; "Sequence No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //DEBUT AJOUT JX-XAD du 30/11/2009 (compteur de jours)

                    IF (gBool_Debut) THEN BEGIN
                        IF (gdate_available <> 0D) THEN
                            gInt_NbDays := DT2DATE("Approval Entry"."Last Date-Time Modified") - gdate_available
                        ELSE
                            IF ("Purchase Header"."Document Date" <> 0D) THEN
                                gInt_NbDays := DT2DATE("Approval Entry"."Last Date-Time Modified") - "Purchase Header"."Document Date"
                            ELSE BEGIN
                                gInt_NbDays := 0;
                                gDate_Precedente := 0D;
                            END;
                        gDate_Precedente := DT2DATE("Approval Entry"."Last Date-Time Modified");
                        gBool_Debut := FALSE;
                    END ELSE
                        IF (gDate_Precedente <> 0D) THEN BEGIN
                            gInt_NbDays := DT2DATE("Approval Entry"."Last Date-Time Modified") - gDate_Precedente;
                            gDate_Precedente := DT2DATE("Approval Entry"."Last Date-Time Modified");
                        END;

                    gInt_NbTotalDays += gInt_NbDays;

                    //FIN AJOUT JX-XAD du 30/11/2009 (compteur de jours)
                end;

                trigger OnPreDataItem()
                begin
                    gBool_Debut := TRUE;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //DEBUT AJOUT JX-XAD du 30/11/2009

                //Recherche de la date de mise à disposition
                gRec_Historic.SETRANGE(gRec_Historic.Type, gRec_Historic.Type::Invoice);
                gRec_Historic.SETRANGE(gRec_Historic."No.", "Purchase Header"."No.");
                gdate_available := 0D;
                IF gRec_Historic.FIND('+') THEN
                    gdate_available := DT2DATE(gRec_Historic."Date time");

                //Initialisation compteur de jours
                IF (gdate_available <> 0D) AND ("Purchase Header"."BC6_Invoice receipt date" <> 0D) THEN BEGIN
                    gInt_NbDays := gdate_available - "Purchase Header"."BC6_Invoice receipt date";
                    gInt_NbTotalDays := gInt_NbDays;
                END ELSE BEGIN
                    gInt_NbTotalDays := 0;
                    gInt_NbDays := 0;
                END;

                //Récupération du n° de commande (celui n'étant pas indiqué car les facture sont créées avec les réceptions
                //                                et non créées depuis les commandes)
                gRecPurchaseline.SETRANGE("Document Type", "Purchase Header"."Document Type");
                gRecPurchaseline.SETRANGE("Document No.", "Purchase Header"."No.");

                gtextOrderNo := '';
                IF gRecPurchaseline.FIND('-') THEN
                    REPEAT
                    BEGIN
                        gInt_PosTextCommande := STRPOS(gRecPurchaseline.Description, Text1000000005);
                        IF (gInt_PosTextCommande <> 0) THEN BEGIN
                            gInt_PosTextCommande += STRLEN(Text1000000005);
                            REPEAT
                                gInt_PosTextCommande += 1;
                                IF (COPYSTR(gRecPurchaseline.Description, gInt_PosTextCommande, 1) <> ' ') THEN
                                    gtextOrderNo += COPYSTR(gRecPurchaseline.Description, gInt_PosTextCommande, 1);
                            UNTIL (COPYSTR(gRecPurchaseline.Description, gInt_PosTextCommande, 1) = ' ') OR
                                  (COPYSTR(gRecPurchaseline.Description, gInt_PosTextCommande, 1) = '');
                        END;
                    END;
                    UNTIL (gRecPurchaseline.NEXT() = 0) OR (gtextOrderNo <> '');

                //gtextOrderNo := gRecPurchaseline.Description - padstr(gRecPurchaseline.Description,5);

                //FIN AJOUT JX-XAD du 30/11/2009
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET();
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
            end;
        }
        dataitem("Saut de page"; 2000000026)
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

        }
        dataitem("Purch. Inv. Header"; 122)
        {
            RequestFilterFields = "Buy-from Vendor No.", "No.";
            column(CompanyInfo_Picture_Control1000000031; CompanyInfo.Picture)
            {
            }
            column(Purch__Inv__Header_Amount; Amount)
            {
            }
            column(Purch__Inv__Header__No__; "No.")
            {
            }
            column(Purch__Inv__Header__Buy_from_Vendor_No__; "Buy-from Vendor No.")
            {
            }
            column(Purch__Inv__Header__Buy_from_Vendor_Name_; "Buy-from Vendor Name")
            {
            }
            column(gtextOrderNo_Control1000000062; gtextOrderNo)
            {
            }
            column(Purch__Inv__Header__Document_Date_; "Document Date")
            {
            }
            column(Purch__Inv__Header__Due_Date_; "Due Date")
            {
            }
            column(Purch__Inv__Header__Vendor_Invoice_No__; "Vendor Invoice No.")
            {
            }
            column(Purch__Inv__Header__Invoice_receipt_date_; "BC6_Invoice receipt date")
            {
            }
            column(Purch__Inv__Header__Creation_date_; "BC6_Creation date")
            {
            }
            column(gInt_NbDays_Control1000000060; gInt_NbDays)
            {
            }
            column(Purch__Inv__Header__Purch__Inv__Header___Original_user_; "Purch. Inv. Header"."BC6_Original user")
            {
            }
            column(gdate_available_Control1000000084; gdate_available)
            {
            }
            column(gInt_NbTotalDays_Control1000000079; gInt_NbTotalDays)
            {
            }
            column(Posted_approvals_invoices_reportCaption; Posted_approvals_invoices_reportCaptionLbl)
            {
            }
            column(Last_date_modifiedCaption_Control1000000041; Last_date_modifiedCaption_Control1000000041Lbl)
            {
            }
            column(Amount_without_VATCaption_Control1000000045; Amount_without_VATCaption_Control1000000045Lbl)
            {
            }
            column(Purch__Inv__Header__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Purch__Inv__Header__Buy_from_Vendor_No__Caption; FIELDCAPTION("Buy-from Vendor No."))
            {
            }
            column(Purch__Inv__Header__Buy_from_Vendor_Name_Caption; FIELDCAPTION("Buy-from Vendor Name"))
            {
            }
            column(Purch__Inv__Header__Document_Date_Caption; FIELDCAPTION("Document Date"))
            {
            }
            column(Purch__Inv__Header__Due_Date_Caption; FIELDCAPTION("Due Date"))
            {
            }
            column(Transfer_No_Caption; Transfer_No_CaptionLbl)
            {
            }
            column(Posted_Approval_Entry__Approver_ID_Caption; "Posted Approval Entry".FIELDCAPTION("Approver ID"))
            {
            }
            column(Posted_Approval_Entry_StatusCaption; "Posted Approval Entry".FIELDCAPTION(Status))
            {
            }
            column(PayrollCaption_Control1000000025; PayrollCaption_Control1000000025Lbl)
            {
            }
            column(Order_No_Caption_Control1000000029; Order_No_Caption_Control1000000029Lbl)
            {
            }
            column(Purch__Inv__Header__Vendor_Invoice_No__Caption; FIELDCAPTION("Vendor Invoice No."))
            {
            }
            column(Invoice_receipt__dateCaption_Control1000000046; Invoice_receipt__dateCaption_Control1000000046Lbl)
            {
            }
            column(Creation_dateCaption_Control1000000047; Creation_dateCaption_Control1000000047Lbl)
            {
            }
            column(Nb_of_daysCaption_Control1000000053; Nb_of_daysCaption_Control1000000053Lbl)
            {
            }
            column(Total_daysCaption_Control1000000075; Total_daysCaption_Control1000000075Lbl)
            {
            }
            column(date_of_availabilityCaption_Control1000000083; date_of_availabilityCaption_Control1000000083Lbl)
            {
            }
            dataitem("Posted Approval Entry"; 456)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Table ID", "Document No.", "Sequence No.") ORDER(Ascending);
                column(Posted_Approval_Entry__Last_Date_Time_Modified_; "Last Date-Time Modified")
                {
                }
                column(Posted_Approval_Entry__Approver_ID_; "Approver ID")
                {
                }
                column(Posted_Approval_Entry_Status; Status)
                {
                }
                column(Posted_Approval_Entry__Document_No__; "Document No.")
                {
                }
                column(gInt_NbDays_Control1000000061; gInt_NbDays)
                {
                }
                column(gInt_NbTotalDays_Control1000000078; gInt_NbTotalDays)
                {
                }
                column(Posted_Approval_Entry_Table_ID; "Table ID")
                {
                }
                column(Posted_Approval_Entry_Sequence_No_; "Sequence No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //DEBUT AJOUT JX-XAD du 30/11/2009

                    IF (gBool_Debut) THEN BEGIN
                        IF (gdate_available <> 0D) THEN
                            gInt_NbDays := DT2DATE("Posted Approval Entry"."Last Date-Time Modified") - gdate_available
                        ELSE
                            IF ("Purch. Inv. Header"."Document Date" <> 0D) THEN
                                gInt_NbDays := DT2DATE("Posted Approval Entry"."Last Date-Time Modified") - "Purch. Inv. Header"."Document Date"
                            ELSE BEGIN
                                gInt_NbDays := 0;
                                gDate_Precedente := 0D;
                            END;
                        gDate_Precedente := DT2DATE("Posted Approval Entry"."Last Date-Time Modified");
                        gBool_Debut := FALSE;
                    END ELSE
                        IF (gDate_Precedente <> 0D) THEN BEGIN
                            gInt_NbDays := DT2DATE("Posted Approval Entry"."Last Date-Time Modified") - gDate_Precedente;
                            gDate_Precedente := DT2DATE("Posted Approval Entry"."Last Date-Time Modified");
                        END;

                    gInt_NbTotalDays += gInt_NbDays;

                    //FIN AJOUT JX-XAD du 30/11/2009
                end;

                trigger OnPreDataItem()
                begin
                    gBool_Debut := TRUE;
                end;
            }
            dataitem("Vendor Ledger Entry"; 25)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.") ORDER(Ascending);
                column(gInt_NbDaysPayment; gInt_NbDaysPayment)
                {
                }
                column(gInt_NbTotalDaysPayment; gInt_NbTotalDaysPayment)
                {
                }
                column(gtextPayroll; gtextPayroll)
                {
                }
                column(gtxt_Document; gtxt_Document)
                {
                }
                column(gdate_PostingDate; gdate_PostingDate)
                {
                }
                column(gdate_CreationDatePayment; gdate_CreationDatePayment)
                {
                }
                column(gInt_NbDays_Control1000000085; gInt_NbDays)
                {
                }
                column(gInt_NbTotalDays_Control1000000086; gInt_NbTotalDays)
                {
                }
                column(Payment_preparationCaption; Payment_preparationCaptionLbl)
                {
                }
                column(Validation_PaymentCaption; Validation_PaymentCaptionLbl)
                {
                }
                column(Vendor_Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                column(Vendor_Ledger_Entry_Document_No_; "Document No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    gtxt_Document := '';
                    gInt_NbDaysPayment := 0;
                    gInt_NbDays := 0;
                    gdate_CreationDatePayment := 0D;
                    gdate_PostingDate := 0D;

                    "Vendor Ledger Entry".CALCFIELDS("Vendor Ledger Entry"."Remaining Amount");

                    IF
                      "Vendor Ledger Entry"."Remaining Amount" <> 0
                    THEN
                        gtextPayroll := Text1000000003
                    ELSE BEGIN
                        gtextPayroll := Text1000000004;
                        IF "Vendor Ledger Entry"."Closed by Entry No." <> 0 THEN
                            IF gRec_VendorLedgerEntry.GET("Vendor Ledger Entry"."Closed by Entry No.") THEN
                                IF gRec_VendorLedgerEntry."Document Type" = gRec_VendorLedgerEntry."Document Type"::Payment THEN BEGIN
                                    gdate_CreationDatePayment := gRec_VendorLedgerEntry."Document Date";
                                    gdate_PostingDate := gRec_VendorLedgerEntry."Posting Date";
                                    gtxt_Document := gRec_VendorLedgerEntry."Document No.";
                                    IF (gDate_Precedente <> 0D) THEN BEGIN
                                        gInt_NbDays := gdate_CreationDatePayment - gDate_Precedente;
                                        gInt_NbDaysPayment := gdate_PostingDate - gdate_CreationDatePayment;
                                    END;
                                END;
                    END;

                    gInt_NbTotalDays += gInt_NbDays;
                    gInt_NbTotalDaysPayment := gInt_NbTotalDays + gInt_NbDaysPayment;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //DEBUT AJOUT JX-XAD du 30/11/2009

                gtxt_Document := '';

                //Recherche de la date de mise à disposition
                gRec_Historic.SETRANGE(gRec_Historic.Type, gRec_Historic.Type::Invoice);
                gRec_Historic.SETRANGE(gRec_Historic."No.", "Purch. Inv. Header"."No.");
                gdate_available := 0D;
                IF gRec_Historic.FIND('+') THEN
                    gdate_available := DT2DATE(gRec_Historic."Date time");

                //Initialisation compteur de jours
                IF (gdate_available <> 0D) AND ("Purch. Inv. Header"."BC6_Invoice receipt date" <> 0D) THEN BEGIN
                    gInt_NbDays := gdate_available - "Purch. Inv. Header"."BC6_Invoice receipt date";
                    gInt_NbTotalDays := gInt_NbDays;
                END ELSE BEGIN
                    gInt_NbTotalDays := 0;
                    gInt_NbDays := 0;
                END;

                //Récupération du n° de commande (celui n'étant pas indiqué car les facture sont créées avec les réceptions
                //                                et non créées depuis les commandes)
                gRecPurchaselinearchive.SETRANGE("Document No.", "Purch. Inv. Header"."No.");

                gtextOrderNo := '';
                IF gRecPurchaselinearchive.FIND('-') THEN
                    REPEAT
                    BEGIN
                        gInt_PosTextCommande := STRPOS(gRecPurchaselinearchive.Description, Text1000000005);
                        IF (gInt_PosTextCommande <> 0) THEN BEGIN
                            gInt_PosTextCommande += STRLEN(Text1000000005);
                            REPEAT
                                gInt_PosTextCommande += 1;
                                IF (COPYSTR(gRecPurchaselinearchive.Description, gInt_PosTextCommande, 1) <> ' ') THEN
                                    gtextOrderNo += COPYSTR(gRecPurchaselinearchive.Description, gInt_PosTextCommande, 1);
                            UNTIL (COPYSTR(gRecPurchaselinearchive.Description, gInt_PosTextCommande, 1) = ' ') OR
                                  (COPYSTR(gRecPurchaselinearchive.Description, gInt_PosTextCommande, 1) = '');
                        END;
                    END;
                    UNTIL (gRecPurchaselinearchive.NEXT() = 0) OR (gtextOrderNo <> '');

                //gtextOrderNo := gRecPurchaseline.Description - padstr(gRecPurchaseline.Description,5);

                //FIN AJOUT JX-XAD du 30/11/2009
            end;
        }
    }
    var
        gRec_Historic: Record "BC6_VSC historic";
        CompanyInfo: Record "Company Information";
        gRecPurchaselinearchive: Record "Purch. Inv. Line";
        gRecPurchaseline: Record "Purchase Line";
        gRec_VendorLedgerEntry: Record "Vendor Ledger Entry";
        gBool_Debut: Boolean;
        gdate_available: Date;
        gdate_CreationDatePayment: Date;
        gdate_PostingDate: Date;
        gDate_Precedente: Date;
        gInt_NbDays: Integer;
        gInt_NbDaysPayment: Integer;
        gInt_NbTotalDays: Integer;
        gInt_NbTotalDaysPayment: Integer;
        gInt_PosTextCommande: Integer;
        Amount_without_VATCaption_Control1000000045Lbl: Label 'Amount without VAT', Comment = 'FRA="Montant HT"';
        Amount_without_VATCaptionLbl: Label 'Amount without VAT', Comment = 'FRA="Montant HT"';
        Creation_dateCaption_Control1000000047Lbl: Label 'Creation date', Comment = 'FRA="Date de création"';
        Creation_dateCaptionLbl: Label 'Creation date', Comment = 'FRA="Date de création"';
        Current_approvals_invoices_reportCaptionLbl: Label 'Current approvals invoices report', Comment = 'FRA="Etat des approbations de factures en cours"';
        date_of_availabilityCaption_Control1000000083Lbl: Label 'date of availability', Comment = 'FRA="Date de mise à disposition"';
        date_of_availabilityCaptionLbl: Label 'date of availability', Comment = 'FRA="Date de mise à disposition"';
        Invoice_receipt__dateCaption_Control1000000046Lbl: Label 'Invoice receipt. date', Comment = 'FRA="Date récept. facture"';
        Invoice_receipt__dateCaptionLbl: Label 'Invoice receipt. date', Comment = 'FRA="Date récept. facture"';
        Last_date_modifiedCaption_Control1000000041Lbl: Label 'Last date modified', Comment = 'FRA="Dernière modification"';
        Last_date_modifiedCaptionLbl: Label 'Last date modified', Comment = 'FRA="Dernière modification"';
        Nb_of_daysCaption_Control1000000053Lbl: Label 'Nb of days', Comment = 'FRA="Nb de jours"';
        Nb_of_daysCaptionLbl: Label 'Nb of days', Comment = 'FRA="Nb de jours"';
        NoCaptionLbl: Label 'No', Comment = 'FRA="Non"';
        Order_No_Caption_Control1000000029Lbl: Label 'Order No.', Comment = 'FRA="N° commande"';
        Order_No_CaptionLbl: Label 'Order No.', Comment = 'FRA="N° commande"';
        Payment_preparationCaptionLbl: Label 'Payment preparation', Comment = 'FRA="Prépa RGLT"';
        PayrollCaption_Control1000000025Lbl: Label 'Payroll', Comment = 'FRA="Payé"';
        PayrollCaptionLbl: Label 'Payroll', Comment = 'FRA="Payé"';
        Posted_approvals_invoices_reportCaptionLbl: Label 'Posted approvals invoices report', Comment = 'FRA="Etat des approbations de factures enregistrées"';
        Text1000000001: Label 'Page %1';
        Text1000000003: Label 'No', Comment = 'FRA="Non"';
        Text1000000004: Label 'Yes', Comment = 'FRA="Oui"';
        Text1000000005: Label 'order', Comment = 'FRA="Commande"';
        Total_daysCaption_Control1000000075Lbl: Label 'Total days', Comment = 'FRA="Total jours"';
        Total_daysCaptionLbl: Label 'Total days', Comment = 'FRA="Total jours"';
        Transfer_No_CaptionLbl: Label 'Transfer No.', Comment = 'FRA="N° virement"';
        Validation_PaymentCaptionLbl: Label 'Validation Payment', Comment = 'FRA="Validation RGLT"';
        gtextPayroll: Text[3];
        gtextOrderNo: Text[10];
        gtxt_Document: Text[30];
}

