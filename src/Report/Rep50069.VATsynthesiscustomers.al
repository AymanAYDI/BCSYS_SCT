report 50069 "BC6_VAT synthesis customers"
{
    // //Création JX-AUD du 22/11/11
    // //Reprise du report 50010 en l'adaptant au client
    // 
    // //JX-AUD du 13/05/2013
    // //Agrandissement logo
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/VATsynthesiscustomers.rdl';
    Caption = 'VAT synthesis customers', Comment = 'FRA="Synthèse TVA clients"';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(DataItem1000000002; Integer)
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            MaxIteration = 1;
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(Text015; Text015)
            {
            }
            column("USERID"; USERID)
            {
            }
            column(FORMAT_TODAY_; FORMAT(TODAY))
            {
            }
            column(Text014_____FORMAT_TIME_; Text014 + ' ' + FORMAT(TIME))
            {
            }
            column(Text017_______Gtxt_FiltreCompteTVA; Text017 + ' : ' + Gtxt_FiltreCompteTVA)
            {
            }
            column(Reminder_of_the_selectionCaption; Reminder_of_the_selectionCaptionLbl)
            {
            }
            column(User__Caption; User__CaptionLbl)
            {
            }
            column(Date__Caption; Date__CaptionLbl)
            {
            }
            column(External_Document_No_Caption; External_Document_No_CaptionLbl)
            {
            }
            column(Accounting_DateCaption; Accounting_DateCaptionLbl)
            {
            }
            column(VAT_Bus__Posting_GroupCaption; VAT_Bus__Posting_GroupCaptionLbl)
            {
            }
            column(VAT_Prod__Posting_GroupCaption; VAT_Prod__Posting_GroupCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(VAT_AmountCaption; VAT_AmountCaptionLbl)
            {
            }
            column(Amount_including_VATCaption; Amount_including_VATCaptionLbl)
            {
            }
            column(VAT_____Am__Inc__VAT__VAT_Caption; VAT_____Am__Inc__VAT__VAT_CaptionLbl)
            {
            }
            column(Piece_NumberCaption; Piece_NumberCaptionLbl)
            {
            }
            column(Journal__CodeCaption; Journal__CodeCaptionLbl)
            {
            }
            column(Account_DescriptionCaption; Account_DescriptionCaptionLbl)
            {
            }
            column(Account_NumberCaption; Account_NumberCaptionLbl)
            {
            }
            column(Centralizer_accountCaption; Centralizer_accountCaptionLbl)
            {
            }
            column(TOTALCaption; TOTALCaptionLbl)
            {
            }

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET();
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
            end;
        }
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(Original_Amount; Gdec_SoldeTotal)
            {
                AutoFormatType = 1;
            }
            column(Gdec_MontantTotalTVA; Gdec_MontantTotalTVA)
            {
            }
            column(Customer_No_; "No.")
            {
            }
            dataitem(DataItem8503; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Customer No.", "Posting Date", "Currency Code");

                trigger OnAfterGetRecord()
                var
                    CustomerLedgEntry: Record "Cust. Ledger Entry";
                begin
                    CustomerLedgEntry.SETCURRENTKEY("Closed by Entry No.");
                    CustomerLedgEntry.SETRANGE("Closed by Entry No.", "Entry No.");
                    CustomerLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
                    IF CustomerLedgEntry.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            InsertTemp(CustomerLedgEntry);
                        UNTIL CustomerLedgEntry.NEXT() = 0;

                    IF "Closed by Entry No." <> 0 THEN BEGIN
                        CustomerLedgEntry.SETRANGE("Closed by Entry No.", "Closed by Entry No.");
                        IF CustomerLedgEntry.FINDSET(FALSE, FALSE) THEN
                            REPEAT
                                InsertTemp(CustomerLedgEntry);
                            UNTIL CustomerLedgEntry.NEXT() = 0;
                    END;

                    CustomerLedgEntry.RESET();
                    CustomerLedgEntry.SETRANGE("Entry No.", "Closed by Entry No.");
                    CustomerLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
                    IF CustomerLedgEntry.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            InsertTemp(CustomerLedgEntry);
                        UNTIL CustomerLedgEntry.NEXT() = 0;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Posting Date", EndingDate + 1, 99991231D);
                end;
            }
            dataitem(OpenCustomerLedgEntry; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Customer No.", Open, Positive, "Due Date", "Currency Code");

                trigger OnAfterGetRecord()
                begin
                    IF AgingBy = AgingBy::"Posting Date" THEN BEGIN
                        CALCFIELDS("Remaining Amt. (LCY)");
                        IF "Remaining Amt. (LCY)" = 0 THEN
                            CurrReport.SKIP();
                    END;
                    InsertTemp(OpenCustomerLedgEntry);
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
                dataitem(TempCustomertLedgEntryLoop; Integer)
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                    PrintOnlyIfDetail = false;
                    column(Customer__No__; Customer."No.")
                    {
                    }
                    column(Gbool_TotalParClient; Gbool_TotalParClient)
                    {
                    }
                    column(CustomerLedgEntryEndingDate_Amount; CustomerLedgEntryEndingDate.Amount)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(CustomerLedgEntryEndingDate__Document_No__; CustomerLedgEntryEndingDate."Document No.")
                    {
                    }
                    column(CustomerLedgEntryEndingDate__Posting_Date_; CustomerLedgEntryEndingDate."Posting Date")
                    {
                    }
                    column(Customer_Name; Customer.Name)
                    {
                    }
                    column(CustomerLedgEntryEndingDate__Source_Code_; CustomerLedgEntryEndingDate."Source Code")
                    {
                    }
                    column(CustomerLedgEntryEndingDate__External_Document_No__; CustomerLedgEntryEndingDate."External Document No.")
                    {
                    }
                    column(CustomerLedgEntryEndingDate_Description; CustomerLedgEntryEndingDate.Description)
                    {
                    }
                    column(GCode_CompteCentralisateur; GCode_CompteCentralisateur)
                    {
                    }
                    column(Gdec_MontantTVA; Gdec_MontantTVA)
                    {
                    }
                    column(ROUND_ABS_Gdec_MontantTVA___ABS_CustomerLedgEntryEndingDate_Amount__ABS_Gdec_MontantTVA___100_0_1_; ROUND(ABS(Gdec_MontantTVA) / (ABS(CustomerLedgEntryEndingDate.Amount) - ABS(Gdec_MontantTVA)) * 100, 0.1))
                    {
                    }
                    column(Gcode_GrComptaMarcheTVA; Gcode_GrComptaMarcheTVA)
                    {
                    }
                    column(Gcode_GrComptaProduitTVA; Gcode_GrComptaProduitTVA)
                    {
                    }
                    column(Customer__No___Control1000000071; Customer."No.")
                    {
                    }
                    column(CustomerLedgEntryEndingDate_Amount_Control1000000066; CustomerLedgEntryEndingDate.Amount)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(Gdec_MontantTVA_Control1000000110; Gdec_MontantTVA)
                    {
                    }
                    column(Customer_Name_Control1000000111; Customer.Name)
                    {
                    }
                    column(TempCustomertLedgEntryLoop_Number; Number)
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        CustomerLedgEntry: Record "Cust. Ledger Entry";
                        PeriodIndex: Integer;
                    begin
                        IF Number = 1 THEN BEGIN
                            IF NOT TempCustomerLedgEntry.FINDSET(FALSE, FALSE) THEN
                                CurrReport.BREAK();
                        END ELSE
                            IF TempCustomerLedgEntry.NEXT() = 0 THEN
                                CurrReport.BREAK();

                        CustomerLedgEntryEndingDate := TempCustomerLedgEntry;
                        //Modif JX-AUD du 22/11/11
                        //N° Compte
                        IF Grec_GL_Entry.GET(CustomerLedgEntryEndingDate."Entry No.") THEN
                            Gtext_Compte := Grec_GL_Entry."G/L Account No."
                        ELSE
                            Gtext_Compte := '';

                        //skip si pas 411*
                        //IF Gopt_ComptesFourn = Gopt_ComptesFourn::Comptes401 THEN
                        IF COPYSTR(Gtext_Compte, 1, 3) <> '411' THEN CurrReport.SKIP();
                        //Fin modif JX-AUD du 22/11/11

                        DetailedCustomerLedgerEntry.SETRANGE("Cust. Ledger Entry No.", CustomerLedgEntryEndingDate."Entry No.");
                        IF DetailedCustomerLedgerEntry.FINDSET() THEN
                            REPEAT
                                IF (DetailedCustomerLedgerEntry."Entry Type" =
                                    DetailedCustomerLedgerEntry."Entry Type"::"Initial Entry") AND
                                   (CustomerLedgEntryEndingDate."Posting Date" > EndingDate) AND
                                   (AgingBy <> AgingBy::"Posting Date")
                                THEN
                                    IF CustomerLedgEntryEndingDate."Document Date" <= EndingDate THEN
                                        DetailedCustomerLedgerEntry."Posting Date" :=
                                          CustomerLedgEntryEndingDate."Document Date"
                                    ELSE
                                        IF (CustomerLedgEntryEndingDate."Due Date" <= EndingDate) AND
                                           (AgingBy = AgingBy::"Due Date")
                                        THEN
                                            DetailedCustomerLedgerEntry."Posting Date" :=
                                              CustomerLedgEntryEndingDate."Due Date";

                                IF DetailedCustomerLedgerEntry."Posting Date" <= EndingDate THEN BEGIN
                                    IF DetailedCustomerLedgerEntry."Entry Type" IN
                                      [DetailedCustomerLedgerEntry."Entry Type"::"Initial Entry",
                                       DetailedCustomerLedgerEntry."Entry Type"::"Unrealized Loss",
                                       DetailedCustomerLedgerEntry."Entry Type"::"Unrealized Gain",
                                       DetailedCustomerLedgerEntry."Entry Type"::"Realized Loss",
                                       DetailedCustomerLedgerEntry."Entry Type"::"Realized Gain",
                                       DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount",
                                       DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount (VAT Excl.)",
                                       DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount (VAT Adjustment)",
                                       DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance",
                                       DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance",
                                       DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance (VAT Excl.)",
                                       DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance (VAT Adjustment)",
                                       DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Excl.)",
                                       DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Adjustment)"]
                                    THEN BEGIN
                                        CustomerLedgEntryEndingDate.Amount := CustomerLedgEntryEndingDate.Amount + DetailedCustomerLedgerEntry.Amount;
                                        CustomerLedgEntryEndingDate."Amount (LCY)" :=
                                          CustomerLedgEntryEndingDate."Amount (LCY)" + DetailedCustomerLedgerEntry."Amount (LCY)";
                                    END;
                                    CustomerLedgEntryEndingDate."Remaining Amount" :=
                                      CustomerLedgEntryEndingDate."Remaining Amount" + DetailedCustomerLedgerEntry.Amount;
                                    CustomerLedgEntryEndingDate."Remaining Amt. (LCY)" :=
                                      CustomerLedgEntryEndingDate."Remaining Amt. (LCY)" + DetailedCustomerLedgerEntry."Amount (LCY)";
                                END;
                            UNTIL DetailedCustomerLedgerEntry.NEXT() = 0;

                        IF CustomerLedgEntryEndingDate."Remaining Amount" = 0 THEN
                            CurrReport.SKIP();

                        CASE AgingBy OF
                            AgingBy::"Due Date":
                                PeriodIndex := GetPeriodIndex(CustomerLedgEntryEndingDate."Due Date");
                            AgingBy::"Posting Date":
                                PeriodIndex := GetPeriodIndex(CustomerLedgEntryEndingDate."Posting Date");
                            AgingBy::"Document Date":
                                BEGIN
                                    IF CustomerLedgEntryEndingDate."Document Date" > EndingDate THEN BEGIN
                                        CustomerLedgEntryEndingDate."Remaining Amount" := 0;
                                        CustomerLedgEntryEndingDate."Remaining Amt. (LCY)" := 0;
                                        CustomerLedgEntryEndingDate."Document Date" := CustomerLedgEntryEndingDate."Posting Date";
                                    END;
                                    PeriodIndex := GetPeriodIndex(CustomerLedgEntryEndingDate."Document Date");
                                END;
                        END;
                        CLEAR(AgedCustomerLedgEntry);
                        AgedCustomerLedgEntry[PeriodIndex]."Remaining Amount" := CustomerLedgEntryEndingDate."Remaining Amount";
                        AgedCustomerLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" := CustomerLedgEntryEndingDate."Remaining Amt. (LCY)";
                        TotalCustomerLedgEntry[PeriodIndex]."Remaining Amount" += CustomerLedgEntryEndingDate."Remaining Amount";
                        TotalCustomerLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += CustomerLedgEntryEndingDate."Remaining Amt. (LCY)";
                        GrandTotalCustomerLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += CustomerLedgEntryEndingDate."Remaining Amt. (LCY)";
                        TotalCustomerLedgEntry[1].Amount += CustomerLedgEntryEndingDate."Remaining Amount";
                        TotalCustomerLedgEntry[1]."Amount (LCY)" += CustomerLedgEntryEndingDate."Remaining Amt. (LCY)";
                        GrandTotalCustomerLedgEntry[1]."Amount (LCY)" += CustomerLedgEntryEndingDate."Remaining Amt. (LCY)";

                        //DEBUT AJOUT JX-XAD 17/11/2010
                        GCode_CompteCentralisateur := '';
                        IF Grec_Customer.GET(Customer."No.") THEN
                            IF Grec_CustomerPostingGroup.GET(Grec_Customer."Customer Posting Group") THEN
                                GCode_CompteCentralisateur := Grec_CustomerPostingGroup."Receivables Account";

                        Gcode_GrComptaProduitTVA := '';
                        Gcode_GrComptaMarcheTVA := '';
                        Gdec_MontantTVA := 0;

                        Grec_GL_Entry.RESET();
                        Grec_GL_Entry.SETFILTER(Grec_GL_Entry."Document No.", '%1', CustomerLedgEntryEndingDate."Document No.");
                        IF Grec_GL_Entry.FIND('-') THEN BEGIN
                            //IF Grec_GL_Register.GET(Grec_GL_Entry."Entry No.") THEN
                            Grec_GL_Register.RESET();
                            Grec_GL_Register.SETFILTER(Grec_GL_Register."From Entry No.", '%1', Grec_GL_Entry."Entry No.");
                            IF Grec_GL_Register.FIND('-') THEN BEGIN
                                IF Grec_VAT_Entry.GET(Grec_GL_Register."From VAT Entry No.") THEN BEGIN
                                    Gcode_GrComptaProduitTVA := Grec_VAT_Entry."VAT Prod. Posting Group";
                                    Gcode_GrComptaMarcheTVA := Grec_VAT_Entry."VAT Bus. Posting Group";
                                    IF "Gbool_NePasInclureTVAdéclaréeV" THEN BEGIN
                                        IF Grec_VAT_Entry."Closed by Entry No." = 0 THEN BEGIN
                                            Grec_GL_Entry.SETFILTER(Grec_GL_Entry."G/L Account No.", Gtxt_FiltreCompteTVA);
                                            IF "Gbool_NePasInclureTVAlettréeV" THEN
                                                Grec_GL_Entry.SETFILTER(Grec_GL_Entry.Letter, '=%1', '');
                                            IF Grec_GL_Entry.FIND('-') THEN
                                                REPEAT
                                                    Gdec_MontantTVA += (Grec_GL_Entry.Amount);
                                                UNTIL Grec_GL_Entry.NEXT() = 0;
                                            IF "Gbool_NePasInclureTVAzéroV" AND (Gdec_MontantTVA = 0) THEN
                                                CurrReport.SKIP();
                                            Gdec_MontantTotalTVA += Gdec_MontantTVA;
                                        END ELSE
                                            IF "Gbool_NePasInclureTVAzéroV" AND (Gdec_MontantTVA = 0) THEN
                                                CurrReport.SKIP();
                                    END ELSE BEGIN
                                        Grec_GL_Entry.SETFILTER(Grec_GL_Entry."G/L Account No.", Gtxt_FiltreCompteTVA);
                                        IF "Gbool_NePasInclureTVAlettréeV" THEN
                                            Grec_GL_Entry.SETFILTER(Grec_GL_Entry.Letter, '=%1', '');
                                        IF Grec_GL_Entry.FIND('-') THEN
                                            REPEAT
                                                Gdec_MontantTVA += (Grec_GL_Entry.Amount);
                                            UNTIL Grec_GL_Entry.NEXT() = 0;
                                        IF "Gbool_NePasInclureTVAzéroV" AND (Gdec_MontantTVA = 0) THEN
                                            CurrReport.SKIP();
                                        Gdec_MontantTotalTVA += Gdec_MontantTVA;
                                    END;
                                END;
                            END ELSE
                                IF "Gbool_NePasInclureTVAzéroV" AND (Gdec_MontantTVA = 0) THEN
                                    CurrReport.SKIP();
                        END;
                        //FIN AJOUT JX-XAD 17/11/2010
                    end;

                    trigger OnPostDataItem()
                    begin
                        IF NOT PrintAmountInLCY THEN
                            UpdateCurrencyTotals();
                    end;

                    trigger OnPreDataItem()
                    begin
                        // CurrReport.CREATETOTALS(CustomerLedgEntryEndingDate.Amount);
                        // CurrReport.CREATETOTALS(Gdec_MontantTVA);

                        IF NOT PrintAmountInLCY THEN
                            TempCustomerLedgEntry.SETRANGE("Currency Code", TempCurrency.Code);

                        Grec_GL_Register.SETCURRENTKEY(Grec_GL_Register."From Entry No.");

                        IF TempCustomertLedgEntryLoop.COUNT = 0 THEN
                            CurrReport.SKIP();
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(TotalCustomerLedgEntry);

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
                TempCustomerLedgEntry.RESET();
                TempCustomerLedgEntry.DELETEALL();
            end;

            trigger OnPreDataItem()
            begin
                AgingBy := AgingBy::"Posting Date";
                //MESSAGE(FORMAT(AgingBy));
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

                CLEAR(AgedCustomerLedgEntry);
                TempCurrencyAmount.SETRANGE("Currency Code", TempCurrency2.Code);
                IF TempCurrencyAmount.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        IF TempCurrencyAmount.Date <> 99991231D THEN
                            AgedCustomerLedgEntry[GetPeriodIndex(TempCurrencyAmount.Date)]."Remaining Amount" :=
                              TempCurrencyAmount.Amount
                        ELSE
                            AgedCustomerLedgEntry[6]."Remaining Amount" := TempCurrencyAmount.Amount;
                    UNTIL TempCurrencyAmount.NEXT() = 0;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options', Comment = 'FRA="Options"';
                    field("Filtre Date"; EndingDate)
                    {
                        Caption = 'Filtre Date', Comment = 'FRA="Filtre Date"';
                        ApplicationArea = all;
                    }
                    field("Filtre Compte de TVA"; Gtxt_FiltreCompteTVA)
                    {
                        Caption = 'Filtre Compte de TVA', Comment = 'FRA="Filtre Compte de TVA"';
                        ApplicationArea = all;
                    }
                    field("Gbool_NePasInclureTVAdéclarée"; "Gbool_NePasInclureTVAdéclaréeV")
                    {
                        Caption = 'Ne pas inclure les montants des écritures de TVA déclarée', Comment = 'FRA="Ne pas inclure les montants des écritures de TVA déclarée"';
                        ApplicationArea = all;
                    }
                    field("Gbool_NePasInclureTVAlettrée"; "Gbool_NePasInclureTVAlettréeV")
                    {
                        Caption = 'Ne pas inclure les montants des écritures de TVA lettrée', Comment = 'FRA="Ne pas inclure les montants des écritures de TVA lettrée"';
                        ApplicationArea = all;
                    }
                    field("Gbool_NePasInclureTVAzéro"; "Gbool_NePasInclureTVAzéroV")
                    {
                        Caption = 'Ne pas faire apparaître les lignes où le montant TVA est à zéro', Comment = 'FRA="Ne pas faire apparaître les lignes où le montant TVA est à zéro"';
                        ApplicationArea = all;
                    }
                    field("Total par Clients"; Gbool_TotalParClient)
                    {
                        Caption = 'Total par Clients', Comment = 'FRA="Total par Clients"';
                        ApplicationArea = all;
                    }
                }
            }
        }
        trigger OnOpenPage()
        begin
            IF EndingDate = 0D THEN
                EndingDate := WORKDATE();

            AgingBy := AgingBy::"Posting Date";
            PrintDetails := TRUE;
            EVALUATE(PeriodLength, '<1M>');
        end;
    }
    trigger OnInitReport()
    begin
        Gdec_MontantTotalTVA := 0;
    end;

    trigger OnPreReport()
    begin
        Gtext_Sélection := '';
        IF "Gbool_NePasInclureTVAdéclaréeV" THEN
            Gtext_Sélection += Text018;
        IF "Gbool_NePasInclureTVAlettréeV" THEN
            Gtext_Sélection += '\' + Text019;
        IF "Gbool_NePasInclureTVAzéroV" THEN
            Gtext_Sélection += '\' + Text020;
        IF Gtxt_FiltreCompteTVA = '' THEN
            ERROR(Text016);
        CustomerFilter := Customer.GETFILTERS;
        GLSetup.GET();
        CalcDates();
        CreateHeadings();
    end;

    var
        CompanyInfo: Record "Company Information";
        TempCurrency: Record Currency temporary;
        TempCurrency2: Record Currency temporary;
        TempCurrencyAmount: Record "Currency Amount" temporary;
        AgedCustomerLedgEntry: array[6] of Record "Cust. Ledger Entry";
        CustomerLedgEntryEndingDate: Record "Cust. Ledger Entry";
        GrandTotalCustomerLedgEntry: array[5] of Record "Cust. Ledger Entry";
        TempCustomerLedgEntry: Record "Cust. Ledger Entry" temporary;
        TotalCustomerLedgEntry: array[5] of Record "Cust. Ledger Entry";
        Grec_Customer: Record Customer;
        Grec_CustomerPostingGroup: Record "Customer Posting Group";
        DetailedCustomerLedgerEntry: Record "Detailed Cust. Ledg. Entry";
        Grec_GL_Entry: Record "G/L Entry";
        Grec_GL_Register: Record "G/L Register";
        GLSetup: Record "General Ledger Setup";
        Grec_VAT_Entry: Record "VAT Entry";
        PeriodLength: DateFormula;
        Gbool_NePasInclureTVAdéclaréeV: Boolean;
        Gbool_NePasInclureTVAlettréeV: Boolean;
        Gbool_NePasInclureTVAzéroV: Boolean;
        Gbool_TotalParClient: Boolean;
        PrintAmountInLCY: Boolean;
        PrintDetails: Boolean;
        CurrencyCode: Code[10];
        GCode_CompteCentralisateur: Code[20];
        Gcode_GrComptaMarcheTVA: Code[20];
        Gcode_GrComptaProduitTVA: Code[20];
        EndingDate: Date;
        PeriodEndDate: array[5] of Date;
        PeriodStartDate: array[5] of Date;
        Gdec_MontantTotalTVA: Decimal;
        Gdec_MontantTVA: Decimal;
        Gdec_SoldeTotal: Decimal;
        NumberOfCurrencies: Integer;
        Account_DescriptionCaptionLbl: Label 'Account Description', Comment = 'FRA="Libellé du compte"';
        Account_NumberCaptionLbl: Label 'Account Number', Comment = 'FRA="Numéro Compte"';
        Accounting_DateCaptionLbl: Label 'Accounting Date', Comment = 'FRA="Date comptable"';
        Amount_including_VATCaptionLbl: Label 'Amount including VAT', Comment = 'FRA="Montant TTC"';
        Centralizer_accountCaptionLbl: Label 'Centralizer account', Comment = 'FRA="Centralisateur"';
        Date__CaptionLbl: Label 'Date :', Comment = 'FRA="Date :"';
        DescriptionCaptionLbl: Label 'Description', Comment = 'FRA="Libellé de l''écriture"';
        External_Document_No_CaptionLbl: Label 'External Document No.', Comment = 'FRA="Référence lettrage"';
        Journal__CodeCaptionLbl: Label 'Journal  Code', Comment = 'FRA="Code journal"';
        Piece_NumberCaptionLbl: Label 'Piece Number', Comment = 'FRA="Numéro pièce"';
        Reminder_of_the_selectionCaptionLbl: Label 'Reminder of the selection', Comment = 'FRA="Rappel de la sélection"';
        Text000: Label 'Not Due', Comment = 'FRA="Non échu"';
        Text001: Label 'Before', Comment = 'FRA="Avant"';
        Text002: Label 'days', Comment = 'FRA="jours"';
        Text003: Label 'More than', Comment = 'FRA="Plus de"';
        Text010: Label 'The Date Formula %1 cannot be used. Try to restate it. E.g. 1M+CM instead of CM+1M.', Comment = 'FRA="La formule date %1 ne peut pas être utilisée. Veuillez la redéfinir en utilisant, par exemple, 1M+CM au lieu de CM+1M."';
        Text014: Label 'at', Comment = 'FRA="à"';
        Text015: Label 'VAT synthesis customers', Comment = 'FRA="Synthèse de TVA clients"';
        Text016: Label 'Filter VAT account must not be empty', Comment = 'FRA="Filtre compte TVA ne doit pas être vide"';
        Text017: Label 'Filter VAT account', Comment = 'FRA="Filtre compte TVA"';
        Text018: Label 'Does not include amounts declared VAT entries', Comment = 'FRA="N''inclut pas les montants des écritures de TVA déclarée"';
        Text019: Label 'N''inclut pas les montants des écritures de TVA lettrée', Comment = 'FRA="N''inclut pas les montants des écritures de TVA lettrée"';
        Text020: Label 'N''inclut les écritures dont le montant TVA est à zéro', Comment = 'FRA="N''inclut les écritures dont le montant TVA est à zéro"';
        TOTALCaptionLbl: Label 'TOTAL', Comment = 'FRA="TOTAL"';
        User__CaptionLbl: Label 'User :', Comment = 'FRA="Utilisateur :"';
        VAT_____Am__Inc__VAT__VAT_CaptionLbl: Label 'VAT / ((Am. Inc. VAT)-VAT)', Comment = 'FRA="TVA / (TTC-TVA)"';
        VAT_AmountCaptionLbl: Label 'VAT Amount', Comment = 'FRA="Montant TVA"';
        VAT_Bus__Posting_GroupCaptionLbl: Label 'VAT Bus. Posting Group', Comment = 'FRA="Groupe Compta. Marché TVA"';
        VAT_Prod__Posting_GroupCaptionLbl: Label 'VAT Prod. Posting Group', Comment = 'FRA="Groupe Compta. Produit TVA"';
        HeadingType: Option "Date Interval","Number of Days";
        AgingBy: Option "Due Date","Posting Date","Document Date";
        HeaderText: array[5] of Text[30];
        Gtext_Compte: Text[50];
        "Gtext_Sélection": Text[200];
        Gtxt_FiltreCompteTVA: Text[200];
        CustomerFilter: Text[250];

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

    local procedure InsertTemp(var CustomerLedgEntry: Record "Cust. Ledger Entry")
    var
        Currency: Record Currency;
    begin
        WITH TempCustomerLedgEntry DO BEGIN
            IF GET(CustomerLedgEntry."Entry No.") THEN
                EXIT;
            TempCustomerLedgEntry := CustomerLedgEntry;
            INSERT();
            IF PrintAmountInLCY THEN BEGIN
                CLEAR(TempCurrency);
                TempCurrency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
                IF TempCurrency.INSERT() THEN;
                EXIT;
            END;
            IF TempCurrency.GET("Currency Code") THEN
                EXIT;
            IF "Currency Code" <> '' THEN
                Currency.GET("Currency Code")
            ELSE BEGIN
                CLEAR(Currency);
                Currency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
            END;
            TempCurrency := Currency;
            TempCurrency.INSERT();
        END;
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
        WITH TempCurrencyAmount DO BEGIN
            FOR i := 1 TO ARRAYLEN(TotalCustomerLedgEntry) DO BEGIN
                "Currency Code" := CurrencyCode;
                Date := PeriodStartDate[i];
                IF FIND() THEN BEGIN
                    Amount := Amount + TotalCustomerLedgEntry[i]."Remaining Amount";
                    MODIFY();
                END ELSE BEGIN
                    "Currency Code" := CurrencyCode;
                    Date := PeriodStartDate[i];
                    Amount := TotalCustomerLedgEntry[i]."Remaining Amount";
                    INSERT();
                END;
            END;
            "Currency Code" := CurrencyCode;
            Date := 99991231D;
            IF FIND() THEN BEGIN
                Amount := Amount + TotalCustomerLedgEntry[1].Amount;
                MODIFY();
            END ELSE BEGIN
                "Currency Code" := CurrencyCode;
                Date := 99991231D;
                Amount := TotalCustomerLedgEntry[1].Amount;
                INSERT();
            END;
        END;
    end;
}

