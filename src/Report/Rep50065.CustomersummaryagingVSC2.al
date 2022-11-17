report 50065 "Customer : summary aging VSC 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/CustomersummaryagingVSC2.rdl';
    Caption = 'Customer : summary aging VSC';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Vendor; Customer)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(EnteteToday; FORMAT(TODAY, 0, 4))
            {
            }
            column(EnteteCompany; COMPANYNAME)
            {
            }
            column(EntetePageno; CurrReport.PAGENO())
            {
            }
            column(EnteteUserid; USERID)
            {
            }
            column(EnteteEndingDate; STRSUBSTNO(Text006, FORMAT(EndingDate, 0, 4)))
            {
            }
            column(EnteteSelection; Gtext_Selection)
            {
            }
            column(EnteteFilter; TABLECAPTION + ': ' + VendorFilter)
            {
            }
            column(BDEC90J; HeaderText[5])
            {
            }
            column(BDEC30J; HeaderText[2])
            {
            }
            column(BDNCCaption; HeaderText[1])
            {
            }
            column(BD30J; Gtext_NonEchu[1])
            {
            }
            column(BD3060J; Text022)
            {
            }
            column(BD60J; Text023)
            {
            }
            column(BDEC3060J; Text024)
            {
            }
            column(BCEC6090J; Text025)
            {
            }
            column(TOT8; GrandTotalVendorLedgEntry[5]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(TOT7; GrandTotalVendorLedgEntry[4]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(TOT6; GrandTotalVendorLedgEntry[3]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(TOT5; GrandTotalVendorLedgEntry[2]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(TOT3MT1; GrandTotalVendorLedgEntry[1]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(TOT1; GrandTotalVendorLedgEntry[1]."Amount (LCY)")
            {
                AutoFormatType = 1;
            }
            column(TOT2; Gdec_GrandTotalMontantNonEchu[1])
            {
            }
            column(TOT3; Gdec_GrandTotalMontantNonEchu[2])
            {
            }
            column(TOT4; Gdec_GrandTotalMontantNonEchu[3])
            {
            }
            column(TOT2Caption; Text013)
            {
            }
            column(TOT3Caption; Text021)
            {
            }
            column(TOT2MT1; GrandTotalVendorLedgEntry[1]."Amount (LCY)" - GrandTotalVendorLedgEntry[1]."Remaining Amt. (LCY)")
            {
            }
            column(EnteteCaptionPage; EnteteCaptionPageLbl)
            {
            }
            column(Aged_Overdue_AmountsCaption; Aged_Overdue_AmountsCaptionLbl)
            {
            }
            column(BdDueDate; BdDueDateLbl)
            {
            }
            column(BdDate; BdDateLbl)
            {
            }
            column(BdDocNo; BdDocNo)
            {
            }
            column(BdExtDocNo; BdExtDocNo)
            {
            }
            column(BdDesc; BdDesc)
            {
            }
            column(BdRemAmt; BdRemAmt)
            {
            }
            column(TOTCaption; TOTCaptionLbl)
            {
            }
            column(Vendor_No_; "No.")
            {
            }
            dataitem(DataItem4114; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No.");
                DataItemTableView = sorting("Customer No.", "Posting Date", "Currency Code");

                trigger OnAfterGetRecord()
                var
                    VendorLedgEntry: Record "Cust. Ledger Entry";
                begin
                    VendorLedgEntry.SETCURRENTKEY("Closed by Entry No.");
                    VendorLedgEntry.SETRANGE("Closed by Entry No.", "Entry No.");
                    VendorLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
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
                    VendorLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
                    if VendorLedgEntry.FINDSET(false, false) then
                        repeat
                            InsertTemp(VendorLedgEntry);
                        until VendorLedgEntry.NEXT() = 0;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Posting Date", EndingDate + 1, 99991231D);
                end;
            }
            dataitem(OpenVendorLedgEntry; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No.");
                DataItemTableView = sorting("Customer No.", Open, Positive, "Due Date", "Currency Code");

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
                        SETRANGE("Posting Date", 0D, EndingDate);
                        SETRANGE("Date Filter", 0D, EndingDate);
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
                    column(LigVendorName; Vendor.Name)
                    {
                    }
                    column(LigVendorNo; Vendor."No.")
                    {
                    }
                    column(LigEC4; AgedVendorLedgEntry[5]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(LigEC3; AgedVendorLedgEntry[4]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(LigEC2; AgedVendorLedgEntry[3]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(LigEC1; AgedVendorLedgEntry[2]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(LigRemainAmount; VendorLedgEntryEndingDate."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(LigExternalNo; VendorLedgEntryEndingDate."External Document No.")
                    {
                    }
                    column(LigDocNo; VendorLedgEntryEndingDate."Document No.")
                    {
                    }
                    column(LigPostDate; FORMAT(VendorLedgEntryEndingDate."Posting Date"))
                    {
                    }
                    column(LigNC1; Gdec_MontantNonEchu[1])
                    {
                    }
                    column(LigNC2; Gdec_MontantNonEchu[2])
                    {
                    }
                    column(LigNC3; Gdec_MontantNonEchu[3])
                    {
                    }
                    column(LigDescription; VendorLedgEntryEndingDate.Description)
                    {
                    }
                    column(LigDueDate; FORMAT(VendorLedgEntryEndingDate."Due Date"))
                    {
                    }
                    column(ST1Caption; Text012)
                    {
                    }
                    column(ST1TOT8; TotalVendorLedgEntry[5]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(ST1TOT7; TotalVendorLedgEntry[4]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(ST1TOT6; TotalVendorLedgEntry[3]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(ST1TOT5; TotalVendorLedgEntry[2]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(ST2TOT1; TotalVendorLedgEntry[1].Amount - TotalVendorLedgEntry[1]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(ST1TOT1; TotalVendorLedgEntry[1].Amount)
                    {
                        AutoFormatType = 1;
                    }
                    column(ST1TOT2; Gdec_TotalMontantNonEchu[1])
                    {
                    }
                    column(ST1TOT3; Gdec_TotalMontantNonEchu[2])
                    {
                    }
                    column(ST1TOT4; Gdec_TotalMontantNonEchu[3])
                    {
                    }
                    column(ST2Caption; Text013)
                    {
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

                        //Modif JX-AUD du 01/07/2013
                        if Grec_PurchaseInvoiceHeader.GET(VendorLedgEntryEndingDate."Document No.") then
                            if Grec_PurchaseInvoiceHeader."BC6_Litige" then
                                VendorLedgEntryEndingDate.Description := '* ' + VendorLedgEntryEndingDate.Description;
                        //Fin Modif JX-AUD du 01/07/2013

                        //N° Compte
                        if Grec_GL_Entry.GET(VendorLedgEntryEndingDate."Entry No.") then
                            Gtext_Compte := Grec_GL_Entry."G/L Account No."
                        else
                            Gtext_Compte := '';

                        //skip si pas 401*
                        if Gopt_ComptesFourn = Gopt_ComptesFourn::Comptes401 then
                            if COPYSTR(Gtext_Compte, 1, 3) <> '401' then CurrReport.SKIP();

                        DetailedVendorLedgerEntry.SETRANGE("Cust. Ledger Entry No.", VendorLedgEntryEndingDate."Entry No.");
                        if DetailedVendorLedgerEntry.FINDSET(false, false) then
                            repeat
                                if (DetailedVendorLedgerEntry."Entry Type" =
                                    DetailedVendorLedgerEntry."Entry Type"::"Initial Entry") and
                                   (VendorLedgEntryEndingDate."Posting Date" > EndingDate) and
                                   (AgingBy <> AgingBy::"Posting Date")
                                then
                                    if VendorLedgEntryEndingDate."Document Date" <= EndingDate then
                                        DetailedVendorLedgerEntry."Posting Date" :=
                                          VendorLedgEntryEndingDate."Document Date"
                                    else
                                        if (VendorLedgEntryEndingDate."Due Date" <= EndingDate) and
                                           (AgingBy = AgingBy::"Due Date")
                                        then
                                            DetailedVendorLedgerEntry."Posting Date" :=
                                              VendorLedgEntryEndingDate."Due Date";

                                if (DetailedVendorLedgerEntry."Posting Date" <= EndingDate) or
                                   (TempVendorLedgEntry.Open and
                                    (AgingBy = AgingBy::"Due Date") and
                                    (VendorLedgEntryEndingDate."Due Date" > EndingDate)) then begin
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
                                //PeriodIndex := GetPeriodIndex(VendorLedgEntryEndingDate."Posting Date");   //Modif JX-AUD du 24/08/11
                                PeriodIndex := GetPeriodIndex(VendorLedgEntryEndingDate."Due Date");   //Modif JX-AUD du 24/08/11
                            AgingBy::"Document Date":
                                begin
                                    if VendorLedgEntryEndingDate."Document Date" > EndingDate then begin
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

                        //Traitement écritures échues
                        Gint_IndexPeriodeNonEchue := 0;
                        if PeriodIndex = 1 then
                            if (VendorLedgEntryEndingDate."Due Date" <= Gdate_FinPeriodeNonEchue[1]) then
                                Gint_IndexPeriodeNonEchue := 1
                            else
                                if (VendorLedgEntryEndingDate."Due Date" >= Gdate_DebutPeriodeNonEchue[2]) and
                              (VendorLedgEntryEndingDate."Due Date" <= Gdate_FinPeriodeNonEchue[2]) then
                                    Gint_IndexPeriodeNonEchue := 2
                                else
                                    if (VendorLedgEntryEndingDate."Due Date" >= Gdate_DebutPeriodeNonEchue[3]) then
                                        Gint_IndexPeriodeNonEchue := 3;
                        for i := 1 to 3 do begin
                            if (i = Gint_IndexPeriodeNonEchue) then
                                Gdec_MontantNonEchu[i] := AgedVendorLedgEntry[1]."Remaining Amount"
                            else
                                Gdec_MontantNonEchu[i] := 0;
                            Gdec_TotalMontantNonEchu[i] += Gdec_MontantNonEchu[i];
                            Gdec_GrandTotalMontantNonEchu[i] += Gdec_MontantNonEchu[i];
                        end;
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

                trigger OnPostDataItem()
                begin
                    if NewPagePerVendor and (NumberOfCurrencies > 0) then
                        CurrReport.NEWPAGE();
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

                for i := 1 to 3 do
                    Gdec_TotalMontantNonEchu[i] := 0;
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
                if ISSERVICETIER then
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
                    Caption = 'Options';
                    field("Echéancier à la date du"; EndingDate)
                    {
                        ApplicationArea = All;
                    }
                    field("Type Comptes Fournisseurs"; Gopt_ComptesFourn)
                    {
                        ApplicationArea = All;
                    }
                    field("Afficher l'entête"; Gbool_AfficherEnTete)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin

            Gopt_ComptesFourn := Gopt_ComptesFourn::Tous;
            Gbool_AfficherEnTete := true;

            if EndingDate = 0D then
                EndingDate := WORKDATE();

            AgingBy := AgingBy::"Due Date";
            PrintDetails := true;
            EVALUATE(PeriodLength, '30J');
            HeadingType := HeadingType::"Number of Days";
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        //Modif JX-AUD du 22/08/11
        AgingBy := AgingBy::"Posting Date";
        //Fin modif JX-AUD du 22/08/11

        VendorFilter := Vendor.GETFILTERS;

        GLSetup.GET();

        CalcDates();
        CreateHeadings();

        for i := 1 to 3 do
            Gdec_GrandTotalMontantNonEchu[i] := 0;
    end;

    var
        TempCurrency: Record Currency temporary;
        TempCurrency2: Record Currency temporary;
        TempCurrencyAmount: Record "Currency Amount" temporary;
        AgedVendorLedgEntry: array[6] of Record "Cust. Ledger Entry";
        GrandTotalVendorLedgEntry: array[5] of Record "Cust. Ledger Entry";
        TempVendorLedgEntry: Record "Cust. Ledger Entry" temporary;
        TotalVendorLedgEntry: array[5] of Record "Cust. Ledger Entry";
        VendorLedgEntryEndingDate: Record "Cust. Ledger Entry";
        DetailedVendorLedgerEntry: Record "Detailed Cust. Ledg. Entry";
        Grec_GL_Entry: Record "G/L Entry";
        GLSetup: Record "General Ledger Setup";
        Grec_PurchaseInvoiceHeader: Record "Purch. Inv. Header";
        PeriodLength: DateFormula;
        PeriodLength3: DateFormula;
        Gbool_AfficherEnTete: Boolean;
        NewPagePerVendor: Boolean;
        PrintAmountInLCY: Boolean;
        PrintDetails: Boolean;
        CurrencyCode: Code[10];
        EndingDate: Date;
        Gdate_DebutPeriodeNonEchue: array[3] of Date;
        Gdate_FinPeriodeNonEchue: array[3] of Date;
        PeriodEndDate: array[5] of Date;
        PeriodStartDate: array[5] of Date;
        Gdec_GrandTotalMontantNonEchu: array[3] of Decimal;
        Gdec_MontantNonEchu: array[3] of Decimal;
        Gdec_TotalMontantNonEchu: array[3] of Decimal;
        Gint_IndexPeriodeNonEchue: Integer;
        i: Integer;
        NumberOfCurrencies: Integer;
        PageGroupNo: Integer;
        Aged_Overdue_AmountsCaptionLbl: label 'Due';
        BdDateLbl: label 'Posting date';
        BdDesc: label 'Libellé';
        BdDocNo: label 'N° Document';
        BdDueDateLbl: label 'Due date';
        BdExtDocNo: label 'Référence';
        BdRemAmt: label 'Montant Ouvert';
        EnteteCaptionPageLbl: label 'Page';
        Text000: label 'Not Due';
        Text006: label 'Summary aging as %1';
        Text010: label 'The Date Formula %1 cannot be used. Try to restate it. E.g. 1M+CM instead of CM+1M.';
        Text011: label 'Enter a date formula in the Period Length field.';
        Text012: label 'subtotal';
        Text013: label 'wich expired';
        Text014: label 'To be payed within %1 days';
        Text015: label 'A mature between %1 and %2 days';
        Text016: label 'A maturity beyond 1% days';
        Text018: label 'Less than %1 days';
        Text019: label 'For more than 1% and less than %2 days';
        Text020: label 'For more than 1% days';
        Text021: label 'wich not expired';
        Text022: label 'A échéance entre 30 et 60J';
        Text023: label 'A échéance au delà de 60J';
        Text024: label 'Depuis plus de 30J et moins de 60J';
        Text025: label 'Depuis plus de 60J et moins de 90J';
        TOTCaptionLbl: label 'Total';
        HeadingType: Option "Date Interval","Number of Days";
        AgingBy: Option "Due Date","Posting Date","Document Date";
        Gopt_ComptesFourn: Option Tous,Comptes401;
        Gtext_Compte: Text[10];
        Gtext_Selection: Text[30];
        Gtext_NonEchu: array[3] of Text[50];
        HeaderText: array[5] of Text[50];
        VendorFilter: Text[250];

    local procedure CalcDates()
    var
        PeriodLength2: DateFormula;
        i: Integer;
    begin
        if not EVALUATE(PeriodLength2, '-' + FORMAT(PeriodLength)) then
            ERROR(Text011);
        if (AgingBy = AgingBy::"Due Date") or (AgingBy = AgingBy::"Posting Date") then begin  //Modif JX-AUD du 24/08/11
            PeriodEndDate[1] := 99991231D;
            PeriodStartDate[1] := EndingDate + 1;
        end else begin
            PeriodEndDate[1] := EndingDate;
            PeriodStartDate[1] := CALCDATE(PeriodLength2, EndingDate + 1);
        end;
        for i := 2 to ARRAYLEN(PeriodEndDate) do begin
            PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
            PeriodStartDate[i] := CALCDATE(PeriodLength2, PeriodEndDate[i] + 1);
        end;

        if ISSERVICETIER then
            i := ARRAYLEN(PeriodEndDate);

        PeriodStartDate[i] := 0D;

        for i := 1 to ARRAYLEN(PeriodEndDate) do
            if PeriodEndDate[i] < PeriodStartDate[i] then
                ERROR(Text010, PeriodLength);

        //Calcul de la période concernant les documents non échus
        if EVALUATE(PeriodLength3, '+' + FORMAT(PeriodLength)) then begin
            Gdate_DebutPeriodeNonEchue[1] := PeriodStartDate[1];
            Gdate_DebutPeriodeNonEchue[2] := CALCDATE(PeriodLength3, Gdate_DebutPeriodeNonEchue[1]);
            Gdate_DebutPeriodeNonEchue[3] := CALCDATE(PeriodLength3, Gdate_DebutPeriodeNonEchue[2]);
            Gdate_FinPeriodeNonEchue[1] := CALCDATE(PeriodLength3, Gdate_DebutPeriodeNonEchue[1] - 1);
            Gdate_FinPeriodeNonEchue[2] := CALCDATE(PeriodLength3, Gdate_DebutPeriodeNonEchue[2] - 1);
        end;
    end;

    local procedure CreateHeadings()
    var
        i: Integer;
    begin
        if (AgingBy = AgingBy::"Due Date") or (AgingBy = AgingBy::"Posting Date") then begin //Modif JX-AUD du 24/08/11
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
        /*
        WHILE i < ARRAYLEN(PeriodEndDate) DO BEGIN
            HeaderText[i] := STRSUBSTNO('%1<x<%2 %3',EndingDate - PeriodEndDate[i],EndingDate - PeriodStartDate[i] + 1,Text002);
          i := i + 1;
        END;
        HeaderText[i] := STRSUBSTNO('>=%1 %2',EndingDate - PeriodStartDate[i - 1] + 1,Text002);
        */

        //En-têtes pour les documents échus
        HeaderText[2] := STRSUBSTNO(Text018, EndingDate - PeriodStartDate[2] + 1);
        HeaderText[3] := STRSUBSTNO(Text019, EndingDate - PeriodEndDate[3], EndingDate - PeriodStartDate[3] + 1);
        HeaderText[4] := STRSUBSTNO(Text019, EndingDate - PeriodEndDate[4], EndingDate - PeriodStartDate[4] + 1);
        HeaderText[5] := STRSUBSTNO(Text020, EndingDate - PeriodStartDate[5 - 1] + 1);

        //En-têtes pour les documents non échus
        Gtext_NonEchu[1] := STRSUBSTNO(Text014, Gdate_FinPeriodeNonEchue[1] - EndingDate);
        Gtext_NonEchu[2] := STRSUBSTNO(Text015, Gdate_DebutPeriodeNonEchue[2] - EndingDate - 1, Gdate_FinPeriodeNonEchue[2] - EndingDate);
        Gtext_NonEchu[3] := STRSUBSTNO(Text016, Gdate_FinPeriodeNonEchue[2] - EndingDate);
    end;

    local procedure InsertTemp(var VendorLedgEntry: Record "Cust. Ledger Entry")
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
