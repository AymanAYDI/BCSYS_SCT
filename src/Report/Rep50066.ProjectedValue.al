report 50066 "BC6_Projected Value"
{
    // //Création JX-AUD du 17/08/2011
    // //Création à partir de l'état standard
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/ProjectedValue.rdl';
    Caption = 'Projected Value VSC', Comment = 'FRA="Valeur projetée VSC"';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(DataItem5444; Integer)
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            column("USERID"; USERID)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO())
            {
            }
            column(Text025; Gtext_Filtre)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(MainHeadLineText; MainHeadLineText)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(HeadLineText_5_; Text024)
            {
            }
            column(HeadingAmount3; Text023)
            {
            }
            column(Amts12; Text038)
            {
            }
            column(Amts11; Text037)
            {
            }
            column(Amts10; Text036)
            {
            }
            column(Amts09; Text035)
            {
            }
            column(Amts08; Text034)
            {
            }
            column(Amts07; Text033)
            {
            }
            column(Amts06; Text032)
            {
            }
            column(Amts05; Text031)
            {
            }
            column(Amts04; Text030)
            {
            }
            column(Amts03; Text029)
            {
            }
            column(Amts02; Text028)
            {
            }
            column(Amts01; Text027)
            {
            }
            column(HeadLineText_3_; Text022)
            {
            }
            column(Axe4b; Text019)
            {
            }
            column(Axe3b; Text018)
            {
            }
            column(Axe2b; Text017)
            {
            }
            column(Axe1b; Text016)
            {
            }
            column(ValeurBrute1; Text015)
            {
            }
            column(FADescription1; Text021)
            {
            }
            column(CodeFournisseur1; Text014)
            {
            }
            column(CompteDotation1; Text013)
            {
            }
            column(CompteImmo1; Text012)
            {
            }
            column(FANo1; Text020)
            {
            }
            column(HeadLineText_1_; 'Date acquisition')
            {
            }
            column(Gdec_Montant3; Gdec_Montant3)
            {
                AutoFormatType = 1;
            }
            column(Gdec_Montant2; Gdec_Montant2)
            {
                AutoFormatType = 1;
            }
            column(Total; 'Total')
            {
            }
            column(Gdec_Montant1; Gdec_Montant1)
            {
                AutoFormatType = 1;
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Integer_Number; Number)
            {
            }
            dataitem("Depreciation Book"; "Depreciation Book")
            {
                DataItemTableView = SORTING(Code);
                RequestFilterFields = "Code";
                column(Depreciation_Book_Code; Code)
                {
                }
                dataitem("Fixed Asset"; "Fixed Asset")
                {
                    DataItemTableView = SORTING("No.");
                    RequestFilterFields = "No.", "FA Class Code", "FA Subclass Code", "Budgeted Asset";
                    column(Fixed_Asset_No_; "No.")
                    {
                    }
                    column(Fixed_Asset_FA_Class_Code; "FA Class Code")
                    {
                    }
                    column(Fixed_Asset_FA_Subclass_Code; "FA Subclass Code")
                    {
                    }
                    column(Fixed_Asset_Global_Dimension_1_Code; "Global Dimension 1 Code")
                    {
                    }
                    column(Fixed_Asset_Global_Dimension_2_Code; "Global Dimension 2 Code")
                    {
                    }
                    column(Fixed_Asset_FA_Location_Code; "FA Location Code")
                    {
                    }
                    column(Fixed_Asset_Component_of_Main_Asset; "Component of Main Asset")
                    {
                    }
                    column(Fixed_Asset_FA_Posting_Group; "FA Posting Group")
                    {
                    }
                    dataitem(DataItem9888; "FA Ledger Entry")
                    {
                        DataItemTableView = SORTING("FA No.", "Depreciation Book Code", "FA Posting Date");

                        trigger OnAfterGetRecord()
                        begin
                            IF "Part of Book Value" THEN
                                BookValue := BookValue + Amount;
                            IF "FA Posting Date" < IncludePostedFrom THEN
                                CurrReport.SKIP();
                            EntryPrinted := TRUE;
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE("FA No.", "Fixed Asset"."No.");
                            SETRANGE("Depreciation Book Code", DeprBookCode);
                            BookValue := 0;
                            IF (IncludePostedFrom = 0D) OR NOT PrintDetails THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(ProjectedDepreciation; Integer)
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 .. 1000000));
                        column(Axe4; Gcode_Axe[4])
                        {
                        }
                        column(Axe3; Gcode_Axe[3])
                        {
                        }
                        column(Axe2; Gcode_Axe[2])
                        {
                        }
                        column(Axe1; Gcode_Axe[1])
                        {
                        }
                        column(ValeurBrute; Gdec_ValeurBrute)
                        {
                        }
                        column(Fixed_Asset_Description1; "Fixed Asset".Description)
                        {
                        }
                        column(CodeFournisseur; Gcode_CodeFournisseur)
                        {
                        }
                        column(Date_1_; FORMAT(Date[1]))
                        {
                        }
                        column(Fixed_Asset__No__1; "Fixed Asset"."No.")
                        {
                        }
                        column(CompteDotation; Gcode_CompteDotation)
                        {
                        }
                        column(CompteImmo; Gcode_CompteImmo)
                        {
                        }
                        column(Amounts_2_; Gdec_AmountBefore)
                        {
                            AutoFormatType = 1;
                        }
                        column(Gdec_Cumul; Gdec_Cumul)
                        {
                            AutoFormatType = 1;
                        }
                        column(Amts12b; Gdec_MontantAmtMois[12])
                        {
                        }
                        column(Amts11b; Gdec_MontantAmtMois[11])
                        {
                        }
                        column(Amts10b; Gdec_MontantAmtMois[10])
                        {
                        }
                        column(Amts09b; Gdec_MontantAmtMois[9])
                        {
                        }
                        column(Amts08b; Gdec_MontantAmtMois[8])
                        {
                        }
                        column(Amts07b; Gdec_MontantAmtMois[7])
                        {
                        }
                        column(Amts06b; Gdec_MontantAmtMois[6])
                        {
                        }
                        column(Amts05b; Gdec_MontantAmtMois[5])
                        {
                        }
                        column(Amts04b; Gdec_MontantAmtMois[4])
                        {
                        }
                        column(Amts03b; Gdec_MontantAmtMois[3])
                        {
                        }
                        column(Amts02b; Gdec_MontantAmtMois[2])
                        {
                        }
                        column(Amts01b; Gdec_MontantAmtMois[1])
                        {
                        }
                        column(Gdec_MontantPeriode; Gdec_MontantPeriode)
                        {
                            AutoFormatType = 1;
                        }
                        column(ProjectedDepreciation_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF UntilDate >= EndingDate THEN
                                CurrReport.BREAK()
                            ELSE BEGIN
                                IF Number = 1 THEN BEGIN
                                    CalculateFirstDeprAmount(Done);
                                    DateFromProjection := DepreciationCalc.Yesterday(DateFromProjection, Year365Days);
                                    IF FADeprBook."Book Value" <> 0 THEN
                                        Done := Done OR NOT EntryPrinted;
                                END ELSE
                                    CalculateSecondDeprAmount(Done);
                                IF Done THEN
                                    UpdateTotals()
                                ELSE
                                    CurrReport.BREAK();
                            END;

                            IF Done THEN BEGIN
                                IF DoProjectedDisposal THEN
                                    CalculateGainLoss();

                                IF HasDerogatorySetup THEN BEGIN
                                    DerogBookValue := DerogBookValue + DeprAmount;
                                    DerogBookValueTemp := DerogBookValue;
                                END;

                                IF HasDerogatorySetup THEN BEGIN
                                    DerogBookValue := DerogBookValue + DerogAmount;
                                    DerogEntryAmounts[1] := DerogBookValue;
                                END;
                            END;

                            //Modif JX-AUD du 02/08/11
                            //récupération de la date pour extraire le mois et mettre le montant dans la variable appropriée Gdec_MontantAmtMois
                            IF ((UntilDate > DateDernierAmort) AND (Gint_annee <> DATE2DMY(UntilDate, 3))) THEN BEGIN
                                Gdec_AmountBefore += DeprAmount;
                            END;

                            IF (Gint_annee <> DATE2DMY(UntilDate, 3)) THEN BEGIN
                                CurrReport.SKIP();
                            END;

                            Gint_NbMois := DATE2DMY(UntilDate, 2);
                            CASE Gint_NbMois OF
                                1:
                                    BEGIN
                                        Gdec_MontantAmtMois[1] += DeprAmount;
                                    END;
                                2:
                                    BEGIN
                                        Gdec_MontantAmtMois[2] += DeprAmount;
                                    END;
                                3:
                                    BEGIN
                                        Gdec_MontantAmtMois[3] += DeprAmount;
                                    END;
                                4:
                                    BEGIN
                                        Gdec_MontantAmtMois[4] += DeprAmount;
                                    END;
                                5:
                                    BEGIN
                                        Gdec_MontantAmtMois[5] += DeprAmount;
                                    END;
                                6:
                                    BEGIN
                                        Gdec_MontantAmtMois[6] += DeprAmount;
                                    END;
                                7:
                                    BEGIN
                                        Gdec_MontantAmtMois[7] += DeprAmount;
                                    END;
                                8:
                                    BEGIN
                                        Gdec_MontantAmtMois[8] += DeprAmount;
                                    END;
                                9:
                                    BEGIN
                                        Gdec_MontantAmtMois[9] += DeprAmount;
                                    END;
                                10:
                                    BEGIN
                                        Gdec_MontantAmtMois[10] += DeprAmount;
                                    END;
                                11:
                                    BEGIN
                                        Gdec_MontantAmtMois[11] += DeprAmount;
                                    END;
                                12:
                                    BEGIN
                                        Gdec_MontantAmtMois[12] += DeprAmount;
                                    END;
                            END;
                            //Fin modif JX-AUD du 02/08/11
                            //modif JX-AUD du 02/05/2012
                            Gdec_MontantPeriode := Gdec_MontantAmtMois[1] + Gdec_MontantAmtMois[2] + Gdec_MontantAmtMois[3] + Gdec_MontantAmtMois[4];
                            Gdec_MontantPeriode += Gdec_MontantAmtMois[5] + Gdec_MontantAmtMois[6] + Gdec_MontantAmtMois[7] + Gdec_MontantAmtMois[8];
                            Gdec_MontantPeriode += Gdec_MontantAmtMois[9] + Gdec_MontantAmtMois[10] + Gdec_MontantAmtMois[11] + Gdec_MontantAmtMois[12];
                            Gdec_Cumul := Gdec_AmountBefore + Gdec_MontantPeriode;
                            //fin modif JX-AUD du 02/05/2012
                        end;

                        trigger OnPreDataItem()
                        begin
                            //modif JX-AUD du 02/05/2012
                            InitMonth();
                            //fin modif JX-AUD du 02/05/2012
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF NOT FADeprBook.GET("No.", DeprBookCode) THEN
                            CurrReport.SKIP();
                        IF SkipRecord() THEN
                            CurrReport.SKIP();

                        HasDerogatorySetup := FALSE;
                        FADeprBook2.SETRANGE("FA No.", "No.");
                        FADeprBook2.SETRANGE("Depreciation Book Code", DerogDeprBook.Code);
                        IF FADeprBook2.FIND('-') THEN BEGIN
                            HasDerogatorySetup := TRUE;
                            DerogAssetsIncluded := TRUE;
                            DeprText2 := DeprText;
                        END;
                        IF GroupTotals = GroupTotals::"FA Posting Group" THEN
                            IF "FA Posting Group" <> FADeprBook."FA Posting Group" THEN
                                ERROR(Text004, FIELDCAPTION("FA Posting Group"), "No.");

                        StartingDate := StartingDate2;
                        EndingDate := EndingDate2;
                        DoProjectedDisposal := FALSE;
                        EntryPrinted := FALSE;
                        IF ProjectedDisposal AND
                           (FADeprBook."Projected Disposal Date" > 0D) AND
                           (FADeprBook."Projected Disposal Date" <= EndingDate)
                        THEN BEGIN
                            EndingDate := FADeprBook."Projected Disposal Date";
                            IF StartingDate > EndingDate THEN
                                StartingDate := EndingDate;
                            DoProjectedDisposal := TRUE;
                        END;

                        IF ISSERVICETIER THEN
                            TransferValues();

                        //Modif JX-AUD du 02/08/11
                        CheckDateType(DateType1, DateTypeNo1);
                        Date[1] :=
                          FAGenReport.GetLastDate(
                            "No.", DateTypeNo1, EndingDate, DeprBookCode, FALSE);

                        Gcode_CompteImmo := "FA Posting Group";
                        IF Grec_PostingGroup.GET("FA Posting Group") THEN
                            Gcode_CompteDotation := Grec_PostingGroup."Depreciation Expense Acc."
                        ELSE
                            Gcode_CompteDotation := '';

                        //BCSYS 04052020 Add Repeat
                        Gdec_ValeurBrute := 0;

                        Grec_LedgerEntry.RESET();
                        Grec_LedgerEntry.SETFILTER(Grec_LedgerEntry."FA No.", "No.");
                        Grec_LedgerEntry.SETFILTER(Grec_LedgerEntry."FA Posting Type", FORMAT(Grec_LedgerEntry."FA Posting Type"::"Acquisition Cost"));

                        IF Grec_LedgerEntry.FIND('-') THEN BEGIN
                            //BCSYS 04052020 Add Repeat
                            REPEAT
                                Gdec_ValeurBrute += Grec_LedgerEntry.Amount;
                            UNTIL Grec_LedgerEntry.NEXT() = 0;
                        END;

                        //traitement code fournisseur
                        Grec_LedgerEntry.SETFILTER(Grec_LedgerEntry."Document Type", FORMAT(Grec_LedgerEntry."Document Type"::Invoice));

                        IF Grec_LedgerEntry.FIND('-') THEN
                            IF Grec_PurchInvHeader.GET(Grec_LedgerEntry."Document No.") THEN
                                Gcode_CodeFournisseur := Grec_PurchInvHeader."Buy-from Vendor No."
                            ELSE
                                Gcode_CodeFournisseur := '';

                        //Calcul Gdec_AmountBefore
                        Gdec_AmountBefore := 0;
                        Grec_LedgerEntry.RESET();
                        Grec_LedgerEntry.SETFILTER(Grec_LedgerEntry."FA No.", "No.");
                        Grec_LedgerEntry.SETFILTER(Grec_LedgerEntry."FA Posting Type", FORMAT(Grec_LedgerEntry."FA Posting Type"::Depreciation));
                        //Grec_LedgerEntry.SETFILTER(Grec_LedgerEntry."FA Posting Date",'<=%1',TODAY);
                        //Grec_LedgerEntry.SETFILTER(Grec_LedgerEntry."FA Posting Date",'>=%1&<=%2',StartingDate,TODAY);
                        IF Grec_LedgerEntry.FIND('-') THEN
                            REPEAT
                                Gdec_AmountBefore += Grec_LedgerEntry.Amount;
                                DateDernierAmort := Grec_LedgerEntry."FA Posting Date";//modif JX-AUD du 03/05/2012
                            UNTIL Grec_LedgerEntry.NEXT() = 0;
                        //TotalAmounts[6] := TotalAmounts[6] + Gdec_AmountBefore;

                        //Axes analytiques
                        IF Grec_DefaultDimension.GET(5600, "Fixed Asset"."No.", Gcode_AxeDimension[1]) THEN
                            Gcode_Axe[1] := Grec_DefaultDimension."Dimension Value Code"
                        ELSE
                            Gcode_Axe[1] := '';
                        IF Grec_DefaultDimension.GET(5600, "Fixed Asset"."No.", Gcode_AxeDimension[2]) THEN
                            Gcode_Axe[2] := Grec_DefaultDimension."Dimension Value Code"
                        ELSE
                            Gcode_Axe[2] := '';
                        IF Grec_DefaultDimension.GET(5600, "Fixed Asset"."No.", Gcode_AxeDimension[3]) THEN
                            Gcode_Axe[3] := Grec_DefaultDimension."Dimension Value Code"
                        ELSE
                            Gcode_Axe[3] := '';
                        IF Grec_DefaultDimension.GET(5600, "Fixed Asset"."No.", Gcode_AxeDimension[4]) THEN
                            Gcode_Axe[4] := Grec_DefaultDimension."Dimension Value Code"
                        ELSE
                            Gcode_Axe[4] := '';
                        //Fin Modif JX-AUD du 02/08/11
                    end;

                    trigger OnPreDataItem()
                    begin
                        //Modif JX-AUD du 02/08/11
                        DeprBookCode := "Depreciation Book".Code;
                        DeprBookText := STRSUBSTNO('%1%2 %3', DeprBook.TABLECAPTION, ':', DeprBookCode);
                        //Fin modif JX-AUD du 02/08/11

                        CASE GroupTotals OF
                            GroupTotals::"FA Class":
                                SETCURRENTKEY("FA Class Code");
                            GroupTotals::"FA Subclass":
                                SETCURRENTKEY("FA Subclass Code");
                            GroupTotals::"FA Location":
                                SETCURRENTKEY("FA Location Code");
                            GroupTotals::"Main Asset":
                                SETCURRENTKEY("Component of Main Asset");
                            GroupTotals::"Global Dimension 1":
                                SETCURRENTKEY("Global Dimension 1 Code");
                            GroupTotals::"Global Dimension 2":
                                SETCURRENTKEY("Global Dimension 2 Code");
                            GroupTotals::"FA Posting Group":
                                SETCURRENTKEY("FA Posting Group");
                        END;

                        IF ISSERVICETIER THEN BEGIN
                            GroupTotalsInt := GroupTotals;
                            MakeGroupHeadLine();
                            InitGroupTotals();
                        END;

                        //Modif JX-AUD du 02/08/11
                        DateType1 := 'Date acquisition';
                        InitMonth();
                        Gdec_MontantPeriode := 0;
                        HeadLineText[1] := DateType1;
                        TotalAmounts[6] := 0;
                        AssetAmounts[5] := 0;
                        TotalAmounts[5] := 0;
                        //Fin modif JX-AUD du 02/08/11
                    end;
                }
                dataitem(ProjectionTotal; Integer)
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                }
                dataitem(Buffer; Integer)
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));

                    trigger OnAfterGetRecord()
                    begin
                        IF Number = 1 THEN BEGIN
                            IF NOT FABufferProjection.FIND('-') THEN
                                CurrReport.BREAK();
                        END ELSE
                            IF FABufferProjection.NEXT() = 0 THEN
                                CurrReport.BREAK();
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF NOT PrintAmountsPerDate THEN
                            CurrReport.BREAK();
                        FABufferProjection.RESET();
                    end;
                }
            }

            trigger OnPreDataItem()
            begin
                Gdec_Montant1 := 0;
                Gdec_Montant2 := 0;
                Gdec_Montant3 := 0;
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
                    field(DeprBookCode; DeprBookCode)
                    {
                        Caption = 'Depreciation Book', Comment = 'FRA="Lois d''amortissement"';
                        TableRelation = "Depreciation Book";
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            UpdateReqForm();
                        end;
                    }
                    field(StartingDate; StartingDate)
                    {
                        Caption = 'First Depreciation Date', Comment = 'FRA="Date premier amortissement"';
                        ApplicationArea = All;
                    }
                    field(EndingDate; EndingDate)
                    {
                        Caption = 'Last Depreciation Date', Comment = 'FRA="Date dernier amortissement"';
                        ApplicationArea = All;
                    }
                    field(NumberOfDaysCtrl; PeriodLength)
                    {
                        BlankZero = true;
                        Caption = 'Number of Days', Comment = 'FRA="Nombre de jours"';
                        Editable = NumberOfDaysCtrlEditable;
                        MinValue = 0;
                        Visible = false;
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            IF PeriodLength > 0 THEN
                                UseAccountingPeriod := FALSE;
                        end;
                    }
                    field(DaysInFirstPeriod; DaysInFirstPeriod)
                    {
                        BlankZero = true;
                        Caption = 'No. of Days in First Period', Comment = 'FRA="Nombre de jours dans première période"';
                        MinValue = 0;
                        Visible = false;
                        ApplicationArea = All;
                    }
                    field(IncludePostedFrom; IncludePostedFrom)
                    {
                        Caption = 'Posted Entries From', Comment = 'FRA="Écritures enregistrées à partir du"';
                        Visible = false;
                        ApplicationArea = All;
                    }
                    field(GroupTotals; GroupTotals)
                    {
                        Caption = 'Group Totals', Comment = 'FRA="Sous-totaux"';
                        OptionCaption = ' ,FA Class,FA Subclass,FA Location,Main Asset,Global Dimension 1,Global Dimension 2,FA Posting Group', Comment = 'FRA=" ,Classe immo.,Sous-classe immo.,Emplacement immo.,Immo. principale,Axe principal 1,Axe principal 2,Groupe compta. immo."';
                        Visible = false;
                        ApplicationArea = All;
                    }
                    field(BudgetNameCode; BudgetNameCode)
                    {
                        Caption = 'Copy to G/L Budget Name', Comment = 'FRA="Copier vers nom budget"';
                        TableRelation = "G/L Budget Name";
                        Visible = false;
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            IF BudgetNameCode = '' THEN
                                BalAccount := FALSE;
                        end;
                    }
                    field(BalAccount; BalAccount)
                    {
                        Caption = 'Insert Bal. Account', Comment = 'FRA="Insérer compte contrepartie"';
                        Visible = false;
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            IF BalAccount THEN
                                IF BudgetNameCode = '' THEN
                                    ERROR(Text006, GLBudgetName.TABLECAPTION);
                        end;
                    }
                    field(PrintDetails; PrintDetails)
                    {
                        Caption = 'Print per Fixed Asset', Comment = 'FRA="Imprimer par immobilisation"';
                        Visible = false;
                        ApplicationArea = All;
                    }
                    field(ProjectedDisposal; ProjectedDisposal)
                    {
                        Caption = 'Projected Disposal', Comment = 'FRA="Cession prévue"';
                        Visible = false;
                        ApplicationArea = All;
                    }
                    field(PrintAmountsPerDate; PrintAmountsPerDate)
                    {
                        Caption = 'Print Amounts per Date', Comment = 'FRA="Imprimer montants par date"';
                        Visible = false;
                        ApplicationArea = All;
                    }
                    field(UseAccountingPeriod; UseAccountingPeriod)
                    {
                        Caption = 'Use Accounting Period', Comment = 'FRA="Utiliser période comptable"';
                        Visible = false;
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            IF UseAccountingPeriod THEN
                                PeriodLength := 0;

                            UpdateReqForm();
                        end;
                    }
                }
            }
        }
        trigger OnInit()
        begin
            NumberOfDaysCtrlEditable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            IF DeprBookCode = '' THEN BEGIN
                FASetup.GET();
                DeprBookCode := FASetup."Default Depr. Book";
            END;
            UpdateReqForm();
        end;
    }
    trigger OnInitReport()
    begin
        //Modif JX-AUD du 02/08/11
        IF Grecord_GeneralLedgerSetup.FIND('-') THEN BEGIN
            Gcode_AxeDimension[1] := Grecord_GeneralLedgerSetup."Shortcut Dimension 3 Code";
            Gcode_AxeDimension[2] := Grecord_GeneralLedgerSetup."Shortcut Dimension 4 Code";
            Gcode_AxeDimension[3] := Grecord_GeneralLedgerSetup."Shortcut Dimension 5 Code";
            Gcode_AxeDimension[4] := Grecord_GeneralLedgerSetup."Shortcut Dimension 6 Code";
        END;
    end;

    trigger OnPreReport()
    begin
        PrintDetails := TRUE;
        Gbool_AfficherEnTete := TRUE;
        MainHeadLineText := Text026;
        UseAccountingPeriod := TRUE;
        //Fin modif JX-AUD du 02/08/11

        //modif JX-AUD du 02/05/2012
        Gdate_anneen := DMY2DATE(1, 1, DATE2DMY(TODAY, 3));
        //MESSAGE(FORMAT(Gdate_anneen));
        //fin modif JX-AUD du 02/05/2012

        //modif JX-AUD du 02/05/2012
        //MESSAGE(FORMAT(Gdate_anneen) + ' ' +FORMAT(StartingDate));
        Gtext_Filtre := STRSUBSTNO(Text025, StartingDate, EndingDate);
        //EVALUATE(Gint_annee,DELSTR(FORMAT(DATE2DMY(StartingDate,3)), 1, 2));
        Gint_annee := DATE2DMY(StartingDate, 3);
        StartingDate := Gdate_anneen;
        //fin modif JX-AUD du 02/05/2012

        DeprBook.GET(DeprBookCode);
        CLEAR(DerogDeprBook);
        DerogDeprBook.SETRANGE("Derogatory Calculation", DeprBookCode);
        IF DerogDeprBook.FIND('-') THEN;
        Year365Days := DeprBook."Fiscal Year 365 Days";
        IF GroupTotals = GroupTotals::"FA Posting Group" THEN
            FAGenReport.SetFAPostingGroup("Fixed Asset", DeprBook.Code);
        FAGenReport.AppendFAPostingFilter("Fixed Asset", StartingDate, EndingDate);
        FAFilter := "Fixed Asset".GETFILTERS;
        DeprBookText := STRSUBSTNO('%1%2 %3', DeprBook.TABLECAPTION, ':', DeprBookCode);
        MakeGroupTotalText();
        ValidateDates();
        IF PrintDetails THEN BEGIN
            FANo := "Fixed Asset".FIELDCAPTION("No.");
            FADescription := "Fixed Asset".FIELDCAPTION(Description);
        END;
        IF DeprBook."No. of Days in Fiscal Year" > 0 THEN
            DaysInFiscalYear := DeprBook."No. of Days in Fiscal Year"
        ELSE
            DaysInFiscalYear := 360;
        IF Year365Days THEN
            DaysInFiscalYear := 365;
        IF PeriodLength = 0 THEN
            PeriodLength := DaysInFiscalYear;
        IF (PeriodLength <= 5) OR (PeriodLength > DaysInFiscalYear) THEN
            ERROR(
              Text000, DaysInFiscalYear);
        FALedgEntry2."FA Posting Type" := FALedgEntry2."FA Posting Type"::Depreciation;
        DeprText := STRSUBSTNO('%1', FALedgEntry2."FA Posting Type");
        FALedgEntry2."FA Posting Type" := FALedgEntry2."FA Posting Type"::Derogatory;
        DerogText := STRSUBSTNO('%1', FALedgEntry2."FA Posting Type");
        IF DeprBook."Use Custom 1 Depreciation" THEN BEGIN
            DeprText2 := DeprText;
            FALedgEntry2."FA Posting Type" := FALedgEntry2."FA Posting Type"::"Custom 1";
            Custom1Text := STRSUBSTNO('%1', FALedgEntry2."FA Posting Type");
            DeprCustom1Text := STRSUBSTNO('%1 %2 %3', DeprText, '+', Custom1Text);
        END;
        SalesPriceFieldname := FADeprBook.FIELDCAPTION("Projected Proceeds on Disposal");
        GainLossFieldname := Text001;
    end;

    var
        Text000: Label 'Number of Days must not be greater than %1 or less than 5.', Comment = 'FRA="Le nombre de jours ne doit pas être supérieur à %1 ou inférieur à 5."';
        Text001: Label 'Projected Gain/Loss', Comment = 'FRA="Gains/Pertes prévu(e)s"';
        Text002: Label 'Group Total', Comment = 'FRA="Sous-total"';
        Text003: Label 'Group Totals', Comment = 'FRA="Sous-totaux"';
        Text004: Label '%1 has been modified in fixed asset %2', Comment = 'FRA="%1 a été modifié(e) dans l''immobilisation %2"';
        GLBudgetName: Record "G/L Budget Name";
        FASetup: Record "FA Setup";
        DeprBook: Record "Depreciation Book";
        FADeprBook: Record "FA Depreciation Book";
        FA: Record "Fixed Asset";
        FALedgEntry2: Record "FA Ledger Entry";
        FABufferProjection: Record "FA Buffer Projection" temporary;
        FAGenReport: Codeunit "FA General Report";
        CalculateDepr: Codeunit "Calculate Depreciation";
        FADateCalc: Codeunit "FA Date Calculation";
        DepreciationCalc: Codeunit "Depreciation Calculation";
        DeprBookCode: Code[10];
        FAFilter: Text[250];
        DeprBookText: Text[50];
        GroupCodeName: Text[50];
        GroupCodeName2: Text[50];
        GroupHeadLine: Text[50];
        DeprText: Text[50];
        DeprText2: Text[50];
        Custom1Text: Text[50];
        DeprCustom1Text: Text[50];
        IncludePostedFrom: Date;
        FANo: Text[50];
        FADescription: Text[50];
        GroupTotals: Option " ","FA Class","FA Subclass","FA Location","Main Asset","Global Dimension 1","Global Dimension 2","FA Posting Group";
        BookValue: Decimal;
        NewFiscalYear: Date;
        EndFiscalYear: Date;
        DaysInFiscalYear: Integer;
        Custom1DeprUntil: Date;
        PeriodLength: Integer;
        UseAccountingPeriod: Boolean;
        StartingDate: Date;
        StartingDate2: Date;
        EndingDate: Date;
        EndingDate2: Date;
        PrintAmountsPerDate: Boolean;
        UntilDate: Date;
        PrintDetails: Boolean;
        EntryAmounts: array[4] of Decimal;
        AssetAmounts: array[5] of Decimal;
        GroupAmounts: array[4] of Decimal;
        TotalAmounts: array[6] of Decimal;
        TotalBookValue: array[2] of Decimal;
        DateFromProjection: Date;
        DeprAmount: Decimal;
        Custom1Amount: Decimal;
        NumberOfDays: Integer;
        Custom1NumberOfDays: Integer;
        DaysInFirstPeriod: Integer;
        Done: Boolean;
        NotFirstGroupTotal: Boolean;
        SalesPriceFieldname: Text[80];
        GainLossFieldname: Text[50];
        ProjectedDisposal: Boolean;
        DoProjectedDisposal: Boolean;
        EntryPrinted: Boolean;
        Text005: Label ' ,FA Class,FA Subclass,FA Location,Main Asset,Global Dimension 1,Global Dimension 2,FA Posting Group', Comment = 'FRA=",Classe immo.,Sous-classe immo.,Emplacement immo.,Immo. principale,Axe principal 1,Axe principal 2,Groupe compta. immo."';
        BudgetNameCode: Code[10];
        OldValue: Code[20];
        NewValue: Code[20];
        BalAccount: Boolean;
        Text006: Label 'You must specify %1.', Comment = 'FRA="Vous devez spécifier une valeur %1."';
        TempDeprDate: Date;
        GroupTotalsInt: Integer;
        Year365Days: Boolean;
        Text007: Label 'You must create accounting periods until %1 to use 365 days depreciation and ''Use Accounting Periods''.', Comment = 'FRA="Vous devez créer des périodes comptables jusqu''au %1 pour utiliser un amortissement sur 365 jours et l''option « Utiliser périodes comptables »."';
        FADeprBook2: Record "FA Depreciation Book";
        DerogDeprBook: Record "Depreciation Book";
        CalculateDepreciation: Report "Calculate Depreciation";
        DerogText: Text[30];
        DerogAmount: Decimal;
        DerogBookValue: Decimal;
        AssetDerogAmounts: Decimal;
        GroupDerogAmounts: Decimal;
        TotalDerogAmounts: Decimal;
        DerogEntryAmounts: array[4] of Decimal;
        HasDerogatorySetup: Boolean;
        DerogAssetsIncluded: Boolean;
        DerogBookValueTemp: Decimal;
        [InDataSet]
        NumberOfDaysCtrlEditable: Boolean;
        Gtext_NumeroImmo: Text[50];
        Gcode_CompteImmo: Code[20];
        Gcode_CompteDotation: Code[20];
        Gcode_CodeFournisseur: Code[20];
        Gcode_Axe: array[4] of Code[20];
        Gdec_ValeurBrute: Decimal;
        Gbool_AfficherEnTete: Boolean;
        Grec_PostingGroup: Record "FA Posting Group";
        Grec_LedgerEntry: Record "FA Ledger Entry";
        Grec_DefaultDimension: Record "Default Dimension";
        Grecord_GeneralLedgerSetup: Record "General Ledger Setup";
        Gcode_AxeDimension: array[6] of Code[20];
        Gtext_Filtre: Text[200];
        Grec_PurchInvHeader: Record "Purch. Inv. Header";
        Gtext_Total: Text[30];
        MainHeadLineText: Text[100];
        HeadLineText: array[5] of Text[50];
        Gdec_AmountFinPeriode: Decimal;
        Gtext_Description: Text[250];
        Gcode_No: Code[20];
        DateType1: Text[30];
        Date: array[2] of Date;
        FADateType: Record "FA Date Type";
        TypeExist: Boolean;
        DateTypeNo1: Integer;
        Text008: Label 'The posting type %1 is not a valid option.', Comment = 'FRA="Le type de comptabilisation %1 n''est pas une option valide."';
        Text009: Label '%1 has been modified in fixed asset %2', Comment = 'FRA="%1 a été modifié(e) dans l''immobilisation %2"';
        Text010: Label 'before Starting Date,Net Change,at Ending Date', Comment = 'FRA="Avant date début,Solde période,En date fin"';
        Text011: Label ' ,FA Class,FA Subclass,FA Location,Main Asset,Global Dimension 1,Global Dimension 2,FA Posting Group', Comment = 'FRA=" ,Classe immo.,Sous-classe immo.,Emplacement immo.,Immo. principale,Axe principal 1,Axe principal 2,Groupe compta. immo."';
        Text012: Label 'Compte de l''immobilisation', Comment = 'FRA="Compte de l''immobilisation"';
        Text013: Label 'Compte de dotation', Comment = 'FRA="Compte de dotation"';
        Text014: Label '     Code fournisseur', Comment = 'FRA="     Code fournisseur"';
        Text015: Label 'Valeur brute', Comment = 'FRA="Valeur brute"';
        Text016: Label 'Axe 1', Comment = 'FRA="Axe 1"';
        Text017: Label 'Axe 2', Comment = 'FRA="Axe 2"';
        Text018: Label 'Axe 3', Comment = 'FRA="Axe 3"';
        Text019: Label 'Axe 4', Comment = 'FRA="Axe 4"';
        Text020: Label 'N°', Comment = 'FRA="N°"';
        Text021: Label 'Description', Comment = 'FRA="Description"';
        Text022: Label 'Cumul amts début période', Comment = 'FRA="Cumul amts début période"';
        Text023: Label 'Dotation amts de la période', Comment = 'FRA="Dotation amts de la période"';
        Text024: Label 'Cumul amts fin de période', Comment = 'FRA="Cumul amts fin de période"';
        Text025: Label 'dotation aux amortissements pour la période du %1 au %2', Comment = 'FRA="dotation aux amortissements pour la période du %1 au %2"';
        Text026: Label 'PROJECTED VALUE', Comment = 'FRA="PROJECTED VALUE"';
        Gdec_AmountBefore: Decimal;
        Gdec_MontantAmtMois: array[12] of Decimal;
        Gint_NbMois: Integer;
        Text027: Label 'Amts 01', Comment = 'FRA="Amts 01"';
        Text028: Label 'Amts 02', Comment = 'FRA="Amts 02"';
        Text029: Label 'Amts 03', Comment = 'FRA="Amts 03"';
        Text030: Label 'Amts 04', Comment = 'FRA="Amts 04"';
        Text031: Label 'Amts 05', Comment = 'FRA="Amts 05"';
        Text032: Label 'Amts 06', Comment = 'FRA="Amts 06"';
        Text033: Label 'Amts 07', Comment = 'FRA="Amts 07"';
        Text034: Label 'Amts 08', Comment = 'FRA="Amts 08"';
        Text035: Label 'Amts 09', Comment = 'FRA="Amts 09"';
        Text036: Label 'Amts 10', Comment = 'FRA="Amts 10"';
        Text037: Label 'Amts 11', Comment = 'FRA="Amts 11"';
        Text038: Label 'Amts 12', Comment = 'FRA="Amts 12"';
        Gdate_anneen: Date;
        Gint_annee: Integer;
        Gdec_MontantPeriode: Decimal;
        Gdec_Cumul: Decimal;
        Gdec_Montant1: Decimal;
        Gdec_Montant2: Decimal;
        Gdec_Montant3: Decimal;
        DateDernierAmort: Date;
        CurrReport_PAGENOCaptionLbl: Label 'Page', Comment = 'FRA="Page"';
        NumberOfDays1: Integer;

    local procedure SkipRecord(): Boolean
    begin
        EXIT(
          "Fixed Asset".Inactive OR
          (FADeprBook."Acquisition Date" = 0D) OR
          (FADeprBook."Acquisition Date" > EndingDate) OR
          (FADeprBook."Last Depreciation Date" > EndingDate) OR
          (FADeprBook."Disposal Date" > 0D));
    end;

    local procedure TransferValues()
    begin
        FADeprBook.CALCFIELDS("Book Value", Depreciation, "Custom 1", Derogatory);
        DateFromProjection := 0D;
        EntryAmounts[1] := FADeprBook."Book Value" - FADeprBook.Derogatory;
        EntryAmounts[2] := FADeprBook."Custom 1";
        EntryAmounts[3] := DepreciationCalc.DeprInFiscalYear("Fixed Asset"."No.", DeprBookCode, StartingDate);
        TotalBookValue[1] := TotalBookValue[1] + FADeprBook."Book Value";
        TotalBookValue[2] := TotalBookValue[2] + FADeprBook."Book Value";
        IF HasDerogatorySetup THEN BEGIN
            DerogBookValue := FADeprBook."Book Value";
            DerogEntryAmounts[1] := DerogBookValue;
        END ELSE
            DerogBookValue := 0;
        NewFiscalYear := FADateCalc.GetFiscalYear(DeprBookCode, StartingDate);
        EndFiscalYear := FADateCalc.CalculateDate(
          DepreciationCalc.Yesterday(NewFiscalYear, Year365Days), DaysInFiscalYear, Year365Days);
        TempDeprDate := FADeprBook."Temp. Ending Date";

        IF DeprBook."Use Custom 1 Depreciation" THEN
            Custom1DeprUntil := FADeprBook."Depr. Ending Date (Custom 1)"
        ELSE
            Custom1DeprUntil := 0D;

        IF Custom1DeprUntil > 0D THEN
            EntryAmounts[4] := GetDeprBasis();
        UntilDate := 0D;
        AssetAmounts[1] := 0;
        AssetAmounts[2] := 0;
        AssetAmounts[3] := 0;
        AssetAmounts[4] := 0;
        AssetDerogAmounts := 0;
    end;

    local procedure CalculateFirstDeprAmount(var Done: Boolean)
    var
        FirstTime: Boolean;
    begin
        FirstTime := TRUE;
        UntilDate := StartingDate;
        REPEAT
            IF NOT FirstTime THEN
                GetNextDate();
            FirstTime := FALSE;
            CalculateDepr.Calculate(
              DeprAmount, Custom1Amount, NumberOfDays, Custom1NumberOfDays,
              "Fixed Asset"."No.", DeprBookCode, UntilDate, EntryAmounts, 0D, DaysInFirstPeriod);
            Done := (DeprAmount <> 0) OR (Custom1Amount <> 0);
            CalculateDerogDepreciation(0D, DaysInFirstPeriod);
        UNTIL (UntilDate >= EndingDate) OR Done;
        EntryAmounts[3] :=
          DepreciationCalc.DeprInFiscalYear("Fixed Asset"."No.", DeprBookCode, UntilDate);
        NumberOfDays1 := NumberOfDays;
    end;

    local procedure CalculateSecondDeprAmount(var Done: Boolean)
    begin
        GetNextDate();
        CalculateDepr.Calculate(
          DeprAmount, Custom1Amount, NumberOfDays, Custom1NumberOfDays,
          "Fixed Asset"."No.", DeprBookCode, UntilDate, EntryAmounts, DateFromProjection, 0);
        Done := CalculationDone(
          (DeprAmount <> 0) OR (Custom1Amount <> 0), DateFromProjection);
        NumberOfDays1 := NumberOfDays;
        CalculateDerogDepreciation(DateFromProjection, 0);
    end;

    local procedure GetNextDate()
    var
        UntilDate2: Date;
    begin
        UntilDate2 := GetPeriodEndingDate(UseAccountingPeriod, UntilDate, PeriodLength);
        IF Custom1DeprUntil > 0D THEN
            IF (UntilDate < Custom1DeprUntil) AND (UntilDate2 > Custom1DeprUntil) THEN
                UntilDate2 := Custom1DeprUntil;

        IF TempDeprDate > 0D THEN
            IF (UntilDate < TempDeprDate) AND (UntilDate2 > TempDeprDate) THEN
                UntilDate2 := TempDeprDate;

        IF (UntilDate < EndFiscalYear) AND (UntilDate2 > EndFiscalYear) THEN
            UntilDate2 := EndFiscalYear;

        IF UntilDate = EndFiscalYear THEN BEGIN
            EntryAmounts[3] := 0;
            NewFiscalYear := DepreciationCalc.ToMorrow(EndFiscalYear, Year365Days);
            EndFiscalYear := FADateCalc.CalculateDate(EndFiscalYear, DaysInFiscalYear, Year365Days);
        END;

        DateFromProjection := DepreciationCalc.ToMorrow(UntilDate, Year365Days);
        UntilDate := UntilDate2;
        IF (UntilDate >= EndingDate) THEN
            UntilDate := EndingDate;
    end;

    local procedure GetPeriodEndingDate(UseAccountingPeriod: Boolean; PeriodEndingDate: Date; var PeriodLength: Integer): Date
    var
        AccountingPeriod: Record "Accounting Period";
        UntilDate2: Date;
    begin
        IF NOT UseAccountingPeriod THEN
            EXIT(FADateCalc.CalculateDate(PeriodEndingDate, PeriodLength, Year365Days));
        AccountingPeriod.SETFILTER(
          "Starting Date", '>=%1', DepreciationCalc.ToMorrow(PeriodEndingDate, Year365Days) + 1);
        IF AccountingPeriod.FINDFIRST() THEN BEGIN
            IF DATE2DMY(AccountingPeriod."Starting Date", 1) <> 31 THEN
                UntilDate2 := DepreciationCalc.Yesterday(AccountingPeriod."Starting Date", Year365Days)
            ELSE
                UntilDate2 := AccountingPeriod."Starting Date" - 1;
            PeriodLength :=
              DepreciationCalc.DeprDays(
                DepreciationCalc.ToMorrow(PeriodEndingDate, Year365Days), UntilDate2, Year365Days);
            IF (PeriodLength <= 5) OR (PeriodLength > DaysInFiscalYear) THEN
                PeriodLength := DaysInFiscalYear;
            EXIT(UntilDate2);
        END ELSE BEGIN
            IF Year365Days THEN
                ERROR(Text007, DepreciationCalc.ToMorrow(EndingDate, Year365Days) + 1);
            EXIT(FADateCalc.CalculateDate(PeriodEndingDate, PeriodLength, Year365Days));
        END;
    end;

    local procedure MakeGroupTotalText()
    begin
        CASE GroupTotals OF
            GroupTotals::"FA Class":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("FA Class Code");
            GroupTotals::"FA Subclass":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("FA Subclass Code");
            GroupTotals::"FA Location":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("FA Location Code");
            GroupTotals::"Main Asset":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("Main Asset/Component");
            GroupTotals::"Global Dimension 1":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("Global Dimension 1 Code");
            GroupTotals::"Global Dimension 2":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("Global Dimension 2 Code");
            GroupTotals::"FA Posting Group":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("FA Posting Group");
        END;
        IF GroupCodeName <> '' THEN BEGIN
            GroupCodeName2 := GroupCodeName;
            IF GroupTotals = GroupTotals::"Main Asset" THEN
                GroupCodeName2 := STRSUBSTNO('%1', SELECTSTR(GroupTotals + 1, Text005));
            GroupCodeName := STRSUBSTNO('%1%2 %3', Text003, ':', GroupCodeName2);
        END;
    end;

    local procedure ValidateDates()
    begin
        FAGenReport.ValidateDeprDates(StartingDate, EndingDate);
        EndingDate2 := EndingDate;
        StartingDate2 := StartingDate;
    end;

    local procedure MakeGroupHeadLine()
    begin
        CASE GroupTotals OF
            GroupTotals::"FA Class":
                GroupHeadLine := "Fixed Asset"."FA Class Code";
            GroupTotals::"FA Subclass":
                GroupHeadLine := "Fixed Asset"."FA Subclass Code";
            GroupTotals::"FA Location":
                GroupHeadLine := "Fixed Asset"."FA Location Code";
            GroupTotals::"Main Asset":
                BEGIN
                    FA."Main Asset/Component" := FA."Main Asset/Component"::"Main Asset";
                    GroupHeadLine :=
                      STRSUBSTNO('%1 %2', FA."Main Asset/Component", "Fixed Asset"."Component of Main Asset");
                    IF "Fixed Asset"."Component of Main Asset" = '' THEN
                        GroupHeadLine := STRSUBSTNO('%1%2', GroupHeadLine, '*****');
                END;
            GroupTotals::"Global Dimension 1":
                GroupHeadLine := "Fixed Asset"."Global Dimension 1 Code";
            GroupTotals::"Global Dimension 2":
                GroupHeadLine := "Fixed Asset"."Global Dimension 2 Code";
            GroupTotals::"FA Posting Group":
                GroupHeadLine := "Fixed Asset"."FA Posting Group";
        END;
        IF GroupHeadLine = '' THEN
            GroupHeadLine := '*****';
    end;

    local procedure UpdateTotals()
    var
        BudgetDepreciation: Codeunit "Budget Depreciation";
        EntryNo: Integer;
        CodeName: Code[20];
    begin
        EntryAmounts[1] := EntryAmounts[1] + DeprAmount + Custom1Amount;
        IF Custom1DeprUntil > 0D THEN
            IF UntilDate <= Custom1DeprUntil THEN
                EntryAmounts[4] := EntryAmounts[4] + DeprAmount + Custom1Amount;
        EntryAmounts[2] := EntryAmounts[2] + Custom1Amount;
        EntryAmounts[3] := EntryAmounts[3] + DeprAmount + Custom1Amount;
        AssetAmounts[1] := AssetAmounts[1] + DeprAmount;
        AssetAmounts[2] := AssetAmounts[2] + Custom1Amount;
        GroupAmounts[1] := GroupAmounts[1] + DeprAmount;
        GroupAmounts[2] := GroupAmounts[2] + Custom1Amount;
        TotalAmounts[1] := TotalAmounts[1] + DeprAmount;
        TotalAmounts[2] := TotalAmounts[2] + Custom1Amount;
        IF NOT HasDerogatorySetup THEN BEGIN
            TotalBookValue[1] := TotalBookValue[1] + DeprAmount + Custom1Amount;
            TotalBookValue[2] := TotalBookValue[2] + DeprAmount + Custom1Amount;
        END ELSE BEGIN
            AssetDerogAmounts := AssetDerogAmounts + DerogAmount;
            GroupDerogAmounts := GroupDerogAmounts + DerogAmount;
            TotalDerogAmounts := TotalDerogAmounts + DerogAmount;
            TotalBookValue[1] := TotalBookValue[1] + DeprAmount + Custom1Amount + DerogAmount;
            TotalBookValue[2] := TotalBookValue[2] + DeprAmount + Custom1Amount + DerogAmount;
        END;
        IF BudgetNameCode <> '' THEN
            BudgetDepreciation.CopyProjectedValueToBudget(
              FADeprBook, BudgetNameCode, UntilDate, DeprAmount, Custom1Amount, BalAccount);

        IF (UntilDate > 0D) OR PrintAmountsPerDate THEN BEGIN
            FABufferProjection.RESET();
            IF FABufferProjection.FIND('+') THEN
                EntryNo := FABufferProjection."Entry No." + 1
            ELSE
                EntryNo := 1;
            FABufferProjection.SETRANGE("FA Posting Date", UntilDate);
            IF GroupTotals <> GroupTotals::" " THEN BEGIN
                CASE GroupTotals OF
                    GroupTotals::"FA Class":
                        CodeName := "Fixed Asset"."FA Class Code";
                    GroupTotals::"FA Subclass":
                        CodeName := "Fixed Asset"."FA Subclass Code";
                    GroupTotals::"FA Location":
                        CodeName := "Fixed Asset"."FA Location Code";
                    GroupTotals::"Main Asset":
                        CodeName := "Fixed Asset"."Component of Main Asset";
                    GroupTotals::"Global Dimension 1":
                        CodeName := "Fixed Asset"."Global Dimension 1 Code";
                    GroupTotals::"Global Dimension 2":
                        CodeName := "Fixed Asset"."Global Dimension 2 Code";
                    GroupTotals::"FA Posting Group":
                        CodeName := "Fixed Asset"."FA Posting Group";
                END;
                FABufferProjection.SETRANGE("Code Name", CodeName);
            END;
            IF NOT FABufferProjection.FIND('=><') THEN BEGIN
                FABufferProjection.INIT();
                FABufferProjection."Code Name" := CodeName;
                FABufferProjection."FA Posting Date" := UntilDate;
                FABufferProjection."Entry No." := EntryNo;
                FABufferProjection.Depreciation := DeprAmount;
                FABufferProjection."Custom 1" := Custom1Amount;
                FABufferProjection.INSERT();
            END ELSE BEGIN
                FABufferProjection.Depreciation := FABufferProjection.Depreciation + DeprAmount;
                FABufferProjection."Custom 1" := FABufferProjection."Custom 1" + Custom1Amount;
                FABufferProjection.MODIFY();
            END;
        END;
    end;

    local procedure InitGroupTotals()
    begin
        GroupDerogAmounts := 0;
        GroupAmounts[1] := 0;
        GroupAmounts[2] := 0;
        GroupAmounts[3] := 0;
        GroupAmounts[4] := 0;
        IF NotFirstGroupTotal THEN
            TotalBookValue[1] := 0
        ELSE
            TotalBookValue[1] := EntryAmounts[1];
        NotFirstGroupTotal := TRUE;
    end;

    local procedure GetDeprBasis(): Decimal
    var
        FALedgEntry: Record "FA Ledger Entry";
    begin
        FALedgEntry.SETCURRENTKEY("FA No.", "Depreciation Book Code", "Part of Book Value", "FA Posting Date");
        FALedgEntry.SETRANGE("FA No.", "Fixed Asset"."No.");
        FALedgEntry.SETRANGE("Depreciation Book Code", DeprBookCode);
        FALedgEntry.SETRANGE("Part of Book Value", TRUE);
        FALedgEntry.SETRANGE("FA Posting Date", 0D, Custom1DeprUntil);
        FALedgEntry.CALCSUMS(Amount);
        EXIT(FALedgEntry.Amount);
    end;

    local procedure CalculateGainLoss()
    var
        EntryAmounts: array[14] of Decimal;
        CalculateDisposal: Codeunit "Calculate Disposal";
    begin
        CalculateDisposal.CalcGainLoss("Fixed Asset"."No.", DeprBookCode, EntryAmounts);
        AssetAmounts[3] := FADeprBook."Projected Proceeds on Disposal";
        IF EntryAmounts[1] <> 0 THEN
            AssetAmounts[4] := EntryAmounts[1]
        ELSE
            AssetAmounts[4] := EntryAmounts[2];
        AssetAmounts[4] :=
          AssetAmounts[4] + AssetAmounts[1] + AssetAmounts[2] - FADeprBook."Projected Proceeds on Disposal";
        GroupAmounts[3] := GroupAmounts[3] + AssetAmounts[3];
        GroupAmounts[4] := GroupAmounts[4] + AssetAmounts[4];
        TotalAmounts[3] := TotalAmounts[3] + AssetAmounts[3];
        TotalAmounts[4] := TotalAmounts[4] + AssetAmounts[4];
    end;

    local procedure CalculationDone(Done: Boolean; FirstDeprDate: Date): Boolean
    var
        TableDeprCalc: Codeunit "Table Depr. Calculation";
    begin
        IF Done OR
          (FADeprBook."Depreciation Method" <> FADeprBook."Depreciation Method"::"User-Defined")
        THEN
            EXIT(Done);
        EXIT(
          TableDeprCalc.GetTablePercent(
            DeprBookCode, FADeprBook."Depreciation Table Code",
            FADeprBook."First User-Defined Depr. Date", FirstDeprDate, UntilDate) = 0);
    end;

    local procedure UpdateReqForm()
    var
        DeprBook: Record "Depreciation Book";
    begin
        IF ISSERVICETIER THEN BEGIN
            PageUpdateReqForm();
            EXIT;
        END;
        IF DeprBookCode <> '' THEN
            DeprBook.GET(DeprBookCode);

        PeriodLength := 0;
        IF DeprBook."Fiscal Year 365 Days" AND NOT UseAccountingPeriod THEN
            PeriodLength := 365;
    end;

    procedure CalculateDerogDepreciation(DateFromProjection2: Date; DaysInFirstPeriod2: Integer)
    begin
        IF HasDerogatorySetup THEN BEGIN
            CalculateDepr.Calculate(
              DerogAmount, Custom1Amount, NumberOfDays, Custom1NumberOfDays,
              "Fixed Asset"."No.", DerogDeprBook.Code, UntilDate, DerogEntryAmounts, DateFromProjection2, DaysInFirstPeriod2);
            DerogAmount := CalculateDepreciation.CalcDerogDeprAmount(DerogAmount, DeprAmount);
        END;
    end;

    local procedure PageUpdateReqForm()
    var
        DeprBook: Record "Depreciation Book";
    begin
        IF DeprBookCode <> '' THEN
            DeprBook.GET(DeprBookCode);

        PeriodLength := 0;
        IF DeprBook."Fiscal Year 365 Days" AND NOT UseAccountingPeriod THEN
            PeriodLength := 365;
    end;

    local procedure CheckDateType(var DateType: Text[30]; var DateTypeNo: Integer)
    begin
        DateTypeNo := 0;
        IF DateType = '' THEN
            EXIT;
        FADateType.SETRANGE("FA Entry", TRUE);
        IF FADateType.FIND('-') THEN
            REPEAT
                TypeExist := DateType = FADateType."FA Date Type Name";
                IF TypeExist THEN
                    DateTypeNo := FADateType."FA Date Type No.";
            UNTIL (FADateType.NEXT() = 0) OR TypeExist;

        IF NOT TypeExist THEN
            ERROR(Text007, DateType);
    end;

    procedure InitMonth()
    begin
        //Modif JX-AUD du 02/08/11
        Gdec_MontantAmtMois[1] := 0;
        Gdec_MontantAmtMois[2] := 0;
        Gdec_MontantAmtMois[3] := 0;
        Gdec_MontantAmtMois[4] := 0;
        Gdec_MontantAmtMois[5] := 0;
        Gdec_MontantAmtMois[6] := 0;
        Gdec_MontantAmtMois[7] := 0;
        Gdec_MontantAmtMois[8] := 0;
        Gdec_MontantAmtMois[9] := 0;
        Gdec_MontantAmtMois[10] := 0;
        Gdec_MontantAmtMois[11] := 0;
        Gdec_MontantAmtMois[12] := 0;
        //Fin modif JX-AUD du 02/08/11
    end;
}

