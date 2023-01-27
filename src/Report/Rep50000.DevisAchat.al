report 50000 "BC6_Devis Achat"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/DevisAchat.rdl';
    Caption = 'Purchase - Quote', Comment = 'FRA="Achats : Devis"';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Quote));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order';
            column(DocType_PurchHeader; "Document Type")
            {
            }
            column(No_PurchHeader; "No.")
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(PurchLineInvDiscAmtCaption; PurchLineInvDiscAmtCaptionLbl)
            {
            }
            column(SubtotalCaption; SubtotalCaptionLbl)
            {
            }
            column(VATAmtLineVATCaption; VATAmtLineVATCaptionLbl)
            {
            }
            column(VATAmtLineVATAmtCaption; VATAmtLineVATAmtCaptionLbl)
            {
            }
            column(VATAmtSpecCaption; VATAmtSpecCaptionLbl)
            {
            }
            column(VATIdentifierCaption; VATIdentifierCaptionLbl)
            {
            }
            column(VATAmtLineInvDiscBaseAmtCaption; VATAmtLineInvDiscBaseAmtCaptionLbl)
            {
            }
            column(VATAmtLineLineAmtCaption; VATAmtLineLineAmtCaptionLbl)
            {
            }
            column(VALVATBaseLCYCaption; VALVATBaseLCYCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(PaymentTermsDescCaption; PaymentTermsDescCaptionLbl)
            {
            }
            column(ShipmentMethodDescCaption; ShipmentMethodDescCaptionLbl)
            {
            }
            column(PrepymtTermsDescCaption; PrepymtTermsDescCaptionLbl)
            {
            }
            column(HomePageCaption; HomePageCaptionLbl)
            {
            }
            column(EmailIDCaption; EmailIDCaptionLbl)
            {
            }
            column(AllowInvoiceDiscCaption; AllowInvoiceDiscCaptionLbl)
            {
            }
            column(NoCaption; NoCaptionlbl)
            {
            }
            column(QtyCaption; QtyCaptionlbl)
            {
            }
            column(DirectCost; DirectCostlbl)
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
            column(UserSetupName; Grec_UserSetup."BC6_Nom")
            {
            }
            column(UserSetupFct; Grec_UserSetup."BC6_Fonction")
            {
            }
            column(UserPicture; Grec_UserSetup."BC6_Picture")
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
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfoFaxNo; CompanyInfo."Fax No.")
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
                    column(CompanyInfoPicture; CompanyInfo.Picture)
                    {
                    }
                    column(DocDate_PurchHeader; "Purchase Header"."Document Date")
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_PurchHeader; "Purchase Header"."VAT Registration No.")
                    {
                    }
                    column(PurchaserText; PurchaserText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourRef_PurchHeader; "Purchase Header"."Your Reference")
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(BuyFrmVendNo_PurchHeader; "Purchase Header"."Buy-from Vendor No.")
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
                    column(PricesInclVAT_PurchHeader; "Purchase Header"."Prices Including VAT")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(VATBaseDisc_PurchHeader; "Purchase Header"."VAT Base Discount %")
                    {
                    }
                    column(PricesInclVATtxt; PricesInclVATtxt)
                    {
                    }
                    column(PaymentTermsDesc; PaymentTerms.Description)
                    {
                    }
                    column(PaymentMethod; PaymentMethod.Description)
                    {
                    }
                    column(ShipmentMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    column(AssignedUser; "Purchase Header"."Assigned User ID")
                    {
                    }
                    column(PrepmtPaymentTermsDesc; PrepmtPaymentTerms.Description)
                    {
                    }
                    column(ShowInternalInfo; ShowInternalInfo)
                    {
                    }
                    column(TotalText; TotalText)
                    {
                    }
                    column(DimText; DimText)
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
                    column(OrderNoCaption; OrderNoCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(DocumentDateCaption; DocumentDateCaptionLbl)
                    {
                    }
                    column(BuyFrmVendNo_PurchHeaderCaption; "Purchase Header".FIELDCAPTION("Buy-from Vendor No."))
                    {
                    }
                    column(PricesInclVAT_PurchHeaderCaption; "Purchase Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    dataitem(DimensionLoop1; 2000000026)
                    {
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(HdrDimCaption; HdrDimCaptionLbl)
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
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK();
                        end;
                    }
                    dataitem(RoundLoop; 2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(LineAmt_PurchLine; TempPurchLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(LineNo_PurchLine; "Purchase Line"."Line No.")
                        {
                        }
                        column(AllowInvDisctxt; AllowInvDisctxt)
                        {
                        }
                        column(Type_PurchLine; FORMAT("Purchase Line".Type, 0, 2))
                        {
                        }
                        column(No_PurchLine; "Purchase Line"."No.")
                        {
                        }
                        column(Desc_PurchLine; "Purchase Line".Description)
                        {
                        }
                        column(Qty_PurchLine; "Purchase Line".Quantity)
                        {
                        }
                        column(UOM_PurchLine; "Purchase Line"."Unit of Measure")
                        {
                        }
                        column(DirUnitCost_PurchLine; "Purchase Line"."Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(LineDisc_PurchLine; "Purchase Line"."Line Discount %")
                        {
                        }
                        column(LineAmt2_PurchLine; "Purchase Line"."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AllowInvDisc_PurchLine; "Purchase Line"."Allow Invoice Disc.")
                        {
                        }
                        column(HomePage; CompanyInfo."Home Page")
                        {
                        }
                        column(EMail; CompanyInfo."E-Mail")
                        {
                        }
                        column(VATIdentifier_PurchLine; "Purchase Line"."VAT Identifier")
                        {
                        }
                        column(InvDiscAmt_PurchLine; -TempPurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVAT; TempPurchLine."Line Amount" - TempPurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AmountIncVAT; TempPurchLine."Amount Including VAT")
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(VATAmountText; TempVATAmountLine.VATAmountText())
                        {
                        }
                        column(VATAmountLine; TempPurchLine."Amount Including VAT" - "Purchase Line"."Line Amount")
                        {
                        }
                        column(VATAmount; VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATPercent; "Purchase Line"."VAT %")
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(VATDiscountAmount; -VATDiscountAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalSubTotal; TotalSubTotal)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvoiceDiscountAmount; TotalInvoiceDiscountAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmount; TotalAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(DirectUniCostCaption; DirectUniCostCaptionLbl)
                        {
                        }
                        column(PurchLineLineDiscCaption; PurchLineLineDiscCaptionLbl)
                        {
                        }
                        column(VATDiscountAmountCaption; VATDiscountAmountCaptionLbl)
                        {
                        }
                        column(No_PurchLineCaption; "Purchase Line".FIELDCAPTION("No."))
                        {
                        }
                        column(Desc_PurchLineCaption; "Purchase Line".FIELDCAPTION(Description))
                        {
                        }
                        column(Qty_PurchLineCaption; "Purchase Line".FIELDCAPTION(Quantity))
                        {
                        }
                        column(UOM_PurchLineCaption; "Purchase Line".FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(VATIdentifier_PurchLineCaption; "Purchase Line".FIELDCAPTION("VAT Identifier"))
                        {
                        }
                        dataitem(DimensionLoop2; 2000000026)
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                            column(LineDimCaption; LineDimCaptionLbl)
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

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Purchase Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                TempPurchLine.FIND('-')
                            ELSE
                                TempPurchLine.NEXT();
                            "Purchase Line" := TempPurchLine;

                            IF NOT "Purchase Header"."Prices Including VAT" AND
                               (TempPurchLine."VAT Calculation Type" = TempPurchLine."VAT Calculation Type"::"Full VAT")
                            THEN
                                TempPurchLine."Line Amount" := 0;

                            IF (TempPurchLine.Type = TempPurchLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "Purchase Line"."No." := '';
                            AllowInvDisctxt := FORMAT("Purchase Line"."Allow Invoice Disc.");
                            TotalSubTotal += "Purchase Line"."Line Amount";
                            TotalInvoiceDiscountAmount -= "Purchase Line"."Inv. Discount Amount";
                            TotalAmount += "Purchase Line".Amount;
                        end;

                        trigger OnPostDataItem()
                        begin
                            TempPurchLine.DELETEALL();
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := TempPurchLine.FIND('+');
                            WHILE MoreLines AND (TempPurchLine.Description = '') AND (TempPurchLine."Description 2" = '') AND
                                  (TempPurchLine."No." = '') AND (TempPurchLine.Quantity = 0) AND
                                  (TempPurchLine.Amount = 0)
                            DO
                                MoreLines := TempPurchLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK();
                            TempPurchLine.SETRANGE("Line No.", 0, TempPurchLine."Line No.");
                            SETRANGE(Number, 1, TempPurchLine.COUNT);
                        end;
                    }
                    dataitem(VATCounter; 2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmtLineVATBase; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; TempVATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF VATAmount = 0 THEN
                                CurrReport.BREAK();
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

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              TempVATAmountLine.GetBaseLCY(
                                "Purchase Header"."Posting Date", "Purchase Header"."Currency Code", "Purchase Header"."Currency Factor");
                            VALVATAmountLCY :=
                              TempVATAmountLine.GetAmountLCY(
                                "Purchase Header"."Posting Date", "Purchase Header"."Currency Code", "Purchase Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Purchase Header"."Currency Code" = '') OR
                               (TempVATAmountLine.GetTotalVATAmount() = 0)
                            THEN
                                CurrReport.BREAK();

                            SETRANGE(Number, 1, TempVATAmountLine.COUNT);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text007 + Text008
                            ELSE
                                VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Purchase Header"."Posting Date", "Purchase Header"."Currency Code", 1);
                            VALExchRate := STRSUBSTNO(Text009, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total2; 2000000026)
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(PayToVendNo_PurchHeader; "Purchase Header"."Pay-to Vendor No.")
                        {
                        }
                        column(VendAddr8; VendAddr[8])
                        {
                        }
                        column(VendAddr7; VendAddr[7])
                        {
                        }
                        column(VendAddr6; VendAddr[6])
                        {
                        }
                        column(VendAddr5; VendAddr[5])
                        {
                        }
                        column(VendAddr4; VendAddr[4])
                        {
                        }
                        column(VendAddr3; VendAddr[3])
                        {
                        }
                        column(VendAddr2; VendAddr[2])
                        {
                        }
                        column(VendAddr1; VendAddr[1])
                        {
                        }
                        column(PaymentDetailsCaption; PaymentDetailsCaptionLbl)
                        {
                        }
                        column(VendNoCaption; VendNoCaptionLbl)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF "Purchase Header"."Buy-from Vendor No." = "Purchase Header"."Pay-to Vendor No." THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(Total3; 2000000026)
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(SellToCustNo_PurchHeader; "Purchase Header"."Sell-to Customer No.")
                        {
                        }
                        column(ShiptoAddressCaption; ShiptoAddressCaptionLbl)
                        {
                        }
                        column(SellToCustNo_PurchHeaderCaption; "Purchase Header".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF ("Purchase Header"."Sell-to Customer No." = '') AND (ShipToAddr[1] = '') THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(PrepmtLoop; 2000000026)
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(PrepmtLineAmount; PrepmtLineAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvBufGLAccNo; TempPrepmtInvBuf."G/L Account No.")
                        {
                        }
                        column(PrepmtInvBufDesc; TempPrepmtInvBuf.Description)
                        {
                        }
                        column(TotalInclVATText2; TotalInclVATText)
                        {
                        }
                        column(TotalExclVATText2; TotalExclVATText)
                        {
                        }
                        column(PrepmtInvBufAmt; TempPrepmtInvBuf.Amount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountText; TempPrepmtVATAmountLine.VATAmountText())
                        {
                        }
                        column(PrepmtVATAmount; PrepmtVATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtTotalAmountInclVAT; PrepmtTotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATBaseAmount; PrepmtVATBaseAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvBuDescCaption; PrepmtInvBuDescCaptionLbl)
                        {
                        }
                        column(PrepmtInvBufGLAccNoCaption; PrepmtInvBufGLAccNoCaptionLbl)
                        {
                        }
                        column(PrepaymentSpecCaption; PrepaymentSpecCaptionLbl)
                        {
                        }
                        dataitem(PrepmtDimLoop; 2000000026)
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT PrepmtDimSetEntry.FINDSET() THEN
                                        CurrReport.BREAK();
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK();

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText := STRSUBSTNO('%1 %2', PrepmtDimSetEntry."Dimension Code", PrepmtDimSetEntry."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            PrepmtDimSetEntry."Dimension Code", PrepmtDimSetEntry."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL PrepmtDimSetEntry.NEXT() = 0;
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT TempPrepmtInvBuf.FIND('-') THEN
                                    CurrReport.BREAK();
                            END ELSE
                                IF TempPrepmtInvBuf.NEXT() = 0 THEN
                                    CurrReport.BREAK();

                            IF ShowInternalInfo THEN
                                PrepmtDimSetEntry.SETRANGE("Dimension Set ID", TempPrepmtInvBuf."Dimension Set ID");

                            IF "Purchase Header"."Prices Including VAT" THEN
                                PrepmtLineAmount := TempPrepmtInvBuf."Amount Incl. VAT"
                            ELSE
                                PrepmtLineAmount := TempPrepmtInvBuf.Amount;
                        end;

                    }
                    dataitem(PrepmtVATCounter; 2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(PrepmtVATAmtLineVATAmt; TempPrepmtVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVATBase; TempPrepmtVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineLineAmt; TempPrepmtVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVAT; TempPrepmtVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(PrepmtVATAmtLineVATId; TempPrepmtVATAmountLine."VAT Identifier")
                        {
                        }
                        column(PrepymtVATAmtSpecCaption; PrepymtVATAmtSpecCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempPrepmtVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE(Number, 1, TempPrepmtVATAmountLine.COUNT);
                        end;
                    }
                    dataitem(Signature; 2000000026)
                    {
                        DataItemTableView = WHERE(Number = CONST(1));
                        column(Affsignature; AffSignature)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            AffSignature := TRUE;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                var
                    TempPrepmtPurchLine: Record "Purchase Line" temporary;
                    TempPurchLine: Record "Purchase Line" temporary;
                begin
                    CLEAR(TempPurchLine);
                    CLEAR(PurchPost);
                    TempPurchLine.DELETEALL();
                    TempVATAmountLine.DELETEALL();
                    PurchPost.GetPurchLines("Purchase Header", TempPurchLine, 0);
                    TempPurchLine.CalcVATAmountLines(0, "Purchase Header", TempPurchLine, TempVATAmountLine);
                    TempPurchLine.UpdateVATOnLines(0, "Purchase Header", TempPurchLine, TempVATAmountLine);
                    VATAmount := TempVATAmountLine.GetTotalVATAmount();
                    VATBaseAmount := TempVATAmountLine.GetTotalVATBase();
                    VATDiscountAmount :=
                      TempVATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := TempVATAmountLine.GetTotalAmountInclVAT();

                    TempPrepmtInvBuf.DELETEALL();
                    PurchPostPrepmt.GetPurchLines("Purchase Header", 0, TempPrepmtPurchLine);
                    IF NOT TempPrepmtPurchLine.ISEMPTY THEN BEGIN
                        PurchPostPrepmt.GetPurchLinesToDeduct("Purchase Header", TempPurchLine);
                        IF NOT TempPurchLine.ISEMPTY THEN
                            PurchPostPrepmt.CalcVATAmountLines("Purchase Header", TempPurchLine, TempPrePmtVATAmountLineDeduct, 1);
                    END;
                    PurchPostPrepmt.CalcVATAmountLines("Purchase Header", TempPrepmtPurchLine, TempPrepmtVATAmountLine, 0);
                    TempPrepmtVATAmountLine.DeductVATAmountLine(TempPrePmtVATAmountLineDeduct);
                    PurchPostPrepmt.UpdateVATOnLines("Purchase Header", TempPrepmtPurchLine, TempPrepmtVATAmountLine, 0);
                    PurchPostPrepmt.BuildInvLineBuffer("Purchase Header", TempPrepmtPurchLine, 0, TempPrepmtInvBuf);
                    PrepmtVATAmount := TempPrepmtVATAmountLine.GetTotalVATAmount();
                    PrepmtVATBaseAmount := TempPrepmtVATAmountLine.GetTotalVATBase();
                    PrepmtTotalAmountInclVAT := TempPrepmtVATAmountLine.GetTotalAmountInclVAT();

                    IF Number > 1 THEN
                        CopyText := Text003;
                    OutputNo := OutputNo + 1;

                    TotalSubTotal := 0;
                    TotalAmount := 0;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        PurchCountPrinted.RUN("Purchase Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopiesV) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            var
            // TODO: Record Approval Setup is missing  
            //Lrec_ApprovalSetup: Record 452; 
            begin
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");

                CompanyInfo.GET();
                CompanyInfo.CALCFIELDS(Picture);
                /*
                Pied2 := CompanyInfo.Name+' '+CompanyInfo."Name 2"+' - '+'Service comptabilité - '+CompanyInfo.Address+' '
                          +CompanyInfo."Address 2"+' - '+CompanyInfo."Post Code"+' '+CompanyInfo.City;
                Pied3 := CompanyInfo.Name+' '+CompanyInfo."Name 2";
                Pied4 := CompanyInfo.Address+' '+CompanyInfo."Address 2"+' '+CompanyInfo."Post Code"+' '+CompanyInfo.City;
                Pied5 := Text015+CompanyInfo."Phone No."+' - FAX : '+CompanyInfo."Fax No.";
                Pied6 := CompanyInfo."Legal Form"+' ' +Text013 +' '+CompanyInfo."Stock Capital"+' - '+CompanyInfo."Trade Register"
                          +' - SIRET '+CompanyInfo."Registration No."+' - '+CompanyInfo."APE Code"+' - ' +Text014 +' '+CompanyInfo."VAT Registration No.";
                */
                Pied2 := CompanyInfo.Name + ' ' + CompanyInfo."Name 2" + ' - ' + 'Service comptabilité - ' + CompanyInfo.Address + ' '
                           + CompanyInfo."Address 2" + ' ' + CompanyInfo."Post Code" + ' ' + CompanyInfo.City + ' ' + Text015 + CompanyInfo."Phone No." + ' - FAX : ' + CompanyInfo."Fax No.";
                Pied3 := CompanyInfo."Legal Form" + ' ' + Text013 + ' ' + CompanyInfo."Stock Capital" + ' - ' + CompanyInfo."Trade Register"
                          + ' - SIRET ' + CompanyInfo."Registration No." + ' - ' + CompanyInfo."APE Code" + ' - ' + Text014 + ' ' + CompanyInfo."VAT Registration No.";

                AffSignature := FALSE;

                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                IF "Purchaser Code" = '' THEN BEGIN
                    SalesPurchPerson.INIT();
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

                FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, "Purchase Header");
                IF "Buy-from Vendor No." <> "Pay-to Vendor No." THEN
                    FormatAddr.PurchHeaderPayTo(VendAddr, "Purchase Header");
                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT()
                ELSE BEGIN
                    PaymentTerms.GET("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                END;

                IF "Payment Method Code" = '' THEN
                    PaymentMethod.INIT()
                ELSE
                    PaymentMethod.GET("Payment Method Code");

                IF "Prepmt. Payment Terms Code" = '' THEN
                    PrepmtPaymentTerms.INIT()
                ELSE BEGIN
                    PrepmtPaymentTerms.GET("Prepmt. Payment Terms Code");
                    PrepmtPaymentTerms.TranslateDescription(PrepmtPaymentTerms, "Language Code");
                END;
                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT()
                ELSE BEGIN
                    ShipmentMethod.GET("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
                END;

                FormatAddr.PurchHeaderShipTo(ShipToAddr, "Purchase Header");

                IF NOT CurrReport.PREVIEW THEN BEGIN
                    IF ArchiveDocumentV THEN
                        ArchiveManagement.StorePurchDocument("Purchase Header", LogInteractionV);

                    IF LogInteractionV THEN BEGIN
                        CALCFIELDS("No. of Archived Versions");
                        SegManagement.LogDocument(
                          13, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Vendor, "Buy-from Vendor No.",
                          "Purchaser Code", '', "Posting Description", '');
                    END;
                END;
                PricesInclVATtxt := FORMAT("Prices Including VAT");


                // Prendre la signature de l'utilisateur s'il a les droits nécessaires,
                // sinon prendre celle de l'approbateur et remonter ainsi la chaine des approbateurs jusqu'à ce que les droits le permmettent
                CALCFIELDS(Amount);
                Gcode_PrécédentUserID := ''; // MODIF JX-XAD 05/07/2011
                Gcode_UserID := "Purchase Header"."Assigned User ID";
                IF Grec_UserSetup.GET(Gcode_UserID) THEN
                    //Modif JX-XAD 12/11/08
                    //  WHILE ("Purchase Line".Amount > Grec_UserSetup."Request Amount Approval Limit")
                    WHILE (Amount > Grec_UserSetup."Request Amount Approval Limit")
                        AND (NOT Grec_UserSetup."Unlimited Request Approval") DO BEGIN
                        // DEBUT MODIF JX-XAD 05/07/2011
                        IF (Gcode_PrécédentUserID = Gcode_UserID) THEN
                            ERROR(Text016);
                        // FIN MODIF JX-XAD 05/07/2011
                        Gcode_PrécédentUserID := Gcode_UserID;
                        Gcode_UserID := Grec_UserSetup."Approver ID";
                        IF NOT Grec_UserSetup.GET(Gcode_UserID) THEN
                            ERROR(Text012, Gcode_PrécédentUserID);
                    END
                ELSE
                    ERROR(Text011, Gcode_UserID);

                //modif LAB du 30/10/08
                //changement du code de catherine

                //IF Gcode_UserID = 'CATHERINE_SCHOU' THEN

                //Début Modif JX-XAD le 12-01-2010
                //IF Gcode_UserID = 'SCHOUDB' THEN
                /* TODO : Record Approval Setup is missing 
                       Lrec_ApprovalSetup.RESET;
                       Lrec_ApprovalSetup.FIND('-');
                       IF Gcode_UserID = Lrec_ApprovalSetup."Approval Administrator" THEN
               */

                //Fin Modif JX-XAD le 12-01-2010

                //fin modif LAB du 30/10/08

                BEGIN
                    //DEBUT MODIF JX-XAD 07/03/2011
                    //Gcode_UserID := 'RACHEL_PICARD';
                    Gcode_UserID := CompanyInfo."BC6_Leader";
                    //FIN MODIF JX-XAD 07/03/2011
                    IF NOT Grec_UserSetup.GET(Gcode_UserID) THEN
                        ERROR(Text011, Gcode_UserID);
                END;

                Grec_UserSetup.CALCFIELDS(Grec_UserSetup."BC6_Picture");

                //FIN MODIF JX-XAD 13/10/2008

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
        Title = 'ORDER', Comment = 'FRA="DEVIS"';
        LabelVendor = 'Purchaser', Comment = 'FRA="Acheteur"';
        PayMethod = 'Payment Method', Comment = 'FRA="ode de réglement"';
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
        PrepmtDimSetEntry: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        TempPrepmtInvBuf: Record "Prepayment Inv. Line Buffer" temporary;
        TempPurchLine: Record "Purchase Line" temporary;
        PurchSetup: Record "Purchases & Payables Setup";
        RespCenter: Record "Responsibility Center";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        Grec_UserSetup: Record "User Setup";
        TempPrepmtVATAmountLine: Record "VAT Amount Line" temporary;
        TempPrePmtVATAmountLineDeduct: Record "VAT Amount Line" temporary;
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        ArchiveManagement: Codeunit ArchiveManagement;
        FormatAddr: Codeunit "Format Address";
        Language: Codeunit Language;
        PurchPost: Codeunit "Purch.-Post";
        PurchCountPrinted: Codeunit "Purch.Header-Printed";
        PurchPostPrepmt: Codeunit "Purchase-Post Prepayments";
        SegManagement: Codeunit SegManagement;
        AffSignature: Boolean;
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
        "Gcode_PrécédentUserID": Code[50];
        Gcode_UserID: Code[50];
        PrepmtLineAmount: Decimal;
        PrepmtTotalAmountInclVAT: Decimal;
        PrepmtVATAmount: Decimal;
        PrepmtVATBaseAmount: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        TotalSubTotal: Decimal;
        VALVATAmountLCY: Decimal;
        VALVATBaseLCY: Decimal;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        NoOfCopiesV: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        AllowInvoiceDiscCaptionLbl: Label 'Allow Invoice Discount', Comment = 'FRA="Autoriser remise facture"';
        AmountCaptionLbl: Label 'Amount', Comment = 'FRA="Montant"';
        CompanyInfoBankAccNoCaptionLbl: Label 'Account No.', Comment = 'FRA="N° compte"';
        CompanyInfoBankNameCaptionLbl: Label 'Bank', Comment = 'FRA="Banque"';
        CompanyInfoGiroNoCaptionLbl: Label 'Giro No.', Comment = 'FRA="N° CCP"';
        CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.', Comment = 'FRA="N° téléphone"';
        CompanyInfoVATRegNoCaptionLbl: Label 'VAT Registration No.', Comment = 'FRA="N° identif. intracomm."';
        DirectCostlbl: Label 'Unit Price', Comment = 'FRA="Prix unitaire"';
        DirectUniCostCaptionLbl: Label 'Direct Unit Cost', Comment = 'FRA="Coût unitaire direct"';
        DocumentDateCaptionLbl: Label 'Document Date', Comment = 'FRA="Date document"';
        EmailIDCaptionLbl: Label 'E-Mail', Comment = 'FRA="E-mail"';
        HdrDimCaptionLbl: Label 'Header Dimensions', Comment = 'FRA="Analytique en-tête"';
        HomePageCaptionLbl: Label 'Home Page', Comment = 'FRA="Page d''accueil"';
        LigHTlbl: Label 'Amount', Comment = 'FRA="Montant HT"';
        LigTTClbl: Label 'Amount IV', Comment = 'FRA="Montant TTC"';
        LigTVAlbl: Label 'VAT', Comment = 'FRA="TVA"';
        LineDimCaptionLbl: Label 'Line Dimensions', Comment = 'FRA="Analytique ligne"';
        NoCaptionlbl: Label 'Internal No.', Comment = 'FRA="N° Interne"';
        OrderNoCaptionLbl: Label 'Order No.', Comment = 'FRA="N° Devis"';
        PageCaptionLbl: Label 'Page', Comment = 'FRA="Page"';
        PaymentDetailsCaptionLbl: Label 'Payment Details', Comment = 'FRA="Détail paiement"';
        PaymentTermsDescCaptionLbl: Label 'Payment Terms', Comment = 'FRA="Conditions de paiement"';
        Pied1lbl: Label 'Adresse de facturation :';
        PrepaymentSpecCaptionLbl: Label 'Prepayment Specification', Comment = 'FRA="Spécification acompte"';
        PrepmtInvBuDescCaptionLbl: Label 'Description', Comment = 'FRA="Désignation"';
        PrepmtInvBufGLAccNoCaptionLbl: Label 'G/L Account No.', Comment = 'FRA="N° compte général"';
        PrepymtTermsDescCaptionLbl: Label 'Prepmt. Payment Terms', Comment = 'FRA="Conditions paiement acompte"';
        PrepymtVATAmtSpecCaptionLbl: Label 'Prepayment VAT Amount Specification', Comment = 'FRA="Spécification montant TVA acompte"';
        PurchLineInvDiscAmtCaptionLbl: Label 'Invoice Discount Amount', Comment = 'FRA="Montant remise facture"';
        PurchLineLineDiscCaptionLbl: Label 'Discount %', Comment = 'FRA="% Rem."';
        QtyCaptionlbl: Label 'Qty', Comment = 'FRA="Qté"';
        RemImp2lbl: Label 'Prière de reporter le n° de Bon de commande sur la facture,';
        RemImp3lbl: Label 'condition préalable au règlement de celle-ci.';
        RemImplbl: Label 'IMPORTANT :', Comment = 'FRA="IMPORTANT :"';
        ShipmentMethodDescCaptionLbl: Label 'Shipment Method', Comment = 'FRA="Conditions de livraison"';
        ShiptoAddressCaptionLbl: Label 'Ship-to Address', Comment = 'FRA="Adresse destinataire"';
        SubtotalCaptionLbl: Label 'Subtotal', Comment = 'FRA="Sous-total"';
        Text000: Label 'Purchaser', Comment = 'FRA="Acheteur"';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT', Comment = 'FRA="Total %1 TTC"';
        Text003: Label ' COPY', Comment = 'FRA=" COPIE"';
        Text004: Label 'Quote %1', Comment = 'FRA="Devis %1"';
        Text006: Label 'Total %1 Excl. VAT', Comment = 'FRA="Total %1 HT"';
        Text007: Label 'VAT Amount Specification in ', Comment = 'FRA="Détail TVA dans "';
        Text008: Label 'Local Currency', Comment = 'FRA="Devise société"';
        Text009: Label 'Exchange rate: %1/%2', Comment = 'FRA="Taux de change : %1/%2"';
        Text011: Label 'Utilisisateur ''''%1'''' non déclaré dans la liste des paramètres utilisateurs';
        Text012: Label 'ID approbateur doit être paramétré pour utilisateur %1';
        Text013: Label 'with capital of', Comment = 'FRA="au capital de"';
        Text014: Label 'VAT Identification No.', Comment = 'FRA="N° d''identification TVA"';
        Text015: Label 'Phone : ', Comment = 'FRA="Tél. : "';
        Text016: Label 'Error ! approval user setup are not correct', Comment = 'FRA="Erreur ! les paramètres utilisateurs approbations sont incorrects"';
        TotalCaptionLbl: Label 'Total';
        VALVATBaseLCYCaptionLbl: Label 'VAT Base', Comment = 'FRA="Base TVA"';
        VATAmtLineInvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount', Comment = 'FRA="Montant base remise facture"';
        VATAmtLineLineAmtCaptionLbl: Label 'Line Amount', Comment = 'FRA="Montant ligne"';
        VATAmtLineVATAmtCaptionLbl: Label 'VAT Amount', Comment = 'FRA="Montant TVA"';
        VATAmtLineVATCaptionLbl: Label 'VAT %', Comment = 'FRA="% TVA"';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification', Comment = 'FRA="Détail montant TVA"';
        VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT', Comment = 'FRA="Escompte sur TVA"';
        VATIdentifierCaptionLbl: Label 'VAT Identifier', Comment = 'FRA="Identifiant TVA"';
        VendNoCaptionLbl: Label 'Vendor No.', Comment = 'FRA="N° fournisseur"';
        Pied2: Text;
        Pied3: Text;
        Pied4: Text;
        Pied5: Text;
        Pied6: Text;
        AllowInvDisctxt: Text[30];
        CopyText: Text[30];
        PricesInclVATtxt: Text[30];
        PurchaserText: Text[30];
        BuyFromAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        VALExchRate: Text[50];
        VendAddr: array[8] of Text[50];
        OldDimText: Text[75];
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

