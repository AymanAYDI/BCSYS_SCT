codeunit 50005 "BC6_EventsMgt"
{
    //---Codeunit11
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Check Line", 'OnCheckDimensionsOnAfterAssignDimTableIDs', '', false, false)]
    local procedure Cdu11_OnCheckDimensionsOnAfterAssignDimTableIDs_GenJnlCheckLine(var GenJournalLine: Record "Gen. Journal Line"; var TableID: array[10] of Integer; var No: array[10] of Code[20]; var CheckDone: Boolean)
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        BC6_FunctMgt.OnCheckDimensionsOnAfterAssignDimTableIDsCodeunit11(GenJournalLine, TableID, No, CheckDone);
    end;

    //---Codeunit12
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnInsertVATOnAfterAssignVATEntryFields', '', false, false)]
    local procedure Cdu12_OnInsertVATOnAfterAssignVATEntryFields_GenJnlPostLine(GenJnlLine: Record "Gen. Journal Line"; var VATEntry: Record "VAT Entry"; CurrExchRate: Record "Currency Exchange Rate")
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        BC6_FunctMgt.OnInsertVATOnAfterAssignVATEntryFields_Cdu12(VATEntry);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostVendOnAfterInitVendLedgEntry', '', false, false)]
    local procedure Cdu12_OnPostVendOnAfterInitVendLedgEntry_GenJnlPostLine(var GenJnlLine: Record "Gen. Journal Line"; var VendLedgEntry: Record "Vendor Ledger Entry")
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        BC6_FunctMgt.OnPostVendOnAfterInitVendLedgEntry_Cdu12(VendLedgEntry);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostVendAfterTempDtldCVLedgEntryBufInit', '', false, false)]
    local procedure Cdu12_OnPostVendAfterTempDtldCVLedgEntryBufInit_GenJnlPostLine(var GenJnlLine: Record "Gen. Journal Line"; var TempDtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer" temporary)
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        BC6_FunctMgt.OnPostVendAfterTempDtldCVLedgEntryBufInit_Cdu12(TempDtldCVLedgEntryBuf);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLRegister', '', false, false)]
    local procedure Cdu12_OnAfterInitGLRegister_GenJnlPostLine(var GLRegister: Record "G/L Register"; var GenJournalLine: Record "Gen. Journal Line")
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        BC6_FunctMgt.OnAfterInitGLRegister_Cdu12(GLRegister);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', false, false)]
    local procedure Cdu12_OnAfterInitGLEntry_GenJnlPostLine(var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        BC6_FunctMgt.OnAfterInitGLEntry_Cdu12(GLEntry, GenJournalLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnVendUnrealizedVATOnBeforeInitGLEntryVAT', '', false, false)]
    local procedure Cdu12_OnVendUnrealizedVATOnBeforeInitGLEntryVAT_GenJnlPostLine(var GenJournalLine: Record "Gen. Journal Line"; var VATEntry: Record "VAT Entry"; var VATAmount: Decimal; var VATBase: Decimal; var VATAmountAddCurr: Decimal; var VATBaseAddCurr: Decimal)
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        BC6_FunctMgt.OnAfterInitGLEntry_Cdu12(VATEntry, VATAmount, VATBase);
    end;
    //---Cdu22---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertCapValueEntry', '', false, false)]
    local procedure Cdu22_OnBeforeInsertCapValueEntry_ItemJnlPostLine(var ValueEntry: Record "Value Entry"; ItemJnlLine: Record "Item Journal Line")
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        BC6_FunctMgt.OnBeforeInsertCapValueEntry_Cdu22(ValueEntry);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnInsertItemRegOnBeforeItemRegInsert', '', false, false)]
    local procedure Cdu22_OnInsertItemRegOnBeforeItemRegInsert_ItemJnlPostLine(var ItemRegister: Record "Item Register"; var ItemJournalLine: Record "Item Journal Line")
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        BC6_FunctMgt.OnInsertItemRegOnBeforeItemRegInsert_Cdu22(ItemRegister);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnInitValueEntryOnBeforeRoundAmtValueEntry', '', false, false)]
    local procedure Cdu22_OnInitValueEntryOnBeforeRoundAmtValueEntry_ItemJnlPostLine(var ValueEntry: Record "Value Entry"; ItemJnlLine: Record "Item Journal Line")
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        BC6_FunctMgt.OnInitValueEntryOnBeforeRoundAmtValueEntry_Cdu22(ValueEntry);
    end;
    //---Cdu40 -> CDU "System Initialization"
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"System Initialization", 'OnAfterLogin', '', false, false)]
    local procedure Cdu40_OnAfterLogin_SystemInitialization()
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        BC6_FunctMgt.OnAfterLoginCodeunit150();
    end;
    //---Codeunit80
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure Cdu80_OnBeforePostSalesDoc_SalesPost(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean)
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        BC6_FunctMgt.OnBeforePostSalesDocCodeunit80(SalesHeader);
    end;
    //---Codeunit81
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeConfirmPost', '', false, false)]
    local procedure Cdu81_OnBeforeConfirmPost_SalesPostYesNo(var SalesHeader: Record "Sales Header"; var DefaultOption: Integer; var Result: Boolean; var IsHandled: Boolean)
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        BC6_FunctMgt.OnBeforeConfirmPostCodeunit81(DefaultOption);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnAfterConfirmPost', '', false, false)]
    local procedure Cdu81_OnAfterConfirmPost_SalesPostYesNo(var SalesHeader: Record "Sales Header")
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        BC6_FunctMgt.OnAfterConfirmPostCodeunit81(SalesHeader);
    end;

    //---Codeunit82
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post + Print", 'OnBeforeConfirmPostProcedure', '', false, false)]
    local procedure Cdu82_OnBeforeConfirmPostProcedure_SalesPostPrint(var SalesHeader: Record "Sales Header"; var DefaultOption: Integer; var Result: Boolean; var IsHandled: Boolean)
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        BC6_FunctMgt.OnAfterConfirmPostCodeunit82(DefaultOption);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post + Print", 'OnAfterConfirmPost', '', false, false)]
    local procedure Cdu82_OnAfterConfirmPost_SalesPostPrint(var SalesHeader: Record "Sales Header")
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        BC6_FunctMgt.OnAfterConfirmPostCodeunit81(SalesHeader);
    end;
    //---TAB18---
    [EventSubscriber(ObjectType::Table, DataBase::Customer, 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure TAB18_OnAfterValidateEvent_Customer(var xRec: Record Customer; var Rec: Record Customer; CurrFieldNo: Integer)
    var
        Text50000: label 'La longueur maximum du code client est de 10 caractères', Comment = 'FRA="La longueur maximum du code client est de 10 caractères"';
    begin
        if STRLEN(Rec."No.") > 10 then
            ERROR(Text50000);
    end;
    //---TAB23---
    [EventSubscriber(ObjectType::Table, DataBase::Vendor, 'OnAfterInsertEvent', '', false, false)]
    local procedure TAB23_OnAfterInsertEvent_Vendor(var Rec: Record Vendor; RunTrigger: Boolean)
    var
        FunctionsMgt: Codeunit "BC6_FunctionsMgt";
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        FunctionsMgt.OnAfterInsertVendor(Rec);
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::Vendor, 'OnAfterValidateNo', '', false, false)]
    local procedure TAB23_OnAfterValidateEvent_Vendor(var Vendor: Record Vendor; xVendor: Record Vendor)
    var
        Text50000: label 'The maximum length of the supplier code is 10 characters', Comment = 'FRA="La longueur maximum du code fournisseur est de 10 caractères"';
    begin
        if STRLEN(Vendor."No.") > 10 then
            ERROR(Text50000);
    end;
    //---TAB36---
    [EventSubscriber(ObjectType::Table, DataBase::"Sales Header", 'OnValidatePaymentTermsCodeOnBeforeCalculatePrepaymentDueDate', '', false, false)]
    local procedure TAB36_OnValidatePaymentTermsCodeOnBeforeCalculatePrepaymentDueDate_SalesHeader(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    var
        PaymentTerms: Record "Payment Terms";
    begin
        if Gbool_ImportGroupInvoice_SalesHeader then begin
            SalesHeader."Prepayment Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", TODAY);
            IsHandled := true;
        end
        else
            SalesHeader."Prepayment Due Date" := CalcDate(PaymentTerms."Due Date Calculation", SalesHeader."Document Date");
    end;

    //---TAB38---
    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Header", 'OnInitInsertOnBeforeInitRecord', '', false, false)]
    local procedure TAB38_OnInitInsertOnBeforeInitRecord_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; var xPurchaseHeader: Record "Purchase Header")
    begin
        if not Gbool_ImportGroupInvoice_PurchHeader then begin
            PurchaseHeader.VALIDATE(PurchaseHeader."Assigned User ID", USERID);
            PurchaseHeader.VALIDATE(PurchaseHeader."BC6_Original user", USERID);
            PurchaseHeader.VALIDATE(PurchaseHeader."BC6_Creation date", TODAY);
        end;
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Header", 'OnBeforeValidateDocumentDateWithPostingDate', '', false, false)]
    local procedure TAB38_OnBeforeValidateDocumentDateWithPostingDate_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; CallingFieldNo: Integer; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Header", 'OnInitFromVendorOnBeforeInitRecord', '', false, false)]
    local procedure TAB38_OnInitFromVendorOnBeforeInitRecord_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header")
    begin
        if xPurchaseHeader."Assigned User ID" <> '' then
            PurchaseHeader."Assigned User ID" := xPurchaseHeader."Assigned User ID";
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Header", 'OnUpdatePurchLinesByChangedFieldName', '', false, false)]
    local procedure TAB38_OnUpdatePurchLinesByChangedFieldName_PurchaseHeader(PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; ChangedFieldName: Text[100]; ChangedFieldNo: Integer)
    begin
        case ChangedFieldName of
            PurchHeader.FIELDCAPTION("BC6_Matricule No."):
                PurchLine.VALIDATE("BC6_Matricule No.", PurchHeader."BC6_Matricule No.");
        end;
    end;
    //---TAB39---
    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnAfterAssignHeaderValues', '', false, false)]
    local procedure TAB39_OnAfterAssignHeaderValues_PurchaseLine(var PurchLine: Record "Purchase Line"; PurchHeader: Record "Purchase Header")
    begin
        PurchLine."BC6_Matricule No." := PurchHeader."BC6_Matricule No.";
    end;
    //---TAB49---
    [EventSubscriber(ObjectType::Table, DataBase::"Invoice Posting Buffer", 'OnAfterPrepareSales', '', false, false)]
    local procedure TAB49_OnAfterPrepareSales_InvoicePostBuffer(var SalesLine: Record "Sales Line"; var InvoicePostingBuffer: Record "Invoice Posting Buffer")
    begin
        //DEBUT AJOUT JX-XAD 26/05/2009
        InvoicePostingBuffer."BC6_Description" := SalesLine.Description;  // Modif JX-XAD 05/08/2010 suite migration
        //FIN AJOUT JX-XAD 26/05/2009
    end;

    //---PAG146
    [EventSubscriber(ObjectType::Page, Page::"Posted Purchase Invoices", 'OnOpenPageEvent', '', false, false)]
    local procedure PAG146_OnOpenPageEvent_PostedPurchaseInvoices(var Rec: Record "Purch. Inv. Header")
    var
        FunctionsMgt: Codeunit "BC6_FunctionsMgt";
    begin
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("User ID", FunctionsMgt.jx_GetPurchasesFilter());
        Rec.FILTERGROUP(0);
    end;

    //---TAB25---
    [EventSubscriber(ObjectType::Table, DataBase::"Vendor Ledger Entry", 'OnAfterCopyVendLedgerEntryFromGenJnlLine', '', false, false)]
    local procedure TAB25_OnAfterCopyVendLedgerEntryFromGenJnlLine_VendorLedgerEntry(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        VendorLedgerEntry."BC6_BC No." := GenJournalLine."BC6_BC No.";
        VendorLedgerEntry."BC6_Yooz No." := GenJournalLine."BC6_Yooz No.";
        VendorLedgerEntry."BC6_Yooz Token link" := GenJournalLine."BC6_Yooz Token link";
        VendorLedgerEntry."BC6_Document Type Prepaid" := GenJournalLine."BC6_Document Type Prepaid";
        VendorLedgerEntry."BC6_Document Prepaid" := GenJournalLine."BC6_Document Prepaid";
    end;
    //(CopyToVendLedgEntry TAB 382) 
    [EventSubscriber(ObjectType::Table, DataBase::"Vendor Ledger Entry", 'OnAfterCopyVendLedgerEntryFromCVLedgEntryBuffer', '', false, false)]
    local procedure TAB25_OnAfterCopyVendLedgerEntryFromCVLedgEntryBuffer_VendorLedgerEntry(var VendorLedgerEntry: Record "Vendor Ledger Entry"; CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer")
    begin
        // PBE  PREPAID 21/07/2016
        VendorLedgerEntry."BC6_Document Type Prepaid" := CVLedgerEntryBuffer."BC6_Document Type Prepaid";
        VendorLedgerEntry."BC6_Document Prepaid" := CVLedgerEntryBuffer."BC6_Document Prepaid";
        //
    end;
    //---Codeunit 6620---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopyPurchaseDocument', '', false, false)]
    local procedure Cdu6620_OnAfterCopyPurchaseDocument_CopyDocumentMgt(FromDocumentType: Option; FromDocumentNo: Code[20]; var ToPurchaseHeader: Record "Purchase Header"; FromDocOccurenceNo: Integer; FromDocVersionNo: Integer; IncludeHeader: Boolean; RecalculateLines: Boolean; MoveNegLines: Boolean)
    begin
        if (IncludeHeader) and (ToPurchaseHeader."Document Type" = ToPurchaseHeader."Document Type"::Invoice) then begin
            ToPurchaseHeader."Assigned User ID" := USERID;
            ToPurchaseHeader.MODIFY();
        end;
    end;
    //---Codeunit/90---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure Codeunit90_OnBeforePostPurchaseDoc_PurchPost(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; CommitIsSupressed: Boolean; var HideProgressWindow: Boolean)
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        //Modif JX-VSC4.0-PBD du 24/06/15 Migration 2015 - Gestion statut réception
        BC6_FunctMgt.Fct_OnBeforePostPurchaseDocCodeunit90(PurchaseHeader, PreviewMode, CommitIsSupressed, HideProgressWindow);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchRcptHeaderInsert', '', false, false)]
    local procedure Codeunit90_OnBeforePurchRcptHeaderInsert_PurchPost(var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchaseHeader: Record "Purchase Header"; CommitIsSupressed: Boolean; WarehouseReceiptHeader: Record "Warehouse Receipt Header"; WhseReceive: Boolean; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; WhseShip: Boolean)
    begin
        PurchRcptHeader."User ID" := PurchaseHeader."Assigned User ID";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeReturnShptHeaderInsert', '', false, false)]
    local procedure Codeunit90_OnBeforeReturnShptHeaderInsert_PurchPost(var ReturnShptHeader: Record "Return Shipment Header"; var PurchHeader: Record "Purchase Header"; CommitIsSupressed: Boolean; WarehouseReceiptHeader: Record "Warehouse Receipt Header"; WhseReceive: Boolean; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; WhseShip: Boolean)
    begin
        ReturnShptHeader."User ID" := PurchHeader."Assigned User ID";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchInvHeaderInsert', '', false, false)]
    local procedure Codeunit90_OnBeforePurchInvHeaderInsert_PurchPost(var PurchInvHeader: Record "Purch. Inv. Header"; var PurchHeader: Record "Purchase Header"; CommitIsSupressed: Boolean)
    begin
        PurchInvHeader."User ID" := PurchHeader."Assigned User ID";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchCrMemoHeaderInsert', '', false, false)]
    local procedure Codeunit90_OnBeforePurchCrMemoHeaderInsert_PurchPost(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PurchHeader: Record "Purchase Header"; CommitIsSupressed: Boolean)
    begin
        PurchCrMemoHdr."User ID" := PurchHeader."Assigned User ID";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeCheckExternalDocumentNumber', '', false, false)]
    local procedure Codeunit90_OnBeforeCheckExternalDocumentNumber_PurchPost(VendorLedgerEntry: Record "Vendor Ledger Entry"; PurchaseHeader: Record "Purchase Header"; var Handled: Boolean; DocType: Option; ExtDocNo: Text[35]; SrcCode: Code[10]; GenJnlLineDocType: Enum "Gen. Journal Document Type"; GenJnlLineDocNo: Code[20]; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line")
    var
        VendorMgt: Codeunit "Vendor Mgt.";
    begin
        VendorLedgerEntry.Reset();
        VendorLedgerEntry.SetCurrentKey("External Document No.");
        VendorMgt.SetFilterForExternalDocNo(VendorLedgerEntry, GenJnlLineDocType, ExtDocNo, PurchaseHeader."Pay-to Vendor No.", PurchaseHeader."Document Date");
        Handled := true;
    end;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromPurchHeader', '', false, false)]
    local procedure Codeunit90_OnAfterCopyGenJnlLineFromPurchHeader_PurchPost(PurchaseHeader: Record "Purchase Header"; var GenJournalLine: Record "Gen. Journal Line")
    var
    begin
        GenJournalLine.Description := PurchaseHeader."Your Reference";
        GenJournalLine."BC6_BC No." := PurchaseHeader."BC6_BC No.";
        GenJournalLine."BC6_Yooz No." := PurchaseHeader."BC6_Yooz No.";
        GenJournalLine."BC6_Yooz Token link" := PurchaseHeader."BC6_Yooz Token link";
        if PurchaseHeader."BC6_Document Prepaid" then begin
            GenJournalLine."BC6_Document Type Prepaid" := PurchaseHeader."BC6_Document Type Prepaid";
            GenJournalLine."BC6_Document Prepaid" := PurchaseHeader."BC6_Document No. Prepaid";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnFinalizePostingOnAfterUpdateItemChargeAssgnt', '', false, false)]
    local procedure Codeunit90_OnFinalizePostingOnAfterUpdateItemChargeAssgnt_PurchPost(var PurchHeader: Record "Purchase Header")
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        if (PurchHeader."Document Type" = PurchHeader."Document Type"::Order) then
            BC6_FunctMgt.FctReceiptStatus(PurchHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeDeleteAfterPosting', '', false, false)]
    local procedure Codeunit90_OnBeforeDeleteAfterPosting_PurchPost(var PurchaseHeader: Record "Purchase Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var SkipDelete: Boolean; CommitIsSupressed: Boolean; var TempPurchLine: Record "Purchase Line" temporary; var TempPurchLineGlobal: Record "Purchase Line" temporary)
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        if (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order) then
            BC6_FunctMgt.FctReceiptStatus(PurchaseHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchLineDeleteAll', '', false, false)]
    local procedure Codeunit90_OnBeforePurchLineDeleteAll_PurchPost(var PurchaseLine: Record "Purchase Line"; CommitIsSupressed: Boolean; var TempPurchLine: Record "Purchase Line" temporary)
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
        lPurchOrder: Record "Purchase Header";
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        repeat
            if PurchRcptLine.GET(TempPurchLine."Receipt No.", TempPurchLine."Receipt Line No.") then
                if PurchRcptLine."Order No." <> '' then
                    if lPurchOrder.GET(lPurchOrder."Document Type"::Order, PurchRcptLine."Order No.") then
                        BC6_FunctMgt.FctReceiptStatus(lPurchOrder);
        until TempPurchLine.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"PostPurch-Delete", 'OnAfterInitDeleteHeader', '', false, false)]
    local procedure Codeunit364_OnAfterInitDeleteHeader_PostPurchDelete(var PurchHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var ReturnShptHeader: Record "Return Shipment Header"; var PurchInvHeaderPrepmt: Record "Purch. Inv. Header"; var PurchCrMemoHdrPrepmt: Record "Purch. Cr. Memo Hdr.")
    begin
        if (PurchHeader."Receiving No. Series" <> '') and (PurchHeader."Receiving No." <> '') then
            PurchRcptHeader."User ID" := PurchHeader."Assigned User ID";
        if (PurchHeader."Return Shipment No. Series" <> '') and (PurchHeader."Return Shipment No." <> '') then
            ReturnShptHeader."User ID" := PurchHeader."Assigned User ID";
        if (PurchHeader."Posting No. Series" <> '') and
        ((PurchHeader."Document Type" in [PurchHeader."Document Type"::"Return Order", PurchHeader."Document Type"::"Credit Memo"]) and
               (PurchHeader."Posting No." <> '') or
               (PurchHeader."Document Type" = PurchHeader."Document Type"::"Credit Memo") and
               (PurchHeader."No. Series" = PurchHeader."Posting No. Series"))
           then
            PurchCrMemoHdr."User ID" := PurchHeader."Assigned User ID";
        if (PurchHeader."Prepmt. Cr. Memo No. Series" <> '') and (PurchHeader."Prepmt. Cr. Memo No." <> '') then
            PurchCrMemoHdrPrepmt."User ID" := PurchHeader."Assigned User ID";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"PostPurch-Delete", 'OnAfterInitPurchInvHeader', '', false, false)]
    local procedure Codeunit364_OnAfterInitPurchInvHeader_PostPurchDelete(var PurchInvHeader: Record "Purch. Inv. Header"; PurchHeader: Record "Purchase Header")
    begin
        PurchInvHeader."User ID" := PurchHeader."Assigned User ID";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"PostPurch-Delete", 'OnAfterInitPurchInvHeaderPrepmt', '', false, false)]
    local procedure Codeunit364_OnAfterInitPurchInvHeaderPrepmt_PostPurchDelete(var PurchInvHeaderPrepmt: Record "Purch. Inv. Header"; PurchHeader: Record "Purchase Header")
    begin
        PurchInvHeaderPrepmt."User ID" := PurchHeader."Assigned User ID";
    end;
    // ---Codeunit/91---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeSelectPostOrderOption', '', false, false)]
    local procedure Codeunit91_OnBeforeSelectPostOrderOption_PurchPost(var PurchaseHeader: Record "Purchase Header"; DefaultOption: Integer; var Result: Boolean; var IsHandled: Boolean)
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        Result := BC6_FunctMgt.Fct_OnBeforeSelectPostOrderOptionCodeunit91(PurchaseHeader, DefaultOption, IsHandled);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnAfterConfirmPost', '', false, false)]
    local procedure Codeunit91_OnAfterConfirmPost_PurchPost(var PurchaseHeader: Record "Purchase Header")
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        BC6_FunctMgt.Fct_OnAfterConfirmPostCodeunit91(PurchaseHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnAfterPost', '', false, false)]
    local procedure Codeunit91_OnAfterPost_PurchPost(var PurchaseHeader: Record "Purchase Header")
    var
        TempGrec_Temp: Record "BC6_Table temporaire" temporary;
    begin
        //DEBUT MODIF JX-XAD 10/07/2009
        if TempGrec_Temp.GET(-1) then
            TempGrec_Temp.DELETE();
        //FIN MODIF JX-XAD 10/07/2009
    end;
    // ---Codeunit/92---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post + Print", 'OnBeforeSelectPostOrderOption', '', false, false)]
    local procedure Codeunit92_OnBeforeSelectPostOrderOption_PurchPostPrint(var PurchaseHeader: Record "Purchase Header"; DefaultOption: Integer; var Result: Boolean; var IsHandled: Boolean)
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        Result := BC6_FunctMgt.Fct_OnBeforeSelectPostOrderOptionCodeunit91(PurchaseHeader, DefaultOption, IsHandled);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post + Print", 'OnAfterConfirmPost', '', false, false)]
    local procedure Codeunit92_OnAfterConfirmPost_PurchPostPrint(PurchaseHeader: Record "Purchase Header")
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        BC6_FunctMgt.Fct_OnAfterConfirmPostCodeunit91(PurchaseHeader);
    end;
    //---Codeunit/415---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnCodeOnBeforeModifyHeader', '', false, false)]
    local procedure Codeunit415_OnCodeOnBeforeModifyHeader_ReleasePurchaseDocument(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; PreviewMode: Boolean; var LinesWereModified: Boolean)
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        BC6_FunctMgt.FctReceiptStatus(PurchaseHeader);
    end;
    //---CODEUNIT/5813---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", 'OnAfterCode', '', false, false)]
    local procedure Cdu5813_OnAfterCode_UndoPurchaseReceiptLine(var PurchRcptLine: Record "Purch. Rcpt. Line")
    var
        PurchOrder: Record "Purchase Header";
        PurchRelease: Codeunit "Release Purchase Document";
    begin
        if PurchRcptLine."Order No." <> '' then
            if PurchOrder.GET(PurchOrder."Document Type"::Order, PurchRcptLine."Order No.") then begin
                PurchRelease.Reopen(PurchOrder);
                PurchRelease.RUN(PurchOrder);
            end;
    end;
    //---TAB10865---
    [EventSubscriber(ObjectType::Table, DataBase::"Payment Header", 'OnAfterModifyEvent', '', false, false)]
    local procedure TAB10865_OnAfterModifyEvent_PaymentHeader(var Rec: Record "Payment Header"; RunTrigger: Boolean)
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        Rec.MODIFY();
        Rec.FctYooz(true);
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Payment Header", 'OnBeforeInsertEvent', '', false, false)]
    local procedure TAB10865_OnBeforeInsertEvent_PaymentHeader(var Rec: Record "Payment Header"; RunTrigger: Boolean)
    var
        GLSetup: Record "General Ledger Setup";
        GetProcess: Record "Payment Class";
        Process: Record "Payment Class";
        xRec: Record "Payment Header";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        if Rec."No." = '' then begin
            GLSetup.GET();
            IF GLSetup."BC6_Default Payment Class" <> '' then
                Process.GET(GLSetup."BC6_Default Payment Class")
            else
                if PAGE.RunModal(PAGE::"Payment Class List", GetProcess) = ACTION::LookupOK then
                    Process := GetProcess;
            Process.TestField("Header No. Series");
            NoSeriesMgt.InitSeries(Process."Header No. Series", xRec."No. Series", 0D, Rec."No.", Rec."No. Series");
            Rec.Validate("Payment Class", Process.Code);
        end;
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Payment Header", 'OnAfterInsertEvent', '', false, false)]
    local procedure TAB10865_OnAfterInsertEvent_PaymentHeader(var Rec: Record "Payment Header"; RunTrigger: Boolean)
    var
        CompanyInfo: Record "Company Information";
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        // JX-VSC3.0-PBD Banque info. Société par défaut
        CompanyInfo.GET();
        Rec.VALIDATE("Account No.", CompanyInfo."Default Bank Account No.");
        //
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Payment Header", 'OnAfterValidateEvent', 'Status No.', false, false)]
    local procedure TAB10865_OnAfterValidateEvent_PaymentHeader(var xRec: Record "Payment Header"; var Rec: Record "Payment Header"; CurrFieldNo: Integer)
    var
        RecLVSCSettings: Record "BC6_VSC Settings";
        CduLVendorPayments: Codeunit "BC6_Vendor Payments";
    begin
        //>>BC6 SBE 25/11/2021
        RecLVSCSettings.GET();
        IF (xRec."Status No." <> Rec."Status No.") AND (Rec."Status No." = 5000) THEN
            //Check If enabled Auto Mail Sending
            IF RecLVSCSettings."Draft Account Depart.Auto Send" THEN BEGIN
                CLEAR(CduLVendorPayments);
                CduLVendorPayments.FctSendPaymentMail(Rec, FALSE);
            END;
        //<<BC6 SBE 25/11/2021
    end;
    //---TAB10866---
    [EventSubscriber(ObjectType::Table, DataBase::"Payment Line", 'OnAfterModifyEvent', '', false, false)]
    local procedure TAB10866_OnAfterModifyEvent_PaymentLine(var Rec: Record "Payment Line"; RunTrigger: Boolean)
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        Rec.FctYooz(true);
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Payment Line", 'OnUpdateEntryOnBeforeDimensionSetup', '', false, false)]
    local procedure TAB10866_OnUpdateEntryOnBeforeDimensionSetup_PaymentLine(var PaymentLine: Record "Payment Line")
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        BC6_FunctMgt.OnUpdateEntryOnBeforeDimensionSetupTAB10866(PaymentLine);
    end;
    //---TAB288---
    [EventSubscriber(ObjectType::Table, DataBase::"Vendor Bank Account", 'OnAfterModifyEvent', '', false, false)]
    local procedure TAB288_OnAfterModifyEvent_VendorBankAccount(var xRec: Record "Vendor Bank Account"; var Rec: Record "Vendor Bank Account"; RunTrigger: Boolean)
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        BC6_FunctMgt.OnAfterModifyEventT288(xRec, Rec);
    end;
    //---TAB36
    procedure SetCompany_SalesHeader(NameSociety: Text[30])
    var
        BankAcc: Record "Bank Account";
        CompanyInfo: Record "Company Information";
        CurrExchRate: Record "Currency Exchange Rate";
        CustLedgEntry: Record "Cust. Ledger Entry";
        Cust: Record Customer;
        GLAcc: Record "G/L Account";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        GenJnILine: Record "Gen. Journal Line";
        GLSetup: Record "General Ledger Setup";
        InvtSetup: Record "Inventory Setup";
        Location: Record Location;
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        PostCode: Record "Post Code";
        ReservEntry: Record "Reservation Entry";
        RespCenter: Record "Responsibility Center";
        ReturnRcptHeader: Record "Return Receipt Header";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesCommentLine: Record "Sales Comment Line";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCrMemoHeaderPrepmt: Record "Sales Cr.Memo Header";
        SalesHeader: Record "Sales Header";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesInvHeaderPrepmt: Record "Sales Invoice Header";
        SalesLine: Record "Sales Line";
        SalesShptHeader: Record "Sales Shipment Header";
        ShipToAddr: Record "Ship-to Address";
        ShippingAgentService: Record "Shipping Agent Services";
        WhseRequest: Record "Warehouse Request";

    begin
        //MODIF JX-AUD du 12/05/14
        SalesSetup.CHANGECOMPANY(NameSociety);
        GLSetup.CHANGECOMPANY(NameSociety);
        GLAcc.CHANGECOMPANY(NameSociety);
        SalesHeader.CHANGECOMPANY(NameSociety);
        SalesLine.CHANGECOMPANY(NameSociety);
        CustLedgEntry.CHANGECOMPANY(NameSociety);
        Cust.CHANGECOMPANY(NameSociety);
        PaymentTerms.CHANGECOMPANY(NameSociety);
        PaymentMethod.CHANGECOMPANY(NameSociety);
        CurrExchRate.CHANGECOMPANY(NameSociety);
        SalesCommentLine.CHANGECOMPANY(NameSociety);
        ShipToAddr.CHANGECOMPANY(NameSociety);
        PostCode.CHANGECOMPANY(NameSociety);
        BankAcc.CHANGECOMPANY(NameSociety);
        SalesShptHeader.CHANGECOMPANY(NameSociety);
        SalesInvHeader.CHANGECOMPANY(NameSociety);
        SalesCrMemoHeader.CHANGECOMPANY(NameSociety);
        ReturnRcptHeader.CHANGECOMPANY(NameSociety);
        SalesInvHeaderPrepmt.CHANGECOMPANY(NameSociety);
        SalesCrMemoHeaderPrepmt.CHANGECOMPANY(NameSociety);
        GenBusPostingGrp.CHANGECOMPANY(NameSociety);
        GenJnILine.CHANGECOMPANY(NameSociety);
        RespCenter.CHANGECOMPANY(NameSociety);
        InvtSetup.CHANGECOMPANY(NameSociety);
        Location.CHANGECOMPANY(NameSociety);
        WhseRequest.CHANGECOMPANY(NameSociety);
        ShippingAgentService.CHANGECOMPANY(NameSociety);
        //TempReqLine.CHANGECOMPANY(NameSociety);
        ReservEntry.CHANGECOMPANY(NameSociety);
        //TempReservEntry.CHANGECOMPANY(NameSociety);
        CompanyInfo.CHANGECOMPANY(NameSociety);
        Gbool_ImportGroupInvoice_SalesHeader := true;
        //FIN MODIF JX-AUD du 12/05/14
    end;
    //---tab38
    procedure SetCompany_PurchaseHeader(NameSociety: Text[30])
    var
        BankAcc: Record "Bank Account";
        Grec_QualificationFAP: Record "BC6_FAP Status";
        Grec_Matricule: Record "BC6_Matricule";
        CompanyInfo: Record "Company Information";
        CurrExchRate: Record "Currency Exchange Rate";
        Cust: Record Customer;
        GLAcc: Record "G/L Account";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        GenJnILine: Record "Gen. Journal Line";
        GLSetup: Record "General Ledger Setup";
        InvtSetup: Record "Inventory Setup";
        Location: Record Location;
        OrderAddr: Record "Order Address";
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        PostCode: Record "Post Code";
        PurchCommentLine: Record "Purch. Comment Line";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        PurchCrMemoHeaderPrepmt: Record "Purch. Cr. Memo Hdr.";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchInvHeaderPrepmt: Record "Purch. Inv. Header";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        xPurchLine: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
        RespCenter: Record "Responsibility Center";
        ReturnShptHeader: Record "Return Shipment Header";
        ShipToAddr: Record "Ship-to Address";
        Vend: Record Vendor;
        VendLedgEntry: Record "Vendor Ledger Entry";
        WhseRequest: Record "Warehouse Request";
    begin
        //MODIF JX-AUD du 12/05/14
        PurchSetup.CHANGECOMPANY(NameSociety);
        GLSetup.CHANGECOMPANY(NameSociety);
        GLAcc.CHANGECOMPANY(NameSociety);
        PurchLine.CHANGECOMPANY(NameSociety);
        xPurchLine.CHANGECOMPANY(NameSociety);
        VendLedgEntry.CHANGECOMPANY(NameSociety);
        Vend.CHANGECOMPANY(NameSociety);
        PaymentTerms.CHANGECOMPANY(NameSociety);
        PaymentMethod.CHANGECOMPANY(NameSociety);
        CurrExchRate.CHANGECOMPANY(NameSociety);
        PurchHeader.CHANGECOMPANY(NameSociety);
        PurchCommentLine.CHANGECOMPANY(NameSociety);
        ShipToAddr.CHANGECOMPANY(NameSociety);
        Cust.CHANGECOMPANY(NameSociety);
        CompanyInfo.CHANGECOMPANY(NameSociety);
        PostCode.CHANGECOMPANY(NameSociety);
        OrderAddr.CHANGECOMPANY(NameSociety);
        BankAcc.CHANGECOMPANY(NameSociety);
        PurchRcptHeader.CHANGECOMPANY(NameSociety);
        PurchInvHeader.CHANGECOMPANY(NameSociety);
        PurchCrMemoHeader.CHANGECOMPANY(NameSociety);
        ReturnShptHeader.CHANGECOMPANY(NameSociety);
        PurchInvHeaderPrepmt.CHANGECOMPANY(NameSociety);
        PurchCrMemoHeaderPrepmt.CHANGECOMPANY(NameSociety);
        GenBusPostingGrp.CHANGECOMPANY(NameSociety);
        GenJnILine.CHANGECOMPANY(NameSociety);
        RespCenter.CHANGECOMPANY(NameSociety);
        Location.CHANGECOMPANY(NameSociety);
        WhseRequest.CHANGECOMPANY(NameSociety);
        InvtSetup.CHANGECOMPANY(NameSociety);
        Grec_Matricule.CHANGECOMPANY(NameSociety);
        Grec_QualificationFAP.CHANGECOMPANY(NameSociety);
        Gbool_ImportGroupInvoice_PurchHeader := true;
        //FIN MODIF JX-AUD du 12/05/14
    end;
    //---TAB382---
    [EventSubscriber(ObjectType::Table, DataBase::"CV Ledger Entry Buffer", 'OnAfterCopyFromVendLedgerEntry', '', false, false)]
    local procedure TAB382_OnAfterCopyFromVendLedgerEntry_CVLedgerEntryBuffer(var CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer"; VendorLedgerEntry: Record "Vendor Ledger Entry")
    begin
        CVLedgerEntryBuffer."BC6_Document Type Prepaid" := VendorLedgerEntry."BC6_Document Type Prepaid";
        CVLedgerEntryBuffer."BC6_Document Prepaid" := VendorLedgerEntry."BC6_Document Prepaid";
    end;
    //---PAG97
    [EventSubscriber(ObjectType::Page, Page::"Purchase Quote Subform", 'OnAfterNoOnAfterValidate', '', false, false)]
    local procedure PAG91_OnAfterNoOnAfterValidate_PurchaseQuoteSubform(var PurchaseLine: Record "Purchase Line"; var xPurchaseLine: Record "Purchase Line")
    begin
        //Modif JX-AUD du 25/01/2013
        if ((COMPANYNAME = 'VSC') or (COMPANYNAME = 'VSCT') or (COMPANYNAME = 'Agence') or (COMPANYNAME = 'VFEC') or
          (COMPANYNAME = 'VSC - RECETTE') or (COMPANYNAME = 'VSCT - RECETTE')
          or (COMPANYNAME = 'Agence - RECETTE') or (COMPANYNAME = 'VFEC - RECETTE') or (COMPANYNAME = 'SNCF-C25')) then
            if PurchaseLine.Type = PurchaseLine.Type::Item then// Type article
                if PurchaseLine."Unit of Measure" = 'Euros' then//Unité EUROS


                    PurchaseLine.VALIDATE("Direct Unit Cost", 1);
        //Fin  modif JX-AUD du 25/01/2013
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Quote Subform", 'OnAfterValidateEvent', 'Direct Unit Cost', false, false)]
    local procedure PAG91_OnAfterValidateEventDirectUnitCost_PurchaseQuoteSubform(var xRec: Record "Purchase Line"; var Rec: Record "Purchase Line")
    begin
        //Modif JX-AUD du 25/01/2013
        if ((COMPANYNAME = 'VSC') or (COMPANYNAME = 'VSCT') or (COMPANYNAME = 'Agence') or (COMPANYNAME = 'VFEC') or
          (COMPANYNAME = 'VSC - RECETTE') or (COMPANYNAME = 'VSCT - RECETTE')
          or (COMPANYNAME = 'Agence - RECETTE') or (COMPANYNAME = 'VFEC - RECETTE') or (COMPANYNAME = 'SNCF-C25')) then
            if Rec.Type = Rec.Type::Item then// Type article
                if Rec."Unit of Measure" = 'Euros' then//Unité EUROS
                    Rec.VALIDATE("Direct Unit Cost", 1);
        //Fin  modif JX-AUD du 25/01/2013
    end;
    //---PAG136---
    [EventSubscriber(ObjectType::Page, Page::"Posted Purchase Receipt", 'OnOpenPageEvent', '', false, false)]
    local procedure PAG136_OnOpenPageEvent_PostedPurchaseReceipt(var Rec: Record "Purch. Rcpt. Header")
    var
        FunctionsMgt: Codeunit "BC6_FunctionsMgt";
    begin
        //Début Modif JX-XAD du 05/08/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramŠtres utilisateur)
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("User ID", FunctionsMgt.jx_GetPurchasesFilter());
        Rec.FILTERGROUP(0);
        //Fin Modif JX-XAD du 05/08/2008
    end;
    //---TAB121 
    [EventSubscriber(ObjectType::Table, DataBase::"Purch. Rcpt. Line", 'OnAfterCopyFromPurchRcptLine', '', false, false)]
    local procedure TAB121_OnAfterCopyFromPurchRcptLine_PurchRcptLine(var PurchaseLine: Record "Purchase Line"; PurchRcptLine: Record "Purch. Rcpt. Line"; var TempPurchLine: Record "Purchase Line")
    var
        PurchInvHeader: Record "Purchase Header";
    begin
        if PurchInvHeader."No." <> TempPurchLine."Document No." then
            PurchInvHeader.Get(TempPurchLine."Document Type", TempPurchLine."Document No.");
        // Migration 2015 : A la demande de VSC
        PurchaseLine.VALIDATE("VAT Bus. Posting Group", PurchInvHeader."VAT Bus. Posting Group");
        // Migration 2015 : A la demande de VSC
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purch. Rcpt. Line", 'OnBeforeInsertInvLineFromRcptLineBeforeInsertTextLine', '', false, false)]
    local procedure TAB121_OnBeforeInsertInvLineFromRcptLineBeforeInsertTextLine_PurchRcptLine(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchLine: Record "Purchase Line"; var NextLineNo: Integer; var Handled: Boolean)
    var
        Text000: Label 'Receipt No. %1- order %2 :', Comment = 'FRA="N° réception %1 - Commande %2 :"';
    begin
        // Modif LAB du 11/12/2008
        // Ajout Numéro de commande depuis extraction ligne réception sur ligne facture
        PurchLine.Description := STRSUBSTNO(Text000, PurchRcptLine."Document No.", PurchRcptLine."Order No.");
        //fin modif LAB du 11/12/2008
    end;
    //---PAG6650
    [EventSubscriber(ObjectType::Page, Page::"Posted Return Shipment", 'OnOpenPageEvent', '', false, false)]
    local procedure PAG6650_OnOpenPageEvent_PostedReturnShipment(var Rec: Record "Return Shipment Header")
    var
        UserMgt: Codeunit "BC6_FunctionsMgt";
    begin
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("User ID", UserMgt.jx_GetPurchasesFilter());
        Rec.FILTERGROUP(0);
        Rec.SetSecurityFilterOnRespCenter();
    end;
    //---PAG10868
    [EventSubscriber(ObjectType::Page, Page::"Payment Slip", 'OnAfterGetRecordEvent', '', false, false)]
    local procedure PAG10868_OnAfterGetRecord_PaymentSlip(var Rec: Record "Payment Header")
    var
        PaymentSlip: Page "Payment Slip";
    begin
        PaymentSlip.FctYoozNo();
    end;

    [EventSubscriber(ObjectType::Page, Page::"Payment Slip", 'OnAfterGetCurrRecordEvent', '', false, false)]
    local procedure PAG10868_OnAfterGetCurrRecord_PaymentSlip(var Rec: Record "Payment Header")
    var
        PaymentSlip: Page "Payment Slip";
    begin
        PaymentSlip.FctYoozNo();
    end;

    //---TAB296---
    [EventSubscriber(ObjectType::Table, DataBase::"Reminder Line", 'OnAfterModifyEvent', '', false, false)]
    local procedure TAB296_OnAfterModifyEvent_ReminderLine(var xRec: Record "Reminder Line"; var Rec: Record "Reminder Line"; RunTrigger: Boolean)
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        BC6_FunctMgt.OnAfterModifyEventT296(Rec);
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Reminder Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure TAB296_OnAfterInsertEvent_ReminderLine(var Rec: Record "Reminder Line"; RunTrigger: Boolean)
    var
        BC6_FunctMgt: Codeunit "BC6_FunctionsMgt";
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        BC6_FunctMgt.OnAfterInsertEventT296(Rec);
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Reminder Line", 'OnAfterCopyFromCustLedgEntry', '', false, false)]
    local procedure TAB296_OnAfterCopyFromCustLedgEntry_ReminderLine(var ReminderLine: Record "Reminder Line"; CustLedgerEntry: Record "Cust. Ledger Entry")
    var
        Grec_SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        //DEBUT JX-XAD 03/09/2010
        IF Grec_SalesInvoiceHeader.GET(ReminderLine."Document No.") THEN BEGIN
            ReminderLine."BC6_Agent" := Grec_SalesInvoiceHeader."BC6_Agent";
            ReminderLine."BC6_Paying agent" := Grec_SalesInvoiceHeader."BC6_Paying agent";
        END;
        //FIN JX-XAD 03/09/2010
    end;
    //---TAB480---
    [EventSubscriber(ObjectType::Table, DataBase::"Dimension Set Entry", 'OnAfterInsertEvent', '', false, false)]
    local procedure TAB480_OnAfterInsertEvent_DimensionSetEntry(var Rec: Record "Dimension Set Entry"; RunTrigger: Boolean)
    var
        DimVal: Record "Dimension Value";
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        IF DimVal.GET(Rec."Dimension Code", Rec."Dimension Value Code") THEN
            Rec."Dimension Value ID" := DimVal."Dimension Value ID"
        ELSE BEGIN
            DimVal.INIT();
            DimVal.VALIDATE("Dimension Code", Rec."Dimension Code");
            DimVal.VALIDATE(Code, Rec."Dimension Value Code");
            DimVal.VALIDATE("Dimension Value Type", DimVal."Dimension Value Type"::Standard);
            DimVal.INSERT(TRUE);
            DimVal.GET(Rec."Dimension Code", Rec."Dimension Value Code");
            Rec."Dimension Value ID" := DimVal."Dimension Value ID";
            Rec.Modify();
        END;
    end;
    //---CDU74
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Get Receipt", 'OnBeforeTestPurchRcptLineVATBusPostingGroup', '', false, false)]
    local procedure Cdu74_OnBeforeTestPurchRcptLineVATBusPostingGroup_PurchGetReceipt(PurchRcptLine: Record "Purch. Rcpt. Line"; PurchHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Get Receipt", 'OnCreateInvLinesOnAfterCalcShowNotSameVendorsMessage', '', false, false)]
    local procedure Cdu74_OnCreateInvLinesOnAfterCalcShowNotSameVendorsMessage_PurchGetReceipt(PurchHeader: Record "Purchase Header"; PurchRcptHeader: Record "Purch. Rcpt. Header"; var TransferLine: Boolean; var ShowDifferentPayToVendMsg: Boolean)
    var
        Text000: Label 'The %1 on the %2 %3 and the %4 %5 must be the same.', Comment = 'FRA="Le %1 de l''%2 %3 et de l''%4 %5 doit être le même. %6 %7"';
    begin
        if ShowDifferentPayToVendMsg then begin
            Message(Text000, PurchHeader.FieldCaption("Pay-to Vendor No."), PurchHeader.TableCaption(), PurchHeader."No.",
            PurchRcptHeader.TableCaption(), PurchRcptHeader."No.", PurchHeader."Pay-to Vendor No.", PurchRcptHeader."Pay-to Vendor No.");
            TransferLine := false;
        end;
        ShowDifferentPayToVendMsg := false;
    end;
    //---CDU408
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"DimensionManagement", 'OnBeforeLookupDimValueCode', '', false, false)]
    local procedure Cdu408_OnBeforeLookupDimValueCode_DimensionManagement(FieldNumber: Integer; var ShortcutDimCode: Code[20]; var IsHandled: Boolean)
    var
        FunctionsMgt: Codeunit BC6_FunctionsMgt;
    begin
        FunctionsMgt.BC6_LookupDimValueCode_CDU408(FieldNumber, ShortcutDimCode, IsHandled);
    end;
    //---Tab81
    [EventSubscriber(ObjectType::Table, DataBase::"Gen. Journal Line", 'OnBeforeValidateShortcutDimCode', '', false, false)]
    local procedure Tab81_OnBeforeValidateShortcutDimCode_GenJournalLine(var GenJournalLine: Record "Gen. Journal Line"; var xGenJournalLine: Record "Gen. Journal Line"; FieldNumber: Integer; var ShortcutDimCode: Code[20]; var IsHandled: Boolean)
    var
        FunctionsMgt: codeunit "BC6_FunctionsMgt";
    begin
        if FieldNumber > 8 then begin
            IsHandled := true;
            GenJournalLine.TestField("Check Printed", false);
            FunctionsMgt.BC6_ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, GenJournalLine."Dimension Set ID");
        end;

    end;
    //---Tab81
    [EventSubscriber(ObjectType::Table, DataBase::"Gen. Journal Line", 'OnBeforeLookupShortcutDimCode', '', false, false)]
    local procedure Tab81_OnBeforeLookupShortcutDimCode_GenJournalLine(var GenJournalLine: Record "Gen. Journal Line"; xGenJournalLine: Record "Gen. Journal Line"; FieldNumber: Integer; var ShortcutDimCode: Code[20]; var IsHandled: Boolean)
    var
        FunctionsMgt: codeunit "BC6_FunctionsMgt";
    begin
        if FieldNumber > 8 then begin
            GenJournalLine.TestField("Check Printed", false);
            FunctionsMgt.BC6_LookupDimValueCode_CDU408(FieldNumber, ShortcutDimCode, IsHandled);
            FunctionsMgt.BC6_ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, GenJournalLine."Dimension Set ID");
        end;

    end;
    //---Tab39
    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnBeforeValidateShortcutDimCode', '', false, false)]
    local procedure Tab39_OnBeforeValidateShortcutDimCode_PurchaseLine(var PurchaseLine: Record "Purchase Line"; var xPurchaseLine: Record "Purchase Line"; FieldNumber: Integer; var ShortcutDimCode: Code[20]; var IsHandled: Boolean)
    var
        FunctionsMgt: codeunit "BC6_FunctionsMgt";
    begin
        if FieldNumber > 8 then begin
            IsHandled := true;
            FunctionsMgt.BC6_ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, PurchaseLine."Dimension Set ID");
            FunctionsMgt.VerifyItemLineDim();
        end;
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnBeforeLookupShortcutDimCode', '', false, false)]
    local procedure Tab39_OnBeforeLookupShortcutDimCode_PurchaseLine(var PurchaseLine: Record "Purchase Line"; var xPurchaseLine: Record "Purchase Line"; FieldNumber: Integer; var ShortcutDimCode: Code[20]; var IsHandled: Boolean)
    var
        FunctionsMgt: codeunit "BC6_FunctionsMgt";
    begin
        if FieldNumber > 8 then begin
            FunctionsMgt.BC6_LookupDimValueCode_CDU408(FieldNumber, ShortcutDimCode, IsHandled);
            FunctionsMgt.BC6_ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, PurchaseLine."Dimension Set ID");
            FunctionsMgt.VerifyItemLineDim();
        end;
    end;
    //---TAB37
    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnBeforeLookupShortcutDimCode', '', false, false)]
    local procedure TAB37_OnBeforeLookupShortcutDimCode(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; FieldNumber: Integer; var ShortcutDimCode: Code[20]; var IsHandled: Boolean)
    var
        FunctionsMgt: codeunit "BC6_FunctionsMgt";
    begin
        if FieldNumber > 8 then begin
            FunctionsMgt.BC6_LookupDimValueCode_CDU408(FieldNumber, ShortcutDimCode, IsHandled);
            FunctionsMgt.BC6_ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, SalesLine."Dimension Set ID");
            FunctionsMgt.VerifyItemLineDim();
        end;
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnBeforeValidateShortcutDimCode', '', false, false)]
    local procedure TAB37_OnBeforeValidateShortcutDimCode(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; FieldNumber: Integer; var ShortcutDimCode: Code[20]; var IsHandled: Boolean)
    var
        FunctionsMgt: codeunit "BC6_FunctionsMgt";
    begin
        if FieldNumber > 8 then begin
            IsHandled := true;
            FunctionsMgt.BC6_ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, SalesLine."Dimension Set ID");
            FunctionsMgt.VerifyItemLineDim();
        end;
    end;

    //COD343
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Dimension CaptionClass Mgmt", 'OnTranslateDimCaptionClassOnDimCaptionTypeCaseElse', '', false, false)]
    local procedure COD343_OnTranslateDimCaptionClassOnDimCaptionTypeCaseElse(DimCaptionType: Text[80]; DimCaptionRef: Text[80]; Language: Integer; DimOptionalParam1: Text[80]; DimOptionalParam2: Text[80]; var Result: Text; var IsHandled: Boolean)
    var
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.Get();
        case DimCaptionType of
            '50000':
                begin
                    case DimCaptionRef of
                        '9':
                            Result :=
                              CodeCaption(
                                Language, DimOptionalParam1, DimOptionalParam2,
                                GLSetup."BC6_Shortcut Dimension 9 Code",
                                GLSetup.FieldCaption("BC6_Shortcut Dimension 9 Code"));
                        '10':
                            Result :=
                              CodeCaption(
                                Language, DimOptionalParam1, DimOptionalParam2,
                                GLSetup."BC6_Shortcut Dimension 10 Code",
                                GLSetup.FieldCaption("BC6_Shortcut Dimension 10 Code"));
                    end;
                    IsHandled := true;
                end;
        end;
    end;

    local procedure CodeCaption(Language: Integer; DimOptionalParam1: Text; DimOptionalParam2: Text; DimCode: Code[20]; DimFieldCaption: Text[1024]): Text
    var
        Dim: Record Dimension;
    begin
        if Dim.Get(DimCode) then
            exit(DimOptionalParam1 + Dim.GetMLCodeCaption(Language) + DimOptionalParam2);
        exit(
          DimOptionalParam1 +
          DimFieldCaption +
          DimOptionalParam2);
    end;

    var
        Gbool_ImportGroupInvoice_PurchHeader: Boolean;
        Gbool_ImportGroupInvoice_SalesHeader: Boolean;
}
