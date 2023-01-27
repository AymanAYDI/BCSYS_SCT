report 50067 "VSC Fixed Asset - Analysis New"
{
    // NAVW13.10,JX-VSC1.0-XAD
    // 
    // CREATION JX-XAD 19/12/2008
    // Créé à partir du report 5600
    // 
    // MODIF JX-XAD 17/04/2009
    // Ajout du champ "FA location code"
    // 
    // MODIF JX-XAD 08/06/2009
    // Traitement des axes analytiques pour les sociétés VSC et Agence (Trigger OnAfterGetRecord)
    // Traduction en anglais ==> Création de constantes de texte pour le request form
    // 
    // ------------------------------- V 1.2 -------------------------------
    // 
    // MODIF JX-XAD 04/01/2010
    // Test sur les dates de début et de fin
    // 
    // MODIF JX-XAD 04/02/2010
    // Ajout d'une coche dans l'onglet options du request form pour afficher ou non la partie en-tête du report
    // et cela dans le but d'exporter l'état dans Excel.
    // 
    // // modif LAB du 18/08/2010
    // // Modif du chmap dans les section (groupe compta immo) car mal calculé
    // 
    // MODIF JX-XAD 15/04/2011
    // Traitement des axes analytiques VFEC
    // 
    // //Modif JX-AUD du 23/08/11
    // //Insertion du datatitem Depreciation book pour prendre en compte toutes les lois en même temps
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/VSCFixedAssetAnalysisNew.rdl';
    Caption = 'Immobilisations - Analyse VSC NEW', Comment = 'FRA="Immobilisations - Analyse VSC NEW"';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Depreciation Book"; "Depreciation Book")
        {
            DataItemTableView = SORTING(Code);
            RequestFilterFields = "Code";
            dataitem("Fixed Asset"; "Fixed Asset")
            {
                RequestFilterFields = "No.", "FA Class Code", "FA Subclass Code", "Budgeted Asset";
                column(Depreciation_Book_Code; "Depreciation Book".Code)
                {
                }
                column(MainHeadLineText; MainHeadLineText)
                {
                }
                column(Gtxt_CompanyName; Gtxt_CompanyName)
                {
                }
                column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
                {
                }
                column("USERID"; USERID)
                {
                }
                column(DeprBookText; DeprBookText)
                {
                }
                column(Fixed_Asset__TABLECAPTION_________FAFilter; "Fixed Asset".TABLECAPTION + ': ' + FAFilter)
                {
                }
                column(GroupHeadLine; GroupHeadLine)
                {
                }
                column(Fixed_Asset__No__; "No.")
                {
                }
                column(Fixed_Asset_Description; Description)
                {
                }
                column(Amounts_2_; Amounts[2])
                {
                    AutoFormatType = 1;
                }
                column(Amounts_3_; Amounts[3])
                {
                    AutoFormatType = 1;
                }
                column(Fixed_Asset__Fixed_Asset___FA_Subclass_Code_; "Fixed Asset"."FA Subclass Code")
                {
                }
                column(Fixed_Asset__Fixed_Asset___Serial_No__; "Fixed Asset"."Serial No.")
                {
                }
                column(Gcode_Axe1; Gcode_Axe1)
                {
                }
                column(Gcode_Axe3; Gcode_Axe3)
                {
                }
                column(Gcode_Axe4; Gcode_Axe4)
                {
                }
                column(Fixed_Asset__FA_Posting_Group_; "FA Posting Group")
                {
                }
                column(Gcode_Axe2; Gcode_Axe2)
                {
                }
                column(Gdec_TxAmtCompt; Gdec_TxAmtCompt)
                {
                    AutoFormatType = 1;
                }
                column(Date_2_; Date[2])
                {
                }
                column(Date_1_; Date[1])
                {
                }
                column("Gdec_NbAnnéeAmt"; Gdec_NbAnnéeAmt)
                {
                    AutoFormatType = 1;
                }
                column(Amounts_1_; Amounts[1])
                {
                    AutoFormatType = 1;
                }
                column("Gdate_DébutAmort"; Gdate_DébutAmort)
                {
                }
                column(Gdate_FinAmort; Gdate_FinAmort)
                {
                }
                column(Amounts_4_; Amounts[4])
                {
                    AutoFormatType = 1;
                }
                column(Fixed_Asset__Fixed_Asset___FA_Location_Code_; "Fixed Asset"."FA Location Code")
                {
                }
                column(GroupAmounts_1_; GroupAmounts[1])
                {
                    AutoFormatType = 1;
                }
                column(GroupAmounts_2_; GroupAmounts[2])
                {
                    AutoFormatType = 1;
                }
                column(GroupAmounts_3_; GroupAmounts[3])
                {
                    AutoFormatType = 1;
                }
                column(Text002__________GroupHeadLine; Text002 + ': ' + GroupHeadLine)
                {
                }
                column(GroupAmounts_4_; GroupAmounts[4])
                {
                    AutoFormatType = 1;
                }
                column(TotalAmounts_1_; TotalAmounts[1])
                {
                    AutoFormatType = 1;
                }
                column(TotalAmounts_2_; TotalAmounts[2])
                {
                    AutoFormatType = 1;
                }
                column(TotalAmounts_3_; TotalAmounts[3])
                {
                    AutoFormatType = 1;
                }
                column(TotalAmounts_4_; TotalAmounts[4])
                {
                    AutoFormatType = 1;
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(Dim__1Caption; Dim__1CaptionLbl)
                {
                }
                column(Dim__2Caption; Dim__2CaptionLbl)
                {
                }
                column(Dim__3Caption; Dim__3CaptionLbl)
                {
                }
                column(Dim__4Caption; Dim__4CaptionLbl)
                {
                }
                column(Serial_No_Caption; Serial_No_CaptionLbl)
                {
                }
                column(Subclass_codeCaption; Subclass_codeCaptionLbl)
                {
                }
                column(AccountCaption; AccountCaptionLbl)
                {
                }
                column(Count__Deprec__DurationCaption; Count__Deprec__DurationCaptionLbl)
                {
                }
                column(Count__deprec__rateCaption; Count__deprec__rateCaptionLbl)
                {
                }
                column(Deprec__start__dateCaption; Deprec__start__dateCaptionLbl)
                {
                }
                column(Loc__codeCaption; Loc__codeCaptionLbl)
                {
                }
                column(Card_No_Caption; Card_No_CaptionLbl)
                {
                }
                column(Disposal_dateCaption; Disposal_dateCaptionLbl)
                {
                }
                column(DescriptionCaption; DescriptionCaptionLbl)
                {
                }
                column(Countable_basisCaption; Countable_basisCaptionLbl)
                {
                }
                column(Acq__dateCaption; Acq__dateCaptionLbl)
                {
                }
                column(Accumulated_depreciation_earlier_periodCaption; Accumulated_depreciation_earlier_periodCaptionLbl)
                {
                }
                column(Accumulated_depreciation_periodCaption; Accumulated_depreciation_periodCaptionLbl)
                {
                }
                column(Total_depreciationCaption; Total_depreciationCaptionLbl)
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(Fixed_Asset_FA_Class_Code; "FA Class Code")
                {
                }
                column(Fixed_Asset_Global_Dimension_1_Code; "Global Dimension 1 Code")
                {
                }
                column(Fixed_Asset_Global_Dimension_2_Code; "Global Dimension 2 Code")
                {
                }
                column(Fixed_Asset_Component_of_Main_Asset; "Component of Main Asset")
                {
                }
                column(Deprec__ending__dateCaptionLbl; Deprec__ending__dateCaptionLbl)
                {
                }
                column(Gcode_CodeFournisseur; Gcode_CodeFournisseur)
                {
                }
                column(Text014; Text014)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF NOT FADeprBook.GET("No.", DeprBookCode) THEN
                        CurrReport.SKIP();
                    IF SkipRecord() THEN
                        CurrReport.SKIP();

                    IF GroupTotals = GroupTotals::"FA Posting Group" THEN
                        IF "FA Posting Group" <> FADeprBook."FA Posting Group" THEN
                            ERROR(Text009, FIELDCAPTION("FA Posting Group"), "No.");

                    Date[1] :=
                      FAGenReport.GetLastDate(
                        "No.", DateTypeNo1, EndingDate, DeprBookCode, FALSE);
                    Date[2] :=
                      FAGenReport.GetLastDate(
                        "No.", DateTypeNo2, EndingDate, DeprBookCode, FALSE);

                    BeforeAmount := 0;
                    EndingAmount := 0;
                    IF BudgetReport THEN
                        BudgetDepreciation.Calculate(
                          "No.", GetStartDate(StartingDate), EndingDate, DeprBookCode, BeforeAmount, EndingAmount);

                    IF SetAmountToZero(PostingTypeNo1, Period1) THEN
                        Amounts[1] := 0
                    ELSE
                        Amounts[1] :=
                          FAGenReport.CalcFAPostedAmount(
                            "No.", PostingTypeNo1, Period1, StartingDate, EndingDate,
                            DeprBookCode, BeforeAmount, EndingAmount, FALSE, FALSE);

                    IF SetAmountToZero(PostingTypeNo2, Period2) THEN
                        Amounts[2] := 0
                    ELSE
                        Amounts[2] :=
                          FAGenReport.CalcFAPostedAmount(
                            "No.", PostingTypeNo2, Period2, StartingDate, EndingDate,
                            DeprBookCode, BeforeAmount, EndingAmount, FALSE, FALSE);

                    IF SetAmountToZero(PostingTypeNo3, Period3) THEN
                        Amounts[3] := 0
                    ELSE
                        Amounts[3] :=
                          FAGenReport.CalcFAPostedAmount(
                            "No.", PostingTypeNo3, Period3, StartingDate, EndingDate,
                            DeprBookCode, BeforeAmount, EndingAmount, FALSE, FALSE);

                    //DEBUT MODIF JX-XAD 19/12/2008
                    IF SetAmountToZero(PostingTypeNo4, Period4) THEN
                        Amounts[4] := 0
                    ELSE
                        Amounts[4] :=
                          FAGenReport.CalcFAPostedAmount(
                            "No.", PostingTypeNo4, Period4, StartingDate, EndingDate,
                            DeprBookCode, BeforeAmount, EndingAmount, FALSE, FALSE);


                    Gcode_Axe1 := '';
                    Gcode_Axe2 := '';
                    Gcode_Axe3 := '';
                    Gcode_Axe4 := '';

                    //DEBUT MODIF JX-XAD 08/06/2009
                    //IF Grec_AxeAnalytique.GET(5600,"Fixed Asset"."No.",'ORGANISATION') THEN
                    //  Gcode_Axe1 := Grec_AxeAnalytique."Dimension Value Code";
                    //IF Grec_AxeAnalytique.GET(5600,"Fixed Asset"."No.",'CLIENT') THEN
                    //  Gcode_Axe2 := Grec_AxeAnalytique."Dimension Value Code";
                    //IF Grec_AxeAnalytique.GET(5600,"Fixed Asset"."No.",'PRODUIT') THEN
                    //  Gcode_Axe3 := Grec_AxeAnalytique."Dimension Value Code";
                    //IF Grec_AxeAnalytique.GET(5600,"Fixed Asset"."No.",'PROJET') THEN
                    //  Gcode_Axe4 := Grec_AxeAnalytique."Dimension Value Code";

                    CASE COMPANYNAME OF
                        'VSCT', 'VSCT Test':
                            BEGIN
                                IF Grec_AxeAnalytique.GET(5600, "Fixed Asset"."No.", 'ORGANISATION') THEN
                                    Gcode_Axe1 := Grec_AxeAnalytique."Dimension Value Code";
                                IF Grec_AxeAnalytique.GET(5600, "Fixed Asset"."No.", 'CLIENT') THEN
                                    Gcode_Axe2 := Grec_AxeAnalytique."Dimension Value Code";
                                IF Grec_AxeAnalytique.GET(5600, "Fixed Asset"."No.", 'PRODUIT') THEN
                                    Gcode_Axe3 := Grec_AxeAnalytique."Dimension Value Code";
                                IF Grec_AxeAnalytique.GET(5600, "Fixed Asset"."No.", 'PROJET') THEN
                                    Gcode_Axe4 := Grec_AxeAnalytique."Dimension Value Code";
                            END;
                        'VSC', 'VSC Test':
                            BEGIN
                                IF Grec_AxeAnalytique.GET(5600, "Fixed Asset"."No.", 'TYPE') THEN
                                    Gcode_Axe1 := Grec_AxeAnalytique."Dimension Value Code";
                                IF Grec_AxeAnalytique.GET(5600, "Fixed Asset"."No.", 'BU-PROJET') THEN
                                    Gcode_Axe2 := Grec_AxeAnalytique."Dimension Value Code";
                                IF Grec_AxeAnalytique.GET(5600, "Fixed Asset"."No.", 'DEPARTEMENT') THEN
                                    Gcode_Axe3 := Grec_AxeAnalytique."Dimension Value Code";
                            END;
                        'Agence', 'Agence Test':
                            BEGIN
                                IF Grec_AxeAnalytique.GET(5600, "Fixed Asset"."No.", 'TYPE') THEN
                                    Gcode_Axe1 := Grec_AxeAnalytique."Dimension Value Code";
                                IF Grec_AxeAnalytique.GET(5600, "Fixed Asset"."No.", 'PRODUITS') THEN
                                    Gcode_Axe2 := Grec_AxeAnalytique."Dimension Value Code";
                                IF Grec_AxeAnalytique.GET(5600, "Fixed Asset"."No.", 'DEPARTEMENT') THEN
                                    Gcode_Axe3 := Grec_AxeAnalytique."Dimension Value Code";
                            END;
                        //DEBUT MODIF JX-XAD 15/04/2011
                        'VFEC', 'VFEC Test':
                            BEGIN
                                IF Grec_AxeAnalytique.GET(5600, "Fixed Asset"."No.", 'BUDGET') THEN
                                    Gcode_Axe1 := Grec_AxeAnalytique."Dimension Value Code";
                                IF Grec_AxeAnalytique.GET(5600, "Fixed Asset"."No.", 'SERVICE') THEN
                                    Gcode_Axe2 := Grec_AxeAnalytique."Dimension Value Code";
                            END;
                    //FIN MODIF JX-XAD 15/04/2011
                    END;
                    //FIN MODIF JX-XAD 08/06/2009

                    Gdec_NbAnnéeAmt := 0;
                    Gdec_TxAmtCompt := 0;
                    Gdate_DébutAmort := 0D;
                    //BCSYS 170320
                    Gdate_FinAmort := 0D;

                    IF Grec_PlanAmortissement.GET("Fixed Asset"."No.", DeprBookCode) THEN BEGIN
                        IF Grec_PlanAmortissement."No. of Depreciation Years" <> 0 THEN
                            Gdec_NbAnnéeAmt := Grec_PlanAmortissement."No. of Depreciation Years"
                        ELSE
                            //DEBUT MODIF JX-XAD 04/01/2010
                            IF (Grec_PlanAmortissement."Depreciation Ending Date" <> 0D) AND (Grec_PlanAmortissement."Depreciation Starting Date" <> 0D) THEN
                                //FIN MODIF JX-XAD 04/01/2010
                                Gdec_NbAnnéeAmt := (Grec_PlanAmortissement."Depreciation Ending Date" - Grec_PlanAmortissement."Depreciation Starting Date");
                        IF Gdec_NbAnnéeAmt <> 0 THEN
                            Gdec_TxAmtCompt := 100 / Gdec_NbAnnéeAmt;
                        Gdate_DébutAmort := Grec_PlanAmortissement."Depreciation Starting Date";
                        //BCSYS 17032020
                        Gdate_FinAmort := Grec_PlanAmortissement."Depreciation Ending Date";
                    END;
                    //FIN MODIF JX-XAD 19/12/2008

                    //BCSYS 060520
                    //traitement code fournisseur
                    Grec_LedgerEntry.SETFILTER(Grec_LedgerEntry."FA No.", "No.");
                    Grec_LedgerEntry.SETFILTER(Grec_LedgerEntry."FA Posting Type", FORMAT(Grec_LedgerEntry."FA Posting Type"::"Acquisition Cost"));
                    Grec_LedgerEntry.SETFILTER(Grec_LedgerEntry."Document Type", FORMAT(Grec_LedgerEntry."Document Type"::Invoice));

                    IF Grec_LedgerEntry.FIND('-') THEN
                        IF Grec_PurchInvHeader.GET(Grec_LedgerEntry."Document No.") THEN
                            Gcode_CodeFournisseur := Grec_PurchInvHeader."Buy-from Vendor No."
                        ELSE
                            Gcode_CodeFournisseur := '';
                    //FIN BCSYS 060520
                end;

                trigger OnPreDataItem()
                begin
                    //Modif JX-AUD du 23/08/11
                    DeprBookCode := "Depreciation Book".Code;
                    DeprBookText := STRSUBSTNO('%1%2 %3', DeprBook.TABLECAPTION, ':', DeprBookCode);
                    //Fin modif JX-AUD du 23/08/11

                    CASE GroupTotals OF
                        GroupTotals::"FA Class":
                            SETCURRENTKEY("FA Class Code");
                        GroupTotals::"FA Subclass":
                            SETCURRENTKEY("FA Subclass Code");
                        GroupTotals::"Main Asset":
                            SETCURRENTKEY("Component of Main Asset");
                        GroupTotals::"Global Dimension 1":
                            SETCURRENTKEY("Global Dimension 1 Code");
                        GroupTotals::"FA Location":
                            SETCURRENTKEY("FA Location Code");
                        GroupTotals::"Global Dimension 2":
                            SETCURRENTKEY("Global Dimension 2 Code");
                        GroupTotals::"FA Posting Group":
                            SETCURRENTKEY("FA Posting Group");
                    END;
                    FAPostingType.CreateTypes();
                    FADateType.CreateTypes();
                    CheckDateType(DateType1, DateTypeNo1);
                    CheckDateType(DateType2, DateTypeNo2);
                    CheckPostingType(PostingType1, PostingTypeNo1);
                    CheckPostingType(PostingType2, PostingTypeNo2);
                    CheckPostingType(PostingType3, PostingTypeNo3);
                    CheckPostingType(PostingType4, PostingTypeNo4);  //Ajout JX-XAD 31/12/2008
                    MakeGroupTotalText();
                    FAGenReport.ValidateDates(StartingDate, EndingDate);
                    MakeDateHeadLine();
                    MakeAmountHeadLine(3, PostingType1, PostingTypeNo1, Period1);
                    MakeAmountHeadLine(4, PostingType2, PostingTypeNo2, Period2);
                    MakeAmountHeadLine(5, PostingType3, PostingTypeNo3, Period3);
                    MakeAmountHeadLine(6, PostingType4, PostingTypeNo4, Period4);  //Ajout JX-XAD 31/12/2008
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Date Début"; StartingDate)
                {
                    ApplicationArea = All;
                    Caption = 'Date Début', Comment = 'FRA="Date Début"';
                }
                field("Date Fin"; EndingDate)
                {
                    ApplicationArea = All;
                    Caption = 'Date Fin', Comment = 'FRA="Date Fin"';
                }
                field("Afficher Entête"; Gbool_AfficherEnTete)
                {
                    ApplicationArea = All;
                    Caption = 'Afficher Entête', Comment = 'FRA="Afficher Entête"';
                }
            }
        }
        trigger OnOpenPage()
        begin

            IF DeprBookCode = '' THEN BEGIN
                FASetup.GET();
                DeprBookCode := FASetup."Default Depr. Book";
            END;
            FAPostingType.CreateTypes();
            FADateType.CreateTypes();

            //DEBUT MODIF JX-XAD 31/12/2008
            //Initialisation du report
            PrintDetails := TRUE;
            DateType1 := Text_DateType1;        //'Date cession';
            DateType2 := Text_DateType2;        //'Date acquisition';
            PostingType1 := Text_PostingType1;  //'Amortissement';
            PostingType2 := Text_PostingType2;  //'Amortissement';
            PostingType3 := Text_PostingType3;  //'Amortissement';
            PostingType4 := Text_PostingType4;  //'Coût acquisition';
            Period1 := Period1::"before Starting Date";
            Period2 := Period2::"Net Change";
            Period3 := Period3::"at Ending Date";
            Period4 := Period4::"at Ending Date";
            //FIN MODIF JX-XAD 31/12/2008
        end;
    }
    trigger OnPreReport()
    begin
        DeprBook.GET(DeprBookCode);
        IF GroupTotals = GroupTotals::"FA Posting Group" THEN
            FAGenReport.SetFAPostingGroup("Fixed Asset", DeprBook.Code);
        FAGenReport.AppendFAPostingFilter("Fixed Asset", StartingDate, EndingDate);
        FAFilter := "Fixed Asset".GETFILTERS;
        MainHeadLineText := Text000;
        IF BudgetReport THEN
            MainHeadLineText := STRSUBSTNO('%1 %2', MainHeadLineText, Text001);
        //Modif JX-AUD du 03/08/11
        //DeprBookText := STRSUBSTNO('%1%2 %3',DeprBook.TABLECAPTION,':',DeprBookCode);
        //Fin modif JX-AUD du 03/08/11
        IF PrintDetails THEN BEGIN
            FANo := "Fixed Asset".FIELDCAPTION("No.");
            FADescription := "Fixed Asset".FIELDCAPTION(Description);
        END;
    end;

    var
        Grec_AxeAnalytique: Record "Default Dimension";
        DeprBook: Record "Depreciation Book";
        FADateType: Record "FA Date Type";
        FADeprBook: Record "FA Depreciation Book";
        Grec_PlanAmortissement: Record "FA Depreciation Book";
        Grec_LedgerEntry: Record "FA Ledger Entry";
        FAPostingType: Record "FA Posting Type";
        FASetup: Record "FA Setup";
        Grec_PurchInvHeader: Record "Purch. Inv. Header";
        BudgetDepreciation: Codeunit "Budget Depreciation";
        FAGenReport: Codeunit "FA General Report";
        BudgetReport: Boolean;
        Gbool_AfficherEnTete: Boolean;
        PrintDetails: Boolean;
        SalesReport: Boolean;
        TypeExist: Boolean;
        DeprBookCode: Code[10];
        Gcode_Axe1: Code[20];
        Gcode_Axe2: Code[20];
        Gcode_Axe3: Code[20];
        Gcode_Axe4: Code[20];
        Gcode_CodeFournisseur: Code[20];
        AcquisitionDate: Date;
        Date: array[2] of Date;
        DisposalDate: Date;
        EndingDate: Date;
        "Gdate_DébutAmort": Date;
        Gdate_FinAmort: Date;
        StartingDate: Date;
        Amounts: array[4] of Decimal;
        BeforeAmount: Decimal;
        EndingAmount: Decimal;
        "Gdec_NbAnnéeAmt": Decimal;
        Gdec_TxAmtCompt: Decimal;
        GroupAmounts: array[4] of Decimal;
        TotalAmounts: array[4] of Decimal;
        DateTypeNo1: Integer;
        DateTypeNo2: Integer;
        PostingTypeNo1: Integer;
        PostingTypeNo2: Integer;
        PostingTypeNo3: Integer;
        PostingTypeNo4: Integer;
        AccountCaptionLbl: Label 'Account', Comment = 'FRA="Compte"';
        Accumulated_depreciation_earlier_periodCaptionLbl: Label 'Accumulated depreciation earlier period', Comment = 'FRA="Cumul amt antérieur période"';
        Accumulated_depreciation_periodCaptionLbl: Label 'Accumulated depreciation period', Comment = 'FRA="Cumul amt période"';
        Acq__dateCaptionLbl: Label 'Acq. date', Comment = 'FRA="Date acq."';
        Card_No_CaptionLbl: Label 'Card No.', Comment = 'FRA="N° de fiche"';
        Count__Deprec__DurationCaptionLbl: Label 'Count. Deprec. Duration', Comment = 'FRA="Durée Amt Compt"';
        Count__deprec__rateCaptionLbl: Label 'Count. deprec. rate', Comment = 'FRA="Tx Amt Compt"';
        Countable_basisCaptionLbl: Label 'Countable basis', Comment = 'FRA="Base comptable"';
        CurrReport_PAGENOCaptionLbl: Label 'Page', Comment = 'FRA="Page"';
        Deprec__ending__dateCaptionLbl: Label 'Deprec. ending date', Comment = 'FRA="Date fin amort."';
        Deprec__start__dateCaptionLbl: Label 'Deprec. start. date', Comment = 'FRA="Date début amort."';
        DescriptionCaptionLbl: Label 'Description', Comment = 'FRA="Libellé"';
        Dim__1CaptionLbl: Label 'Dim. 1', Comment = 'FRA="AXE 1"';
        Dim__2CaptionLbl: Label 'Dim. 2', Comment = 'FRA="AXE 2"';
        Dim__3CaptionLbl: Label 'Dim. 3', Comment = 'FRA="AXE 3"';
        Dim__4CaptionLbl: Label 'Dim. 4', Comment = 'FRA="AXE 4"';
        Disposal_dateCaptionLbl: Label 'Disposal date', Comment = 'FRA="Date de cession"';
        Loc__codeCaptionLbl: Label 'Loc. code', Comment = 'FRA="Code empl"';
        Serial_No_CaptionLbl: Label 'Serial No.', Comment = 'FRA="N° Série"';
        Subclass_codeCaptionLbl: Label 'Subclass code', Comment = 'FRA="Code sous-classe immo"';
        Text000: Label 'Fixed Asset - Analysis', Comment = 'FRA="Immobilisations - Analyse"';
        Text001: Label '(Budget Report)', Comment = 'FRA="(Etat budget)"';
        Text002: Label 'Group Total', Comment = 'FRA="Sous-total"';
        Text003: Label 'Sold', Comment = 'FRA="Vendu"';
        Text004: Label 'Group Totals: %1', Comment = 'FRA="Sous-totaux : %1"';
        Text005: Label '%1 or %2 must be specified only together with the option %3.', Comment = 'FRA="%1 et %2 ne doivent être défini(e)s qu''avec l''option %3."';
        Text006: Label 'The Starting Date must be specified when you use the option %1.', Comment = 'FRA="La date début ne doit être définie que lorsque l''option %1 est utilisée."';
        Text007: Label 'The date type %1 is not a valid option.', Comment = 'FRA="Le type date %1 n''est pas une option valide."';
        Text008: Label 'The posting type %1 is not a valid option.', Comment = 'FRA="Le type de comptabilisation %1 n''est pas une option valide."';
        Text009: Label '%1 has been modified in fixed asset %2', Comment = 'FRA="%1 a été modifié(e) dans l''immobilisation %2"';
        Text010: Label 'before Starting Date,Net Change,at Ending Date', Comment = 'FRA="Avant date début,Solde période,En date fin"';
        Text011: Label ' ,FA Class,FA Subclass,FA Location,Main Asset,Global Dimension 1,Global Dimension 2,FA Posting Group', Comment = 'FRA=" ,Classe immo.,Sous-classe immo.,Emplacement immo.,Immo. principale,Axe principal 1,Axe principal 2,Groupe compta. immo."';
        Text014: Label 'Vendor Code', Comment = 'FRA="Code fournisseur"';
        Text_DateType1: Label 'Disposal Date', Comment = 'FRA="Date cession"';
        Text_DateType2: Label 'Acquisition Date', Comment = 'FRA="Date acquisition"';
        Text_PostingType1: Label 'Depreciation', Comment = 'FRA="Amortissement"';
        Text_PostingType2: Label 'Depreciation', Comment = 'FRA="Amortissement"';
        Text_PostingType3: Label 'Depreciation', Comment = 'FRA="Amortissement"';
        Text_PostingType4: Label 'Acquisition Cost', Comment = 'FRA="Coût acquisition"';
        Total_depreciationCaptionLbl: Label 'Total depreciation', Comment = 'FRA="Total AMT"';
        TotalCaptionLbl: Label 'Total', Comment = 'FRA="Total"';
        GroupTotals: Option " ","FA Class","FA Subclass","FA Location","Main Asset","Global Dimension 1","Global Dimension 2","FA Posting Group";
        Period1: Option "before Starting Date","Net Change","at Ending Date";
        Period2: Option "before Starting Date","Net Change","at Ending Date";
        Period3: Option "before Starting Date","Net Change","at Ending Date";
        Period4: Option "before Starting Date","Net Change","at Ending Date";
        DateType1: Text[30];
        DateType2: Text[30];
        PostingType1: Text[30];
        PostingType2: Text[30];
        PostingType3: Text[30];
        PostingType4: Text[30];
        DeprBookText: Text[50];
        FADescription: Text[50];
        FANo: Text[50];
        GroupCodeName: Text[50];
        GroupHeadLine: Text[50];
        Gtxt_CompanyName: Text[50];
        HeadLineText: array[6] of Text[50];
        MainHeadLineText: Text[100];
        FAFilter: Text[250];

    local procedure SkipRecord(): Boolean
    begin
        AcquisitionDate := FADeprBook."Acquisition Date";
        DisposalDate := FADeprBook."Disposal Date";

        IF "Fixed Asset".Inactive THEN
            EXIT(TRUE);
        IF (AcquisitionDate = 0D) THEN
            EXIT(TRUE);
        IF (AcquisitionDate > EndingDate) AND (EndingDate > 0D) THEN
            EXIT(TRUE);
        IF SalesReport AND (DisposalDate = 0D) THEN
            EXIT(TRUE);
        IF SalesReport AND (EndingDate > 0D) AND
          ((DisposalDate > EndingDate) OR (DisposalDate < StartingDate))
        THEN
            EXIT(TRUE);

        IF NOT SalesReport AND (DisposalDate > 0D) AND (DisposalDate < StartingDate) THEN
            EXIT(TRUE);
        EXIT(FALSE);
    end;

    local procedure SetSalesMark(): Text[30]
    begin
        IF DisposalDate > 0D THEN
            IF (EndingDate = 0D) OR (DisposalDate <= EndingDate) THEN
                EXIT(Text003);
        EXIT('');
    end;

    local procedure MakeGroupTotalText()
    begin
        CASE GroupTotals OF
            GroupTotals::"FA Class":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("FA Class Code");
            GroupTotals::"FA Subclass":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("FA Subclass Code");
            GroupTotals::"Main Asset":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("Main Asset/Component");
            GroupTotals::"Global Dimension 1":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("Global Dimension 1 Code");
            GroupTotals::"FA Location":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("FA Location Code");
            GroupTotals::"Global Dimension 2":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("Global Dimension 2 Code");
            GroupTotals::"FA Posting Group":
                GroupCodeName := "Fixed Asset".FIELDCAPTION("FA Posting Group");
        END;
        IF GroupCodeName <> '' THEN
            GroupCodeName := STRSUBSTNO(Text004, GroupCodeName);
    end;

    local procedure MakeDateHeadLine()
    begin
        IF NOT PrintDetails THEN
            EXIT;
        HeadLineText[1] := DateType1;
        HeadLineText[2] := DateType2;
    end;

    local procedure MakeAmountHeadLine(i: Integer; PostingType: Text[50]; PostingTypeNo: Integer; Period: Option "before Starting Date","Net Change","at Ending Date")
    begin
        IF PostingTypeNo = 0 THEN
            EXIT;
        CASE PostingTypeNo OF
            FADeprBook.FIELDNO("Proceeds on Disposal"),
          FADeprBook.FIELDNO("Gain/Loss"):
                IF Period <> Period::"at Ending Date" THEN BEGIN
                    Period := Period::"at Ending Date";
                    ERROR(
                      Text005,
                      FADeprBook.FIELDCAPTION("Proceeds on Disposal"),
                      FADeprBook.FIELDCAPTION("Gain/Loss"),
                      SELECTSTR(Period + 1, Text010));
                END;
        END;
        IF Period = Period::"before Starting Date" THEN
            IF StartingDate = 0D THEN
                ERROR(
                  Text006, SELECTSTR(Period + 1, Text010));

        HeadLineText[i] := STRSUBSTNO('%1 %2', PostingType, SELECTSTR(Period + 1, Text010));
    end;

    local procedure MakeGroupHeadLine()
    begin
        CASE GroupTotals OF
            GroupTotals::"FA Class":
                GroupHeadLine := "Fixed Asset"."FA Class Code";
            GroupTotals::"FA Subclass":
                GroupHeadLine := "Fixed Asset"."FA Subclass Code";
            GroupTotals::"Main Asset":
                BEGIN
                    GroupHeadLine := STRSUBSTNO('%1 %2', SELECTSTR(GroupTotals + 1, Text011), "Fixed Asset"."Component of Main Asset");
                    IF "Fixed Asset"."Component of Main Asset" = '' THEN
                        GroupHeadLine := GroupHeadLine + '*****';
                END;
            GroupTotals::"Global Dimension 1":
                GroupHeadLine := "Fixed Asset"."Global Dimension 1 Code";
            GroupTotals::"FA Location":
                GroupHeadLine := "Fixed Asset"."FA Location Code";
            GroupTotals::"Global Dimension 2":
                GroupHeadLine := "Fixed Asset"."Global Dimension 2 Code";
            GroupTotals::"FA Posting Group":
                GroupHeadLine := "Fixed Asset"."FA Posting Group";
        END;
        IF GroupHeadLine = '' THEN
            GroupHeadLine := '*****';
    end;

    local procedure SetAmountToZero(PostingTypeNo: Integer; Period: Option "before Starting Date","Net Change","at Ending Date"): Boolean
    begin
        CASE PostingTypeNo OF
            FADeprBook.FIELDNO("Proceeds on Disposal"),
          FADeprBook.FIELDNO("Gain/Loss"):
                EXIT(FALSE);
        END;
        IF NOT SalesReport AND (Period = Period::"at Ending Date") AND (SetSalesMark() <> '') THEN
            EXIT(TRUE);
        EXIT(FALSE);
    end;

    local procedure GetStartDate(StartDate: Date): Date
    begin
        IF StartDate <= 00000101D THEN
            EXIT(0D)
        ELSE
            EXIT(StartDate - 1);
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

    local procedure CheckPostingType(var PostingType: Text[30]; var PostingTypeNo: Integer)
    begin
        PostingTypeNo := 0;
        IF PostingType = '' THEN
            EXIT;
        FAPostingType.SETRANGE("FA Entry", TRUE);
        IF FAPostingType.FIND('-') THEN
            REPEAT
                TypeExist := PostingType = FAPostingType."FA Posting Type Name";
                IF TypeExist THEN
                    PostingTypeNo := FAPostingType."FA Posting Type No.";
            UNTIL (FAPostingType.NEXT() = 0) OR TypeExist;
        IF NOT TypeExist THEN
            ERROR(Text008, PostingType);
    end;
}

