report 50003 "BC6_Avoir Achat"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/AvoirAchat.rdl';
    Caption = 'Purchase - Credit Memo', Comment = 'FRA="Achats : Avoir fournisseur"';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Purch. Inv. Header"; 124)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Posted Purchase Invoice';
            column(No_PurchHeader; "No.")
            {
            }
            column(InvDiscAmtCaption; InvDiscAmtCaptionLbl)
            {
            }
            column(AllowInvDiscCaption; AllowInvDiscCaptionLbl)
            {
            }
            column(NoCaption; NoCaptionlbl)
            {
            }
            column(RemImp; RemImplbl)
            {
            }
            column(RemImp2; RemImp2lbl)
            {
            }
            column(RemImp3; RemImp3lbl)
            {
            }
            column(VATDetail; VATDetailV)
            {
            }
            column(VALVATBaseLCYCaption; VALVATBaseLCYCaptionLbl)
            {
            }
            column(VATAmtLineVATAmtCaption; VATAmtLineVATAmtCaptionLbl)
            {
            }
            column(VATAmtSpecCaption; VATAmtSpecCaptionLbl)
            {
            }
            column(VATAmtLineInvDiscBaseAmtCaption; VATAmtLineInvDiscBaseAmtCaptionLbl)
            {
            }
            column(Pied1; Pied1lbl)
            {
            }
            column(Pied2; Pied2)
            {
            }
            column(Pied3; Pied3)
            {
            }
            column(Pied4; Pied4)
            {
            }
            column(Pied5; Pied5)
            {
            }
            column(Pied6; Pied6)
            {
            }
            dataitem(CopyLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(ReportTitleCopyText; STRSUBSTNO(Text004, CopyText))
                    {
                    }
                    column(OrderNoCaption; OrderNoCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(DocumentDateCaption; DocumentDateCaptionLbl)
                    {
                    }
                    column(PaymentTermsDescCaption; PaymentTermsDescCaptionLbl)
                    {
                    }
                    column(ShipmentMethodDescCaption; ShipmentMethodDescCaptionLbl)
                    {
                    }
                    column(PaymentMethodCaption; PaymentMethodCaptionLbl)
                    {
                    }
                    column(PaymentTermsDesc; PaymentTerms.Description)
                    {
                    }
                    column(ShipmentMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    column(PaymentMethod; PaymentMethod.Description)
                    {
                    }
                    column(DocCaptionCopyText; OrderNoCaptionLbl)
                    {
                    }
                    column(VendAddr1; VendAddr[1])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(VendAddr2; VendAddr[2])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(VendAddr3; VendAddr[3])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(VendAddr4; VendAddr[4])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(VendAddr5; VendAddr[5])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(VendAddr6; VendAddr[6])
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoEMail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(HomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(EMail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoPicture; CompanyInfo.Picture)
                    {
                    }
                    column(PayToVendNo_PurchHeader; "Purch. Inv. Header"."Pay-to Vendor No.")
                    {
                    }
                    column(DocDate_PurchHeader; FORMAT("Purch. Inv. Header"."Posting Date"))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_PurchHeader; "Purch. Inv. Header"."VAT Registration No.")
                    {
                    }
                    column(DueDate_PurchInvHeader; FORMAT("Purch. Inv. Header"."Due Date"))
                    {
                    }
                    column(PurchaserText; PurchaserText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(RefText; ReferenceText)
                    {
                    }
                    column(YourRef_PurchHeader; "Purch. Inv. Header"."Your Reference")
                    {
                    }
                    column(OrderNoText; OrderNoText)
                    {
                    }
                    column(VendAddr7; VendAddr[7])
                    {
                    }
                    column(VendAddr8; VendAddr[8])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(PostingDate_PurchHeader; FORMAT("Purch. Inv. Header"."Posting Date"))
                    {
                    }
                    column(PricesInclVAT_PurchHeader; "Purch. Inv. Header"."Prices Including VAT")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(ShowInternalInfo; ShowInternalInfo)
                    {
                    }
                    column(VATBaseDisc_PurchHeader; "Purch. Inv. Header"."VAT Base Discount %")
                    {
                    }
                    column(PricesInclVATtxt; PricesInclVATtxt)
                    {
                    }
                    column(BuyFromVendNo_PurchHeader; "Purch. Inv. Header"."Buy-from Vendor No.")
                    {
                    }
                    column(PhoneNoCaption; PhoneNoCaptionLbl)
                    {
                    }
                    column(HomePageCaption; HomePageCaptionLbl)
                    {
                    }
                    column(EMailCaption; EMailCaptionLbl)
                    {
                    }
                    column(VATRegNoCaption; VATRegNoCaptionLbl)
                    {
                    }
                    column(GiroNoCaption; GiroNoCaptionLbl)
                    {
                    }
                    column(BankNameCaption; BankNameCaptionLbl)
                    {
                    }
                    column(BankAccNoCaption; BankAccNoCaptionLbl)
                    {
                    }
                    column(DueDateCaption; DueDateCaptionLbl)
                    {
                    }
                    column(InvoiceNoCaption; InvoiceNoCaptionLbl)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(PostingDateCaption; PostingDateCaptionLbl)
                    {
                    }
                    column(PaymentTermsCaption; PaymentTermsCaptionLbl)
                    {
                    }
                    column(ShipmentMethodCaption; ShipmentMethodCaptionLbl)
                    {
                    }
                    column(DocDateCaption; DocDateCaptionLbl)
                    {
                    }
                    column(PayToVendNo_PurchInvHeaderCaption; "Purch. Inv. Header".FIELDCAPTION("Pay-to Vendor No."))
                    {
                    }
                    column(PricesIncVAT_PurchInvHeaderCaption; "Purch. Inv. Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    column(BuyFromVendNo_PurchInvHeaderCaption; "Purch. Inv. Header".FIELDCAPTION("Buy-from Vendor No."))
                    {
                    }
                    column(BuyFromAddr1; BuyFromAddr[1])
                    {
                    }
                    column(BuyFromAddr2; BuyFromAddr[2])
                    {
                    }
                    column(BuyFromAddr3; BuyFromAddr[3])
                    {
                    }
                    column(BuyFromAddr4; BuyFromAddr[4])
                    {
                    }
                    column(BuyFromAddr5; BuyFromAddr[5])
                    {
                    }
                    column(BuyFromAddr6; BuyFromAddr[6])
                    {
                    }
                    column(BuyFromAddr7; BuyFromAddr[7])
                    {
                    }
                    column(BuyFromAddr8; BuyFromAddr[8])
                    {
                    }
                    column(ShipToAddressCaption; ShiptoAddressCaptionLbl)
                    {
                    }
                    column(ShipToAddr1; ShipToAddr[1])
                    {
                    }
                    column(ShipToAddr2; ShipToAddr[2])
                    {
                    }
                    column(ShipToAddr3; ShipToAddr[3])
                    {
                    }
                    column(ShipToAddr4; ShipToAddr[4])
                    {
                    }
                    column(ShipToAddr5; ShipToAddr[5])
                    {
                    }
                    column(ShipToAddr6; ShipToAddr[6])
                    {
                    }
                    column(ShipToAddr7; ShipToAddr[7])
                    {
                    }
                    column(ShipToAddr8; ShipToAddr[8])
                    {
                    }
                    column(BuyFrmVendNo_PurchHeader; "Purch. Inv. Header"."Buy-from Vendor No.")
                    {
                    }
                    column(BuyFrmVendNo_PurchHeaderCaption; "Purch. Inv. Header".FIELDCAPTION("Buy-from Vendor No."))
                    {
                    }
                    column(PricesInclVAT_PurchHeaderCaption; "Purch. Inv. Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    column(CompanyInfoPhoneNoCaption; CompanyInfoPhoneNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoVATRegNoCaption; CompanyInfoVATRegNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoGiroNoCaption; CompanyInfoGiroNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankNameCaption; CompanyInfoBankNameCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankAccNoCaption; CompanyInfoBankAccNoCaptionLbl)
                    {
                    }
                    column(EmailIDCaption; EmailIDCaptionLbl)
                    {
                    }
                    column(Acheteur; "Purch. Inv. Header"."User ID")
                    {
                    }
                    dataitem(DimensionLoop1; 2000000026)
                    {
                        DataItemLinkReference = "Purch. Inv. Header";
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(DimText_DimensionLoop1; DimText)
                        {
                        }
                        column(HeaderDimensionsCaption; HeaderDimensionsCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DimSetEntry1.FINDSET() THEN
                                    CurrReport.BREAK();
                            END ELSE
                                IF NOT Continue THEN
                                    CurrReport.BREAK();

                            CLEAR(DimText);
                            Continue := FALSE;
                            REPEAT
                                OldDimText := DimText;
                                IF DimText = '' THEN
                                    DimText := STRSUBSTNO('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                END;
                            UNTIL DimSetEntry1.NEXT() = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowInternalInfo THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem("Purch. Inv. Line"; 125)
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purch. Inv. Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(LineAmt_PurchLine; "Line Amount")
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(Desc_PurchLine; Description)
                        {
                        }
                        column(Type_PurchLine; Type)
                        {
                        }
                        column(No_PurchLine; "No.")
                        {
                        }
                        column(Qty_PurchLine; Quantity)
                        {
                        }
                        column(UOM_PurchLine; "Unit of Measure")
                        {
                        }
                        column(DirUnitCost_PurchLine; "Direct Unit Cost")
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 2;
                        }
                        column(DirectCost; "Direct Unit Cost")
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 2;
                        }
                        column(LineDisc_PurchLine; "Line Discount %")
                        {
                        }
                        column(InvDiscAmt_PurchLine; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(AllowInvDisc_PurchInvLine; "Allow Invoice Disc.")
                        {
                        }
                        column(VATIdentifier_PurchLine; "VAT Identifier")
                        {
                        }
                        column(LineNo_PurchLine; "Line No.")
                        {
                        }
                        column(VATPercent; "VAT %")
                        {
                        }
                        column(LineAmt2_PurchLine; "Line Amount")
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(AllowVATDisctxt; AllowVATDisctxt)
                        {
                        }
                        column(PurchInLineTypeNo; PurchInLineTypeNo)
                        {
                        }
                        column(VATAmtText; VATAmountText)
                        {
                        }
                        column(NegInvDiscAmt_PurchInvLine; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(PurchInvLineAmt; Amount)
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(AmountIncVAT; "Amount Including VAT")
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(AmtIncVATAmt_PurchLine; "Amount Including VAT" - Amount)
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(VATAmountText; TempVATAmountLine.VATAmountText())
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(NegLineAmtInvDiscAmtAmtIncVAT_PurchInvLine; -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT"))
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATDiscountAmount; -VATDiscountAmount)
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(TotalSubTotal; TotalSubTotal)
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvoiceDiscountAmount; TotalInvoiceDiscountAmount)
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmount; TotalAmount)
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountVAT; TotalAmountVAT)
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount; TotalAmountVAT)
                        {
                        }
                        column(VATAmountLine; VATAmount)
                        {
                        }
                        column(TotalPaymentDiscOnVAT; TotalPaymentDiscountOnVAT)
                        {
                            AutoFormatType = 1;
                        }
                        column(DirectUnitCostCaption; DirectUnitCostCaptionLbl)
                        {
                        }
                        column(DiscountPctCaption; DiscountPctCaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(PymtDiscOnVATCaption; PymtDiscOnVATCaptionLbl)
                        {
                        }
                        column(Desc_PurchLineCaption; FIELDCAPTION(Description))
                        {
                        }
                        column(No_PurchInvLineCaption; FIELDCAPTION("No."))
                        {
                        }
                        column(QtyCaption; FIELDCAPTION(Quantity))
                        {
                        }
                        column(UOM_PurchLineCaption; FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(VATIdentifier_PurchLineCaption; FIELDCAPTION("VAT Identifier"))
                        {
                        }
                        column(DirectUniCostCaption; DirectUniCostCaptionLbl)
                        {
                        }
                        column(PurchLineLineDiscCaption; PurchLineLineDiscCaptionLbl)
                        {
                        }
                        column(VATAmtLineVATCaption; VATAmtLineVATCaptionLbl)
                        {
                        }
                        column(VATAmtLineLineAmtCaption; VATAmtLineLineAmtCaptionLbl)
                        {
                        }
                        column(LigHT; LigHTlbl)
                        {
                        }
                        column(LigTTC; LigTTClbl)
                        {
                        }
                        column(LigTVA; LigTVAlbl)
                        {
                        }
                        column(PurchLineInvDiscAmtCaption; PurchLineInvDiscAmtCaptionLbl)
                        {
                        }
                        column(VATDiscountAmountCaption; VATDiscountAmountCaptionLbl)
                        {
                        }
                        dataitem(DimensionLoop2; 2000000026)
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                            column(DimText_DimensionLoop2; DimText)
                            {
                            }
                            column(LineDimensionsCaption; LineDimensionsCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT DimSetEntry2.FINDSET() THEN
                                        CurrReport.BREAK();
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK();

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText := STRSUBSTNO('%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL DimSetEntry2.NEXT() = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT ShowInternalInfo THEN
                                    CurrReport.BREAK();

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Purch. Inv. Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF (Type = Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "No." := '';

                            TempVATAmountLine.INIT();
                            TempVATAmountLine."VAT Identifier" := "VAT Identifier";
                            TempVATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            TempVATAmountLine."Tax Group Code" := "Tax Group Code";
                            TempVATAmountLine."Use Tax" := "Use Tax";
                            TempVATAmountLine."VAT %" := "VAT %";
                            TempVATAmountLine."VAT Base" := Amount;
                            TempVATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            TempVATAmountLine."Line Amount" := "Line Amount";
                            IF "Allow Invoice Disc." THEN
                                TempVATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            TempVATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            TempVATAmountLine.InsertLine();

                            AllowVATDisctxt := FORMAT("Allow Invoice Disc.");
                            PurchInLineTypeNo := Type.AsInteger();

                            VATAmount := "Amount Including VAT" - Amount;
                            TotalSubTotal += "Line Amount";
                            TotalInvoiceDiscountAmount -= "Inv. Discount Amount";
                            TotalAmount += Amount;
                            TotalAmountVAT += "Amount Including VAT" - Amount;
                            TotalAmountInclVAT += "Amount Including VAT";
                            TotalPaymentDiscountOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");
                        end;

                        trigger OnPreDataItem()
                        var
                            PurchInvLine: Record "Purch. Inv. Line";
                            VATIdentifier: Code[10];
                        begin
                            TempVATAmountLine.DELETEALL();
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) AND (Amount = 0) DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK();
                            SETRANGE("Line No.", 0, "Line No.");

                            PurchInvLine.SETRANGE("Document No.", "Purch. Inv. Header"."No.");
                            PurchInvLine.SETFILTER(Type, '<>%1', 0);
                            VATAmountText := '';
                            IF PurchInvLine.FIND('-') THEN BEGIN
                                VATAmountText := STRSUBSTNO(Text017, PurchInvLine."VAT %");
                                VATIdentifier := PurchInvLine."VAT Identifier";
                                REPEAT
                                    IF (PurchInvLine."VAT Identifier" <> VATIdentifier) AND (PurchInvLine.Quantity <> 0) THEN
                                        VATAmountText := Text018;
                                UNTIL PurchInvLine.NEXT() = 0;
                            END;
                        end;
                    }
                    dataitem(VATCounter; 2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmtLineVATBase; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; TempVATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATPercentageCaption; VATPercentageCaptionLbl)
                        {
                        }
                        column(VATBaseCaption; VATBaseCaptionLbl)
                        {
                        }
                        column(VATAmtCaption; VATAmtCaptionLbl)
                        {
                        }
                        column(VATAmtSpecificationCaption; VATAmtSpecificationCaptionLbl)
                        {
                        }
                        column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(LineAmtCaption; LineAmtCaptionLbl)
                        {
                        }
                        column(VATIdentifierCaption; VATIdentifierCaptionLbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE(Number, 1, TempVATAmountLine.COUNT);
                        end;
                    }
                    dataitem(VATCounterLCY; 2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT_VATCounterLCY; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier_VATCounterLCY; TempVATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              TempVATAmountLine.GetBaseLCY(
                                "Purch. Inv. Header"."Posting Date", "Purch. Inv. Header"."Currency Code",
                                "Purch. Inv. Header"."Currency Factor");
                            VALVATAmountLCY :=
                              TempVATAmountLine.GetAmountLCY(
                                "Purch. Inv. Header"."Posting Date", "Purch. Inv. Header"."Currency Code",
                                "Purch. Inv. Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Purch. Inv. Header"."Currency Code" = '')
                            THEN
                                CurrReport.BREAK();

                            SETRANGE(Number, 1, TempVATAmountLine.COUNT);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text007 + Text008
                            ELSE
                                VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Purch. Inv. Header"."Posting Date", "Purch. Inv. Header"."Currency Code", 1);
                            CalculatedExchRate := ROUND(1 / "Purch. Inv. Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                            VALExchRate := STRSUBSTNO(Text009, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; 2000000026)
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    }
                    dataitem(Total2; 2000000026)
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                        trigger OnPreDataItem()
                        begin
                            IF "Purch. Inv. Header"."Buy-from Vendor No." = "Purch. Inv. Header"."Pay-to Vendor No." THEN
                                CurrReport.BREAK();
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN BEGIN
                        OutputNo := OutputNo + 1;
                        CopyText := Text003;
                    END;
                    TotalSubTotal := 0;
                    TotalInvoiceDiscountAmount := 0;
                    TotalAmount := 0;
                    TotalAmountVAT := 0;
                    TotalAmountInclVAT := 0;
                    TotalPaymentDiscountOnVAT := 0;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        PurchCrMemoCountPrinted.RUN("Purch. Inv. Header");
                end;

                trigger OnPreDataItem()
                begin
                    OutputNo := 1;
                    NoOfLoops := ABS(NoOfCopiesV) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");
                CompanyInfo.GET();
                CompanyInfo.CALCFIELDS(Picture);
                Pied2 := CompanyInfo.Name + ' ' + CompanyInfo."Name 2" + ' - ' + 'Service comptabilité - ' + CompanyInfo.Address + ' '
                          + CompanyInfo."Address 2" + ' - ' + CompanyInfo."Post Code" + ' ' + CompanyInfo.City;
                Pied3 := CompanyInfo.Name + ' ' + CompanyInfo."Name 2";
                Pied4 := CompanyInfo.Address + ' ' + CompanyInfo."Address 2" + ' ' + CompanyInfo."Post Code" + ' ' + CompanyInfo.City;
                Pied5 := Text015 + CompanyInfo."Phone No." + ' - FAX : ' + CompanyInfo."Fax No.";
                Pied6 := CompanyInfo."Legal Form" + ' ' + Text013 + ' ' + CompanyInfo."Stock Capital" + ' - ' + CompanyInfo."Trade Register"
                          + ' - SIRET ' + CompanyInfo."Registration No." + ' - ' + CompanyInfo."APE Code" + ' - ' + Text014 + ' ' + CompanyInfo."VAT Registration No.";

                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                FormatAddr.PurchCrMemoBuyFrom(BuyFromAddr, "Purch. Inv. Header");

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                OrderNoText := '';
                IF "Purchaser Code" = '' THEN BEGIN
                    CLEAR(SalesPurchPerson);
                    PurchaserText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Purchaser Code");
                    PurchaserText := Text000
                END;
                IF "Your Reference" = '' THEN
                    ReferenceText := ''
                ELSE
                    ReferenceText := FIELDCAPTION("Your Reference");
                IF "VAT Registration No." = '' THEN
                    VATNoText := ''
                ELSE
                    VATNoText := FIELDCAPTION("VAT Registration No.");
                IF "Currency Code" = '' THEN BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text001, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text002, GLSetup."LCY Code");
                    TotalExclVATText := STRSUBSTNO(Text006, GLSetup."LCY Code");
                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text002, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text006, "Currency Code");
                END;
                FormatAddr.PurchCrMemoPayTo(VendAddr, "Purch. Inv. Header");
                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT()
                ELSE BEGIN
                    PaymentTerms.GET("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                END;
                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT()
                ELSE BEGIN
                    ShipmentMethod.GET("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
                END;
                IF "Payment Method Code" = '' THEN
                    PaymentMethod.INIT()
                ELSE
                    PaymentMethod.GET("Payment Method Code");

                FormatAddr.PurchCrMemoShipTo(ShipToAddr, "Purch. Inv. Header");

                IF LogInteractionV THEN
                    IF NOT CurrReport.PREVIEW THEN
                        SegManagement.LogDocument(
                          14, "No.", 0, 0, DATABASE::Vendor, "Buy-from Vendor No.", "Purchaser Code", '', "Posting Description", '');
                PricesInclVATtxt := FORMAT("Prices Including VAT");
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
                    field(NoofCopies; NoOfCopiesV)
                    {
                        Caption = 'No. of Copies', Comment = 'FRA="Nombre de copies"';
                        ApplicationArea = All;
                    }
                    field(ShowInternalInformation; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information', Comment = 'FRA="Afficher info. internes"';
                        ApplicationArea = All;
                    }
                    field(ArchiveDocument; ArchiveDocumentV)
                    {
                        Caption = 'Archive Document', Comment = 'FRA="Archiver document"';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            IF NOT ArchiveDocumentV THEN
                                LogInteractionV := FALSE;
                        end;
                    }
                    field(LogInteraction; LogInteractionV)
                    {
                        Caption = 'Log Interaction', Comment = 'FRA="Journal interaction"';
                        Enabled = LogInteractionEnable;
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            IF LogInteractionV THEN
                                ArchiveDocumentV := ArchiveDocumentEnable;
                        end;
                    }
                    field(VATDetail; VATDetailV)
                    {
                        Caption = 'Détail TVA';
                        ApplicationArea = All;
                    }
                }
            }
        }
        trigger OnInit()
        begin
            LogInteractionEnable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            ArchiveDocumentV := PurchSetup."Archive Orders";
            LogInteractionV := SegManagement.FindInteractTmplCode(13) <> '';
            LogInteractionEnable := LogInteractionV;
        end;
    }

    labels
    {
        ShipmentAddr = 'Shipment Address', Comment = 'FRA="Adresse de livraison"';
        PayAddr = 'Payment Address', Comment = 'FRA="Adresse de réglement"';
        Title = 'ORDER', Comment = 'FRA="AVOIR"';
        LabelVendor = 'Purchaser', Comment = 'FRA="Acheteur"';
        PayMethod = 'Payment Method', Comment = 'FRA="Mode de réglement"';
    }

    trigger OnInitReport()
    begin
        GLSetup.GET();
        PurchSetup.GET();
    end;

    var
        CompanyInfo: Record "Company Information";
        CurrExchRate: Record "Currency Exchange Rate";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        PurchSetup: Record "Purchases & Payables Setup";
        RespCenter: Record "Responsibility Center";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        FormatAddr: Codeunit "Format Address";
        Language: Codeunit Language;
        PurchCrMemoCountPrinted: Codeunit "PurchCrMemo-Printed";
        SegManagement: Codeunit SegManagement;
        ArchiveDocumentV: Boolean;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        Continue: Boolean;
        LogInteractionV: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        ShowInternalInfo: Boolean;
        VATDetailV: Boolean;
        CalculatedExchRate: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        TotalPaymentDiscountOnVAT: Decimal;
        TotalSubTotal: Decimal;
        VALVATAmountLCY: Decimal;
        VALVATBaseLCY: Decimal;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        NoOfCopiesV: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        PurchInLineTypeNo: Integer;
        AllowInvDiscCaptionLbl: Label 'Allow Invoice Discount', Comment = 'FRA="Autoriser remise facture"';
        AmountCaptionLbl: Label 'Amount', Comment = 'FRA="Montant"';
        BankAccNoCaptionLbl: Label 'Account No.', Comment = 'FRA="N° compte"';
        BankNameCaptionLbl: Label 'Bank', Comment = 'FRA="Banque"';
        CompanyInfoBankAccNoCaptionLbl: Label 'Account No.', Comment = 'FRA="N° compte"';
        CompanyInfoBankNameCaptionLbl: Label 'Bank', Comment = 'FRA="Banque"';
        CompanyInfoGiroNoCaptionLbl: Label 'Giro No.', Comment = 'FRA="N° CCP"';
        CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.', Comment = 'FRA="N° téléphone"';
        CompanyInfoVATRegNoCaptionLbl: Label 'VAT Registration No.', Comment = 'FRA="N° identif. intracomm."';
        DirectUniCostCaptionLbl: Label 'Direct Unit Cost', Comment = 'FRA="Coût unitaire direct"';
        DirectUnitCostCaptionLbl: Label 'Direct Unit Cost', Comment = 'FRA="Coût unitaire direct"';
        DiscountPctCaptionLbl: Label 'Discount %', Comment = 'FRA="% remise"';
        DocDateCaptionLbl: Label 'Document Date', Comment = 'FRA="Date Commande"';
        DocumentDateCaptionLbl: Label 'Document Date', Comment = 'FRA="Date Commande"';
        DueDateCaptionLbl: Label 'Due Date', Comment = 'FRA="Date d''échéance"';
        EMailCaptionLbl: Label 'E-Mail';
        EmailIDCaptionLbl: Label 'E-Mail';
        GiroNoCaptionLbl: Label 'Giro No.', Comment = 'FRA="N° CCP"';
        HeaderDimensionsCaptionLbl: Label 'Header Dimensions', Comment = 'FRA="Analytique en-tête"';
        HomePageCaptionLbl: Label 'Home Page', Comment = 'FRA="Page d''accueil"';
        InvDiscAmtCaptionLbl: Label 'Invoice Discount Amount', Comment = 'FRA="Montant remise facture"';
        InvDiscBaseAmtCaptionLbl: Label 'Inv. Disc. Base Amount', Comment = 'FRA="Montant base remise facture"';
        InvoiceNoCaptionLbl: Label 'Invoice No.', Comment = 'FRA="N° facture"';
        LigHTlbl: Label 'Amount', Comment = 'FRA="Montant HT"';
        LigTTClbl: Label 'Amount IV', Comment = 'FRA="Montant TTC"';
        LigTVAlbl: Label 'VAT', Comment = 'FRA="TVA"';
        LineAmtCaptionLbl: Label 'Line Amount', Comment = 'FRA="Montant ligne"';
        LineDimensionsCaptionLbl: Label 'Line Dimensions', Comment = 'FRA="Analytique ligne"';
        NoCaptionlbl: Label 'Internal No.', Comment = 'FRA="N° Interne"';
        OrderNoCaptionLbl: Label 'Order No.', Comment = 'FRA="N° Avoir"';
        PageCaptionLbl: Label 'Page';
        PaymentMethodCaptionLbl: Label 'Payment Method', Comment = 'FRA="Mode de règlement"';
        PaymentTermsCaptionLbl: Label 'Payment Terms', Comment = 'FRA="Conditions de paiement"';
        PaymentTermsDescCaptionLbl: Label 'Payment Terms', Comment = 'FRA="Conditions de paiement"';
        PhoneNoCaptionLbl: Label 'Phone No.', Comment = 'FRA="N° téléphone"';
        Pied1lbl: Label 'Adresse de facturation :';
        PostingDateCaptionLbl: Label 'Posting Date', Comment = 'FRA="Date Avoir"';
        PurchLineInvDiscAmtCaptionLbl: Label 'Invoice Discount Amount', Comment = 'FRA="Montant remise facture"';
        PurchLineLineDiscCaptionLbl: Label 'Discount %', Comment = 'FRA="% Rem."';
        PymtDiscOnVATCaptionLbl: Label 'Payment Discount on VAT', Comment = 'FRA="Escompte sur TVA"';
        RemImp2lbl: Label 'Prière de reporter le n° de Bon de commande sur la facture,';
        RemImp3lbl: Label 'condition préalable au règlement de celle-ci.';
        RemImplbl: Label 'IMPORTANT :';
        ShipmentMethodCaptionLbl: Label 'Shipment Method', Comment = 'FRA="Conditions de livraison"';
        ShipmentMethodDescCaptionLbl: Label 'Shipment Method', Comment = 'FRA="Conditions de livraison"';
        ShiptoAddressCaptionLbl: Label 'Ship-to Address', Comment = 'FRA="Adresse destinataire"';
        SubtotalCaptionLbl: Label 'Subtotal', Comment = 'FRA="Sous-total"';
        Text000: Label 'Purchaser', Comment = 'FRA="Acheteur"';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT', Comment = 'FRA="Total %1 TTC"';
        Text003: Label ' COPY', Comment = 'FRA=" COPIE"';
        Text004: Label 'Order%1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT', Comment = 'FRA="Total %1 HT"';
        Text007: Label 'VAT Amount Specification in ', Comment = 'FRA="Détail TVA dans "';
        Text008: Label 'Local Currency', Comment = 'FRA="Devise société"';
        Text009: Label 'Exchange rate: %1/%2', Comment = 'FRA="Taux de change : %1/%2"';
        Text013: Label 'with capital of', Comment = 'FRA="au capital de"';
        Text014: Label 'VAT Identification No.', Comment = 'FRA="N° d''identification TVA"';
        Text015: Label 'Phone : ', Comment = 'FRA="Tél. : "';
        Text017: Label '%1% VAT', Comment = 'FRA="TVA %1%"';
        Text018: Label 'VAT Amount', Comment = 'FRA="Montant TVA"';
        TotalCaptionLbl: Label 'Total';
        VALVATBaseLCYCaptionLbl: Label 'VAT Base', Comment = 'FRA="Base TVA"';
        VATAmtCaptionLbl: Label 'VAT Amount', Comment = 'FRA="Montant TVA"';
        VATAmtLineInvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount', Comment = 'FRA="Montant base remise facture"';
        VATAmtLineLineAmtCaptionLbl: Label 'Line Amount', Comment = 'FRA="Montant ligne"';
        VATAmtLineVATAmtCaptionLbl: Label 'VAT Amount', Comment = 'FRA="Montant TVA"';
        VATAmtLineVATCaptionLbl: Label 'VAT %', Comment = 'FRA="% TVA"';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification', Comment = 'FRA="Détail montant TVA"';
        VATAmtSpecificationCaptionLbl: Label 'VAT Amount Specification', Comment = 'FRA="Détail montant TVA"';
        VATBaseCaptionLbl: Label 'VAT Base', Comment = 'FRA="Base TVA"';
        VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT', Comment = 'FRA="Escompte sur TVA"';
        VATIdentifierCaptionLbl: Label 'VAT Identifier', Comment = 'FRA="Identifiant TVA"';
        VATPercentageCaptionLbl: Label 'VAT %', Comment = 'FRA="% TVA"';
        VATRegNoCaptionLbl: Label 'VAT Registration No.', Comment = 'FRA="N° identif. intracomm."';
        Pied2: Text;
        Pied3: Text;
        Pied4: Text;
        Pied5: Text;
        Pied6: Text;
        AllowVATDisctxt: Text[30];
        CopyText: Text[30];
        PricesInclVATtxt: Text[30];
        PurchaserText: Text[30];
        VATAmountText: Text[30];
        BuyFromAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        VALExchRate: Text[50];
        VendAddr: array[8] of Text[50];
        OldDimText: Text[75];
        OrderNoText: Text[80];
        ReferenceText: Text[80];
        VALSpecLCYHeader: Text[80];
        VATNoText: Text[80];
        DimText: Text[120];

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewArchiveDocument: Boolean; NewLogInteraction: Boolean)
    begin
        NoOfCopiesV := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        ArchiveDocumentV := NewArchiveDocument;
        LogInteractionV := NewLogInteraction;
    end;
}

