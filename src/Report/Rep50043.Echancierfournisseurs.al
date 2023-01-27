report 50043 "BC6_Echéancier fournisseurs"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/Echéancierfournisseurs.rdl';
    Caption = 'Echéancier fournisseurs';

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = SORTING("No.");
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column("USERID"; USERID)
            {
            }
            column(FORMAT_EndingDate_; FORMAT(EndingDate))
            {
            }
            column(Original_Amount; Gdec_MontantTotal)
            {
                AutoFormatType = 1;
            }
            column(Original_Amount_Control1000000011; Gdec_SoldeTotal)
            {
                AutoFormatType = 1;
            }
            column("Echéancier_fournisseurs_à_date_duCaption"; Echéancier_fournisseurs_à_date_duCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(N__documentCaption; N__documentCaptionLbl)
            {
            }
            column(Date_de_comptabilisationCaption; Date_de_comptabilisationCaptionLbl)
            {
            }
            column(MontantCaption; MontantCaptionLbl)
            {
            }
            column("Date_d_échéanceCaption"; Date_d_échéanceCaptionLbl)
            {
            }
            column(Date_documentCaption; Date_documentCaptionLbl)
            {
            }
            column(Nom_du_fournisseurCaption; Nom_du_fournisseurCaptionLbl)
            {
            }
            column(Code_fournisseurCaption; Code_fournisseurCaptionLbl)
            {
            }
            column(SoldeCaption; SoldeCaptionLbl)
            {
            }
            column(Vendor_No_; "No.")
            {
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No." = FIELD("No.");
                DataItemTableView = SORTING("Vendor No.", "Posting Date", "Currency Code");

                trigger OnAfterGetRecord()
                var
                    VendorLedgEntry: Record "Vendor Ledger Entry";
                begin
                    VendorLedgEntry.SETCURRENTKEY("Closed by Entry No.");
                    VendorLedgEntry.SETRANGE("Closed by Entry No.", "Entry No.");
                    VendorLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
                    IF VendorLedgEntry.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            InsertTemp(VendorLedgEntry);
                        UNTIL VendorLedgEntry.NEXT() = 0;

                    IF "Closed by Entry No." <> 0 THEN BEGIN
                        VendorLedgEntry.SETRANGE("Closed by Entry No.", "Closed by Entry No.");
                        IF VendorLedgEntry.FINDSET(FALSE, FALSE) THEN
                            REPEAT
                                InsertTemp(VendorLedgEntry);
                            UNTIL VendorLedgEntry.NEXT() = 0;
                    END;

                    VendorLedgEntry.RESET();
                    VendorLedgEntry.SETRANGE("Entry No.", "Closed by Entry No.");
                    VendorLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
                    IF VendorLedgEntry.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            InsertTemp(VendorLedgEntry);
                        UNTIL VendorLedgEntry.NEXT() = 0;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Posting Date", EndingDate + 1, 99991231D);
                end;
            }
            dataitem(OpenVendorLedgEntry; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No." = FIELD("No.");
                DataItemTableView = SORTING("Vendor No.", Open, Positive, "Due Date", "Currency Code");

                trigger OnAfterGetRecord()
                begin
                    IF AgingBy = AgingBy::"Posting Date" THEN BEGIN
                        CALCFIELDS("Remaining Amt. (LCY)");
                        IF "Remaining Amt. (LCY)" = 0 THEN
                            CurrReport.SKIP();
                    END;
                    InsertTemp(OpenVendorLedgEntry);
                end;

                trigger OnPreDataItem()
                begin
                    IF AgingBy = AgingBy::"Posting Date" THEN BEGIN
                        SETRANGE("Posting Date", 0D, EndingDate);
                        SETRANGE("Date Filter", 0D, EndingDate);
                    END
                end;
            }
            dataitem(CurrencyLoop; Integer)
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                PrintOnlyIfDetail = true;
                dataitem(TempVendortLedgEntryLoop; Integer)
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                    column(VendorLedgEntryEndingDate_Amount; VendorLedgEntryEndingDate.Amount)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(VendorLedgEntryEndingDate__Document_Date_; VendorLedgEntryEndingDate."Document Date")
                    {
                    }
                    column(VendorLedgEntryEndingDate__Document_No__; VendorLedgEntryEndingDate."Document No.")
                    {
                    }
                    column(VendorLedgEntryEndingDate__Posting_Date_; VendorLedgEntryEndingDate."Posting Date")
                    {
                    }
                    column(Original_Amount_Control1000000001; VendorLedgEntryEndingDate."Due Date")
                    {
                        AutoFormatType = 1;
                    }
                    column(Vendor_Name; Vendor.Name)
                    {
                    }
                    column(Vendor__No__; Vendor."No.")
                    {
                    }
                    column(VendorLedgEntryEndingDate__Remaining_Amount_; VendorLedgEntryEndingDate."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(TempVendortLedgEntryLoop_Number; Number)
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        VendorLedgEntry: Record "Vendor Ledger Entry";
                        PeriodIndex: Integer;
                    begin
                        IF Number = 1 THEN BEGIN
                            IF NOT TempVendorLedgEntry.FINDSET(FALSE, FALSE) THEN
                                CurrReport.BREAK();
                        END ELSE
                            IF TempVendorLedgEntry.NEXT() = 0 THEN
                                CurrReport.BREAK();

                        VendorLedgEntryEndingDate := TempVendorLedgEntry;
                        DetailedVendorLedgerEntry.SETRANGE("Vendor Ledger Entry No.", VendorLedgEntryEndingDate."Entry No.");
                        IF DetailedVendorLedgerEntry.FINDSET() THEN
                            REPEAT
                                IF (DetailedVendorLedgerEntry."Entry Type" =
                                    DetailedVendorLedgerEntry."Entry Type"::"Initial Entry") AND
                                   (VendorLedgEntryEndingDate."Posting Date" > EndingDate) AND
                                   (AgingBy <> AgingBy::"Posting Date")
                                THEN
                                    IF VendorLedgEntryEndingDate."Document Date" <= EndingDate THEN
                                        DetailedVendorLedgerEntry."Posting Date" :=
                                          VendorLedgEntryEndingDate."Document Date"
                                    ELSE
                                        IF (VendorLedgEntryEndingDate."Due Date" <= EndingDate) AND
                                           (AgingBy = AgingBy::"Due Date")
                                        THEN
                                            DetailedVendorLedgerEntry."Posting Date" :=
                                              VendorLedgEntryEndingDate."Due Date";

                                IF DetailedVendorLedgerEntry."Posting Date" <= EndingDate THEN BEGIN
                                    IF DetailedVendorLedgerEntry."Entry Type" IN
                                      [DetailedVendorLedgerEntry."Entry Type"::"Initial Entry",
                                       DetailedVendorLedgerEntry."Entry Type"::"Unrealized Loss",
                                       DetailedVendorLedgerEntry."Entry Type"::"Unrealized Gain",
                                       DetailedVendorLedgerEntry."Entry Type"::"Realized Loss",
                                       DetailedVendorLedgerEntry."Entry Type"::"Realized Gain",
                                       DetailedVendorLedgerEntry."Entry Type"::"Payment Discount",
                                       DetailedVendorLedgerEntry."Entry Type"::"Payment Discount (VAT Excl.)",
                                       DetailedVendorLedgerEntry."Entry Type"::"Payment Discount (VAT Adjustment)",
                                       DetailedVendorLedgerEntry."Entry Type"::"Payment Tolerance",
                                       DetailedVendorLedgerEntry."Entry Type"::"Payment Discount Tolerance",
                                       DetailedVendorLedgerEntry."Entry Type"::"Payment Tolerance (VAT Excl.)",
                                       DetailedVendorLedgerEntry."Entry Type"::"Payment Tolerance (VAT Adjustment)",
                                       DetailedVendorLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Excl.)",
                                       DetailedVendorLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Adjustment)"]
                                    THEN BEGIN
                                        VendorLedgEntryEndingDate.Amount := VendorLedgEntryEndingDate.Amount + DetailedVendorLedgerEntry.Amount;
                                        VendorLedgEntryEndingDate."Amount (LCY)" :=
                                          VendorLedgEntryEndingDate."Amount (LCY)" + DetailedVendorLedgerEntry."Amount (LCY)";
                                    END;
                                    VendorLedgEntryEndingDate."Remaining Amount" :=
                                      VendorLedgEntryEndingDate."Remaining Amount" + DetailedVendorLedgerEntry.Amount;
                                    VendorLedgEntryEndingDate."Remaining Amt. (LCY)" :=
                                      VendorLedgEntryEndingDate."Remaining Amt. (LCY)" + DetailedVendorLedgerEntry."Amount (LCY)";
                                END;
                            UNTIL DetailedVendorLedgerEntry.NEXT() = 0;

                        IF VendorLedgEntryEndingDate."Remaining Amount" = 0 THEN
                            CurrReport.SKIP();

                        CASE AgingBy OF
                            AgingBy::"Due Date":
                                PeriodIndex := GetPeriodIndex(VendorLedgEntryEndingDate."Due Date");
                            AgingBy::"Posting Date":
                                PeriodIndex := GetPeriodIndex(VendorLedgEntryEndingDate."Posting Date");
                            AgingBy::"Document Date":
                                BEGIN
                                    IF VendorLedgEntryEndingDate."Document Date" > EndingDate THEN BEGIN
                                        VendorLedgEntryEndingDate."Remaining Amount" := 0;
                                        VendorLedgEntryEndingDate."Remaining Amt. (LCY)" := 0;
                                        VendorLedgEntryEndingDate."Document Date" := VendorLedgEntryEndingDate."Posting Date";
                                    END;
                                    PeriodIndex := GetPeriodIndex(VendorLedgEntryEndingDate."Document Date");
                                END;
                        END;
                        CLEAR(AgedVendorLedgEntry);
                        AgedVendorLedgEntry[PeriodIndex]."Remaining Amount" := VendorLedgEntryEndingDate."Remaining Amount";
                        AgedVendorLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" := VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                        TotalVendorLedgEntry[PeriodIndex]."Remaining Amount" += VendorLedgEntryEndingDate."Remaining Amount";
                        TotalVendorLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                        GrandTotalVendorLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                        TotalVendorLedgEntry[1].Amount += VendorLedgEntryEndingDate."Remaining Amount";
                        TotalVendorLedgEntry[1]."Amount (LCY)" += VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                        GrandTotalVendorLedgEntry[1]."Amount (LCY)" += VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                    end;

                    trigger OnPostDataItem()
                    begin
                        IF NOT PrintAmountInLCY THEN
                            UpdateCurrencyTotals();
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF NOT PrintAmountInLCY THEN
                            TempVendorLedgEntry.SETRANGE("Currency Code", TempCurrency.Code);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(TotalVendorLedgEntry);

                    IF Number = 1 THEN BEGIN
                        IF NOT TempCurrency.FINDSET(FALSE, FALSE) THEN
                            CurrReport.BREAK();
                    END ELSE
                        IF TempCurrency.NEXT() = 0 THEN
                            CurrReport.BREAK();

                    IF TempCurrency.Code <> '' THEN
                        CurrencyCode := TempCurrency.Code
                    ELSE
                        CurrencyCode := GLSetup."LCY Code";

                    NumberOfCurrencies := NumberOfCurrencies + 1;
                end;

                trigger OnPreDataItem()
                begin
                    NumberOfCurrencies := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TempCurrency.RESET();
                TempCurrency.DELETEALL();
                TempVendorLedgEntry.RESET();
                TempVendorLedgEntry.DELETEALL();
            end;
        }
        dataitem(CurrencyTotals; Integer)
        {
            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));

            trigger OnAfterGetRecord()
            begin
                IF Number = 1 THEN BEGIN
                    IF NOT TempCurrency2.FINDSET(FALSE, FALSE) THEN
                        CurrReport.BREAK();
                END ELSE
                    IF TempCurrency2.NEXT() = 0 THEN
                        CurrReport.BREAK();

                CLEAR(AgedVendorLedgEntry);
                TempCurrencyAmount.SETRANGE("Currency Code", TempCurrency2.Code);
                IF TempCurrencyAmount.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        IF TempCurrencyAmount.Date <> 99991231D THEN
                            AgedVendorLedgEntry[GetPeriodIndex(TempCurrencyAmount.Date)]."Remaining Amount" :=
                              TempCurrencyAmount.Amount
                        ELSE
                            AgedVendorLedgEntry[6]."Remaining Amount" := TempCurrencyAmount.Amount;
                    UNTIL TempCurrencyAmount.NEXT() = 0;
            end;
        }
    }
    trigger OnPreReport()
    begin
        VendorFilter := Vendor.GETFILTERS;

        GLSetup.GET();

        CalcDates();
        CreateHeadings();
    end;

    var
        TempCurrency: Record Currency temporary;
        TempCurrency2: Record Currency temporary;
        TempCurrencyAmount: Record "Currency Amount" temporary;
        DetailedVendorLedgerEntry: Record "Detailed Vendor Ledg. Entry"
