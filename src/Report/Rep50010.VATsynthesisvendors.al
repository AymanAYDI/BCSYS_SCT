report 50010 "BC6_VAT synthesis vendors"
{
    // CREATION DECEMBRE 2010
    // Génération d'un état permettant de visualiser les montants TVA de tous les documents des comptes fournisseurs
    // 
    // //MODIF JX-XAD 09/03/2011
    // //ajout filtre date
    // 
    // //Modif JX-AUD du 01/08/11
    // //Filtre sur compte 401*
    // 
    // //JX-AUD du 13/05/2013
    // //Agrandissement logo
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/VATsynthesisvendors.rdl';
    Caption = 'VAT synthesis vendors', Comment = 'FRA="Synthèse TVA fournisseurs"';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(DataItem1000000002; Integer)
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            MaxIteration = 1;
            column(Text015; Text015)
            {
            }
            column("USERID"; USERID)
            {
            }
            column(FORMAT_TODAY_; FORMAT(TODAY))
            {
            }
            column(STRSUBSTNO_Text001_FORMAT_CurrReport_PAGENO__; STRSUBSTNO(Text001, FORMAT(CurrReport.PAGENO())))
            {
            }
            column(Text014_____FORMAT_TIME_; Text014 + ' ' + FORMAT(TIME))
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
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
            column(Centralizer_accountCaption; Centralizer_accountCaptionLbl)
            {
            }
            column(Account_NumberCaption; Account_NumberCaptionLbl)
            {
            }
            column(Account_DescriptionCaption; Account_DescriptionCaptionLbl)
            {
            }
            column(Journal__CodeCaption; Journal__CodeCaptionLbl)
            {
            }
            column(Piece_NumberCaption; Piece_NumberCaptionLbl)
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
            column(TOTALCaption; TOTALCaptionLbl)
            {
            }
        }
        dataitem(Vendor; Vendor)
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
            dataitem(OpenVendorLedgEntry; 25)
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
                PrintOnlyIfDetail = false;
                dataitem(TempVendorLedgEntryLoop; Integer)
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                    column(Gbool_TotalParFournisseur; Gbool_TotalParFournisseur)
                    {
                    }
                    column(VendorLedgEntryEndingDate_Amount; VendorLedgEntryEndingDate.Amount)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(VendorLedgEntryEndingDate__Document_No__; VendorLedgEntryEndingDate."Document No.")
                    {
                    }
                    column(VendorLedgEntryEndingDate__Posting_Date_; VendorLedgEntryEndingDate."Posting Date")
                    {
                    }
                    column(Vendor_Name; Vendor.Name)
                    {
                    }
                    column(Vendor__No__; Vendor."No.")
                    {
                    }
                    column(VendorLedgEntryEndingDate__Source_Code_; VendorLedgEntryEndingDate."Source Code")
                    {
                    }
                    column(VendorLedgEntryEndingDate__External_Document_No__; VendorLedgEntryEndingDate."External Document No.")
                    {
                    }
                    column(VendorLedgEntryEndingDate_Description; VendorLedgEntryEndingDate.Description)
                    {
                    }
                    column(GCode_CompteCentralisateur; GCode_CompteCentralisateur)
                    {
                    }
                    column(Gdec_MontantTVA; Gdec_MontantTVA)
                    {
                    }
                    column(ROUND_ABS_Gdec_MontantTVA___ABS_VendorLedgEntryEndingDate_Amount__ABS_Gdec_MontantTVA___100_0_1_; ROUND(ABS(Gdec_MontantTVA) / (ABS(VendorLedgEntryEndingDate.Amount) - ABS(Gdec_MontantTVA)) * 100, 0.1))
                    {
                    }
                    column(Gcode_GrComptaMarcheTVA; Gcode_GrComptaMarcheTVA)
                    {
                    }
                    column(Gcode_GrComptaProduitTVA; Gcode_GrComptaProduitTVA)
                    {
                    }
                    column(Vendor__No___Control1000000071; Vendor."No.")
                    {
                    }
                    column(VendorLedgEntryEndingDate_Amount_Control1000000066; VendorLedgEntryEndingDate.Amount)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(Gdec_MontantTVA_Control1000000110; Gdec_MontantTVA)
                    {
                    }
                    column(Vendor_Name_Control1000000111; Vendor.Name)
                    {
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
                        //Modif JX-AUD du 01/08/11
                        //N° Compte
                        IF Grec_GL_Entry.GET(VendorLedgEntryEndingDate."Entry No.") THEN
                            Gtext_Compte := Grec_GL_Entry."G/L Account No."
                        ELSE
                            Gtext_Compte := '';

                        //skip si pas 401*
                        //IF Gopt_ComptesFourn = Gopt_ComptesFourn::Comptes401 THEN
                        IF COPYSTR(Gtext_Compte, 1, 3) <> '401' THEN CurrReport.SKIP();
                        //Fin modif JX-AUD du 01/08/11

                        DetailedVendorLedgerEntry.SETRANGE("Vendor Ledger Entry No.", VendorLedgEntryEndingDate."Entry No.");
                        IF DetailedVendorLedgerEntry.FINDSET() THEN
                            REPEAT
                                IF (DetailedVendorLedgerEntry."Entry Type" =
                                    DetailedVendorLedgerEntry."Entry Type"::"Initial Entry") AND
                                   (VendorLedgEntryEndingDate."Posting Date" > EndingDate) AND
                                   (AgingBy <> AgingBy::"Posting Date")
                                THEN BEGIN
                                    IF VendorLedgEntryEndingDate."Document Date" <= EndingDate THEN
                                        DetailedVendorLedgerEntry."Posting Date" :=
                                          VendorLedgEntryEndingDate."Document Date"
                                    ELSE
                                        IF (VendorLedgEntryEndingDate."Due Date" <= EndingDate) AND
                                           (AgingBy = AgingBy::"Due Date")
                                        THEN
                                            DetailedVendorLedgerEntry."Posting Date" :=
                                              VendorLedgEntryEndingDate."Due Date"
                                END;

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

                        //DEBUT AJOUT JX-XAD 17/11/2010
                        GCode_CompteCentralisateur := '';
                        IF Grec_Vendor.GET(Vendor."No.") THEN
                            IF Grec_VendorPostingGroup.GET(Grec_Vendor."Vendor Posting Group") THEN
                                GCode_CompteCentralisateur := Grec_VendorPostingGroup."Payables Account";

                        Gcode_GrComptaProduitTVA := '';
                        Gcode_GrComptaMarcheTVA := '';
                        Gdec_MontantTVA := 0;

                        Grec_GL_Entry.RESET();
                        Grec_GL_Entry.SETFILTER(Grec_GL_Entry."Document No.", '%1', VendorLedgEntryEndingDate."Document No.");
                        IF Grec_GL_Entry.FindFirst() THEN BEGIN
                            //IF Grec_GL_Register.GET(Grec_GL_Entry."Entry No.") THEN
                            Grec_GL_Register.RESET();
                            Grec_GL_Register.SETFILTER(Grec_GL_Register."From Entry No.", '%1', Grec_GL_Entry."Entry No.");
                            IF Grec_GL_Register.FindFirst() THEN BEGIN
                                IF Grec_VAT_Entry.GET(Grec_GL_Register."From VAT Entry No.") THEN BEGIN
                                    Gcode_GrComptaProduitTVA := Grec_VAT_Entry."VAT Prod. Posting Group";
                                    Gcode_GrComptaMarcheTVA := Grec_VAT_Entry."VAT Bus. Posting Group";
                                    IF Gbool_NePasInclureTVAdéclarée THEN BEGIN
                                        IF Grec_VAT_Entry."Closed by Entry No." = 0 THEN BEGIN
                                            Grec_GL_Entry.SETFILTER(Grec_GL_Entry."G/L Account No.", Gtxt_FiltreCompteTVA);
                                            IF Gbool_NePasInclureTVAlettrée THEN
                                                Grec_GL_Entry.SETFILTER(Grec_GL_Entry.Letter, '=%1', '');
                                            IF Grec_GL_Entry.FindSet() THEN
                                                REPEAT
                                                    Gdec_MontantTVA += Grec_GL_Entry.Amount;
                                                UNTIL Grec_GL_Entry.NEXT() = 0;
                                            IF Gbool_NePasInclureTVAzéro AND (Gdec_MontantTVA = 0) THEN
                                                CurrReport.SKIP();
                                            Gdec_MontantTotalTVA += Gdec_MontantTVA;
                                        END ELSE BEGIN
                                            IF Gbool_NePasInclureTVAzéro AND (Gdec_MontantTVA = 0) THEN
                                                CurrReport.SKIP();
                                        END;
                                    END ELSE BEGIN
                                        Grec_GL_Entry.SETFILTER(Grec_GL_Entry."G/L Account No.", Gtxt_FiltreCompteTVA);
                                        IF Gbool_NePasInclureTVAlettrée THEN
                                            Grec_GL_Entry.SETFILTER(Grec_GL_Entry.Letter, '=%1', '');
                                        IF Grec_GL_Entry.FindSet() THEN
                                            REPEAT
                                                Gdec_MontantTVA += Grec_GL_Entry.Amount;
                                            UNTIL Grec_GL_Entry.NEXT() = 0;
                                        IF Gbool_NePasInclureTVAzéro AND (Gdec_MontantTVA = 0) THEN
                                            CurrReport.SKIP();
                                        Gdec_MontantTotalTVA += Gdec_MontantTVA;
                                    END;
                                END;
                            END ELSE BEGIN
                                IF Gbool_NePasInclureTVAzéro AND (Gdec_MontantTVA = 0) THEN
                                    CurrReport.SKIP();
                            END;
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
                        // CurrReport.CREATETOTALS(VendorLedgEntryEndingDate.Amount);
                        // CurrReport.CREATETOTALS(Gdec_MontantTVA);
                        IF NOT PrintAmountInLCY THEN
                            TempVendorLedgEntry.SETRANGE("Currency Code", TempCurrency.Code);

                        Grec_GL_Register.SETCURRENTKEY(Grec_GL_Register."From Entry No.");
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

    requestpage
    {
        layout
        {
            area(content)
            {
                field("Filtre Date"; EndingDate)
                {
                    ApplicationArea = All;
                    Caption = 'Filtre Date', Comment = 'FRA="Filtre Date"';
                }
                field("Filtre Compte de TVA"; Gtxt_FiltreCompteTVA)
                {
                    ApplicationArea = All;
                    Caption = 'Filtre Compte de TVA', Comment = 'FRA="Filtre Compte de TVA"';
                }
                field("Gbool_NePasInclureTVAdéclarée"; Gbool_NePasInclureTVAdéclarée)
                {
                    Caption = 'Ne pas inclure les montants des écritures de TVA déclarée', Comment = 'FRA="Ne pas inclure les montants des écritures de TVA déclarée"';
                    ApplicationArea = All;
                }
                field("Gbool_NePasInclureTVAlettrée"; Gbool_NePasInclureTVAlettrée)
                {
                    Caption = 'Ne pas inclure les montants des écritures de TVA lettrée', Comment = 'FRA="Ne pas inclure les montants des écritures de TVA lettrée"';
                    ApplicationArea = All;
                }
                field("Gbool_NePasInclureTVAzéro"; Gbool_NePasInclureTVAzéro)
                {
                    Caption = 'Ne pas faire apparaître les lignes où le montant TVA est à zéro', Comment = 'FRA="Ne pas faire apparaître les lignes où le montant TVA est à zéro"';
                    ApplicationArea = All;
                }
                field("Total par fournisseur"; Gbool_TotalParFournisseur)
                {
                    ApplicationArea = All;
                    Caption = 'Total par fournisseur', Comment = 'FRA="Total par fournisseur"';
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
        IF Gbool_NePasInclureTVAdéclarée THEN
            Gtext_Sélection += Text018;
        IF Gbool_NePasInclureTVAlettrée THEN
            Gtext_Sélection += '\' + Text019;
        IF Gbool_NePasInclureTVAzéro THEN
            Gtext_Sélection += '\' + Text020;

        IF Gtxt_FiltreCompteTVA = '' THEN
            ERROR(Text016);

        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(CompanyInfo.Picture);


        VendorFilter := Vendor.GETFILTERS;

        GLSetup.GET();

        CalcDates();
        CreateHeadings();
    end;

    var
        GLSetup: Record "General Ledger Setup";
        TempVendorLedgEntry: Record "Vendor Ledger Entry" temporary;
        VendorLedgEntryEndingDate: Record "Vendor Ledger Entry";
        TotalVendorLedgEntry: array[5] of Record "Vendor Ledger Entry";
        GrandTotalVendorLedgEntry: array[5] of Record "Vendor Ledger Entry";
        AgedVendorLedgEntry: array[6] of Record "Vendor Ledger Entry";
        TempCurrency: Record Currency temporary;
        TempCurrency2: Record Currency temporary;
        TempCurrencyAmount: Record "Currency Amount" temporary;
        DetailedVendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";
        VendorFilter: Text[250];
        PrintAmountInLCY: Boolean;
        EndingDate: Date;
        AgingBy: Option "Due Date","Posting Date","Document Date";
        PeriodLength: DateFormula;
        PrintDetails: Boolean;
        HeadingType: Option "Date Interval","Number of Days";
        NewPagePerVendor: Boolean;
        PeriodStartDate: array[5] of Date;
        PeriodEndDate: array[5] of Date;
        HeaderText: array[5] of Text[30];
        Text000: Label 'Not Due', Comment = 'FRA="Non échu"';
        Text001: Label 'Before', Comment = 'FRA="Avant"';
        CurrencyCode: Code[10];
        Text002: Label 'days', Comment = 'FRA="jours"';
        Text003: Label 'More than', Comment = 'FRA="Plus de"';
        Text004: Label 'Aged by %1', Comment = 'FRA="Agée par %1"';
        Text005: Label 'Total for %1', Comment = 'FRA="Total de %1"';
        Text006: Label 'Aged as of %1', Comment = 'FRA="Agée en date du %1"';
        Text007: Label 'Aged by %1', Comment = 'FRA="Agée par %1"';
        Text008: Label 'All Amounts in LCY', Comment = 'FRA="Tous les montants DS"';
        NumberOfCurrencies: Integer;
        Text009: Label 'Due Date,Posting Date,Document Date', Comment = 'FRA="Date d''échéance,Date comptabilisation,Date document"';
        Text010: Label 'The Date Formula %1 cannot be used. Try to restate it. E.g. 1M+CM instead of CM+1M.', Comment = 'FRA="La formule date %1 ne peut pas être utilisée. Veuillez la redéfinir en utilisant, par exemple, 1M+CM au lieu de CM+1M."';
        Gdec_MontantTotal: Decimal;
        Gdec_SoldeTotal: Decimal;
        CompanyInfo: Record "Company Information";
        Text011: Label 'Page %1', Comment = 'FRA="Page %1"';
        Text012: Label 'Account :', Comment = 'FRA="Compte :"';
        Text013: Label 'Vendor :', Comment = 'FRA="Fournisseur :"';
        Text014: Label 'at', Comment = 'FRA="à"';
        Text015: Label 'VAT synthesis vendors', Comment = 'FRA="Synthèse de TVA fournisseurs"';
        Grec_Vendor: Record Vendor;
        Grec_VendorPostingGroup: Record "Vendor Posting Group";
        GCode_CompteCentralisateur: Code[20];
        Gtxt_FiltreCompteTVA: Text[200];
        Text016: Label 'Filter VAT account must not be empty', Comment = 'FRA="Filtre compte TVA ne doit pas être vide"';
        Text017: Label 'Filter VAT account', Comment = 'FRA="Filtre compte TVA"';
        Grec_VAT_Entry: Record "VAT Entry";
        Grec_GL_Entry: Record "G/L Entry";
        Grec_GL_Register: Record "G/L Register";
        Gdec_MontantTVA: Decimal;
        Gdec_MontantTotalTVA: Decimal;
        Gcode_GrComptaProduitTVA: Code[20];
        Gcode_GrComptaMarcheTVA: Code[20];
        "Gbool_NePasInclureTVAdéclarée": Boolean;
        "Gbool_NePasInclureTVAlettrée": Boolean;
        "Gbool_NePasInclureTVAzéro": Boolean;
        Gbool_TotalParFournisseur: Boolean;
        Text018: Label 'Does not include amounts declared VAT entries', Comment = 'FRA="N''inclut pas les montants des écritures de TVA déclarée"';
        "Gtext_Sélection": Text[200];
        Text019: Label 'N''inclut pas les montants des écritures de TVA lettrée', Comment = 'FRA="N''inclut pas les montants des écritures de TVA lettrée"';
        Text020: Label 'N''inclut les écritures dont le montant TVA est à zéro', Comment = 'FRA="N''inclut les écritures dont le montant TVA est à zéro"';
        Gtext_Compte: Text[50];
        Reminder_of_the_selectionCaptionLbl: Label 'Reminder of the selection', Comment = 'FRA="Rappel de la sélection"';
        User__CaptionLbl: Label 'User :', Comment = 'FRA="Utilisateur :"';
        Date__CaptionLbl: Label 'Date :', Comment = 'FRA="Date :"';
        Centralizer_accountCaptionLbl: Label 'Centralizer account', Comment = 'FRA="Centralisateur"';
        Account_NumberCaptionLbl: Label 'Account Number', Comment = 'FRA="Numéro Compte"';
        Account_DescriptionCaptionLbl: Label 'Account Description', Comment = 'FRA="Libellé du compte"';
        Journal__CodeCaptionLbl: Label 'Journal  Code', Comment = 'FRA="Code journal"';
        Piece_NumberCaptionLbl: Label 'Piece Number', Comment = 'FRA="Numéro pièce"';
        External_Document_No_CaptionLbl: Label 'External Document No.', Comment = 'FRA="Référence lettrage"';
        Accounting_DateCaptionLbl: Label 'Accounting Date', Comment = 'FRA="Date comptable"';
        VAT_Bus__Posting_GroupCaptionLbl: Label 'VAT Bus. Posting Group', Comment = 'FRA="Groupe Compta. Marché TVA"';
        VAT_Prod__Posting_GroupCaptionLbl: Label 'VAT Prod. Posting Group', Comment = 'FRA="Groupe Compta. Produit TVA"';
        DescriptionCaptionLbl: Label 'Description', Comment = 'FRA="Libellé de l''écriture"';
        VAT_AmountCaptionLbl: Label 'VAT Amount', Comment = 'FRA="Montant TVA"';
        Amount_including_VATCaptionLbl: Label 'Amount including VAT', Comment = 'FRA="Montant TTC"';
        VAT_____Am__Inc__VAT__VAT_CaptionLbl: Label 'VAT / ((Am. Inc. VAT)-VAT)', Comment = 'FRA="TVA / (TTC-TVA)"';
        TOTALCaptionLbl: Label 'TOTAL', Comment = 'FRA="TOTAL"';

    local procedure CalcDates()
    var
        i: Integer;
        PeriodLength2: DateFormula;
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

