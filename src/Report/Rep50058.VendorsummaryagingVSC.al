report 50058 "BC6_Vendor : summary aging VSC"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/VendorsummaryagingVSC.rdl';
    Caption = 'Vendor : summary aging VSC', Comment = 'FRA="Fourn. : Echéancier VSC"';

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; '')
            {
            }
            column("USERID"; USERID)
            {
            }
            column(STRSUBSTNO_Text006_FORMAT_EndingDate_0_4__; STRSUBSTNO(Text006, FORMAT(EndingDateV, 0, 4)))
            {
            }
            column(HeaderText_5_; HeaderText[5])
            {
            }
            column(HeaderText_4_; HeaderText[4])
            {
            }
            column(HeaderText_3_; HeaderText[3])
            {
            }
            column(HeaderText_2_; HeaderText[2])
            {
            }
            column(HeaderText_1_; HeaderText[1])
            {
            }
            column(Original_Amount; GrandTotalVendorLedgEntry[5]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(Original_Amount_Control43; GrandTotalVendorLedgEntry[4]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(Original_Amount_Control44; GrandTotalVendorLedgEntry[3]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(Original_Amount_Control45; GrandTotalVendorLedgEntry[2]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(Original_Amount_Control46; GrandTotalVendorLedgEntry[1]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(Original_Amount_Control47; GrandTotalVendorLedgEntry[1]."Amount (LCY)")
            {
                AutoFormatType = 1;
            }
            column(PctNonEchu; Pct(GrandTotalVendorLedgEntry[1]."Remaining Amt. (LCY)", GrandTotalVendorLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(Pct1; Pct(GrandTotalVendorLedgEntry[2]."Remaining Amt. (LCY)", GrandTotalVendorLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(Pct2; Pct(GrandTotalVendorLedgEntry[3]."Remaining Amt. (LCY)", GrandTotalVendorLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(Pct3; Pct(GrandTotalVendorLedgEntry[4]."Remaining Amt. (LCY)", GrandTotalVendorLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(Pct4; Pct(GrandTotalVendorLedgEntry[5]."Remaining Amt. (LCY)", GrandTotalVendorLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(Pct100; '100%')
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Original_Amount_Control58Caption; Original_Amount_Control58CaptionLbl)
            {
            }
            column(Document_No_Caption; VendorLedgEntryEndingDate__Document_No__CaptionLbl)
            {
            }
            column(VendorLedgEntryEndingDate__Posting_Date_Caption; VendorLedgEntryEndingDate__Posting_Date_CaptionLbl)
            {
            }
            column(Document_Type_Caption; FORMAT_VendorLedgEntryEndingDate__Document_Type__CaptionLbl)
            {
            }
            column(Aged_Overdue_AmountsCaption; Aged_Overdue_AmountsCaptionLbl)
            {
            }
            column(Total__LCY_Caption; Total__LCY_CaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(Vendor_No_; "No.")
            {
            }
            dataitem(DataItem4114; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No." = field("No.");
                DataItemTableView = sorting("Vendor No.", "Posting Date", "Currency Code");

                trigger OnAfterGetRecord()
                var
                    VendorLedgEntry: Record "Vendor Ledger Entry";
                begin
                    VendorLedgEntry.SETCURRENTKEY("Closed by Entry No.");
                    VendorLedgEntry.SETRANGE("Closed by Entry No.", "Entry No.");
                    VendorLedgEntry.SETRANGE("Posting Date", 0D, EndingDateV);
                    if VendorLedgEntry.FINDSET(false, false) then
                        repeat
                            InsertTemp(VendorLedgEntry);
                        until VendorLedgEntry.NEXT() = 0;

                    if "Closed by Entry No." <> 0 then begin
                        VendorLedgEntry.SETRANGE("Closed by Entry No.", "Closed by Entry No.");
                        if VendorLedgEntry.FINDSET(false, false) then
                            repeat
                                InsertTemp(VendorLedgEntry);
                            until VendorLedgEntry.NEXT() = 0;
                    end;

                    VendorLedgEntry.RESET();
                    VendorLedgEntry.SETRANGE("Entry No.", "Closed by Entry No.");
                    VendorLedgEntry.SETRANGE("Posting Date", 0D, EndingDateV);
                    if VendorLedgEntry.FINDSET(false, false) then
                        repeat
                            InsertTemp(VendorLedgEntry);
                        until VendorLedgEntry.NEXT() = 0;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Posting Date", EndingDateV + 1, 99991231D);
                end;
            }
            dataitem(OpenVendorLedgEntry; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No." = field("No.");
                DataItemTableView = sorting("Vendor No.", Open, Positive, "Due Date", "Currency Code");

                trigger OnAfterGetRecord()
                begin
                    if AgingBy = AgingBy::"Posting Date" then begin
                        CALCFIELDS("Remaining Amt. (LCY)");
                        if "Remaining Amt. (LCY)" = 0 then
                            CurrReport.SKIP();
                    end;
                    InsertTemp(OpenVendorLedgEntry);
                end;

                trigger OnPreDataItem()
                begin
                    if AgingBy = AgingBy::"Posting Date" then begin
                        SETRANGE("Posting Date", 0D, EndingDateV);
                        SETRANGE("Date Filter", 0D, EndingDateV);
                    end
                end;
            }
            dataitem(CurrencyLoop; Integer)
            {
                DataItemTableView = sorting(Number) where(Number = filter(1 ..));
                PrintOnlyIfDetail = true;
                dataitem(TempVendortLedgEntryLoop; Integer)
                {
                    DataItemTableView = sorting(Number) where(Number = filter(1 ..));
                    column(Vendor_Name; Vendor.Name)
                    {
                    }
                    column(Vendor__No__; Vendor."No.")
                    {
                    }
                    column(Original_Amount_Control89; AgedVendorLedgEntry[5]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(Original_Amount_Control90; AgedVendorLedgEntry[4]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(Original_Amount_Control91; AgedVendorLedgEntry[3]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(Original_Amount_Control92; AgedVendorLedgEntry[2]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(NonEchu; AgedVendorLedgEntry[1]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(Total; VendorLedgEntryEndingDate."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(DocumentNo; VendorLedgEntryEndingDate."Document No.")
                    {
                    }
                    column(DocumentType; FORMAT(VendorLedgEntryEndingDate."Document Type"))
                    {
                    }
                    column(PostingDate; FORMAT(VendorLedgEntryEndingDate."Posting Date"))
                    {
                    }
                    column(STRSUBSTNO_Text005_Vendor_Name__Control101; STRSUBSTNO(Text005, Vendor.Name))
                    {
                    }
                    column(Original_Amount_Control102; TotalVendorLedgEntry[5]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(Original_Amount_Control103; TotalVendorLedgEntry[4]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(Original_Amount_Control104; TotalVendorLedgEntry[3]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(Original_Amount_Control105; TotalVendorLedgEntry[2]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(Original_Amount_Control106; TotalVendorLedgEntry[1]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(Original_Amount_Control107; TotalVendorLedgEntry[1].Amount)
                    {
                        AutoFormatType = 1;
                    }
                    column(TempVendortLedgEntryLoop_Number; Number)
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        PeriodIndex: Integer;
                    begin
                        if Number = 1 then begin
                            if not TempVendorLedgEntry.FINDSET(false, false) then
                                CurrReport.BREAK();
                        end else
                            if TempVendorLedgEntry.NEXT() = 0 then
                                CurrReport.BREAK();

                        VendorLedgEntryEndingDate := TempVendorLedgEntry;
                        DetailedVendorLedgerEntry.SETRANGE("Vendor Ledger Entry No.", VendorLedgEntryEndingDate."Entry No.");
                        if DetailedVendorLedgerEntry.FINDSET(false, false) then
                            repeat
                                if (DetailedVendorLedgerEntry."Entry Type" =
                                    DetailedVendorLedgerEntry."Entry Type"::"Initial Entry") and
                                   (VendorLedgEntryEndingDate."Posting Date" > EndingDateV) and
                                   (AgingBy <> AgingBy::"Posting Date")
                                then
                                    if VendorLedgEntryEndingDate."Document Date" <= EndingDateV then
                                        DetailedVendorLedgerEntry."Posting Date" :=
                                          VendorLedgEntryEndingDate."Document Date"
                                    else
                                        if (VendorLedgEntryEndingDate."Due Date" <= EndingDateV) and
                                           (AgingBy = AgingBy::"Due Date")
                                        then
                                            DetailedVendorLedgerEntry."Posting Date" := VendorLedgEntryEndingDate."Due Date";

                                if (DetailedVendorLedgerEntry."Posting Date" <= EndingDateV) or
                                   (TempVendorLedgEntry.Open and
                                    (AgingBy = AgingBy::"Due Date") and
                                    (VendorLedgEntryEndingDate."Due Date" > EndingDateV)) then begin
                                    if DetailedVendorLedgerEntry."Entry Type" in
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
                                    then begin
                                        VendorLedgEntryEndingDate.Amount := VendorLedgEntryEndingDate.Amount + DetailedVendorLedgerEntry.Amount;
                                        VendorLedgEntryEndingDate."Amount (LCY)" :=
                                          VendorLedgEntryEndingDate."Amount (LCY)" + DetailedVendorLedgerEntry."Amount (LCY)";
                                    end;
                                    VendorLedgEntryEndingDate."Remaining Amount" :=
                                      VendorLedgEntryEndingDate."Remaining Amount" + DetailedVendorLedgerEntry.Amount;
                                    VendorLedgEntryEndingDate."Remaining Amt. (LCY)" :=
                                      VendorLedgEntryEndingDate."Remaining Amt. (LCY)" + DetailedVendorLedgerEntry."Amount (LCY)";
                                end;
                            until DetailedVendorLedgerEntry.NEXT() = 0;

                        if VendorLedgEntryEndingDate."Remaining Amount" = 0 then
                            CurrReport.SKIP();

                        case AgingBy of
                            AgingBy::"Due Date":
                                PeriodIndex := GetPeriodIndex(VendorLedgEntryEndingDate."Due Date");
                            AgingBy::"Posting Date":
                                PeriodIndex := GetPeriodIndex(VendorLedgEntryEndingDate."Posting Date");
                            AgingBy::"Document Date":
                                begin
                                    if VendorLedgEntryEndingDate."Document Date" > EndingDateV then begin
                                        VendorLedgEntryEndingDate."Remaining Amount" := 0;
                                        VendorLedgEntryEndingDate."Remaining Amt. (LCY)" := 0;
                                        VendorLedgEntryEndingDate."Document Date" := VendorLedgEntryEndingDate."Posting Date";
                                    end;
                                    PeriodIndex := GetPeriodIndex(VendorLedgEntryEndingDate."Document Date");
                                end;
                        end;
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
                        if not PrintAmountInLCY then
                            UpdateCurrencyTotals();
                    end;

                    trigger OnPreDataItem()
                    begin
                        if not PrintAmountInLCY then
                            TempVendorLedgEntry.SETRANGE("Currency Code", TempCurrency.Code);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(TotalVendorLedgEntry);

                    if Number = 1 then begin
                        if not TempCurrency.FINDSET(false, false) then
                            CurrReport.BREAK();
                    end else
                        if TempCurrency.NEXT() = 0 then
                            CurrReport.BREAK();

                    if TempCurrency.Code <> '' then
                        CurrencyCode := TempCurrency.Code
                    else
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
                if NewPagePerVendor then
                    PageGroupNo := PageGroupNo + 1;

                TempCurrency.RESET();
                TempCurrency.DELETEALL();
                TempVendorLedgEntry.RESET();
                TempVendorLedgEntry.DELETEALL();
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;
            end;
        }
        dataitem(CurrencyTotals; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = filter(1 ..));

            trigger OnAfterGetRecord()
            begin
                if Number = 1 then begin
                    if not TempCurrency2.FINDSET(false, false) then
                        CurrReport.BREAK();
                end else
                    if TempCurrency2.NEXT() = 0 then
                        CurrReport.BREAK();

                CLEAR(AgedVendorLedgEntry);
                TempCurrencyAmount.SETRANGE("Currency Code", TempCurrency2.Code);
                if TempCurrencyAmount.FINDSET(false, false) then
                    repeat
                        if TempCurrencyAmount.Date <> 99991231D then
                            AgedVendorLedgEntry[GetPeriodIndex(TempCurrencyAmount.Date)]."Remaining Amount" :=
                              TempCurrencyAmount.Amount
                        else
                            AgedVendorLedgEntry[6]."Remaining Amount" := TempCurrencyAmount.Amount;
                    until TempCurrencyAmount.NEXT() = 0;
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 0;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options', Comment = 'FRA="Options"';
                    field(EndingDate; EndingDateV)
                    {
                        Caption = 'Aged As Of', Comment = 'FRA="Echéancier à la date du"';
                        ApplicationArea = All;
                    }
                }
            }
        }
        trigger OnOpenPage()
        begin
            if EndingDateV = 0D then
                EndingDateV := WORKDATE();
        end;
    }
    trigger OnPreReport()
    begin
        VendorFilter := Vendor.GETFILTERS;
        AgingBy := AgingBy::"Due Date";
        PrintDetails := true;
        EVALUATE(PeriodLength, '30J');
        HeadingType := HeadingType::"Number of Days";

        GLSetup.GET();

        CalcDates();
        CreateHeadings();
    end;

    var
        TempCurrency: Record Currency temporary;
        TempCurrency2: Record Currency temporary;
        TempCurrencyAmount: Record "Currency Amount" temporary;
        DetailedVendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";
        GLSetup: Record "General Ledger Setup";
        AgedVendorLedgEntry: array[6] of Record "Vendor Ledger Entry";
        GrandTotalVendorLedgEntry: array[5] of Record "Vendor Ledger Entry";
        TempVendorLedgEntry: Record "Vendor Ledger Entry" temporary;
        TotalVendorLedgEntry: array[5] of Record "Vendor Ledger Entry";
        VendorLedgEntryEndingDate: Record "Vendor Ledger Entry";
        PeriodLength: DateFormula;
        NewPagePerVendor: Boolean;
        PrintAmountInLCY: Boolean;
        PrintDetails: Boolean;
        CurrencyCode: Code[10];
        EndingDateV: Date;
        PeriodEndDate: array[5] of Date;
        PeriodStartDate: array[5] of Date;
        NumberOfCurrencies: Integer;
        PageGroupNo: Integer;
        Aged_Overdue_AmountsCaptionLbl: label 'Due', Comment = 'FRA="Echu"';
        CurrReport_PAGENOCaptionLbl: label 'Page', Comment = 'FRA="Page"';
        EmptyStringCaptionLbl: label '%', Comment = 'FRA="%"';
        FORMAT_VendorLedgEntryEndingDate__Document_Type__CaptionLbl: label 'Document type', Comment = 'FRA="Type document"';
        Original_Amount_Control58CaptionLbl: label 'Total', Comment = 'FRA="Total"';
        Text000: label 'Not Due', Comment = 'FRA="Non échu"';
        Text002: label 'days', Comment = 'FRA="jours"';
        Text005: label 'Total for %1', Comment = 'FRA="Total de %1"';
        Text006: label 'Summary aging as %1', Comment = 'FRA="Echéancier fournisseur en date du %1"';
        Text010: label 'The Date Formula %1 cannot be used. Try to restate it. E.g. 1M+CM instead of CM+1M.', Comment = 'FRA="La formule date %1 ne peut pas être utilisée. Veuillez la redéfinir en utilisant, par exemple, 1M+CM au lieu de CM+1M."';
        Text011: label 'Enter a date formula in the Period Length field.', Comment = 'FRA="Entrez une formule de date dans le champ Base période."';
        Total__LCY_CaptionLbl: label 'Total', Comment = 'FRA="Total"';
        VendorLedgEntryEndingDate__Document_No__CaptionLbl: label 'Document No.', Comment = 'FRA="N° document"';
        VendorLedgEntryEndingDate__Posting_Date_CaptionLbl: label 'Posting date', Comment = 'FRA="Date de comptabilisation"';
        HeadingType: Option "Date Interval","Number of Days";
        AgingBy: Option "Due Date","Posting Date","Document Date";
        VendorFilter: Text;
        HeaderText: array[5] of Text[30];

    local procedure CalcDates()
    var
        PeriodLength2: DateFormula;
        i: Integer;
    begin
        if not EVALUATE(PeriodLength2, '-' + FORMAT(PeriodLength)) then
            ERROR(Text011);
        if AgingBy = AgingBy::"Due Date" then begin
            PeriodEndDate[1] := 99991231D;
            PeriodStartDate[1] := EndingDateV + 1;
        end else begin
            PeriodEndDate[1] := EndingDateV;
            PeriodStartDate[1] := CALCDATE(PeriodLength2, EndingDateV + 1);
        end;
        for i := 2 to ARRAYLEN(PeriodEndDate) do begin
            PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
            PeriodStartDate[i] := CALCDATE(PeriodLength2, PeriodEndDate[i] + 1);
        end;

        i := ARRAYLEN(PeriodEndDate);

        PeriodStartDate[i] := 0D;

        for i := 1 to ARRAYLEN(PeriodEndDate) do
            if PeriodEndDate[i] < PeriodStartDate[i] then
                ERROR(Text010, PeriodLength);
    end;

    local procedure CreateHeadings()
    var
        i: Integer;
    begin
        if AgingBy = AgingBy::"Due Date" then begin
            HeaderText[1] := Text000;
            i := 2;
        end else
            i := 1;

        /*
        WHILE i < ARRAYLEN(PeriodEndDate) DO BEGIN
          IF HeadingType = HeadingType::"Date Interval" THEN
            HeaderText[i] := STRSUBSTNO('%1\..%2',PeriodStartDate[i],PeriodEndDate[i])
          ELSE
            HeaderText[i] :=
              STRSUBSTNO('%1 - %2 %3',EndingDate - PeriodEndDate[i] + 1,EndingDate - PeriodStartDate[i] + 1,Text002);
          i := i + 1;
        END;
        IF HeadingType = HeadingType::"Date Interval" THEN
          HeaderText[i] := STRSUBSTNO('%1\%2',Text001,PeriodStartDate[i - 1])
        ELSE
          HeaderText[i] := STRSUBSTNO('%1\%2 %3',Text003,EndingDate - PeriodStartDate[i - 1] + 1,Text002);
        */

        while i < ARRAYLEN(PeriodEndDate) do begin
            HeaderText[i] := STRSUBSTNO('%1<x<%2 %3', EndingDateV - PeriodEndDate[i], EndingDateV - PeriodStartDate[i] + 1, Text002);
            i := i + 1;
        end;
        HeaderText[i] := STRSUBSTNO('>=%1 %2', EndingDateV - PeriodStartDate[i - 1] + 1, Text002);
    end;

    local procedure InsertTemp(var VendorLedgEntry: Record "Vendor Ledger Entry")
    var
        Currency: Record Currency;
    begin
        if TempVendorLedgEntry.GET(VendorLedgEntry."Entry No.") then
            exit;
        TempVendorLedgEntry := VendorLedgEntry;
        TempVendorLedgEntry.INSERT();
        if PrintAmountInLCY then begin
            CLEAR(TempCurrency);
            TempCurrency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
            if TempCurrency.INSERT() then;
            exit;
        end;
        if TempCurrency.GET(TempVendorLedgEntry."Currency Code") then
            exit;
        if TempVendorLedgEntry."Currency Code" <> '' then
            Currency.GET(TempVendorLedgEntry."Currency Code")
        else begin
            CLEAR(Currency);
            Currency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
        end;
        TempCurrency := Currency;
        TempCurrency.INSERT();
    end;

    local procedure GetPeriodIndex(Date: Date): Integer
    var
        i: Integer;
    begin
        for i := 1 to ARRAYLEN(PeriodEndDate) do
            if Date in [PeriodStartDate[i] .. PeriodEndDate[i]] then
                exit(i);
    end;

    local procedure Pct(a: Decimal; b: Decimal): Text[30]
    begin
        if b <> 0 then
            exit(FORMAT(ROUND(100 * a / b, 0.1), 0, '<Sign><Integer><Decimals,2>') + '%');
    end;

    local procedure UpdateCurrencyTotals()
    var
        i: Integer;
    begin
        TempCurrency2.Code := CurrencyCode;
        if TempCurrency2.INSERT() then;
        for i := 1 to ARRAYLEN(TotalVendorLedgEntry) do begin
            TempCurrencyAmount."Currency Code" := CurrencyCode;
            TempCurrencyAmount.Date := PeriodStartDate[i];
            if TempCurrencyAmount.FIND() then begin
                TempCurrencyAmount.Amount := TempCurrencyAmount.Amount + TotalVendorLedgEntry[i]."Remaining Amount";
                TempCurrencyAmount.MODIFY();
            end else begin
                TempCurrencyAmount."Currency Code" := CurrencyCode;
                TempCurrencyAmount.Date := PeriodStartDate[i];
                TempCurrencyAmount.Amount := TotalVendorLedgEntry[i]."Remaining Amount";
                TempCurrencyAmount.INSERT();
            end;
        end;
        TempCurrencyAmount."Currency Code" := CurrencyCode;
        TempCurrencyAmount.Date := 99991231D;
        if TempCurrencyAmount.FIND() then begin
            TempCurrencyAmount.Amount := TempCurrencyAmount.Amount + TotalVendorLedgEntry[1].Amount;
            TempCurrencyAmount.MODIFY();
        end else begin
            TempCurrencyAmount."Currency Code" := CurrencyCode;
            TempCurrencyAmount.Date := 99991231D;
            TempCurrencyAmount.Amount := TotalVendorLedgEntry[1].Amount;
            TempCurrencyAmount.INSERT();
        end;
    end;
}
