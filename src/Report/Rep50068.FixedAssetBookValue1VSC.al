report 50068 "Fixed Asset - Book Value 1 VSC"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/FixedAssetBookValue1VSC.rdl';
    Caption = 'Fixed Asset - Book Value 01', Comment = 'FRA="Immo. - Valeur comptable 01 VSC"';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Depreciation Book"; "Depreciation Book")
        {
            DataItemTableView = SORTING(Code);
            RequestFilterFields = "Code";
            column(MainHeadLineText; MainHeadLineText)
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(DeprBookText; DeprBookText)
            {
            }
            column(FAFilter_FixedAsset; "Fixed Asset".TABLECAPTION + ': ' + FAFilter)
            {
            }
            column(FAFilter; FAFilter)
            {
            }
            column(PrintDetails; PrintDetailsV)
            {
            }
            column(GroupTotals; SELECTSTR(GroupTotalsV + 1, GroupTotalsTxt))
            {
            }
            column(GroupCodeName; GroupCodeName)
            {
            }
            column(HeadLineText1; HeadLineText[1])
            {
            }
            column(HeadLineText2; HeadLineText[2])
            {
            }
            column(HeadLineText3; HeadLineText[3])
            {
            }
            column(HeadLineText4; HeadLineText[4])
            {
            }
            column(HeadLineText5; HeadLineText[5])
            {
            }
            column(HeadLineText6; HeadLineText[6])
            {
            }
            column(HeadLineText7; HeadLineText[7])
            {
            }
            column(HeadLineText8; HeadLineText[8])
            {
            }
            column(HeadLineText9; HeadLineText[9])
            {
            }
            column(HeadLineText10; HeadLineText[10])
            {
            }
            column(FANo; FANo)
            {
            }
            column(FADescription; FADescription)
            {
            }
            column(HeadLineText11; HeadLineText[11])
            {
            }
            column(HeadLineText12; HeadLineText[12])
            {
            }
            column(HeadLineText13; HeadLineText[13])
            {
            }
            column(HeadLineText14; HeadLineText[14])
            {
            }
            column(AfficherEnTete; Gbool_AfficherEnTeteV)
            {
            }
            dataitem("Fixed Asset"; "Fixed Asset")
            {
                RequestFilterFields = "No.", "FA Class Code", "FA Subclass Code", "Budgeted Asset";
                column(GroupTotalsGroupHeadLine1; GroupHeadLine)
                {
                }
                column(No_FixedAsset; "No.")
                {
                    IncludeCaption = true;
                }
                column(Description_FixedAsset; Description)
                {
                    IncludeCaption = true;
                }
                column(StartAmounts1; StartAmounts[1])
                {
                    AutoFormatType = 1;
                }
                column(NetChangeAmounts1; NetChangeAmounts[1])
                {
                    AutoFormatType = 1;
                }
                column(DisposalAmounts1; DisposalAmounts[1])
                {
                    AutoFormatType = 1;
                }
                column(TotalEndingAmounts1; TotalEndingAmounts[1])
                {
                    AutoFormatType = 1;
                }
                column(StartAmounts2; StartAmounts[2])
                {
                    AutoFormatType = 1;
                }
                column(NetChangeAmounts2; NetChangeAmounts[2])
                {
                    AutoFormatType = 1;
                }
                column(DisposalAmounts2; DisposalAmounts[2])
                {
                    AutoFormatType = 1;
                }
                column(TotalEndingAmounts2; TotalEndingAmounts[2])
                {
                    AutoFormatType = 1;
                }
                column(BookValueAtStartingDate; BookValueAtStartingDate)
                {
                    AutoFormatType = 1;
                }
                column(BookValueAtEndingDate; BookValueAtEndingDate)
                {
                    AutoFormatType = 1;
                }
                column(StartAmounts7; StartAmounts[7])
                {
                    AutoFormatType = 1;
                }
                column(NetChangeAmounts7; NetChangeAmounts[7])
                {
                    AutoFormatType = 1;
                }
                column(DisposalAmounts7; DisposalAmounts[7])
                {
                    AutoFormatType = 1;
                }
                column(TotalEndingAmounts7; TotalEndingAmounts[7])
                {
                    AutoFormatType = 1;
                }
                column(DeprBookInfo1; DeprBookInfo[1])
                {
                }
                column(DeprBookInfo2; DeprBookInfo[2])
                {
                }
                column(DeprBookInfo3; DeprBookInfo[3])
                {
                }
                column(DeprBookInfo4; DeprBookInfo[4])
                {
                }
                column(DeprBookInfo5; DeprBookInfo[5])
                {
                }
                column(PrintFASetup; PrintFASetupV)
                {
                }
                column(DerogDeprBookInfo1; DerogDeprBookInfo[1])
                {
                }
                column(DerogDeprBookInfo2; DerogDeprBookInfo[2])
                {
                }
                column(DerogDeprBookInfo3; DerogDeprBookInfo[3])
                {
                }
                column(DerogDeprBookInfo4; DerogDeprBookInfo[4])
                {
                }
                column(DerogDeprBookInfo5; DerogDeprBookInfo[5])
                {
                }
                column(HasDerogatorySetup; HasDerogatorySetup)
                {
                }
                column(GroupTotalsGroupHeadLine; FORMAT(Text002 + ': ' + GroupHeadLine))
                {
                }
                column(GroupStartAmounts1; GroupStartAmounts[1])
                {
                    AutoFormatType = 1;
                }
                column(GroupNetChangeAmounts1; GroupNetChangeAmounts[1])
                {
                    AutoFormatType = 1;
                }
                column(GroupDisposalAmounts1; GroupDisposalAmounts[1])
                {
                    AutoFormatType = 1;
                }
                column(GroupStartAmounts2; GroupStartAmounts[2])
                {
                    AutoFormatType = 1;
                }
                column(GroupNetChangeAmounts2; GroupNetChangeAmounts[2])
                {
                    AutoFormatType = 1;
                }
                column(GroupDisposalAmounts2; GroupDisposalAmounts[2])
                {
                    AutoFormatType = 1;
                }
                column(GroupStartAmounts7; GroupStartAmounts[7])
                {
                    AutoFormatType = 1;
                }
                column(GroupNetChangeAmounts7; GroupNetChangeAmounts[7])
                {
                    AutoFormatType = 1;
                }
                column(GroupDisposalAmounts7; GroupDisposalAmounts[7])
                {
                    AutoFormatType = 1;
                }
                column(TotalStartAmounts1; TotalStartAmounts[1])
                {
                    AutoFormatType = 1;
                }
                column(TotalNetChangeAmounts1; TotalNetChangeAmounts[1])
                {
                    AutoFormatType = 1;
                }
                column(TotalDisposalAmounts1; TotalDisposalAmounts[1])
                {
                    AutoFormatType = 1;
                }
                column(TotalStartAmounts2; TotalStartAmounts[2])
                {
                    AutoFormatType = 1;
                }
                column(TotalNetChangeAmounts2; TotalNetChangeAmounts[2])
                {
                    AutoFormatType = 1;
                }
                column(TotalDisposalAmounts2; TotalDisposalAmounts[2])
                {
                    AutoFormatType = 1;
                }
                column(TotalStartAmounts7; TotalStartAmounts[7])
                {
                    AutoFormatType = 1;
                }
                column(TotalDisposalAmounts7; TotalDisposalAmounts[7])
                {
                    AutoFormatType = 1;
                }
                column(TotalNetChangeAmounts7; TotalNetChangeAmounts[7])
                {
                    AutoFormatType = 1;
                }
                column(FASubclassCode_FixedAsset; "FA Subclass Code")
                {
                }
                column(GloblDimnsnCode_FixedAsset; "Global Dimension 2 Code")
                {
                }
                column(CmpntofMainAset_FixedAsset; "Component of Main Asset")
                {
                }
                column(CurrReportPAGENOCaption; CurrReportPAGENOCaptionLbl)
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF NOT FADeprBook.GET("No.", DeprBookCodeV) THEN
                        CurrReport.SKIP();
                    IF SkipRecord() THEN
                        CurrReport.SKIP();

                    HasDerogatorySetup := FALSE;
                    FADeprBook2.SETRANGE("FA No.", "No.");
                    FADeprBook2.SETRANGE("Depreciation Book Code", DerogDeprBook.Code);
                    IF FADeprBook2.FIND('-') THEN
                        HasDerogatorySetup := TRUE;

                    IF GroupTotalsV = GroupTotalsV::"FA Posting Group" THEN
                        IF "FA Posting Group" <> FADeprBook."FA Posting Group" THEN
                            ERROR(Text007, FIELDCAPTION("FA Posting Group"), "No.");

                    BeforeAmount := 0;
                    EndingAmount := 0;
                    IF BudgetReportV THEN
                        BudgetDepreciation.Calculate(
                          "No.", GetStartingDate(StartingDateV), EndingDateV, DeprBookCodeV, BeforeAmount, EndingAmount);

                    i := 0;
                    WHILE i < NumberOfTypes DO BEGIN
                        i := i + 1;
                        CASE i OF
                            1:
                                PostingType := FADeprBook.FIELDNO("Acquisition Cost");
                            2:
                                PostingType := FADeprBook.FIELDNO(Depreciation);
                            3:
                                PostingType := FADeprBook.FIELDNO("Write-Down");
                            4:
                                PostingType := FADeprBook.FIELDNO(Appreciation);
                            5:
                                PostingType := FADeprBook.FIELDNO("Custom 1");
                            6:
                                PostingType := FADeprBook.FIELDNO("Custom 2");
                            7:
                                PostingType := FADeprBook.FIELDNO(Derogatory);
                        END;
                        IF StartingDateV <= 00000101D THEN
                            StartAmounts[i] := 0
                        ELSE
                            StartAmounts[i] := FAGenReport.CalcFAPostedAmount("No.", PostingType, Period1, StartingDateV,
                              EndingDateV, DeprBookCodeV, BeforeAmount, EndingAmount, FALSE, TRUE);
                        NetChangeAmounts[i] :=
                          FAGenReport.CalcFAPostedAmount(
                            "No.", PostingType, Period2, StartingDateV, EndingDateV,
                            DeprBookCodeV, BeforeAmount, EndingAmount, FALSE, TRUE);
                        IF i = 7 THEN BEGIN
                            FAGenReport.SetSign(TRUE);
                            NetChangeAmounts[i] :=
                              -(FAGenReport.CalcFAPostedAmount(
                                  "No.", PostingType, Period2, StartingDateV, EndingDateV,
                                  DeprBookCodeV, BeforeAmount, EndingAmount, FALSE, TRUE));
                            FAGenReport.SetSign(FALSE);
                            DisposalAmounts[i] :=
                              FAGenReport.CalcFAPostedAmount(
                                "No.", PostingType, Period2, StartingDateV, EndingDateV,
                                DeprBookCodeV, BeforeAmount, EndingAmount, FALSE, TRUE);
                        END;
                        IF GetPeriodDisposal() THEN
                            DisposalAmounts[i] := -(StartAmounts[i] + NetChangeAmounts[i])
                        ELSE
                            IF i <> 7 THEN
                                DisposalAmounts[i] := 0;
                        IF (i >= 3) AND (i <> 7) THEN
                            AddPostingType(i - 3);
                    END;
                    FOR j := 1 TO NumberOfTypes DO
                        TotalEndingAmounts[j] := StartAmounts[j] + NetChangeAmounts[j] + DisposalAmounts[j];
                    BookValueAtEndingDate := 0;
                    BookValueAtStartingDate := 0;
                    FOR j := 1 TO NumberOfTypes DO
                        IF NOT ((j = 7) AND HasDerogatorySetup) THEN BEGIN
                            BookValueAtEndingDate := BookValueAtEndingDate + TotalEndingAmounts[j];
                            BookValueAtStartingDate := BookValueAtStartingDate + StartAmounts[j];
                        END;

                    MakeGroupHeadLine();
                    UpdateTotals();
                    CreateGroupTotals();
                    GetDeprBookInfo();
                    GetDerogDeprBookInfo();
                end;

                trigger OnPostDataItem()
                begin
                    CreateTotals();
                end;

                trigger OnPreDataItem()
                begin
                    //Modif JX-AUD du 03/08/11
                    DeprBookCodeV := "Depreciation Book".Code;
                    DeprBookText := STRSUBSTNO('%1%2 %3', DeprBook.TABLECAPTION, ':', DeprBookCodeV);
                    //Fin modif JX-AUD du 03/08/11

                    CASE GroupTotalsV OF
                        GroupTotalsV::"FA Class":
                            SETCURRENTKEY("FA Class Code");
                        GroupTotalsV::"FA Subclass":
                            SETCURRENTKEY("FA Subclass Code");
                        GroupTotalsV::"FA Location":
                            SETCURRENTKEY("FA Location Code");
                        GroupTotalsV::"Main Asset":
                            SETCURRENTKEY("Component of Main Asset");
                        GroupTotalsV::"Global Dimension 1":
                            SETCURRENTKEY("Global Dimension 1 Code");
                        GroupTotalsV::"Global Dimension 2":
                            SETCURRENTKEY("Global Dimension 2 Code");
                        GroupTotalsV::"FA Posting Group":
                            SETCURRENTKEY("FA Posting Group");
                    END;
                end;
            }
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
                    field(DeprBookCode; DeprBookCodeV)
                    {
                        Caption = 'Depreciation Book', Comment = 'FRA="Lois d''amortissement"';
                        TableRelation = "Depreciation Book";
                        Visible = false;
                        ApplicationArea = All;
                    }
                    field(StartingDate; StartingDateV)
                    {
                        Caption = 'Starting Date', Comment = 'FRA="Date début"';
                        ApplicationArea = All;
                    }
                    field(EndingDate; EndingDateV)
                    {
                        Caption = 'Ending Date', Comment = 'FRA="Date fin"';
                        ApplicationArea = All;
                    }
                    field(GroupTotals; GroupTotalsV)
                    {
                        Caption = 'Group Totals', Comment = 'FRA="Sous-totaux"';
                        OptionCaption = ' ,FA Class,FA Subclass,FA Location,Main Asset,Global Dimension 1,Global Dimension 2,FA Posting Group', Comment = 'FRA=" ,Classe immo.,Sous-classe immo.,Emplacement immo.,Immo. principale,Axe principal 1,Axe principal 2,Groupe compta. immo."';
                        ApplicationArea = All;
                    }
                    field(PrintDetails; PrintDetailsV)
                    {
                        Caption = 'Print per Fixed Asset', Comment = 'FRA="Imprimer par immobilisation"';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            IF NOT PrintDetailsV THEN
                                IF PrintFASetupV THEN
                                    PrintFASetupV := FALSE;
                        end;
                    }
                    field(BudgetReport; BudgetReportV)
                    {
                        Caption = 'Budget Report', Comment = 'FRA="État budget"';
                        ApplicationArea = All;
                    }
                    field(PrintFASetup; PrintFASetupV)
                    {
                        Caption = 'Print FA Setup', Comment = 'FRA="Imprimer Paramètres immobilisations"';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            IF PrintFASetupV THEN
                                IF NOT PrintDetailsV THEN
                                    PrintDetailsV := TRUE;
                        end;
                    }
                    field(Gbool_AfficherEnTete; Gbool_AfficherEnTeteV)
                    {
                        Caption = 'Display the header', Comment = 'FRA="Afficher l''en-tête"';
                        ApplicationArea = All;
                    }
                }
            }
        }
        trigger OnOpenPage()
        begin
            GetDepreciationBookCode();
            //Modif JX-AUD du 03/08/11
            Gbool_AfficherEnTeteV := TRUE;
        end;
    }
    trigger OnInitReport()
    begin
        //Modif JX-AUD du 03/08/11
        Gbool_AfficherEnTeteV := TRUE;
        Gint_NbSaisies := 0; //Modif JX-AUD du 18/11/11
        CLEAR(Gvariant_Tableau);//Modif JX-AUD du 18/11/11
        //Fin modif JX-AUD du 03/08/11
    end;

    trigger OnPreReport()
    begin
        NumberOfTypes := 7;
        CLEAR(DerogDeprBook);
        DeprBook.GET(DeprBookCodeV);
        DerogDeprBook.SETRANGE("Derogatory Calculation", DeprBookCodeV);
        IF DerogDeprBook.FIND('-') THEN;
        IF GroupTotalsV = GroupTotalsV::"FA Posting Group" THEN
            FAGenReport.SetFAPostingGroup("Fixed Asset", DeprBook.Code);
        FAGenReport.AppendFAPostingFilter("Fixed Asset", StartingDateV, EndingDateV);
        FAFilter := "Fixed Asset".GETFILTERS;
        MainHeadLineText := Text000;
        IF BudgetReportV THEN
            MainHeadLineText := STRSUBSTNO('%1 %2', MainHeadLineText, Text001);
        DeprBookText := STRSUBSTNO('%1%2 %3', DeprBook.TABLECAPTION, ':', DeprBookCodeV);
        MakeGroupTotalText();
        FAGenReport.ValidateDates(StartingDateV, EndingDateV);
        MakeDateText();
        MakeHeadLine();
        IF PrintDetailsV THEN BEGIN
            FANo := "Fixed Asset".FIELDCAPTION("No.");
            FADescription := "Fixed Asset".FIELDCAPTION(Description);
        END;
        Period1 := Period1::"Before Starting Date";
        Period2 := Period2::"Net Change";
    end;

    var
        DeprBook: Record "Depreciation Book";
        DerogDeprBook: Record "Depreciation Book";
        FADeprBook: Record "FA Depreciation Book";
        FADeprBook2: Record "FA Depreciation Book";
        FAPostingTypeSetup: Record "FA Posting Type Setup";
        FASetup: Record "FA Setup";
        FA: Record "Fixed Asset";
        BudgetDepreciation: Codeunit "Budget Depreciation";
        FAGenReport: Codeunit "FA General Report";
        BudgetReportV: Boolean;
        Gbool_AfficherEnTeteV: Boolean;
        HasDerogatorySetup: Boolean;
        PrintDetailsV: Boolean;
        PrintFASetupV: Boolean;
        DeprBookCodeV: Code[10];
        AcquisitionDate: Date;
        DisposalDate: Date;
        EndingDateV: Date;
        StartingDateV: Date;
        BeforeAmount: Decimal;
        BookValueAtEndingDate: Decimal;
        BookValueAtStartingDate: Decimal;
        DisposalAmounts: array[7] of Decimal;
        EndingAmount: Decimal;
        GroupDisposalAmounts: array[7] of Decimal;
        GroupNetChangeAmounts: array[7] of Decimal;
        GroupStartAmounts: array[7] of Decimal;
        NetChangeAmounts: array[7] of Decimal;
        StartAmounts: array[7] of Decimal;
        TotalDisposalAmounts: array[7] of Decimal;
        TotalEndingAmounts: array[7] of Decimal;
        TotalNetChangeAmounts: array[7] of Decimal;
        TotalStartAmounts: array[7] of Decimal;
        Gint_NbSaisies: Integer;
        i: Integer;
        j: Integer;
        NumberOfTypes: Integer;
        PostingType: Integer;
        CurrReportPAGENOCaptionLbl: Label 'Page', Comment = 'FRA="Page"';
        GroupTotalsTxt: Label ' ,FA Class,FA Subclass,FA Location,Main Asset,Global Dimension 1,Global Dimension 2,FA Posting Group', Comment = 'FRA=" ,Classe immo.,Sous-classe immo.,Emplacement immo.,Immo. principale,Axe principal 1,Axe principal 2,Groupe compta. immo."';
        Text000: Label 'Fixed Asset - Book Value 01', Comment = 'FRA="Immo. - Valeur comptable 01"';
        Text001: Label '(Budget Report)', Comment = 'FRA="(Etat budget)"';
        Text002: Label 'Group Total', Comment = 'FRA="Sous-total"';
        Text003: Label 'Group Totals', Comment = 'FRA="Sous-totaux"';
        Text004: Label 'in Period', Comment = 'FRA="dans la période"';
        Text005: Label 'Disposal', Comment = 'FRA="Cession"';
        Text006: Label 'Addition', Comment = 'FRA="Ajout"';
        Text007: Label '%1 has been modified in fixed asset %2.', Comment = 'FRA="%1 a été modifié(e) dans l''immobilisation %2."';
        Text10800: Label 'Increased in Period', Comment = 'FRA="Augmenté au cours de la période"';
        Text10801: Label 'Decreased in Period', Comment = 'FRA="Diminué au cours de la période"';
        TotalCaptionLbl: Label 'Total', Comment = 'FRA="Total"';
        GroupTotalsV: Option " ","FA Class","FA Subclass","FA Location","Main Asset","Global Dimension 1","Global Dimension 2","FA Posting Group";
        Period1: Option "Before Starting Date","Net Change","at Ending Date";
        Period2: Option "Before Starting Date","Net Change","at Ending Date";
        FAFilter: Text;
        DeprBookInfo: array[5] of Text[30];
        DerogDeprBookInfo: array[5] of Text[30];
        EndText: Text[30];
        StartText: Text[30];
        DeprBookText: Text[50];
        FADescription: Text[50];
        FANo: Text[50];
        GroupCodeName: Text[50];
        GroupHeadLine: Text[50];
        HeadLineText: array[14] of Text[50];
        MainHeadLineText: Text[100];
        Gvariant_Tableau: array[30000, 15] of Variant;

    local procedure AddPostingType(PostingType: Option "Write-Down",Appreciation,"Custom 1","Custom 2")
    var
        k: Integer;
        L: Integer;
    begin
        k := PostingType + 3;
        CASE PostingType OF
            PostingType::"Write-Down":
                FAPostingTypeSetup.GET(DeprBookCodeV, FAPostingTypeSetup."FA Posting Type"::"Write-Down");
            PostingType::Appreciation:
                FAPostingTypeSetup.GET(DeprBookCodeV, FAPostingTypeSetup."FA Posting Type"::Appreciation);
            PostingType::"Custom 1":
                FAPostingTypeSetup.GET(DeprBookCodeV, FAPostingTypeSetup."FA Posting Type"::"Custom 1");
            PostingType::"Custom 2":
                FAPostingTypeSetup.GET(DeprBookCodeV, FAPostingTypeSetup."FA Posting Type"::"Custom 2");
        END;
        IF FAPostingTypeSetup."Depreciation Type" THEN
            L := 2
        ELSE
            IF FAPostingTypeSetup."Acquisition Type" THEN
                L := 1;
        IF L > 0 THEN BEGIN
            StartAmounts[L] := StartAmounts[L] + StartAmounts[k];
            StartAmounts[k] := 0;
            NetChangeAmounts[L] := NetChangeAmounts[L] + NetChangeAmounts[k];
            NetChangeAmounts[k] := 0;
            DisposalAmounts[L] := DisposalAmounts[L] + DisposalAmounts[k];
            DisposalAmounts[k] := 0;
        END;
    end;

    local procedure SkipRecord(): Boolean
    begin
        AcquisitionDate := FADeprBook."Acquisition Date";
        DisposalDate := FADeprBook."Disposal Date";
        EXIT(
          "Fixed Asset".Inactive OR
          (AcquisitionDate = 0D) OR
          (AcquisitionDate > EndingDateV) AND (EndingDateV > 0D) OR
          (DisposalDate > 0D) AND (DisposalDate < StartingDateV))
    end;

    local procedure GetPeriodDisposal(): Boolean
    begin
        IF DisposalDate > 0D THEN
            IF (EndingDateV = 0D) OR (DisposalDate <= EndingDateV) THEN
                EXIT(TRUE);
        EXIT(FALSE);
    end;

    local procedure MakeGroupTotalText()
    begin
        CASE GroupTotalsV OF
            GroupTotalsV::"FA Class":
                GroupCodeName := FORMAT("Fixed Asset".FIELDCAPTION("FA Class Code"));
            GroupTotalsV::"FA Subclass":
                GroupCodeName := FORMAT("Fixed Asset".FIELDCAPTION("FA Subclass Code"));
            GroupTotalsV::"FA Location":
                GroupCodeName := FORMAT("Fixed Asset".FIELDCAPTION("FA Location Code"));
            GroupTotalsV::"Main Asset":
                GroupCodeName := FORMAT("Fixed Asset".FIELDCAPTION("Main Asset/Component"));
            GroupTotalsV::"Global Dimension 1":
                GroupCodeName := FORMAT("Fixed Asset".FIELDCAPTION("Global Dimension 1 Code"));
            GroupTotalsV::"Global Dimension 2":
                GroupCodeName := FORMAT("Fixed Asset".FIELDCAPTION("Global Dimension 2 Code"));
            GroupTotalsV::"FA Posting Group":
                GroupCodeName := FORMAT("Fixed Asset".FIELDCAPTION("FA Posting Group"));
        END;
        IF GroupCodeName <> '' THEN
            GroupCodeName := FORMAT(STRSUBSTNO('%1%2 %3', Text003, ':', GroupCodeName));
    end;

    local procedure MakeDateText()
    begin
        StartText := STRSUBSTNO('%1', StartingDateV - 1);
        EndText := STRSUBSTNO('%1', EndingDateV);
    end;

    local procedure MakeHeadLine()
    var
        DisposalText: Text[30];
        InPeriodText: Text[30];
    begin
        InPeriodText := Text004;
        DisposalText := Text005;
        HeadLineText[1] := STRSUBSTNO('%1 %2', FADeprBook.FIELDCAPTION("Acquisition Cost"), StartText);
        HeadLineText[2] := STRSUBSTNO('%1 %2', Text006, InPeriodText);
        HeadLineText[3] := STRSUBSTNO('%1 %2', DisposalText, InPeriodText);
        HeadLineText[4] := STRSUBSTNO('%1 %2', FADeprBook.FIELDCAPTION("Acquisition Cost"), EndText);
        HeadLineText[5] := STRSUBSTNO('%1 %2', FADeprBook.FIELDCAPTION(Depreciation), StartText);
        HeadLineText[6] := STRSUBSTNO('%1 %2', FADeprBook.FIELDCAPTION(Depreciation), InPeriodText);
        HeadLineText[7] := STRSUBSTNO(
          '%1 %2 %3', DisposalText, FADeprBook.FIELDCAPTION(Depreciation), InPeriodText);
        HeadLineText[8] := STRSUBSTNO('%1 %2', FADeprBook.FIELDCAPTION(Depreciation), EndText);
        HeadLineText[9] := STRSUBSTNO('%1 %2', FADeprBook.FIELDCAPTION("Book Value"), StartText);
        HeadLineText[10] := STRSUBSTNO('%1 %2', FADeprBook.FIELDCAPTION("Book Value"), EndText);
        HeadLineText[11] := STRSUBSTNO('%1 %2', FADeprBook.FIELDCAPTION(Derogatory), StartText);
        HeadLineText[12] := STRSUBSTNO('%1 %2', FADeprBook.FIELDCAPTION(Derogatory), Text10800);
        HeadLineText[13] := STRSUBSTNO('%1 %2', FADeprBook.FIELDCAPTION(Derogatory), Text10801);
        HeadLineText[14] := STRSUBSTNO('%1 %2', FADeprBook.FIELDCAPTION(Derogatory), EndText);
    end;

    local procedure MakeGroupHeadLine()
    begin
        FOR j := 1 TO NumberOfTypes DO BEGIN
            GroupStartAmounts[j] := 0;
            GroupNetChangeAmounts[j] := 0;
            GroupDisposalAmounts[j] := 0;
        END;
        CASE GroupTotalsV OF
            GroupTotalsV::"FA Class":
                GroupHeadLine := FORMAT("Fixed Asset"."FA Class Code");
            GroupTotalsV::"FA Subclass":
                GroupHeadLine := FORMAT("Fixed Asset"."FA Subclass Code");
            GroupTotalsV::"FA Location":
                GroupHeadLine := FORMAT("Fixed Asset"."FA Location Code");
            GroupTotalsV::"Main Asset":
                BEGIN
                    FA."Main Asset/Component" := FA."Main Asset/Component"::"Main Asset";
                    GroupHeadLine :=
                      FORMAT(STRSUBSTNO('%1 %2', FORMAT(FA."Main Asset/Component"), "Fixed Asset"."Component of Main Asset"));
                    IF "Fixed Asset"."Component of Main Asset" = '' THEN
                        GroupHeadLine := FORMAT(STRSUBSTNO('%1 %2', GroupHeadLine, '*****'));
                END;
            GroupTotalsV::"Global Dimension 1":
                GroupHeadLine := FORMAT("Fixed Asset"."Global Dimension 1 Code");
            GroupTotalsV::"Global Dimension 2":
                GroupHeadLine := FORMAT("Fixed Asset"."Global Dimension 2 Code");
            GroupTotalsV::"FA Posting Group":
                GroupHeadLine := FORMAT("Fixed Asset"."FA Posting Group");
        END;
        IF GroupHeadLine = '' THEN
            GroupHeadLine := FORMAT('*****');
    end;

    local procedure UpdateTotals()
    begin
        FOR j := 1 TO NumberOfTypes DO BEGIN
            GroupStartAmounts[j] := GroupStartAmounts[j] + StartAmounts[j];
            GroupNetChangeAmounts[j] := GroupNetChangeAmounts[j] + NetChangeAmounts[j];
            GroupDisposalAmounts[j] := GroupDisposalAmounts[j] + DisposalAmounts[j];
            TotalStartAmounts[j] := TotalStartAmounts[j] + StartAmounts[j];
            TotalNetChangeAmounts[j] := TotalNetChangeAmounts[j] + NetChangeAmounts[j];
            TotalDisposalAmounts[j] := TotalDisposalAmounts[j] + DisposalAmounts[j];
        END;
    end;

    local procedure CreateGroupTotals()
    begin
        FOR j := 1 TO NumberOfTypes DO
            TotalEndingAmounts[j] :=
              GroupStartAmounts[j] + GroupNetChangeAmounts[j] + GroupDisposalAmounts[j];
        BookValueAtEndingDate := 0;
        BookValueAtStartingDate := 0;
        FOR j := 1 TO NumberOfTypes DO
            IF NOT ((j = 7) AND HasDerogatorySetup) THEN BEGIN
                BookValueAtEndingDate := BookValueAtEndingDate + TotalEndingAmounts[j];
                BookValueAtStartingDate := BookValueAtStartingDate + GroupStartAmounts[j];
            END;
    end;

    local procedure CreateTotals()
    begin
        FOR j := 1 TO NumberOfTypes DO
            TotalEndingAmounts[j] :=
              TotalStartAmounts[j] + TotalNetChangeAmounts[j] + TotalDisposalAmounts[j];
        BookValueAtEndingDate := 0;
        BookValueAtStartingDate := 0;
        FOR j := 1 TO NumberOfTypes DO BEGIN
            BookValueAtEndingDate := BookValueAtEndingDate + TotalEndingAmounts[j];
            BookValueAtStartingDate := BookValueAtStartingDate + TotalStartAmounts[j];
        END;
    end;

    local procedure GetStartingDate(StartingDate: Date): Date
    begin
        IF StartingDate <= 00000101D THEN
            EXIT(0D)
        ELSE
            EXIT(StartingDate - 1);
    end;

    procedure SetMandatoryFields(DepreciationBookCodeFrom: Code[10]; StartingDateFrom: Date; EndingDateFrom: Date)
    begin
        DeprBookCodeV := DepreciationBookCodeFrom;
        StartingDateV := StartingDateFrom;
        EndingDateV := EndingDateFrom;
    end;

    procedure SetTotalFields(GroupTotalsFrom: Option; PrintDetailsFrom: Boolean; BudgetReportFrom: Boolean)
    begin
        GroupTotalsV := GroupTotalsFrom;
        PrintDetailsV := PrintDetailsFrom;
        BudgetReportV := BudgetReportFrom;
    end;

    procedure GetDepreciationBookCode()
    begin
        IF DeprBookCodeV = '' THEN BEGIN
            FASetup.GET();
            DeprBookCodeV := FASetup."Default Depr. Book";
        END;
    end;

    procedure GetDeprBookInfo()
    begin
        DeprBookInfo[1] := DeprBookCodeV;
        DeprBookInfo[2] := FORMAT(FADeprBook."Depreciation Method");
        DeprBookInfo[3] := FORMAT(FADeprBook."Depreciation Starting Date");
        DeprBookInfo[4] := FORMAT(FADeprBook."Depreciation Ending Date");
        DeprBookInfo[5] := FORMAT(FADeprBook."Declining-Balance %");
    end;

    procedure GetDerogDeprBookInfo()
    begin
        DerogDeprBookInfo[1] := FADeprBook2."Depreciation Book Code";
        DerogDeprBookInfo[2] := FORMAT(FADeprBook2."Depreciation Method");
        DerogDeprBookInfo[3] := FORMAT(FADeprBook2."Depreciation Starting Date");
        DerogDeprBookInfo[4] := FORMAT(FADeprBook2."Depreciation Ending Date");
        DerogDeprBookInfo[5] := FORMAT(FADeprBook2."Declining-Balance %");
    end;
}

