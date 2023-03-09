codeunit 50011 "BC6_FunctionsMgt"
{
    //---Codeunit12---
    procedure OnInsertVATOnAfterAssignVATEntryFields_Cdu12(var VATEntry: Record "VAT Entry")
    var
        Grec_Temp: Record "BC6_Table temporaire";
        Gcode_Utilisateur: Code[50];
    begin
        //DEBUT MODIF JX-XAD 10/07/2009
        //VATEntry."User ID" := USERID;
        if Grec_Temp.GET(-1) then
            Gcode_Utilisateur := Grec_Temp.Compte
        else
            Gcode_Utilisateur := USERID;
        VATEntry."User ID" := Gcode_Utilisateur;
        //FIN MODIF JX-XAD 10/07/2009
    end;

    procedure OnPostVendOnAfterInitVendLedgEntry_Cdu12(var VendLedgEntry: Record "Vendor Ledger Entry")
    var
        Grec_Temp: Record "BC6_Table temporaire";
        Gcode_Utilisateur: Code[50];
    begin
        //DEBUT MODIF JX-XAD 10/07/2009
        //VendLedgEntry."User ID" := USERID;
        if Grec_Temp.GET(-1) then
            Gcode_Utilisateur := Grec_Temp.Compte
        else
            Gcode_Utilisateur := USERID;
        VendLedgEntry."User ID" := Gcode_Utilisateur;
        //FIN MODIF JX-XAD 10/07/2009
    end;

    procedure OnPostVendAfterTempDtldCVLedgEntryBufInit_Cdu12(var TempDtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer" temporary)
    var
        Grec_Temp: Record "BC6_Table temporaire";
        Gcode_Utilisateur: Code[50];
    begin
        //DEBUT MODIF JX-XAD 10/07/2009
        //DtldCVLedgEntryBuf."User ID" := USERID;
        if Grec_Temp.GET(-1) then
            Gcode_Utilisateur := Grec_Temp.Compte
        else
            Gcode_Utilisateur := USERID;
        TempDtldCVLedgEntryBuf."User ID" := Gcode_Utilisateur;
        //FIN MODIF JX-XAD 10/07/2009
    end;

    procedure OnAfterInitGLRegister_Cdu12(var GLRegister: Record "G/L Register")
    var
        Grec_Temp: Record "BC6_Table temporaire";
        Gcode_Utilisateur: Code[50];
    begin
        //DEBUT MODIF JX-XAD 10/07/2009
        //GLReg."User ID" := USERID;
        if Grec_Temp.GET(-1) then
            Gcode_Utilisateur := Grec_Temp.Compte
        else
            Gcode_Utilisateur := USERID;
        GLRegister."User ID" := Gcode_Utilisateur;
        //FIN MODIF JX-XAD 10/07/2009
    end;

    procedure OnAfterInitGLEntry_Cdu12(var GLEntry: Record "G/L Entry"; GenJnlLine: Record "Gen. Journal Line")
    var
        Grec_Temp: Record "BC6_Table temporaire";
        lVendLedgEntry: Record "Vendor Ledger Entry";
        Gcode_Utilisateur: Code[50];
    begin
        //DEBUT MODIF JX-XAD 10/07/2009
        //GLEntry."User ID" := USERID;
        if Grec_Temp.GET(-1) then
            Gcode_Utilisateur := Grec_Temp.Compte
        else
            Gcode_Utilisateur := USERID;
        GLEntry."User ID" := Gcode_Utilisateur;
        //FIN MODIF JX-XAD 10/07/2009

        //D‚but Modif JX-XAD 22/10/2008
        GLEntry."BC6_Vendor No." := GenJnlLine."BC6_Vendor No.";
        GLEntry."BC6_Customer No." := GenJnlLine."BC6_Customer No.";   //Ajout JX-XAD 01/10/2010
        //Fin Modif JX-XAD 22/10/2008

        // JX-VSC4.1-PBD  PREPAID 21/07/2016
        if (GenJnlLine."BC6_Document Prepaid" <> '') and (GenJnlLine."Account Type" = GenJnlLine."Account Type"::Vendor) then
            if GLEntry."Document Type" = GLEntry."Document Type"::Invoice then begin
                lVendLedgEntry.RESET();
                lVendLedgEntry.SETCURRENTKEY("Vendor No.", "BC6_Document Type Prepaid", "BC6_Document Prepaid");
                lVendLedgEntry.SETRANGE("Vendor No.", GenJnlLine."Account No.");
                lVendLedgEntry.SETRANGE("BC6_Document Type Prepaid", GenJnlLine."BC6_Document Type Prepaid");
                lVendLedgEntry.SETRANGE("BC6_Document Prepaid", GenJnlLine."BC6_Document Prepaid");
                if lVendLedgEntry.FINDFIRST() then
                    if lVendLedgEntry.Open then begin
                        GenJnlLine."Applies-to Doc. Type" := lVendLedgEntry."Document Type";
                        GenJnlLine."Applies-to Doc. No." := lVendLedgEntry."Document No.";
                        GenJnlLine."Applies-to ID" := GenJnlLine."Document No.";
                        lVendLedgEntry."Applies-to ID" := GenJnlLine."Document No.";
                        lVendLedgEntry.MODIFY();
                    end;
            end else begin
                GLEntry."BC6_Document Type Prepaid" := GenJnlLine."BC6_Document Type Prepaid";
                GLEntry."BC6_Document Prepaid" := GenJnlLine."BC6_Document Prepaid";
            end;
        //
    end;

    procedure OnAfterInitGLEntry_Cdu12(var VATEntry: Record "VAT Entry"; var VATAmount: Decimal; var VATBase: Decimal)
    begin
        VATAmount := VATEntry."Unrealized Amount";
        VATBase := VATEntry."Unrealized Base";
    end;
    //---Cdu22
    procedure OnBeforeInsertCapValueEntry_Cdu22(var ValueEntry: Record "Value Entry")
    var
        Grec_Temp: Record "BC6_Table temporaire";
        Gcode_Utilisateur: Code[50];
    begin
        if Grec_Temp.GET(-1) then
            Gcode_Utilisateur := Grec_Temp.Compte
        else
            Gcode_Utilisateur := USERID;
        ValueEntry."User ID" := Gcode_Utilisateur;
    end;

    procedure OnInsertItemRegOnBeforeItemRegInsert_Cdu22(var ItemRegister: Record "Item Register")
    var
        Grec_Temp: Record "BC6_Table temporaire";
        Gcode_Utilisateur: Code[50];
    begin
        if Grec_Temp.GET(-1) then
            Gcode_Utilisateur := Grec_Temp.Compte
        else
            Gcode_Utilisateur := USERID;
        ItemRegister."User ID" := Gcode_Utilisateur;
    end;

    procedure OnInitValueEntryOnBeforeRoundAmtValueEntry_Cdu22(var ValueEntry: Record "Value Entry")
    var
        Grec_Temp: Record "BC6_Table temporaire";
        Gcode_Utilisateur: Code[50];
    begin
        if Grec_Temp.GET(-1) then
            Gcode_Utilisateur := Grec_Temp.Compte
        else
            Gcode_Utilisateur := USERID;
        ValueEntry."User ID" := Gcode_Utilisateur;
    end;
    //---Cdu40 -> Cdu "System Initialization"
    procedure OnAfterLoginCodeunit150()
    var
        LVSCSettings: Record "BC6_VSC Settings";
    begin
        // JX-VSC3.0-PBD Check VSC Settings
        if not LVSCSettings.GET() then begin
            LVSCSettings.INIT();
            LVSCSettings."On Client" := true;
            LVSCSettings."New Server" := true;
            LVSCSettings."BC Path" := '\\10.16.34.109\Pdf\Fournisseurs\';
            LVSCSettings.INSERT();
        end;
        //
    end;
    //Codeunit80
    procedure OnBeforePostSalesDocCodeunit80(var SalesHeader: Record "Sales Header")
    var
        Text061: label 'The field "Your reference" in header %1 is mandatory', Comment = 'FRA="Le champs "Votre référence" dans en-tête %1 est obligatoire"';
        Text062: label 'The field "Your reference" in header %1 is mandatory', Comment = 'FRA="Le champs "Notre référence" dans en-tête %1 est obligatoire"';
    begin
        //DEBUT MODIF JX-XAD 20/05/2011
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) or (SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo") then begin
            if SalesHeader."Your Reference" = '' then
                ERROR(Text061, SalesHeader."Document Type");
            SalesHeader."Posting Description" := SalesHeader."Your Reference";
        end;
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) then//Modif JX-AUD du 15/02/2013
            if SalesHeader."Your Reference" = '' then
                ERROR(Text062, SalesHeader."Document Type");
        //FIN MODIF JX-XAD 20/05/2011
    end;

    //---Codeunit81
    procedure OnBeforeConfirmPostCodeunit81(var DefaultOption: Integer)
    begin
        DefaultOption := 1;
    end;

    procedure OnAfterConfirmPostCodeunit81(var SalesHeader: Record "Sales Header")
    var
        Lrec_DimensionValue: Record "Dimension Value";
        Lrec_Dimension: Record Dimension;
        Lrec_SalesLine: Record "Sales Line";
        Lcode_AxeReserve: Code[10];
        LCode_DimCode: array[50] of Code[20];
        LCode_DimValueCode: array[50] of Code[20];
        Lint_Compteur: Integer;
    begin
        //DEBUT MODIF JX XAD 16/03/2011 (traitement modification analytique manuelle post validation)
        Lcode_AxeReserve := 'RESERVE';
        if Lrec_Dimension.GET(Lcode_AxeReserve) then begin
            // On initialise, si n‚cessaire, les sections de l'axe analytique 'RESERVE'
            if not Lrec_DimensionValue.GET(Lcode_AxeReserve, '100') then
                for Lint_Compteur := 1 to 100 do
                    if not Lrec_DimensionValue.GET(Lcode_AxeReserve, FORMAT(Lint_Compteur)) then begin
                        Lrec_DimensionValue.INIT();
                        Lrec_DimensionValue.VALIDATE(Lrec_DimensionValue."Dimension Code", Lcode_AxeReserve);
                        Lrec_DimensionValue.VALIDATE(Lrec_DimensionValue.Code, FORMAT(Lint_Compteur));
                        Lrec_DimensionValue.INSERT();
                    end;
            // Traitement de l'axe analytique 'RESERVE' pour chaque ligne du document
            if (SalesHeader."Document Type" in [SalesHeader."Document Type"::Invoice, SalesHeader."Document Type"::"Credit Memo", SalesHeader."Document Type"::Order]) then begin
                Lrec_SalesLine.RESET();
                Lrec_SalesLine.SETFILTER(Lrec_SalesLine."Document Type", '%1', SalesHeader."Document Type");
                Lrec_SalesLine.SETFILTER(Lrec_SalesLine."Document No.", '%1', SalesHeader."No.");
                Lrec_SalesLine.SETFILTER(Lrec_SalesLine.Type, '<>%1', Lrec_SalesLine.Type::" ");
                Lrec_SalesLine.SETFILTER(Lrec_SalesLine."No.", '<>%1', '');
                Lint_Compteur := 0;
                if Lrec_SalesLine.FIND('-') then
                    repeat
                        Lint_Compteur += 1;
                        LCode_DimCode[1] := Lcode_AxeReserve;
                        LCode_DimValueCode[1] := FORMAT(Lint_Compteur);
                        Lrec_SalesLine."Dimension Set ID" := SetNewDimIDSpec(Lrec_SalesLine."Dimension Set ID", Lrec_SalesLine."Shortcut Dimension 1 Code",
                                                      Lrec_SalesLine."Shortcut Dimension 2 Code", LCode_DimCode, LCode_DimValueCode);
                        Lrec_SalesLine.MODIFY();
                    until Lrec_SalesLine.NEXT() = 0;
            end;
        end;
        //FIN MODIF JX XAD 16/03/2011 (traitement modification analytique manuelle post validation)
    end;

    procedure SetNewDimIDSpec(DimSetID: Integer; var GlobalDimVal1: Code[20]; var GlobalDimVal2: Code[20]; DimCode: array[50] of Code[20]; DimValueCode: array[50] of Code[20]): Integer;
    var
        DimSetEntry: Record "Dimension Set Entry";
        TempSetEntry: Record "Dimension Set Entry" temporary;
        DimValue: Record "Dimension Value";
        DimMgt: Codeunit DimensionManagement;
        i: Integer;
        NewDimSetID: Integer;
    begin
        NewDimSetID := DimSetID;
        DimSetEntry.RESET();
        DimSetEntry.FILTERGROUP(2);
        DimSetEntry.SETRANGE("Dimension Set ID", DimSetID);
        DimSetEntry.FILTERGROUP(0);
        TempSetEntry.DELETEALL();
        if DimSetEntry.FindSet() then
            repeat
                TempSetEntry := DimSetEntry;
                TempSetEntry.INSERT();
            until DimSetEntry.NEXT() = 0;
        for i := 1 to 50 do
            if DimCode[i] <> '' then begin
                if not TempSetEntry.GET(DimSetID, DimCode[i]) then begin
                    TempSetEntry.INIT();
                    TempSetEntry."Dimension Set ID" := DimSetID;
                    TempSetEntry."Dimension Code" := DimCode[i];
                    TempSetEntry."Dimension Value Code" := DimValueCode[i];
                    TempSetEntry.INSERT();
                end;
                if DimValue.GET(DimCode[i], DimValueCode[i]) then
                    TempSetEntry."Dimension Value ID" := DimValue."Dimension Value ID";
                TempSetEntry.MODIFY();
            end;
        NewDimSetID := DimSetEntry.GetDimensionSetID(TempSetEntry);
        DimMgt.UpdateGlobalDimFromDimSetID(NewDimSetID, GlobalDimVal1, GlobalDimVal2);
        DimSetEntry.RESET();
        exit(NewDimSetID);
    end;
    //---Cdu82
    procedure OnAfterConfirmPostCodeunit82(var DefaultOption: Integer)
    begin
        DefaultOption := 1;
    end;
    //---Cdu 91---
    procedure Fct_OnBeforeSelectPostOrderOptionCodeunit91(var PurchaseHeader: Record "Purchase Header"; DefaultOption: Integer; var IsHandled: Boolean): Boolean
    var
        Text003: label 'Do you want this document to confirm receipt?', Comment = 'FRA="Souhaitez-vous valider ce document en réception ?"';
    begin
        if CONFIRM(Text003) then begin
            PurchaseHeader.Receive := true;
            PurchaseHeader.Invoice := false;
        end else begin
            IsHandled := true;
            exit;
        end;
        IsHandled := true;
        exit(true);
    end;

    procedure Fct_OnAfterConfirmPostCodeunit91(var PurchaseHeader: Record "Purchase Header")
    var
        Lrec_Dimen: Record Dimension;
        Lrec_DimensionValue: Record "Dimension Value";
        Lrec_PurchLine: Record "Purchase Line";
        Lcode_AxeReserve: Code[10];
        LCode_DimCode: array[50] of Code[20];
        LCode_DimValueCode: array[50] of Code[20];
        Lint_Compteur: Integer;
    begin

        //DEBUT MODIF JX XAD 12/05/2010 (traitement modification analytique manuelle post validation)
        Lcode_AxeReserve := 'RESERVE';
        if Lrec_Dimen.GET(Lcode_AxeReserve) then
            // On initialise, si nécessaire, les sections de l'axe analytique 'RESERVE'
            if not Lrec_DimensionValue.GET(Lcode_AxeReserve, '400') then
                for Lint_Compteur := 1 to 400 do
                    if not Lrec_DimensionValue.GET(Lcode_AxeReserve, FORMAT(Lint_Compteur)) then begin
                        Lrec_DimensionValue.INIT();
                        Lrec_DimensionValue.VALIDATE(Lrec_DimensionValue."Dimension Code", Lcode_AxeReserve);
                        Lrec_DimensionValue.VALIDATE(Lrec_DimensionValue.Code, FORMAT(Lint_Compteur));
                        Lrec_DimensionValue.INSERT();
                    end;
        // Traitement de l'axe analytique 'RESERVE' pour chaque ligne du document
        if (PurchaseHeader."Document Type" in [PurchaseHeader."Document Type"::Invoice, PurchaseHeader."Document Type"::"Credit Memo"]) then begin
            Lrec_PurchLine.RESET();
            Lrec_PurchLine.SETFILTER(Lrec_PurchLine."Document Type", '%1', PurchaseHeader."Document Type");
            Lrec_PurchLine.SETFILTER(Lrec_PurchLine."Document No.", '%1', PurchaseHeader."No.");
            Lrec_PurchLine.SETFILTER(Lrec_PurchLine.Type, '<>%1', Lrec_PurchLine.Type::" ");
            Lrec_PurchLine.SETFILTER(Lrec_PurchLine."No.", '<>%1', '');
            Lint_Compteur := 0;
            if Lrec_PurchLine.FIND('-') then
                repeat
                    Lint_Compteur += 1;
                    LCode_DimCode[1] := Lcode_AxeReserve;
                    LCode_DimValueCode[1] := FORMAT(Lint_Compteur);
                    Lrec_PurchLine."Dimension Set ID" := SetNewDimIDSpec(Lrec_PurchLine."Dimension Set ID", Lrec_PurchLine."Shortcut Dimension 1 Code",
                                                  Lrec_PurchLine."Shortcut Dimension 2 Code", LCode_DimCode, LCode_DimValueCode);
                    Lrec_PurchLine.MODIFY();
                until Lrec_PurchLine.NEXT() = 0;
        end;
        //FIN MODIF JX XAD 12/05/2010 (traitement modification analytique manuelle post validation)
    end;
    //---CODEUNIT/5063---
    PROCEDURE ArchivePurchDocument2(VAR PurchHeader: Record "Purchase Header");
    var
        ArchManagment: Codeunit ArchiveManagement;
    BEGIN
        ArchManagment.StorePurchDocument(PurchHeader, FALSE);
    END;

    //---CODEUNIT/5700---
    procedure jx_GetPurchasesFilter() Ltxt_UserList: Text;
    var
        Lrec_UserSetup: Record "User Setup";
        Lcode_CodeService: Code[20];
        Ltext_UserList: Text;
    begin
        //Ajout JX-XAD du 13/06/2008
        //Filtrer les documents d'achats sur les utilisateurs dont les droits sont indiqu‚s dans les paramŠtres utilisateurs
        if Lrec_UserSetup.GET(USERID) then
            case Lrec_UserSetup."BC6_Droits acces doc. achat" of
                Lrec_UserSetup."BC6_Droits acces doc. achat"::Utilisateur:
                    Ltext_UserList := USERID;
                Lrec_UserSetup."BC6_Droits acces doc. achat"::Responsable:
                    begin
                        Lcode_CodeService := Lrec_UserSetup."Service Resp. Ctr. Filter";
                        Ltext_UserList := '';
                        Lrec_UserSetup.RESET();
                        Lrec_UserSetup.SETFILTER(Lrec_UserSetup."Service Resp. Ctr. Filter", COPYSTR(Lcode_CodeService, 1, 3) + '*');
                        if Lrec_UserSetup.FIND('-') then
                            repeat
                                if Ltext_UserList <> '' then
                                    Ltext_UserList += '|' + Lrec_UserSetup."User ID"
                                else
                                    Ltext_UserList += Lrec_UserSetup."User ID";
                            until Lrec_UserSetup.NEXT() = 0;
                    end;
                Lrec_UserSetup."BC6_Droits acces doc. achat"::"Sous-Responsable":
                    begin
                        Lcode_CodeService := Lrec_UserSetup."Service Resp. Ctr. Filter";
                        Ltext_UserList := '';
                        Lrec_UserSetup.RESET();
                        Lrec_UserSetup.SETFILTER(Lrec_UserSetup."Service Resp. Ctr. Filter", Lcode_CodeService);
                        if Lrec_UserSetup.FIND('-') then
                            repeat
                                if Ltext_UserList <> '' then
                                    Ltext_UserList += '|' + Lrec_UserSetup."User ID"
                                else
                                    Ltext_UserList += Lrec_UserSetup."User ID";
                            until Lrec_UserSetup.NEXT() = 0;
                    end;
                Lrec_UserSetup."BC6_Droits acces doc. achat"::Admin:
                    Ltext_UserList := '';
            end
        else
            Ltext_UserList := USERID;

        exit(Ltext_UserList);
    end;
    //---CDU 7181
    procedure DocExist(CurrentPurchHeader: Record "Purchase Header"; VendNo: Code[20]): Boolean
    var
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchHeader: Record "Purchase Header";
        ReturnShipment: Record "Return Shipment Header";
    begin
        if VendNo = '' then
            exit(false);
        PurchInvHeader.SETCURRENTKEY("Buy-from Vendor No.");
        PurchInvHeader.SETRANGE("Buy-from Vendor No.", VendNo);
        if not PurchInvHeader.ISEMPTY then
            exit(true);
        PurchRcptHeader.SETCURRENTKEY("Buy-from Vendor No.");
        PurchRcptHeader.SETRANGE("Buy-from Vendor No.", VendNo);
        if not PurchRcptHeader.ISEMPTY then
            exit(true);
        PurchCrMemoHeader.SETCURRENTKEY("Buy-from Vendor No.");
        PurchCrMemoHeader.SETRANGE("Buy-from Vendor No.", VendNo);
        if not PurchCrMemoHeader.ISEMPTY then
            exit(true);
        PurchHeader.SETCURRENTKEY("Buy-from Vendor No.");
        PurchHeader.SETRANGE("Buy-from Vendor No.", VendNo);
        if PurchHeader.FINDFIRST() then begin
            if (PurchHeader."Document Type" <> CurrentPurchHeader."Document Type") or
               (PurchHeader."No." <> CurrentPurchHeader."No.")
            then
                exit(true);
            if PurchHeader.FIND('>') then
                exit(true);
        end;
        ReturnShipment.SETCURRENTKEY("Buy-from Vendor No.");
        ReturnShipment.SETRANGE("Buy-from Vendor No.", VendNo);
        if not ReturnShipment.ISEMPTY then
            exit(true);
    end;
    //---Codeunit 90---
    procedure Fct_OnBeforePostPurchaseDocCodeunit90(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; CommitIsSupressed: Boolean; var HideProgressWindow: Boolean)
    var
        Temp_Grec: Record "BC6_Table temporaire" temporary;
        Text061: label 'The field "Your reference" in header %1 is mandatory', Comment = 'FRA="Le champs "Votre référence" dans en-tête %1 est obligatoire"';
    begin
        //DEBUT MODIF JX-XAD 20/05/2011
        if (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice) or (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo") then begin
            if PurchaseHeader."Your Reference" = '' then
                ERROR(Text061, PurchaseHeader."Document Type");
            PurchaseHeader."Posting Description" := PurchaseHeader."Your Reference";
        end;
        //FIN MODIF JX-XAD 20/05/2011

        //DEBUT MODIF JX-XAD 09/07/2009
        if Temp_Grec.GET(-1) then begin
            Temp_Grec.Compte := PurchaseHeader."Assigned User ID";
            Temp_Grec.MODIFY();
        end else begin
            Temp_Grec.Piece := (-1);
            Temp_Grec.Compte := PurchaseHeader."Assigned User ID";
            Temp_Grec.INSERT();
        end;
        //FIN MODIF JX-XAD 09/07/2009
    end;

    //---Codeunit 415---
    procedure FctReceiptStatus(var piPurchOrder: Record "Purchase Header");
    begin
        //Modif JX-VSC4.0-PBD du 24/06/15 Migration 2015 - Gestion statut réception
        if piPurchOrder."Document Type" <> piPurchOrder."Document Type"::Order then
            exit;

        piPurchOrder.CALCFIELDS("BC6_Total Quantity", "BC6_Total Quantity Received");
        if piPurchOrder."BC6_Total Quantity Received" = piPurchOrder."BC6_Total Quantity" then
            piPurchOrder."BC6_Receipt Status" := piPurchOrder."BC6_Receipt Status"::Receive
        else
            if (piPurchOrder."BC6_Total Quantity" <> 0) and (piPurchOrder."BC6_Total Quantity Received" = 0) then
                piPurchOrder."BC6_Receipt Status" := piPurchOrder."BC6_Receipt Status"::"Not receive"
            else
                if (piPurchOrder."BC6_Total Quantity" <> 0) and (piPurchOrder."BC6_Total Quantity Received" < piPurchOrder."BC6_Total Quantity") then
                    piPurchOrder."BC6_Receipt Status" := piPurchOrder."BC6_Receipt Status"::"Partially receive";
    end;
    //---TAB10866---
    procedure OnUpdateEntryOnBeforeDimensionSetupTAB10866(var PaymentLine: Record "Payment Line")
    var
        BankAccount: Record "Bank Account";
        Customer: Record Customer;
        FixedAsset: Record "Fixed Asset";
        GLAccount: Record "G/L Account";
        Vendor: Record Vendor;
    begin
        case PaymentLine."Account Type" of
            PaymentLine."Account Type"::"G/L Account":
                begin
                    GLAccount.Get(PaymentLine."Account No.");
                    PaymentLine."BC6_Account Name" := GLAccount.Name; // JX-YOOZ2 13/11/15
                end;
            PaymentLine."Account Type"::Customer:
                begin
                    Customer.Get(PaymentLine."Account No.");
                    PaymentLine."BC6_Account Name" := Customer.Name; // JX-YOOZ2 13/11/15
                end;
            PaymentLine."Account Type"::Vendor:
                begin
                    Vendor.Get(PaymentLine."Account No.");
                    PaymentLine."BC6_Account Name" := Vendor.Name; // JX-YOOZ2 13/11/15
                end;
            PaymentLine."Account Type"::"Bank Account":
                begin
                    BankAccount.Get(PaymentLine."Account No.");
                    PaymentLine."BC6_Account Name" := BankAccount.Name; // JX-YOOZ2 13/11/15
                end;
            PaymentLine."Account Type"::"Fixed Asset":
                begin
                    FixedAsset.Get(PaymentLine."Account No.");
                    PaymentLine."BC6_Account Name" := FixedAsset.Description; // JX-YOOZ2 13/11/15
                end;
        end;
    end;
    //---TAB23---
    procedure OnAfterInsertVendor(var Vendor: Record Vendor)
    var
        Lrec_VendorBankAccount: Record "Vendor Bank Account";
    begin
        Lrec_VendorBankAccount.RESET();
        Lrec_VendorBankAccount.SETFILTER(Lrec_VendorBankAccount."Vendor No.", Vendor."No.");
        if Lrec_VendorBankAccount.COUNT = 0 then begin
            Lrec_VendorBankAccount.INIT();
            Lrec_VendorBankAccount."Vendor No." := Vendor."No.";
            Lrec_VendorBankAccount.VALIDATE(Lrec_VendorBankAccount.Code, '1');
            Lrec_VendorBankAccount.INSERT();
            if Vendor."BC6_Default Bank Account Code" = '' then
                Vendor.VALIDATE(Vendor."BC6_Default Bank Account Code", '1');
        end;
    end;
    //---TAB288---
    procedure OnAfterModifyEventT288(var xRec: Record "Vendor Bank Account"; var Rec: Record "Vendor Bank Account")
    var
        Grec_Vendor: Record Vendor;
    begin
        if (Rec."Bank Branch No." <> xRec."Bank Branch No.") or (Rec."Agency Code" <> xRec."Agency Code")
        or (Rec."Bank Account No." <> xRec."Bank Account No.") or (Rec."RIB Key" <> xRec."RIB Key")
        or (Rec."SWIFT Code" <> xRec."SWIFT Code") or (Rec.IBAN <> xRec.IBAN) then
            Rec."BC6_Change RIB/IBAN" := TODAY;
        if (Grec_Vendor.GET(Rec."Vendor No.")) then
            if ((Rec.Code = '1') and ((Grec_Vendor."BC6_Default Bank Account Code" = '1') or (Grec_Vendor."BC6_Default Bank Account Code" = ''))) then begin
                Grec_Vendor.VALIDATE("BC6_Default Bank Account Code", '1');
                Grec_Vendor.MODIFY();
            end;
    end;
    //---Codeunit1---
    procedure FctYoozImportFile();
    var
        lrec_FileYooz: Record "BC6_Yooz Import File";
        lrec_FileYooz2: Record "BC6_Yooz Import File";
        lrec_YoozParameters: Record "BC6_Yooz Parameters";
        lrec_NameValueBuffer: Record "Name/Value Buffer";
        FileMgt: Codeunit "File Management";
        ImportXmlFile: File;
        i: Integer;
        FileName: Text[250];
    begin
        if not lrec_YoozParameters.GET() then
            exit;
        if not FileMgt.ServerDirectoryExists(lrec_YoozParameters."Yooz Import Path") then
            exit;
        if not FileMgt.ServerDirectoryExists(lrec_YoozParameters."Yooz Imported File Path") then
            exit;

        // Vérification des fichiers importés par le NAS et à déplacer
        lrec_FileYooz.RESET();
        lrec_FileYooz.SETCURRENTKEY("Yooz Import", "Yooz Import Date");
        lrec_FileYooz.SETRANGE("Yooz Import", false);
        lrec_FileYooz.SETFILTER("Yooz Import Date", '<>%1', 0D);
        if lrec_FileYooz.FindSet() then
            repeat
                for i := STRLEN(lrec_FileYooz."File Name" + lrec_FileYooz."File Name 2") downto 1 do
                    if COPYSTR(lrec_FileYooz."File Name" + lrec_FileYooz."File Name 2", i, 1) = '\' then begin
                        FileName := COPYSTR(lrec_FileYooz."File Name" + lrec_FileYooz."File Name 2", i + 1);
                        i := 1;
                    end;
                FileMgt.DeleteServerFile(lrec_YoozParameters."Yooz Imported File Path" + '\' + FileName);
                if lrec_FileYooz2.GET(lrec_FileYooz."Entry No.") then begin
                    lrec_FileYooz2."Yooz Import" := true;
                    lrec_FileYooz2.MODIFY();
                end;
            until lrec_FileYooz.NEXT() = 0;
        FileMgt.GetServerDirectoryFilesList(lrec_NameValueBuffer, lrec_YoozParameters."Yooz Import Path");
        if lrec_NameValueBuffer.FindSet() then
            repeat
                if lrec_NameValueBuffer.Name <> '' then
                    if ImportXmlFile.OPEN(lrec_NameValueBuffer.Name) then begin
                        lrec_FileYooz.RESET();
                        lrec_FileYooz.SETCURRENTKEY("File Name", "Yooz Import");
                        lrec_FileYooz.SETRANGE("File Name", COPYSTR(lrec_NameValueBuffer.Name, 1, 250));
                        lrec_FileYooz.SETRANGE("Yooz Import", false);
                        if lrec_FileYooz.ISEMPTY then begin
                            lrec_FileYooz.RESET();
                            lrec_FileYooz.INIT();
                            if lrec_FileYooz2.FINDLAST() then
                                lrec_FileYooz."Entry No." := lrec_FileYooz2."Entry No." + 1
                            else
                                lrec_FileYooz."Entry No." := 1;
                            lrec_FileYooz."File Name" := COPYSTR(lrec_NameValueBuffer.Name, 1, 250);
                            lrec_FileYooz."File Name 2" := COPYSTR(lrec_NameValueBuffer.Name, 251);
                            lrec_FileYooz."Created Date" := TODAY;
                            lrec_FileYooz.INSERT();
                        end;
                    end;
            until lrec_NameValueBuffer.NEXT() = 0;
    end;
    //---Codeunit11---
    procedure OnCheckDimensionsOnAfterAssignDimTableIDsCodeunit11(var GenJnlLine: Record "Gen. Journal Line"; var TableID: array[10] of Integer; var No: array[10] of Code[20]; var CheckDone: Boolean)
    var
        GenJnlTemplate2: Record "Gen. Journal Template";
        DimMgt: Codeunit DimensionManagement;
        GenJnlCheckLine: Codeunit "Gen. Jnl.-Check Line";
        Text012: label 'A dimension used in %1 %2, %3, %4 has caused an error. %5', Comment = 'FRA="L''axe analytique utilisé dans %1 %2, %3, %4 a provoqué une erreur. %5"';
    begin
        if GenJnlTemplate2.GET(GenJnlLine."Journal Template Name") then   //MODIF JOH1.0 du 18/03/2015
            if not (GenJnlTemplate2.Type = GenJnlTemplate2.Type::Payments) then //MODIF JOH1.0 du 18/03/2015
                if not (GenJnlTemplate2.Type = GenJnlTemplate2.Type::"Cash Receipts") then  //MODIF JOH1.0 du 18/03/2015

                    //MODIF JOH1.0 du 18/03/2015
                    if not DimMgt.CheckDimValuePosting(TableID, No, GenJnlLine."Dimension Set ID") then
                        GenJnlCheckLine.ThrowGenJnlLineError(GenJnlLine, Text012, DimMgt.GetDimValuePostingErr());
        CheckDone := true;
    end;

    /// CODEUNIT 7181 Purchases Info-Pane Management///
    procedure LookupContacts(VAR PurchHeader: Record "Purchase Header")
    var
        Cont: Record Contact;
        ContBusRelation: Record "Contact Business Relation";
    begin
        IF PurchHeader."Buy-from Vendor No." <> '' THEN BEGIN
            IF Cont.GET(PurchHeader."Buy-from Contact No.") THEN
                Cont.SETRANGE("Company No.", Cont."Company No.")
            ELSE BEGIN
                ContBusRelation.RESET();
                ContBusRelation.SETCURRENTKEY("Link to Table", "No.");
                ContBusRelation.SETRANGE("Link to Table", ContBusRelation."Link to Table"::Vendor);
                ContBusRelation.SETRANGE("No.", PurchHeader."Buy-from Vendor No.");
                IF ContBusRelation.FINDFIRST() THEN
                    Cont.SETRANGE("Company No.", ContBusRelation."Contact No.")
                ELSE
                    Cont.SETRANGE("No.", '');
            END;

            IF Cont.GET(PurchHeader."Buy-from Contact No.") THEN;
        END ELSE
            Cont.SETRANGE("No.", '');
        IF PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK THEN BEGIN
            PurchHeader.VALIDATE("Buy-from Contact No.", Cont."No.");
            PurchHeader.MODIFY(TRUE);
        END;
    end;

    procedure LookupOrderAddr(VAR PurchHeader: Record "Purchase Header")
    var
        OrderAddress: Record "Order Address";
        Text000: Label 'The Ship-to Address has been changed', Comment = 'FRA="L''adresse destinataire a changé."';
    begin
        OrderAddress.SETRANGE("Vendor No.", PurchHeader."Buy-from Vendor No.");
        IF PAGE.RUNMODAL(0, OrderAddress) = ACTION::LookupOK THEN BEGIN
            PurchHeader.VALIDATE("Order Address Code", OrderAddress.Code);
            PurchHeader.MODIFY(TRUE);
            MESSAGE(Text000);
        END;
    end;
    //---Codeunit7181---
    procedure LookupItem(PurchLine: Record "Purchase Line")
    var
        Item: Record Item;
    begin
        PurchLine.TESTFIELD(Type, PurchLine.Type::Item);
        PurchLine.TESTFIELD("No.");
        Item.Get(PurchLine."No.");
        PAGE.RUNMODAL(PAGE::"Item Card", Item);
    end;
    //---TAB296---
    Procedure OnAfterModifyEventT296(var Rec: Record "Reminder Line")
    var
        Grec_SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        IF Grec_SalesInvoiceHeader.GET(Rec."Document No.") THEN BEGIN
            Rec."BC6_Agent" := Grec_SalesInvoiceHeader."BC6_Agent";
            Rec."BC6_Paying agent" := Grec_SalesInvoiceHeader."BC6_Paying agent";
        END;
    END;

    Procedure OnAfterInsertEventT296(var Rec: Record "Reminder Line")
    var
        Grec_SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        IF Grec_SalesInvoiceHeader.GET(Rec."Document No.") THEN BEGIN
            Rec."BC6_Agent" := Grec_SalesInvoiceHeader."BC6_Agent";
            Rec."BC6_Paying agent" := Grec_SalesInvoiceHeader."BC6_Paying agent";
        END;
    END;
    //---CDU408
    procedure LookupDimValueCodeCDU408(FieldNumber: Integer; var ShortcutDimCode: Code[20]; var IsHandled: Boolean)
    var
        DimVal: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        DimensionManagement: Codeunit DimensionManagement;
        Text002: Label 'This Shortcut Dimension is not defined in the %1.', Comment = 'FRA="Ce racourci axe n''est pas défini dans les %1."';
    begin
        if FieldNumber > 8 then begin
            IsHandled := true;
            BC6_GetGLSetup(GLSetupShortcutDimCode);
            if GLSetupShortcutDimCode[FieldNumber] = '' then
                Error(Text002, GLSetup.TableCaption());
            DimVal.SetRange("Dimension Code", GLSetupShortcutDimCode[FieldNumber]);
            DimVal."Dimension Code" := GLSetupShortcutDimCode[FieldNumber];
            DimVal.Code := ShortcutDimCode;
            if PAGE.RunModal(0, DimVal) = ACTION::LookupOK then begin
                DimensionManagement.CheckDim(DimVal."Dimension Code");
                DimensionManagement.CheckDimValue(DimVal."Dimension Code", DimVal.Code);
                ShortcutDimCode := DimVal.Code;
            end;
        end;
    end;

    procedure BC6_GetGLSetup(var GLSetupShortcutDimCodeV: array[10] of Code[20])
    var
        GLSetup: Record "General Ledger Setup";
        HasGotGLSetup: Boolean;
    begin
        if not HasGotGLSetup then begin
            GLSetup.Get();
            GLSetupShortcutDimCodeV[9] := GLSetup."Shortcut Dimension 1 Code";
            GLSetupShortcutDimCodeV[10] := GLSetup."Shortcut Dimension 2 Code";
            HasGotGLSetup := true;
        end;
    end;

    procedure BC6_ValidateShortcutDimValues(FieldNumber: Integer; var ShortcutDimCode: Code[20]; var DimSetID: Integer)
    var
        DimVal: Record "Dimension Value";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        DimensionManagement: Codeunit DimensionManagement;
    begin
        ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimVal."Dimension Code" := GLSetupShortcutDimCode[FieldNumber];
        if ShortcutDimCode <> '' then begin
            DimVal.Get(DimVal."Dimension Code", ShortcutDimCode);
            if not DimensionManagement.CheckDim(DimVal."Dimension Code") then
                Error(DimensionManagement.GetDimErr());
            if not DimensionManagement.CheckDimValue(DimVal."Dimension Code", ShortcutDimCode) then
                Error(DimensionManagement.GetDimErr());
        end;
        DimensionManagement.GetDimensionSet(TempDimSetEntry, DimSetID);
        if TempDimSetEntry.Get(TempDimSetEntry."Dimension Set ID", DimVal."Dimension Code") then
            if TempDimSetEntry."Dimension Value Code" <> ShortcutDimCode then
                TempDimSetEntry.Delete();
        if ShortcutDimCode <> '' then begin
            TempDimSetEntry."Dimension Code" := DimVal."Dimension Code";
            TempDimSetEntry."Dimension Value Code" := DimVal.Code;
            TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
            if TempDimSetEntry.Insert() then;
        end;
        DimSetID := DimensionManagement.GetDimensionSetID(TempDimSetEntry);
    end;

    procedure ValidateDimValueCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimVal: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        Text002: Label 'This Shortcut Dimension is not defined in the %1.', Comment = 'FRA="Ce racourci axe n''est pas défini dans les %1."';
        Text003: Label '%1 is not an available %2 for that dimension.', Comment = 'FRA="%1 : %2 n''est pas une %3 disponible pour cet axe analytique."';
    begin

        BC6_GetGLSetup(GLSetupShortcutDimCode);
        if (GLSetupShortcutDimCode[FieldNumber] = '') and (ShortcutDimCode <> '') then
            Error(Text002, GLSetup.TableCaption());
        DimVal.SetRange("Dimension Code", GLSetupShortcutDimCode[FieldNumber]);
        if ShortcutDimCode <> '' then begin
            DimVal.SetRange(Code, ShortcutDimCode);
            if not DimVal.FindFirst() then begin
                DimVal.SetFilter(Code, StrSubstNo('%1*', ShortcutDimCode));
                if DimVal.FindFirst() then
                    ShortcutDimCode := DimVal.Code
                else
                    Error(
                      Text003,
                      ShortcutDimCode, DimVal.FieldCaption(Code));
            end;
        end;
    end;

    procedure Cdu408_GetShortcutDimensions(DimSetID: Integer; var ShortcutDimCode: array[10] of Code[20])
    begin
        Cdu480_GetShortcutDimensions(DimSetID, ShortcutDimCode);
    end;
    //---CDU480
    procedure Cdu480_GetShortcutDimensions(DimSetID: Integer; var ShortcutDimCode: array[10] of Code[20])
    var
        i: Integer;
    begin
        Clear(ShortcutDimCode);
        if DimSetID = 0 then
            exit;
        Cdu48_GetGLSetup();
        for i := 9 to 10 do
            if GLSetupShortcutDimCode[i] <> '' then
                ShortcutDimCode[i] := Cdu480_GetDimSetEntry(DimSetID, GLSetupShortcutDimCode[i]);
    end;

    procedure Cdu48_GetGLSetup()
    var
        GLSetup: Record "General Ledger Setup";
        WhenGotGLSetup: DateTime;
        HasGotGLSetup: Boolean;
    begin
        if WhenGotGLSetup = 0DT then
            WhenGotGLSetup := CurrentDateTime;
        if CurrentDateTime > WhenGotGLSetup + 60000 then
            HasGotGLSetup := false;
        if HasGotGLSetup then
            exit;
        GLSetup.Get();
        GLSetupShortcutDimCode[9] := GLSetup."Shortcut Dimension 1 Code";
        GLSetupShortcutDimCode[10] := GLSetup."Shortcut Dimension 2 Code";

        HasGotGLSetup := true;
        WhenGotGLSetup := CurrentDateTime;
    end;

    procedure Cdu480_GetDimSetEntry(DimSetID: Integer; DimCode: Code[20]): Code[20]
    var
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        DimensionSetEntry: Record "Dimension Set Entry";
    begin
        if TempDimSetEntry.Get(DimSetID, DimCode) then
            exit(TempDimSetEntry."Dimension Value Code");
        TempDimSetEntry.Init();
        if DimensionSetEntry.Get(DimSetID, DimCode) then
            TempDimSetEntry := DimensionSetEntry
        else begin
            TempDimSetEntry."Dimension Set ID" := DimSetID;
            TempDimSetEntry."Dimension Code" := DimCode;
        end;
        TempDimSetEntry.Insert();
        exit(TempDimSetEntry."Dimension Value Code");
    end;

    //---Tab39
    procedure VerifyItemLineDim()
    var
        PurchaseLine: Record "Purchase Line";
    begin
        if PurchaseLine.IsReceivedShippedItemDimChanged() then
            PurchaseLine.ConfirmReceivedShippedItemDimChange();
    end;

    var
        GLSetupShortcutDimCode: array[10] of Code[20];
}
