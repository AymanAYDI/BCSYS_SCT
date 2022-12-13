report 50026 "VSC- Calc. Post VAT Settlement"
{
    // CREATION JX-XAD le 26/03/2009
    // Mise à jour du Report 20
    // 
    // MODIF JX-XAD le 11/03/2011
    // Recherche du n° facture ou avoir pour les factures de vente
    // 
    // MODIF JX-XAD 11/07/2011
    // Afficher le n° facture pour les virements, encaissement, etc... et cela dans la colonne n° facture :
    // - afficher n° document externe pour les facture d'achat
    // - afficher n° docuement pour les factures de vente
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/VSCCalcPostVATSettlement.rdl';

    Caption = 'Calc. and Post VAT Settlement', Comment = 'FRA="Calculer et valider décl. TVA"';
    Permissions = TableData "VAT Entry" = imd;

    dataset
    {
        dataitem("VAT Posting Setup"; 325)
        {
            DataItemTableView = SORTING("VAT Bus. Posting Group", "VAT Prod. Posting Group");
            RequestFilterFields = "VAT Bus. Posting Group", "VAT Prod. Posting Group";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(STRSUBSTNO_Text005_VATDateFilter_; STRSUBSTNO(Text005, VATDateFilter))
            {
            }
            column(CurrReport_PAGENO; '')
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(USERID; USERID)
            {
            }
            column(PostingDate; PostingDate)
            {
            }
            column(DocNo; DocNo)
            {
            }
            column(GLAccSettle__No__; GLAccSettle."No.")
            {
            }
            column(VAT_Posting_Setup__TABLECAPTION__________VATPostingSetupFilter; "VAT Posting Setup".TABLECAPTION + ': ' + VATPostingSetupFilter)
            {
            }
            column(HeaderText; HeaderText)
            {
            }
            column(VATAmount; VATAmount)
            {
                AutoFormatExpression = GetCurrency();
                AutoFormatType = 1;
            }
            column(GDec_VATBase; GDec_VATBase)
            {
                AutoFormatExpression = GetCurrency();
                AutoFormatType = 1;
            }
            column(VATAmount_GDec_VATBase; VATAmount + GDec_VATBase)
            {
                AutoFormatExpression = GetCurrency();
                AutoFormatType = 1;
            }
            column(VATAmountAddCurr; VATAmountAddCurr)
            {
                AutoFormatExpression = GetCurrency();
                AutoFormatType = 1;
            }
            column(GDec_VATBaseAddCurr; GDec_VATBaseAddCurr)
            {
                AutoFormatExpression = GetCurrency();
                AutoFormatType = 1;
            }
            column(VATAmountAddCurr_GDec_VATBaseAddCurr; VATAmountAddCurr + GDec_VATBaseAddCurr)
            {
                AutoFormatExpression = GetCurrency();
                AutoFormatType = 1;
            }
            column(Calc__and_Post_VAT_SettlementCaption; Calc__and_Post_VAT_SettlementCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Test_Report__not_posted_Caption; Test_Report__not_posted_CaptionLbl)
            {
            }
            column(PostingDateCaption; PostingDateCaptionLbl)
            {
            }
            column(DocNoCaption; DocNoCaptionLbl)
            {
            }
            column(GLAccSettle__No__Caption; GLAccSettle__No__CaptionLbl)
            {
            }
            column(Posting_dateCaption; Posting_dateCaptionLbl)
            {
            }
            column(Document_No_Caption; Document_No_CaptionLbl)
            {
            }
            column(VAT_Entry_TypeCaption; "VAT Entry".FIELDCAPTION(Type))
            {
            }
            column(VAT_Entry_BaseCaption; "VAT Entry".FIELDCAPTION(Base))
            {
            }
            column(VAT_Entry_AmountCaption; "VAT Entry".FIELDCAPTION(Amount))
            {
            }
            column(VAT_Entry__VAT_Calculation_Type_Caption; "VAT Entry".FIELDCAPTION("VAT Calculation Type"))
            {
            }
            column(VAT_Entry__Bill_to_Pay_to_No__Caption; "VAT Entry".FIELDCAPTION("Bill-to/Pay-to No."))
            {
            }
            column(Amount_including_VATCaption; Amount_including_VATCaptionLbl)
            {
            }
            column(Invoice_No_Caption; Invoice_No_CaptionLbl)
            {
            }
            column(Application_dateCaption; Application_dateCaptionLbl)
            {
            }
            column(VATAmountCaption; VATAmountCaptionLbl)
            {
            }
            column(VATAmountAddCurrCaption; VATAmountAddCurrCaptionLbl)
            {
            }
            column(VAT_Posting_Setup_VAT_Bus__Posting_Group; "VAT Bus. Posting Group")
            {
            }
            column(VAT_Posting_Setup_VAT_Prod__Posting_Group; "VAT Prod. Posting Group")
            {
            }
            column(PrintVATEntries; PrintVATEntries)
            {
            }
            column(UseAmtsInAddCurr; UseAmtsInAddCurr)
            {
            }
            column(PrintTotalBase; PrintTotalBase)
            {
            }
            column(PrintTotalBaseCurr; PrintTotalBaseCurr)
            {
            }
            dataitem("Closing G/L and VAT Entry"; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                dataitem("VAT Entry"; 254)
                {
                    DataItemTableView = SORTING(Type, Closed) WHERE(Closed = CONST(false), Type = FILTER(Purchase | Sale));
                    column(GDate_PostingDate; GDate_PostingDate)
                    {
                    }
                    column(VAT_Entry__Document_No__; "Document No.")
                    {
                    }
                    column(VAT_Entry_Type; Type)
                    {
                    }
                    column(VAT_Entry_Base; Base)
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(VAT_Entry_Amount; Amount)
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(VAT_Entry__VAT_Calculation_Type_; "VAT Calculation Type")
                    {
                    }
                    column(VAT_Entry__Bill_to_Pay_to_No__; "Bill-to/Pay-to No.")
                    {
                    }
                    column(Base_Amount; Base + Amount)
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(GCode_DocExterne; GCode_DocExterne)
                    {
                    }
                    column(GDate_Lettrage; GDate_Lettrage)
                    {
                    }
                    column(VAT_Entry__Bill_to_Pay_to_No___Control56; "Bill-to/Pay-to No.")
                    {
                    }
                    column(VAT_Entry__VAT_Calculation_Type__Control57; "VAT Calculation Type")
                    {
                    }
                    column(VAT_Entry__Additional_Currency_Amount_; "Additional-Currency Amount")
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(VAT_Entry__Additional_Currency_Base_; "Additional-Currency Base")
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(VAT_Entry_Type_Control62; Type)
                    {
                    }
                    column(VAT_Entry__Document_No___Control64; "Document No.")
                    {
                    }
                    column(GDate_PostingDate_Control65; GDate_PostingDate)
                    {
                    }
                    column(Additional_Currency_Base_____Additional_Currency_Amount__; ("Additional-Currency Base") + ("Additional-Currency Amount"))
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(GCode_DocExterne_Control1000000008; GCode_DocExterne)
                    {
                    }
                    column(GDate_Lettrage_Control1000000010; GDate_Lettrage)
                    {
                    }
                    column(VAT_Entry_Entry_No_; "Entry No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //DEBUT MODIF JX-XAD 26/03/2009
                        IF "VAT Entry"."Document Type" = "VAT Entry"."Document Type"::Invoice THEN BEGIN
                            IF GRec_PurchInvoice.GET("VAT Entry"."Document No.") THEN BEGIN
                                GCode_DocExterne := GRec_PurchInvoice."Vendor Invoice No.";
                                GDate_PostingDate := GRec_PurchInvoice."Posting Date";
                                //DEBUT MODIF JX-XAD le 11/03/2011
                            END ELSE
                                IF GRec_SalesInvoice.GET("VAT Entry"."Document No.") THEN BEGIN
                                    GCode_DocExterne := GRec_SalesInvoice."External Document No.";
                                    GDate_PostingDate := GRec_SalesInvoice."Posting Date";
                                END;
                            //FIN MODIF JX-XAD le 11/03/2011
                        END ELSE
                            IF "VAT Entry"."Document Type" = "VAT Entry"."Document Type"::"Credit Memo" THEN BEGIN
                                IF GRec_PurchCreditMemo.GET("VAT Entry"."Document No.") THEN BEGIN
                                    GCode_DocExterne := GRec_PurchCreditMemo."Vendor Cr. Memo No.";
                                    GDate_PostingDate := GRec_PurchCreditMemo."Posting Date";
                                    //DEBUT MODIF JX-XAD le 11/03/2011
                                END ELSE
                                    IF GRec_SalesCreditMemo.GET("VAT Entry"."Document No.") THEN BEGIN
                                        GCode_DocExterne := GRec_SalesCreditMemo."External Document No.";
                                        GDate_PostingDate := GRec_SalesCreditMemo."Posting Date";
                                    END;
                                //FIN MODIF JX-XAD le 11/03/2011
                                //DEBUT MODIF JX-XAD 11/07/2011
                            END ELSE
                                IF Grec_VAT_Entry.GET("VAT Entry"."Unrealized VAT Entry No.") THEN BEGIN
                                    IF (Grec_VAT_Entry."Document Type" = Grec_VAT_Entry."Document Type"::Invoice) AND
                                       (Grec_VAT_Entry.Type = Grec_VAT_Entry.Type::Purchase) THEN BEGIN
                                        GCode_DocExterne := Grec_VAT_Entry."External Document No.";
                                        GDate_PostingDate := Grec_VAT_Entry."Posting Date";
                                    END ELSE
                                        IF (Grec_VAT_Entry."Document Type" = Grec_VAT_Entry."Document Type"::Invoice) AND
                                  (Grec_VAT_Entry.Type = Grec_VAT_Entry.Type::Sale) THEN BEGIN
                                            GCode_DocExterne := Grec_VAT_Entry."Document No.";
                                            GDate_PostingDate := Grec_VAT_Entry."Posting Date";
                                        END ELSE BEGIN
                                            GCode_DocExterne := '';
                                            GDate_PostingDate := 0D;
                                        END;
                                    //FIN MODIF JX-XAD 11/07/2011
                                END ELSE BEGIN
                                    GCode_DocExterne := '';
                                    GDate_PostingDate := 0D;
                                END;

                        IF "VAT Entry"."Source Code" = 'ACHLETTR' THEN
                            GDate_Lettrage := "VAT Entry"."Posting Date"
                        ELSE
                            GDate_Lettrage := 0D;
                        //FIN MODIF JX-XAD 26/03/2009
                    end;

                    trigger OnPreDataItem()
                    begin
                        "VAT Entry".COPYFILTERS(VATEntry);
                    end;
                }
                dataitem("Close VAT Entries"; 2000000026)
                {
                    DataItemTableView = SORTING(Number);
                    MaxIteration = 1;
                    column(PostingDate_Control28; PostingDate)
                    {
                    }
                    column(GenJnlLine__VAT_Base_Amount_; GenJnlLine."VAT Base Amount")
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(GenJnlLine__VAT_Amount_; GenJnlLine."VAT Amount")
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(FORMAT_GenJnlLine__VAT_Calculation_Type__; FORMAT(GenJnlLine."VAT Calculation Type"))
                    {
                    }
                    column(GenJnlLine__VAT_Base_Amount__GenJnlLine__VAT_Amount_; GenJnlLine."VAT Base Amount" + GenJnlLine."VAT Amount")
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(VAT_Posting_Setup___VAT_Prod__Posting_Group_; "VAT Posting Setup"."VAT Prod. Posting Group")
                    {
                    }
                    column(VAT_Posting_Setup___VAT_Bus__Posting_Group_; "VAT Posting Setup"."VAT Bus. Posting Group")
                    {
                    }
                    column(FORMAT_GenJnlLine__VAT_Calculation_Type___Control69; FORMAT(GenJnlLine."VAT Calculation Type"))
                    {
                    }
                    column(GenJnlLine__Source_Curr__VAT_Amount_; GenJnlLine."Source Curr. VAT Amount")
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(GenJnlLine__Source_Curr__VAT_Base_Amount_; GenJnlLine."Source Curr. VAT Base Amount")
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(PostingDate_Control74; PostingDate)
                    {
                    }
                    column(GenJnlLine__Source_Curr__VAT_Base_Amount__GenJnlLine__Source_Curr__VAT_Amount_; GenJnlLine."Source Curr. VAT Base Amount" + GenJnlLine."Source Curr. VAT Amount")
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(VAT_Posting_Setup___VAT_Prod__Posting_Group__Control1000000014; "VAT Posting Setup"."VAT Prod. Posting Group")
                    {
                    }
                    column(VAT_Posting_Setup___VAT_Bus__Posting_Group__Control1000000018; "VAT Posting Setup"."VAT Bus. Posting Group")
                    {
                    }
                    column(GenJnlLine2_Amount; GenJnlLine2.Amount)
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(PostingDate_Control96; PostingDate)
                    {
                    }
                    column(VAT_Posting_Setup___VAT_Prod__Posting_Group__Control1000000015; "VAT Posting Setup"."VAT Prod. Posting Group")
                    {
                    }
                    column(VAT_Posting_Setup___VAT_Bus__Posting_Group__Control1000000019; "VAT Posting Setup"."VAT Bus. Posting Group")
                    {
                    }
                    column(VATEntry_Base; VATEntry.Base)
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(GenJnlLine2_Amount__VATEntry_Base; GenJnlLine2.Amount + VATEntry.Base)
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(GenJnlLine2__Source_Currency_Amount_; GenJnlLine2."Source Currency Amount")
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(PostingDate_Control89; PostingDate)
                    {
                    }
                    column(VAT_Posting_Setup___VAT_Prod__Posting_Group__Control1000000016; "VAT Posting Setup"."VAT Prod. Posting Group")
                    {
                    }
                    column(VAT_Posting_Setup___VAT_Bus__Posting_Group__Control1000000020; "VAT Posting Setup"."VAT Bus. Posting Group")
                    {
                    }
                    column(VATEntry__Additional_Currency_Base_; VATEntry."Additional-Currency Base")
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(GenJnlLine2__Source_Currency_Amount__VATEntry__Additional_Currency_Base_; GenJnlLine2."Source Currency Amount" + VATEntry."Additional-Currency Base")
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(GenJnlLine__VAT_Base_Amount_Caption; GenJnlLine__VAT_Base_Amount_CaptionLbl)
                    {
                    }
                    column(GenJnlLine__Source_Curr__VAT_Base_Amount_Caption; GenJnlLine__Source_Curr__VAT_Base_Amount_CaptionLbl)
                    {
                    }
                    column(GenJnlLine2_AmountCaption; GenJnlLine2_AmountCaptionLbl)
                    {
                    }
                    column(GenJnlLine2__Source_Currency_Amount_Caption; GenJnlLine2__Source_Currency_Amount_CaptionLbl)
                    {
                    }
                    column(Close_VAT_Entries_Number; Number)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        // Calculate amount and base
                        VATEntry.CALCSUMS(
                          Base, Amount,
                          "Additional-Currency Base", "Additional-Currency Amount");

                        ReversingEntry := FALSE;
                        // Balancing entries to VAT accounts
                        CLEAR(GenJnlLine);
                        GenJnlLine."System-Created Entry" := TRUE;
                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                        CASE VATType OF
                            VATEntry.Type::Purchase.AsInteger():
                                GenJnlLine.Description :=
                                  DELCHR(
                                    STRSUBSTNO(
                                      Text007,
                                      "VAT Posting Setup"."VAT Bus. Posting Group",
                                      "VAT Posting Setup"."VAT Prod. Posting Group"),
                                    '>');
                            VATEntry.Type::Sale.AsInteger():
                                GenJnlLine.Description :=
                                  DELCHR(
                                    STRSUBSTNO(
                                      Text008,
                                      "VAT Posting Setup"."VAT Bus. Posting Group",
                                      "VAT Posting Setup"."VAT Prod. Posting Group"),
                                    '>');
                        END;
                        GenJnlLine."VAT Bus. Posting Group" := "VAT Posting Setup"."VAT Bus. Posting Group";
                        GenJnlLine."VAT Prod. Posting Group" := "VAT Posting Setup"."VAT Prod. Posting Group";
                        GenJnlLine."VAT Calculation Type" := "VAT Posting Setup"."VAT Calculation Type";
                        GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::Settlement;
                        GenJnlLine."Posting Date" := PostingDate;
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := DocNo;
                        GenJnlLine."Source Code" := SourceCodeSetup."VAT Settlement";
                        GenJnlLine."VAT Posting" := GenJnlLine."VAT Posting"::"Manual VAT Entry";
                        CASE "VAT Posting Setup"."VAT Calculation Type" OF
                            "VAT Posting Setup"."VAT Calculation Type"::"Normal VAT",
                            "VAT Posting Setup"."VAT Calculation Type"::"Full VAT":
                                BEGIN
                                    CASE VATType OF
                                        VATEntry.Type::Purchase.AsInteger():
                                            BEGIN
                                                "VAT Posting Setup".TESTFIELD("Purchase VAT Account");
                                                GenJnlLine."Account No." := "VAT Posting Setup"."Purchase VAT Account";
                                            END;
                                        VATEntry.Type::Sale.AsInteger():
                                            BEGIN
                                                "VAT Posting Setup".TESTFIELD("Sales VAT Account");
                                                GenJnlLine."Account No." := "VAT Posting Setup"."Sales VAT Account";
                                            END;
                                    END;
                                    GenJnlLine.Amount := -VATEntry.Amount;
                                    GenJnlLine."VAT Amount" := -VATEntry.Amount;
                                    GenJnlLine."VAT Base Amount" := -VATEntry.Base;
                                    GenJnlLine."Source Currency Code" := GLSetup."Additional Reporting Currency";
                                    GenJnlLine."Source Currency Amount" := -VATEntry."Additional-Currency Amount";
                                    GenJnlLine."Source Curr. VAT Amount" := -VATEntry."Additional-Currency Amount";
                                    GenJnlLine."Source Curr. VAT Base Amount" := -VATEntry."Additional-Currency Base";
                                    IF PostSettlement THEN
                                        PostGenJnlLine(GenJnlLine);
                                    VATAmount := VATAmount + VATEntry.Amount;
                                    VATAmountAddCurr := VATAmountAddCurr + VATEntry."Additional-Currency Amount";
                                    //DEBUT MODIF JX-XAD 31/03/2009
                                    GDec_VATBase := GDec_VATBase + VATEntry.Base;
                                    GDec_VATBaseAddCurr := GDec_VATBaseAddCurr + VATEntry."Additional-Currency Base";
                                    //FIN MODIF JX-XAD 31/03/2009
                                END;
                            "VAT Posting Setup"."VAT Calculation Type"::"Reverse Charge VAT":
                                BEGIN
                                    CASE VATType OF
                                        VATEntry.Type::Purchase.AsInteger():
                                            BEGIN
                                                "VAT Posting Setup".TESTFIELD("Purchase VAT Account");
                                                GenJnlLine."Account No." := "VAT Posting Setup"."Purchase VAT Account";
                                                GenJnlLine.Amount := -VATEntry.Amount;
                                                GenJnlLine."VAT Amount" := -VATEntry.Amount;
                                                GenJnlLine."VAT Base Amount" := -VATEntry.Base;
                                                GenJnlLine."Source Currency Code" := GLSetup."Additional Reporting Currency";
                                                GenJnlLine."Source Currency Amount" := -VATEntry."Additional-Currency Amount";
                                                GenJnlLine."Source Curr. VAT Amount" := -VATEntry."Additional-Currency Amount";
                                                GenJnlLine."Source Curr. VAT Base Amount" := -VATEntry."Additional-Currency Base";
                                                IF PostSettlement THEN
                                                    PostGenJnlLine(GenJnlLine);

                                                "VAT Posting Setup".TESTFIELD("Reverse Chrg. VAT Acc.");
                                                CLEAR(GenJnlLine2);
                                                GenJnlLine2."System-Created Entry" := TRUE;
                                                GenJnlLine2."Account Type" := GenJnlLine2."Account Type"::"G/L Account";
                                                GenJnlLine2.Description := GenJnlLine.Description;
                                                GenJnlLine2."Posting Date" := PostingDate;
                                                GenJnlLine2."Document Type" := GenJnlLine2."Document Type"::" ";
                                                GenJnlLine2."Document No." := DocNo;
                                                GenJnlLine2."Source Code" := SourceCodeSetup."VAT Settlement";
                                                GenJnlLine2."VAT Posting" := GenJnlLine2."VAT Posting"::"Manual VAT Entry";
                                                GenJnlLine2."Account No." := "VAT Posting Setup"."Reverse Chrg. VAT Acc.";
                                                GenJnlLine2.Amount := VATEntry.Amount;
                                                GenJnlLine2."Source Currency Code" := GLSetup."Additional Reporting Currency";
                                                GenJnlLine2."Source Currency Amount" := VATEntry."Additional-Currency Amount";
                                                IF PostSettlement THEN
                                                    PostGenJnlLine(GenJnlLine2);
                                                ReversingEntry := TRUE;
                                            END;
                                        VATEntry.Type::Sale.AsInteger():
                                            BEGIN
                                                "VAT Posting Setup".TESTFIELD("Sales VAT Account");
                                                GenJnlLine."Account No." := "VAT Posting Setup"."Sales VAT Account";
                                                GenJnlLine.Amount := -VATEntry.Amount;
                                                GenJnlLine."VAT Amount" := -VATEntry.Amount;
                                                GenJnlLine."VAT Base Amount" := -VATEntry.Base;
                                                GenJnlLine."Source Currency Code" := GLSetup."Additional Reporting Currency";
                                                GenJnlLine."Source Currency Amount" := -VATEntry."Additional-Currency Amount";
                                                GenJnlLine."Source Curr. VAT Amount" := -VATEntry."Additional-Currency Amount";
                                                GenJnlLine."Source Curr. VAT Base Amount" := -VATEntry."Additional-Currency Base";
                                                IF PostSettlement THEN
                                                    PostGenJnlLine(GenJnlLine);
                                            END;
                                    END;
                                END;
                            "VAT Posting Setup"."VAT Calculation Type"::"Sales Tax":
                                BEGIN
                                    TaxJurisdiction.GET(VATEntry."Tax Jurisdiction Code");
                                    GenJnlLine."Tax Area Code" := TaxJurisdiction.Code;
                                    GenJnlLine."Use Tax" := VATEntry."Use Tax";
                                    CASE VATType OF
                                        VATEntry.Type::Purchase.AsInteger():
                                            IF VATEntry."Use Tax" THEN BEGIN
                                                TaxJurisdiction.TESTFIELD("Tax Account (Purchases)");
                                                GenJnlLine."Account No." := TaxJurisdiction."Tax Account (Purchases)";
                                                GenJnlLine.Amount := -VATEntry.Amount;
                                                GenJnlLine."VAT Amount" := -VATEntry.Amount;
                                                GenJnlLine."VAT Base Amount" := -VATEntry.Base;
                                                GenJnlLine."Source Currency Code" := GLSetup."Additional Reporting Currency";
                                                GenJnlLine."Source Currency Amount" := -VATEntry."Additional-Currency Amount";
                                                GenJnlLine."Source Curr. VAT Amount" := -VATEntry."Additional-Currency Amount";
                                                GenJnlLine."Source Curr. VAT Base Amount" := -VATEntry."Additional-Currency Base";
                                                IF PostSettlement THEN
                                                    PostGenJnlLine(GenJnlLine);

                                                TaxJurisdiction.TESTFIELD("Reverse Charge (Purchases)");
                                                CLEAR(GenJnlLine2);
                                                GenJnlLine2."System-Created Entry" := TRUE;
                                                GenJnlLine2."Account Type" := GenJnlLine2."Account Type"::"G/L Account";
                                                GenJnlLine2.Description := GenJnlLine.Description;
                                                GenJnlLine2."Posting Date" := PostingDate;
                                                GenJnlLine2."Document Type" := GenJnlLine2."Document Type"::" ";
                                                GenJnlLine2."Document No." := DocNo;
                                                GenJnlLine2."Source Code" := SourceCodeSetup."VAT Settlement";
                                                GenJnlLine2."VAT Posting" := GenJnlLine2."VAT Posting"::"Manual VAT Entry";
                                                GenJnlLine2."Tax Area Code" := TaxJurisdiction.Code;
                                                GenJnlLine2."Use Tax" := VATEntry."Use Tax";
                                                GenJnlLine2."Account No." := TaxJurisdiction."Reverse Charge (Purchases)";
                                                GenJnlLine2.Amount := VATEntry.Amount;
                                                GenJnlLine2."Source Currency Code" := GLSetup."Additional Reporting Currency";
                                                GenJnlLine2."Source Currency Amount" := VATEntry."Additional-Currency Amount";
                                                IF PostSettlement THEN
                                                    PostGenJnlLine(GenJnlLine2);
                                                ReversingEntry := TRUE;
                                            END ELSE BEGIN
                                                TaxJurisdiction.TESTFIELD("Tax Account (Purchases)");
                                                GenJnlLine."Account No." := TaxJurisdiction."Tax Account (Purchases)";
                                                GenJnlLine.Amount := -VATEntry.Amount;
                                                GenJnlLine."VAT Amount" := -VATEntry.Amount;
                                                GenJnlLine."VAT Base Amount" := -VATEntry.Base;
                                                GenJnlLine."Source Currency Code" := GLSetup."Additional Reporting Currency";
                                                GenJnlLine."Source Currency Amount" := -VATEntry."Additional-Currency Amount";
                                                GenJnlLine."Source Curr. VAT Amount" := -VATEntry."Additional-Currency Amount";
                                                GenJnlLine."Source Curr. VAT Base Amount" := -VATEntry."Additional-Currency Base";
                                                IF PostSettlement THEN
                                                    PostGenJnlLine(GenJnlLine);
                                                VATAmount := VATAmount + VATEntry.Amount;
                                                VATAmountAddCurr := VATAmountAddCurr + VATEntry."Additional-Currency Amount";
                                                GDec_VATBase := GDec_VATBase + VATEntry.Base;
                                                GDec_VATBaseAddCurr := GDec_VATBaseAddCurr + VATEntry."Additional-Currency Base";
                                            END;
                                        VATEntry.Type::Sale.AsInteger():
                                            BEGIN
                                                TaxJurisdiction.TESTFIELD("Tax Account (Sales)");
                                                GenJnlLine."Account No." := TaxJurisdiction."Tax Account (Sales)";
                                                GenJnlLine.Amount := -VATEntry.Amount;
                                                GenJnlLine."VAT Amount" := -VATEntry.Amount;
                                                GenJnlLine."VAT Base Amount" := -VATEntry.Base;
                                                GenJnlLine."Source Currency Code" := GLSetup."Additional Reporting Currency";
                                                GenJnlLine."Source Currency Amount" := -VATEntry."Additional-Currency Amount";
                                                GenJnlLine."Source Curr. VAT Amount" := -VATEntry."Additional-Currency Amount";
                                                GenJnlLine."Source Curr. VAT Base Amount" := -VATEntry."Additional-Currency Base";
                                                IF PostSettlement THEN
                                                    PostGenJnlLine(GenJnlLine);
                                                VATAmount := VATAmount + VATEntry.Amount;
                                                VATAmountAddCurr := VATAmountAddCurr + VATEntry."Additional-Currency Amount";
                                                GDec_VATBase := GDec_VATBase + VATEntry.Base;
                                                GDec_VATBaseAddCurr := GDec_VATBaseAddCurr + VATEntry."Additional-Currency Base";
                                            END;
                                    END;
                                END;
                        END;
                        NextVATEntryNo := NextVATEntryNo + 1;

                        // Close current VAT entries
                        IF PostSettlement THEN
                            IF VATEntry.FIND('-') THEN
                                REPEAT
                                    VATEntry2 := VATEntry;
                                    VATEntry2."Closed by Entry No." := NextVATEntryNo;
                                    VATEntry2.Closed := TRUE;
                                    VATEntry2.MODIFY();
                                UNTIL VATEntry.NEXT() = 0;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    VATEntry.RESET();
                    IF NOT
                      VATEntry.SETCURRENTKEY(
                        Type, Closed, "VAT Bus. Posting Group", "VAT Prod. Posting Group", "Posting Date")
                    THEN
                        VATEntry.SETCURRENTKEY(
                          Type, Closed, "Tax Jurisdiction Code", "Use Tax", "Posting Date");
                    VATEntry.SETRANGE(Type, VATType);
                    VATEntry.SETRANGE(Closed, FALSE);
                    VATEntry.SETFILTER("Posting Date", VATDateFilter);
                    VATEntry.SETRANGE("VAT Bus. Posting Group", "VAT Posting Setup"."VAT Bus. Posting Group");
                    VATEntry.SETRANGE("VAT Prod. Posting Group", "VAT Posting Setup"."VAT Prod. Posting Group");

                    CASE "VAT Posting Setup"."VAT Calculation Type" OF
                        "VAT Posting Setup"."VAT Calculation Type"::"Normal VAT",
                        "VAT Posting Setup"."VAT Calculation Type"::"Reverse Charge VAT",
                        "VAT Posting Setup"."VAT Calculation Type"::"Full VAT":
                            BEGIN
                                IF FindFirstEntry THEN BEGIN
                                    IF NOT VATEntry.FIND('-') THEN
                                        REPEAT
                                            VATType := VATType + 1;
                                            VATEntry.SETRANGE(Type, VATType);
                                        UNTIL (VATType = VATEntry.Type::Settlement.AsInteger()) OR VATEntry.FIND('-');
                                    FindFirstEntry := FALSE;
                                END ELSE BEGIN
                                    IF VATEntry.NEXT() = 0 THEN
                                        REPEAT
                                            VATType := VATType + 1;
                                            VATEntry.SETRANGE(Type, VATType);
                                        UNTIL (VATType = VATEntry.Type::Settlement.AsInteger()) OR VATEntry.FIND('-');
                                END;
                                IF VATType < VATEntry.Type::Settlement.AsInteger() THEN
                                    VATEntry.FIND('+');
                            END;
                        "VAT Posting Setup"."VAT Calculation Type"::"Sales Tax":
                            BEGIN
                                IF FindFirstEntry THEN BEGIN
                                    IF NOT VATEntry.FIND('-') THEN
                                        REPEAT
                                            VATType := VATType + 1;
                                            VATEntry.SETRANGE(Type, VATType);
                                        UNTIL (VATType = VATEntry.Type::Settlement.AsInteger()) OR VATEntry.FIND('-');
                                    FindFirstEntry := FALSE;
                                END ELSE BEGIN
                                    VATEntry.SETRANGE("Tax Jurisdiction Code");
                                    VATEntry.SETRANGE("Use Tax");
                                    IF VATEntry.NEXT() = 0 THEN
                                        REPEAT
                                            VATType := VATType + 1;
                                            VATEntry.SETRANGE(Type, VATType);
                                        UNTIL (VATType = VATEntry.Type::Settlement.AsInteger()) OR VATEntry.FIND('-');
                                END;
                                IF VATType < VATEntry.Type::Settlement.AsInteger() THEN BEGIN
                                    VATEntry.SETRANGE("Tax Jurisdiction Code", VATEntry."Tax Jurisdiction Code");
                                    VATEntry.SETRANGE("Use Tax", VATEntry."Use Tax");
                                    VATEntry.FindLast();
                                END;
                            END;
                    END;

                    IF VATType = VATEntry.Type::Settlement.AsInteger() THEN
                        CurrReport.BREAK();
                end;

                trigger OnPreDataItem()
                begin
                    VATType := VATEntry.Type::Purchase.AsInteger();
                    FindFirstEntry := TRUE;
                end;
            }

            trigger OnPostDataItem()
            begin
                // Post to settlement account
                IF VATAmount <> 0 THEN BEGIN
                    GenJnlLine.INIT();
                    GenJnlLine."System-Created Entry" := TRUE;
                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";

                    GLAccSettle.TESTFIELD("Gen. Posting Type", GenJnlLine."Gen. Posting Type"::" ");
                    GLAccSettle.TESTFIELD("VAT Bus. Posting Group", '');
                    GLAccSettle.TESTFIELD("VAT Prod. Posting Group", '');
                    IF VATPostingSetup.GET(GLAccSettle."VAT Bus. Posting Group", GLAccSettle."VAT Prod. Posting Group") THEN
                        VATPostingSetup.TESTFIELD("VAT %", 0);
                    GLAccSettle.TESTFIELD("Gen. Bus. Posting Group", '');
                    GLAccSettle.TESTFIELD("Gen. Prod. Posting Group", '');

                    GenJnlLine.VALIDATE("Account No.", GLAccSettle."No.");
                    GenJnlLine."Posting Date" := PostingDate;
                    GenJnlLine2."Document Type" := GenJnlLine2."Document Type"::" ";
                    GenJnlLine."Document No." := DocNo;
                    GenJnlLine.Description := Text004;
                    GenJnlLine.Amount := VATAmount;
                    GenJnlLine."Source Currency Code" := GLSetup."Additional Reporting Currency";
                    GenJnlLine."Source Currency Amount" := VATAmountAddCurr;
                    GenJnlLine."Source Code" := SourceCodeSetup."VAT Settlement";
                    GenJnlLine."VAT Posting" := GenJnlLine."VAT Posting"::"Manual VAT Entry";
                    IF PostSettlement THEN
                        PostGenJnlLine(GenJnlLine);
                END;
            end;

            trigger OnPreDataItem()
            begin
                GLEntry.LOCKTABLE(); // Avoid deadlock with function 12
                IF RECORDLEVELLOCKING THEN
                    IF GLEntry.FIND('+') THEN;
                VATEntry.LOCKTABLE();
                VATEntry.RESET();
                IF VATEntry.FIND('+') THEN
                    NextVATEntryNo := VATEntry."Entry No.";

                SourceCodeSetup.GET();
                GLSetup.GET();
                VATAmount := 0;
                VATAmountAddCurr := 0;

                IF PostSettlement AND NOT Initialized THEN
                    IF NOT CONFIRM(Text003, FALSE) THEN
                        CurrReport.BREAK();
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(EntrdStartDate; EntrdStartDate)
                {
                    Caption = 'Starting Date', Comment = 'FRA="Date début"';
                    ApplicationArea = All;
                }
                field(EndDateReq; EndDateReq)
                {
                    Caption = 'Ending Date', Comment = 'FRA="Date fin"';
                    ApplicationArea = All;
                }
                field(PostingDate; PostingDate)
                {
                    Caption = 'Posting Date', Comment = 'FRA="Date comptabilisation"';
                    ApplicationArea = All;
                }
                field(DocNo; DocNo)
                {
                    Caption = 'Document No.', Comment = 'FRA="N° document"';
                    ApplicationArea = All;
                }
                field(AccSettle; GLAccSettle."No.")
                {
                    Caption = 'Settlement Account', Comment = 'FRA="Compte de déclaration"';
                    TableRelation = "G/L Account";
                    ApplicationArea = All;
                }
                field(PrintVATEntries; PrintVATEntries)
                {
                    Caption = 'Show VAT Entries', Comment = 'FRA="Afficher écritures TVA"';
                    ApplicationArea = All;
                }
                field(Post; PostSettlement)
                {
                    Caption = 'Post', Comment = 'FRA="Valider"';
                    ApplicationArea = All;
                }
                field(UseAmtsInAddCurr; UseAmtsInAddCurr)
                {
                    Caption = 'Show Amounts in Add. Reporting Currency', Comment = 'FRA="Afficher montants en devise report"';
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        IF PostingDate = 0D THEN
            ERROR(Text000);
        IF DocNo = '' THEN
            ERROR(Text001);
        IF GLAccSettle."No." = '' THEN
            ERROR(Text002);
        GLAccSettle.FIND();

        VATPostingSetupFilter := "VAT Posting Setup".GETFILTERS;
        IF EndDateReq = 0D THEN
            VATEntry.SETFILTER("Posting Date", '%1..', EntrdStartDate)
        ELSE
            VATEntry.SETRANGE("Posting Date", EntrdStartDate, EndDateReq);
        VATDateFilter := VATEntry.GETFILTER("Posting Date");

        PrintTotalBase := NOT UseAmtsInAddCurr;
        PrintTotalBaseCurr := UseAmtsInAddCurr;
    end;

    var
        Text000: Label 'Please enter the posting date.', Comment = 'FRA="Veuillez saisir une date de comptabilisation."';
        Text001: Label 'Please enter the document no.', Comment = 'FRA="Veuillez saisir un numéro de document."';
        Text002: Label 'Please enter the settlement account', Comment = 'FRA="Veuillez saisir un compte de déclaration."';
        Text003: Label 'Do you want to calculate and post the VAT Settlement?', Comment = 'FRA="Souhaitez-vous calculer et valider la déclaration de TVA ?"';
        Text004: Label 'VAT Settlement', Comment = 'FRA="Déclaration de TVA"';
        Text005: Label 'Period: %1', Comment = 'FRA="Période : %1"';
        Text006: Label 'All amounts are in %1', Comment = 'FRA="Tous les montants sont en %1"';
        Text007: Label 'Purchase VAT settlement: #1######## #2########', Comment = 'FRA="Déclaration de TVA achats: #1######## #2########"';
        Text008: Label 'Sales VAT settlement  : #1######## #2########', Comment = 'FRA="Déclaration de TVA ventes  : #1######## #2########"';
        GLAccSettle: Record "G/L Account";
        SourceCodeSetup: Record "Source Code Setup";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlLine2: Record "Gen. Journal Line";
        GLEntry: Record "G/L Entry";
        VATEntry: Record "VAT Entry";
        VATEntry2: Record "VAT Entry";
        TaxJurisdiction: Record "Tax Jurisdiction";
        GLSetup: Record "General Ledger Setup";
        VATPostingSetup: Record "VAT Posting Setup";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        EntrdStartDate: Date;
        EndDateReq: Date;
        PrintVATEntries: Boolean;
        NextVATEntryNo: Integer;
        PostingDate: Date;
        DocNo: Code[20];
        VATType: Integer;
        VATAmount: Decimal;
        VATAmountAddCurr: Decimal;
        PostSettlement: Boolean;
        FindFirstEntry: Boolean;
        ReversingEntry: Boolean;
        Initialized: Boolean;
        VATPostingSetupFilter: Text[250];
        VATDateFilter: Text[50];
        UseAmtsInAddCurr: Boolean;
        HeaderText: Text[50];
        GCode_DocExterne: Code[50];
        GRec_PurchInvoice: Record "Purch. Inv. Header";
        GRec_PurchCreditMemo: Record "Purch. Cr. Memo Hdr.";
        GDate_PostingDate: Date;
        GDate_Lettrage: Date;
        GDec_VATBase: Decimal;
        GDec_VATBaseAddCurr: Decimal;
        GRec_SalesInvoice: Record "Sales Invoice Header";
        GRec_SalesCreditMemo: Record "Sales Cr.Memo Header";
        Grec_VAT_Entry: Record "VAT Entry";
        Calc__and_Post_VAT_SettlementCaptionLbl: Label 'Calc. and Post VAT Settlement', Comment = 'FRA="Calculer et valider décl. TVA"';
        CurrReport_PAGENOCaptionLbl: Label 'Page', Comment = 'FRA="Page"';
        Test_Report__not_posted_CaptionLbl: Label 'Test Report (not posted)', Comment = 'FRA="Impression test (non validée)"';
        PostingDateCaptionLbl: Label 'Posting Date', Comment = 'FRA="Date comptabilisation"';
        DocNoCaptionLbl: Label 'Document No.', Comment = 'FRA="N° document"';
        GLAccSettle__No__CaptionLbl: Label 'Settlement Account', Comment = 'FRA="Compte de déclaration"';
        Posting_dateCaptionLbl: Label 'Posting date', Comment = 'FRA="Date Comptabilisation"';
        Document_No_CaptionLbl: Label 'Document No.', Comment = 'FRA="N° document"';
        Amount_including_VATCaptionLbl: Label 'Amount including VAT', Comment = 'FRA="Montant TTC"';
        Invoice_No_CaptionLbl: Label 'Invoice No.', Comment = 'FRA="N° facture"';
        Application_dateCaptionLbl: Label 'Application date', Comment = 'FRA="Date de lettrage"';
        VATAmountCaptionLbl: Label 'Total', Comment = 'FRA="Total"';
        VATAmountAddCurrCaptionLbl: Label 'Total', Comment = 'FRA="Total"';
        GenJnlLine__VAT_Base_Amount_CaptionLbl: Label 'Settlement', Comment = 'FRA="Déclaration"';
        GenJnlLine__Source_Curr__VAT_Base_Amount_CaptionLbl: Label 'Settlement', Comment = 'FRA="Déclaration"';
        GenJnlLine2_AmountCaptionLbl: Label 'Settlement', Comment = 'FRA="Déclaration"';
        GenJnlLine2__Source_Currency_Amount_CaptionLbl: Label 'Settlement', Comment = 'FRA="Déclaration"';
        PrintTotalBase: Boolean;
        PrintTotalBaseCurr: Boolean;

    procedure InitializeRequest(NewStartDate: Date; NewEndDate: Date; NewPostingDate: Date; NewDocNo: Code[20]; NewSettlementAcc: Code[20]; ShowVATEntries: Boolean; Post: Boolean)
    begin
        EntrdStartDate := NewStartDate;
        EndDateReq := NewEndDate;
        PostingDate := NewPostingDate;
        DocNo := NewDocNo;
        GLAccSettle."No." := NewSettlementAcc;
        PrintVATEntries := ShowVATEntries;
        PostSettlement := Post;
        Initialized := TRUE;
    end;

    procedure GetCurrency(): Code[10]
    begin
        IF UseAmtsInAddCurr THEN
            EXIT(GLSetup."Additional Reporting Currency")
        ELSE
            EXIT('');
    end;

    local procedure PostGenJnlLine(var GenJnlLine: Record "Gen. Journal Line")
    var
        DimMgt: Codeunit DimensionManagement;
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        TableID[1] := DATABASE::"G/L Account";
        TableID[2] := DATABASE::"G/L Account";
        No[1] := GenJnlLine."Account No.";
        No[2] := GenJnlLine."Bal. Account No.";
        GenJnlLine."Dimension Set ID" :=
             DimMgt.GetDefaultDimID(
             TableID, No, GenJnlLine."Source Code",
             GenJnlLine."Shortcut Dimension 1 Code", GenJnlLine."Shortcut Dimension 2 Code", 0, 0);
        GenJnlPostLine.RUN(GenJnlLine);
    end;
}

