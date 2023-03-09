codeunit 50010 "BC6_Vendor Payments"
{
    TableNo = "Vendor Ledger Entry";
    Permissions = tabledata "Vendor Ledger Entry" = rm;

    var
        CompInfo: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        PaymHeader: Record "Payment Header";
        PaymLine: Record "Payment Line";
        PaymLine2: Record "Payment Line";
        PaymentStep: Record "Payment Step";
        VendLedgEntry: Record "Vendor Ledger Entry";
        PaymentMgt: Codeunit "Payment Management";
        AmountToPay: Decimal;
        Text001: label 'One of your slips is being entered. Do you want to add this payment to this slip?', Comment = 'FRA="Un de vos bordereaux est en cours de saisie. Voulez-vous ajouter ce paiement à ce bordereau ?"';
        Text002: label 'This document has already been paid for in advance. Are you sure ?', Comment = 'FRA="Ce document a été déjà réglé par avance. Etes-vous sûr ?"';
        Text003: label 'This invoice has been paid in full. Creation of the slip impossible.', Comment = 'FRA="Cette facture a été intégralement payée. Création du bordereau impossible."';
        Text004: label 'Supplier ledger entry not found.', Comment = 'FRA="Ecriture comptable fournisseur non trouvée."';
        Text005: label 'Do you want to validate this slip (No = Display of the slip)?', Comment = 'FRA="Voulez-vous valider ce bordereau (Non = Affichage du bordereau) ?"';
        Text006: label 'This document already appears on the %1 slip. Would you like to continue ?', Comment = 'FRA="Ce document déjà figure sur le bordereau %1. Souhaitez-vous continuer ?"';
        Line0: label 'Good morning,', Comment = 'FRA="Bonjour,"';
        Line1: label 'You will find attached your transfer advice.', Comment = 'FRA="Vous trouverez en pièce jointe votre avis de virement."';
        EmptyLine: label '<br><br>', Comment = 'FRA="<br><br>"';
        Line3: label 'Best regards,<br><br>', Comment = 'FRA="Cordialement,<br><br>"';
        Line2: label 'We wish you good reception and remain at your disposal for any further questions.', Comment = 'FRA="Nous vous en souhaitons bonne réception et restons à votre disposition pour toutes questions complémentaires."';
        Line4: label 'The accounting department of OUI.Sncf', Comment = 'FRA="Le service de comptabilité  de OUI.Sncf"';
        ErrEnabledMailSending: label 'Unable to send emails because %1 is not enabled in VSC Settings.', Comment = 'FRA="Impossible d''envoyer les emails car le champ %1 n''est pas activé dans Paramètres VSC."';
        TextGSubjectMail: label '%1 - Payment %2', Comment = 'FRA="%1 - Avis de virement %2"';
        MsgPaymentsNotFound: label 'These transfers have already been sent to suppliers or no e-mail address is configured on the supplier files.', Comment = 'FRA="Ces virements ont été déjà envoyés aux fournisseurs ou aucune adresse E-mail est paramétrée sur les fiches fournisseurs."';
        MsgSendCompleted: label 'Sending emails is completed successfully.', Comment = 'FRA="Envoi des e-mails s''est terminé avec succès."';
        MsgProgressEmails: label 'Sending emails in progress', Comment = 'FRA="Envoi des mails en cours"';
        MsgGConfirmSendEmail: label 'Vous voulez envoyer les virements par e-mail aux fournisseurs? ', Comment = 'FRA="Vous voulez envoyer les virements par e-mail aux fournisseurs? "';
        TxtGAttachName: label 'Payment - %1.pdf', Comment = 'FRA="Virement - %1.pdf"';

    trigger OnRun()
    begin
    end;

    procedure CreatePaymentDoc(pPurchHeader: Record "Purchase Header");
    var
        PaymentLine: Record "Payment Line";
        PaymentPage: Page "BC6_Vendor Doc. Payment";
    begin
        PaymentLine.RESET();
        PaymentLine.SETCURRENTKEY("BC6_Pay Document Type", "BC6_Pay Document No.");
        PaymentLine.SETRANGE("BC6_Pay Document Type", pPurchHeader."Document Type".AsInteger() + 1);
        PaymentLine.SETRANGE("BC6_Pay Document No.", pPurchHeader."No.");
        PaymentLine.SETRANGE("Status No.", 0);
        if PaymentLine.FINDFIRST() then
            if not CONFIRM(STRSUBSTNO(Text006, PaymentLine."No."), false) then
                exit;

        VendLedgEntry.RESET();
        VendLedgEntry.SETCURRENTKEY("Vendor No.", "BC6_Document Type Prepaid", "BC6_Document Prepaid");
        VendLedgEntry.SETRANGE("Vendor No.", pPurchHeader."Pay-to Vendor No.");
        VendLedgEntry.SETRANGE("BC6_Document Type Prepaid", pPurchHeader."Document Type".AsInteger() + 1);
        VendLedgEntry.SETRANGE("BC6_Document Prepaid", pPurchHeader."No.");
        if VendLedgEntry.FINDFIRST() then
            if not CONFIRM(Text002, false) then
                exit;

        CLEAR(PaymentPage);
        PaymentPage.SETRECORD(pPurchHeader);
        PaymentPage.LOOKUPMODE(true);
        if PaymentPage.RUNMODAL() = ACTION::LookupCancel then
            exit;
        AmountToPay := PaymentPage.ReturnAmount();
        if AmountToPay = 0 then
            exit;
        CreatePayment(pPurchHeader."Document Type".AsInteger() + 1, pPurchHeader."No.", pPurchHeader."Pay-to Vendor No.");
        pPurchHeader."BC6_Document Prepaid" := true;
        pPurchHeader."BC6_Amount Prepaid" += AmountToPay;
        pPurchHeader."BC6_Document Type Prepaid" := pPurchHeader."Document Type".AsInteger() + 1;
        pPurchHeader."BC6_Document No. Prepaid" := pPurchHeader."No.";
        pPurchHeader.MODIFY();
    end;

    procedure CreatePaymentInv(pInvoiceHeader: Record "Purch. Inv. Header");
    var
        PaymentLine: Record "Payment Line";
        lVendorLedger: Record "Vendor Ledger Entry";
    begin
        PaymentLine.RESET();
        PaymentLine.SETCURRENTKEY("BC6_Pay Document Type", "BC6_Pay Document No.");
        PaymentLine.SETRANGE("BC6_Pay Document Type", PaymentLine."BC6_Pay Document Type"::Invoice);
        PaymentLine.SETRANGE("BC6_Pay Document No.", pInvoiceHeader."No.");
        PaymentLine.SETRANGE("Status No.", 0);
        if PaymentLine.FINDFIRST() then
            if not CONFIRM(STRSUBSTNO(Text006, PaymentLine."No."), false) then
                exit;

        lVendorLedger.RESET();
        lVendorLedger.SETCURRENTKEY("Vendor No.", "Document No.", "Posting Date");
        lVendorLedger.SETRANGE("Vendor No.", pInvoiceHeader."Pay-to Vendor No.");
        lVendorLedger.SETRANGE("Document No.", pInvoiceHeader."No.");
        lVendorLedger.SETRANGE("Document Type", lVendorLedger."Document Type"::Invoice);
        if lVendorLedger.FINDFIRST() then begin
            lVendorLedger.CALCFIELDS("Remaining Amount");
            if not lVendorLedger.Open then
                ERROR(Text003);
            AmountToPay := lVendorLedger."Remaining Amount";
            CreatePayment(0, pInvoiceHeader."No.", pInvoiceHeader."Pay-to Vendor No.");
        end else
            ERROR(Text004);
    end;

    local procedure CreatePayment(TypeDoc: Option Invoice,Quote,Order,FAP; DocNo: Code[20]; VendorNo: Code[20]);
    var
        PaymentSlip: Page "Payment Slip";
    begin
        PaymHeader.RESET();
        PaymHeader.SETCURRENTKEY("BC6_User ID", "Status No.");
        PaymHeader.SETRANGE("BC6_User ID", USERID);
        PaymHeader.SETRANGE("Status No.", 0);
        if PaymHeader.FINDFIRST() then begin
            if not CONFIRM(Text001, true) then
                CreateHeader()
            else begin
                PaymHeader."BC6_Modifcation Date" := WORKDATE();
                PaymHeader.MODIFY();
            end;
        end else
            CreateHeader();

        PaymLine2.RESET();
        PaymLine2.SETRANGE("No.", PaymHeader."No.");
        PaymLine.INIT();
        PaymLine."No." := PaymHeader."No.";
        if PaymLine2.FINDLAST() then
            PaymLine."Line No." := PaymLine2."Line No." + 10000
        else
            PaymLine."Line No." := 10000;
        PaymLine.INSERT();
        PaymLine."Account Type" := PaymLine."Account Type"::Vendor;
        PaymLine.VALIDATE("Account No.", VendorNo);
        PaymLine."Due Date" := WORKDATE();
        PaymLine."Payment Class" := PaymHeader."Payment Class";
        if TypeDoc > TypeDoc::Invoice then begin
            PaymLine."BC6_Pay Document Type" := TypeDoc;
            PaymLine."BC6_Pay Document No." := DocNo;
        end else begin
            PaymLine."BC6_Pay Document Type" := TypeDoc;
            PaymLine."BC6_Pay Document No." := DocNo;
            VendLedgEntry.RESET();
            VendLedgEntry.SETCURRENTKEY("Vendor No.", "Document No.", "Posting Date");
            VendLedgEntry.SETRANGE("Vendor No.", VendorNo);
            VendLedgEntry.SETRANGE("Document No.", DocNo);
            VendLedgEntry.SETRANGE("Document Type", VendLedgEntry."Document Type"::Invoice);
            if VendLedgEntry.FINDFIRST() then begin
                VendLedgEntry."Applies-to ID" := PaymHeader."No." + '/' + FORMAT(PaymLine."Line No.");
                VendLedgEntry.MODIFY();
                PaymLine."Applies-to ID" := PaymHeader."No." + '/' + FORMAT(PaymLine."Line No.");
            end;
        end;
        PaymLine.VALIDATE(Amount, AmountToPay);
        PaymLine.MODIFY();

        COMMIT();
        PaymLine.SETRANGE("No.", PaymHeader."No.");
        PaymHeader.SETRANGE("No.", PaymHeader."No.");
        PaymHeader.MARK(true);
        PaymentStep.SETRANGE("Action Type", PaymentStep."Action Type"::Report);
        PaymentMgt.ProcessPaymentSteps(PaymHeader, PaymentStep);
        PaymHeader.MARK(false);
        if not CONFIRM(Text005, false) then begin
            CLEAR(PaymentSlip);
            PaymentSlip.SETRECORD(PaymHeader);
            PaymentSlip.SETTABLEVIEW(PaymHeader);
            COMMIT();
            PaymentSlip.RUNMODAL();
        end else begin
            PaymentStep.SETFILTER("Action Type", '%1|%2', PaymentStep."Action Type"::None, PaymentStep."Action Type"::Ledger);
            PaymentMgt.ProcessPaymentSteps(PaymHeader, PaymentStep);
        end;
    end;

    local procedure CreateHeader();
    begin
        CompInfo.GET();
        GLSetup.GET();
        PaymHeader.RESET();
        PaymHeader.INIT();
        PaymHeader."No." := '';
        PaymHeader."Payment Class" := GLSetup."BC6_Default Payment Class";
        PaymHeader.INSERT(true);
        PaymHeader."Account Type" := PaymHeader."Account Type"::"Bank Account";
        PaymHeader.VALIDATE("Account No.", CompInfo."Default Bank Account No.");
        PaymHeader."BC6_User ID" := USERID;
        PaymHeader."BC6_Creation Date" := WORKDATE();
        PaymHeader."BC6_Alone Payment" := true;
        PaymHeader.MODIFY();
    end;

    PROCEDURE FctSendPaymentMail(RecPPaymentHeader: Record "Payment Header"; BooPInPageContext: Boolean);
    VAR
        RecLVSCSettings: Record "BC6_VSC Settings";
        RecLPaymentLine: Record "Payment Line";
        RepLPaymentMail: Report "BC6_Send Vendor Pay. E-mail";
        TempBlob: Codeunit "temp blob";
        EMailMessage: Codeunit "Email Message";
        CodLCurrentVendor: Code[20];
        TxtLToFileName: Text;
        InStream: InStream;
        Mail: Codeunit Email;
        RecGVendor: Record Vendor;
        RecLPaymentLine2: Record "Payment Line";
        FileDirectory: Text;
        TxtLMailSubject: Text[250];
        RecGCompanyInfo: Record "Company Information";
        Window: Dialog;
    BEGIN
        RecLVSCSettings.GET();
        RecGCompanyInfo.GET();

        //Get Payment Lines
        RecLPaymentLine.RESET();
        RecLPaymentLine.SETCURRENTKEY("No.", "Account Type", "Account No.");
        RecLPaymentLine.SETRANGE("No.", RecPPaymentHeader."No.");
        RecLPaymentLine.SETRANGE("Account Type", RecLPaymentLine."Account Type"::Vendor);
        RecLPaymentLine.SETRANGE("BC6_E-mail Sent To Vendor", FALSE);
        IF RecLPaymentLine.FindSet() THEN BEGIN

            IF BooPInPageContext THEN
                IF NOT CONFIRM(MsgGConfirmSendEmail, FALSE) THEN
                    EXIT;

            //Check Sender E-mail and Export Path
            RecLVSCSettings.TESTFIELD("Draft Account Depart. E-mail");
            RecLVSCSettings.TESTFIELD("Draft Account Depart. Path");
            FileDirectory := RecLVSCSettings."Draft Account Depart. Path";

            //Window
            IF BooPInPageContext THEN
                Window.OPEN(MsgProgressEmails);

            CodLCurrentVendor := '';
            REPEAT
                IF CodLCurrentVendor <> RecLPaymentLine."Account No." THEN BEGIN
                    RecGVendor.GET(RecLPaymentLine."Account No.");
                    IF RecGVendor."E-Mail" <> '' THEN BEGIN
                        TxtLToFileName := FileDirectory + RecLPaymentLine."No." + '.pdf';

                        CLEAR(RepLPaymentMail);
                        RecPPaymentHeader.SETRECFILTER();
                        RepLPaymentMail.SETTABLEVIEW(RecPPaymentHeader);
                        RepLPaymentMail.FctSetVendorNo(RecLPaymentLine."Account No.");
                        RepLPaymentMail.SAVEASPDF(TxtLToFileName);

                        //Mail
                        TxtLMailSubject := STRSUBSTNO(TextGSubjectMail, RecGCompanyInfo.Name, RecPPaymentHeader."No.");

                        CLEAR(EMailMessage);
                        EMailMessage.Create(RecGVendor."E-Mail", TxtLMailSubject, '', TRUE);
                        //TODO mail.SaveAsDraft(RecLVSCSettings."Draft Account Depart. E-mail");

                        // the add of the attachement 
                        if not TempBlob.HasValue() then
                            exit;
                        TempBlob.CreateInStream(InStream);
                        EmailMessage.AddAttachment(TxtLToFileName, STRSUBSTNO(TxtGAttachName, RecPPaymentHeader."No."), InStream);

                        // create of the body 
                        EMailMessage.AppendToBody(Line0);
                        EMailMessage.AppendToBody(EmptyLine);
                        EMailMessage.AppendToBody(Line1);
                        EMailMessage.AppendToBody(EmptyLine);
                        EMailMessage.AppendToBody(Line2);
                        EMailMessage.AppendToBody(EmptyLine);
                        EMailMessage.AppendToBody(Line3);
                        EMailMessage.AppendToBody(Line4);
                        EMailMessage.AppendToBody(EmptyLine);

                        Mail.Send(EMailMessage);

                        //Update Payment Lines
                        RecLPaymentLine2.RESET();
                        RecLPaymentLine2.SETRANGE("No.", RecLPaymentLine."No.");
                        RecLPaymentLine2.SETRANGE("Account Type", RecLPaymentLine2."Account Type"::Vendor);
                        RecLPaymentLine2.SETRANGE("Account No.", RecLPaymentLine."Account No.");
                        RecLPaymentLine2.MODIFYALL("BC6_E-mail Sent To Vendor", TRUE);

                        ERASE(TxtLToFileName);

                    END;

                    CodLCurrentVendor := RecLPaymentLine."Account No.";
                END;
            UNTIL RecLPaymentLine.NEXT() = 0;

            IF BooPInPageContext THEN BEGIN
                Window.CLOSE();
                MESSAGE(MsgSendCompleted);
            END;

        END ELSE
            MESSAGE(MsgPaymentsNotFound);
    END;

}