;
        GLSetup: Record "General Ledger Setup";
        AgedVendorLedgEntry: array[6] of Record "Vendor Ledger Entry";
        GrandTotalVendorLedgEntry: array[5] of Record "Vendor Ledger Entry";
        TempVendorLedgEntry: Record "Vendor Ledger Entry" temporary;
        TotalVendorLedgEntry: array[5] of Record "Vendor Ledger Entry";
        VendorLedgEntryEndingDate: Record "Vendor Ledger Entry";
        PeriodLength: DateFormula;
        NewPagePerVendor: Boolean;
        PrintAmountInLCY: Boolean;
        CurrencyCode: Code[10];
        EndingDate: Date;
        PeriodEndDate: array[5] of Date;
        PeriodStartDate: array[5] of Date;
        Gdec_MontantTotal: Decimal;
        Gdec_SoldeTotal: Decimal;
        NumberOfCurrencies: Integer;
        Code_fournisseurCaptionLbl: Label 'Code fournisseur';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        "Date_d_échéanceCaptionLbl": Label 'Date d''échéance';
        Date_de_comptabilisationCaptionLbl: Label 'Date de comptabilisation';
        Date_documentCaptionLbl: Label 'Date document';
        "Echéancier_fournisseurs_à_date_duCaptionLbl": Label 'Echéancier fournisseurs à date du';
        MontantCaptionLbl: Label 'Montant';
        N__documentCaptionLbl: Label 'N° document',;
        Nom_du_fournisseurCaptionLbl: Label 'Nom du fournisseur';
        SoldeCaptionLbl: Label 'Solde';
        Text000: Label 'Not Due', Comment = 'FRA="Non échu"';
        Text001: Label 'Before', Comment = 'FRA="Avant"';
        Text002: Label 'days', Comment = 'FRA="jours"';
        Text003: Label 'More than', Comment = 'FRA="Plus de"';
        Text010: Label 'The Date Formula %1 cannot be used. Try to restate it. E.g. 1M+CM instead of CM+1M.', Comment = 'FRA="La formule date %1 ne peut pas être utilisée. Veuillez la redéfinir en utilisant, par exemple, 1M+CM au lieu de CM+1M."';
        HeadingType: Option "Date Interval","Number of Days";
        AgingBy: Option "Due Date","Posting Date","Document Date";
        HeaderText: array[5] of Text[30];
        VendorFilter: Text[250];

    local procedure CalcDates()
    var
        PeriodLength2: DateFormula;
        i: Integer;
    begin
        EVALUATE(PeriodLength2, '-' + FORMAT(PeriodLength));
        IF AgingBy = AgingBy::"Due Date" THEN BEGIN
            PeriodEndDate[1] := 99991231D;
            PeriodStartDate[1] := EndingDate + 1;
        END ELSE BEGIN
            PeriodEndDate[1] := EndingDate;
            PeriodStartDate[1] := CALCDATE(PeriodLength2, EndingDate + 1);
        END;
        FOR i := 2 TO ARRAYLEN(PeriodEndDate) DO BEGIN
            PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
            PeriodStartDate[i] := CALCDATE(PeriodLength2, PeriodEndDate[i] + 1);
        END;
        PeriodStartDate[i] := 0D;

        FOR i := 1 TO ARRAYLEN(PeriodEndDate) DO
            IF PeriodEndDate[i] < PeriodStartDate[i] THEN
                ERROR(Text010, PeriodLength);
    end;

    local procedure CreateHeadings()
    var
        i: Integer;
    begin
        IF AgingBy = AgingBy::"Due Date" THEN BEGIN
            HeaderText[1] := Text000;
            i := 2;
        END ELSE
            i := 1;
        WHILE i < ARRAYLEN(PeriodEndDate) DO BEGIN
            IF HeadingType = HeadingType::"Date Interval" THEN
                HeaderText[i] := STRSUBSTNO('%1\..%2', PeriodStartDate[i], PeriodEndDate[i])
            ELSE
                HeaderText[i] :=
                  STRSUBSTNO('%1 - %2 %3', EndingDate - PeriodEndDate[i] + 1, EndingDate - PeriodStartDate[i] + 1, Text002);
            i := i + 1;
        END;
        IF HeadingType = HeadingType::"Date Interval" THEN
            HeaderText[i] := STRSUBSTNO('%1 %2', Text001, PeriodStartDate[i - 1])
        ELSE
            HeaderText[i] := STRSUBSTNO('%1 \%2 %3', Text003, EndingDate - PeriodStartDate[i - 1] + 1, Text002);
    end;

    local procedure InsertTemp(var VendorLedgEntry: Record "Vendor Ledger Entry")
    var
        Currency: Record Currency;
    begin
        IF TempVendorLedgEntry.GET(VendorLedgEntry."Entry No.") THEN
            EXIT;
        TempVendorLedgEntry := VendorLedgEntry;
        TempVendorLedgEntry.INSERT();
        IF PrintAmountInLCY THEN BEGIN
            CLEAR(TempCurrency);
            TempCurrency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
            IF TempCurrency.INSERT() THEN;
            EXIT;
        END;
        IF TempCurrency.GET(TempVendorLedgEntry."Currency Code") THEN
            EXIT;
        IF TempVendorLedgEntry."Currency Code" <> '' THEN
            Currency.GET(TempVendorLedgEntry."Currency Code")
        ELSE BEGIN
            CLEAR(Currency);
            Currency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
        END;
        TempCurrency := Currency;
        TempCurrency.INSERT();
    end;

    local procedure GetPeriodIndex(Date: Date): Integer
    var
        i: Integer;
    begin
        FOR i := 1 TO ARRAYLEN(PeriodEndDate) DO
            IF Date IN [PeriodStartDate[i] .. PeriodEndDate[i]] THEN
                EXIT(i);
    end;

    local procedure Pct(a: Decimal; b: Decimal): Text[30]
    begin
        IF b <> 0 THEN
            EXIT(FORMAT(ROUND(100 * a / b, 0.1), 0, '<Sign><Integer><Decimals,2>') + '%');
    end;

    local procedure UpdateCurrencyTotals()
    var
        i: Integer;
    begin
        TempCurrency2.Code := CurrencyCode;
        IF TempCurrency2.INSERT() THEN;
        FOR i := 1 TO ARRAYLEN(TotalVendorLedgEntry) DO BEGIN
            TempCurrencyAmount."Currency Code" := CurrencyCode;
            TempCurrencyAmount.Date := PeriodStartDate[i];
            IF TempCurrencyAmount.FIND() THEN BEGIN
                TempCurrencyAmount.Amount := TempCurrencyAmount.Amount + TotalVendorLedgEntry[i]."Remaining Amount";
                TempCurrencyAmount.MODIFY();
            END ELSE BEGIN
                TempCurrencyAmount."Currency Code" := CurrencyCode;
                TempCurrencyAmount.Date := PeriodStartDate[i];
                TempCurrencyAmount.Amount := TotalVendorLedgEntry[i]."Remaining Amount";
                TempCurrencyAmount.INSERT();
            END;
        END;
        TempCurrencyAmount."Currency Code" := CurrencyCode;
        TempCurrencyAmount.Date := 99991231D;
        IF TempCurrencyAmount.FIND() THEN BEGIN
            TempCurrencyAmount.Amount := TempCurrencyAmount.Amount + TotalVendorLedgEntry[1].Amount;
            TempCurrencyAmount.MODIFY();
        END ELSE BEGIN
            TempCurrencyAmount."Currency Code" := CurrencyCode;
            TempCurrencyAmount.Date := 99991231D;
            TempCurrencyAmount.Amount := TotalVendorLedgEntry[1].Amount;
            TempCurrencyAmount.INSERT();
        END;
    end;
}

