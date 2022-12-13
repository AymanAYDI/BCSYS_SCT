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
}
