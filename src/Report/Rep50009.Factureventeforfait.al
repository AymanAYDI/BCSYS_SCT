report 50009 "BC6_Facture vente forfait"
{
    // // modifs LAB du 30/08/2010
    // // Modification de la mise en page de la facture
    // 
    // //modifs AUD du 29/09/2010
    // //affichage des montants HT et TTC si tva à 0.
    // 
    // //modif JX-XAD du 31/01/2011
    // //Ajout de cadres
    // 
    // //modif JX-XAD du 07/02/2011
    // //Corrections dans le bas de page
    // 
    // //MODIF JX-XAD 28/06/2011
    // //Ajout du champ VAT Registration No.
    // 
    // //MODIF JX-AUD 04/02/2013
    // //Remise en place des adresses facturation et livraison pour facture forfait
    // //Modification colonnes Déjà facturé, Reste à facturer et Facturé
    // 
    // //JX-AUD du 13/05/2013
    // //Agrandissement logo
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/Factureventeforfait.rdl';

    Caption = 'Sales - Invoice', Comment = 'FRA="Facture vente forfait"';
    Permissions = TableData "Sales Shipment Buffer" = rimd;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';
            column(No_SalesInvHdr; "No.")
            {
            }
            column(PmtTermsDescCaption; PmtTermsDescCaptionLbl)
            {
            }
            column(ShpMethodDescCaption; ShpMethodDescCaptionLbl)
            {
            }
            column(HomePageCaption; HomePageCaptionCap)
            {
            }
            column(EMailCaption; EMailCaptionLbl)
            {
            }
            column(DocDateCaption; DocDateCaptionLbl)
            {
            }
            column(DisplayAdditionalFeeNote; DisplayAdditionalFeeNoteV)
            {
            }
            dataitem(CopyLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfo3Picture; CompanyInfo3.Picture)
                    {
                    }
                    column(DocCaptCopyText; STRSUBSTNO(DocumentCaption(), CopyText))
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
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(CustAddr1; CustAddr[1])
                    {
                    }
                    column(CustAddr2; CustAddr[2])
                    {
                    }
                    column(CustAddr3; CustAddr[3])
                    {
                    }
                    column(CustAddr4; CustAddr[4])
                    {
                    }
                    column(CustAddr5; CustAddr[5])
                    {
                    }
                    column(CustAddr6; CustAddr[6])
                    {
                    }
                    column(CustAddr7; CustAddr[7])
                    {
                    }
                    column(CustAddr8; CustAddr[8])
                    {
                    }
                    column(BillAddr1; BillAddr[1])
                    {
                    }
                    column(BillAddr2; BillAddr[2])
                    {
                    }
                    column(BillAddr3; BillAddr[3])
                    {
                    }
                    column(BillAddr4; BillAddr[4])
                    {
                    }
                    column(BillAddr5; BillAddr[5])
                    {
                    }
                    column(BillAddr6; BillAddr[6])
                    {
                    }
                    column(BillAddr7; BillAddr[7])
                    {
                    }
                    column(BillAddr8; BillAddr[8])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfoVATRegistrationNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccountNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoEMail; CompanyInfo."E-Mail")
                    {
                    }
                    column(BilltoCustNo_SalesInvHdr; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(PostingDate_SalesInvHdr; FORMAT("Sales Invoice Header"."Posting Date", 0, 1))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_SalesInvHdr; "Sales Invoice Header"."VAT Registration No.")
                    {
                    }
                    column(DueDate_SalesInvHdr; FORMAT("Sales Invoice Header"."Due Date", 0, 1))
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(No1_SalesInvHdr; "Sales Invoice Header"."No.")
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourRef_SalesInvHdr; "Sales Invoice Header"."External Document No.")
                    {
                    }
                    column(OrderNoText; OrderNoText)
                    {
                    }
                    column(OrderNo_SalesInvHdr; "Sales Invoice Header"."Order No.")
                    {
                    }
                    column(DocDate_SalesInvHdr; FORMAT("Sales Invoice Header"."Document Date", 0, 1))
                    {
                    }
                    column(PricesInclVAT_SalesInvHdr; "Sales Invoice Header"."Prices Including VAT")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PricesInclVAT1_SalesInvHdr; FORMAT("Sales Invoice Header"."Prices Including VAT"))
                    {
                    }
                    column(PageCaption; PageCaptionCap)
                    {
                    }
                    column(PaymentTermsDescription; PaymentTerms.Description)
                    {
                    }
                    column(ShipmentMethodDescription; ShipmentMethod.Description)
                    {
                    }
                    column(PhoneNoCaption; PhoneNoCaptionLbl)
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
                    column(PostingDateCaption; PostingDateCaptionLbl)
                    {
                    }
                    column(BilltoCustNo_SalesInvHdrCaption; "Sales Invoice Header".FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(PricesInclVAT_SalesInvHdrCaption; "Sales Invoice Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    column(UserNameCaption; UserNameLbl)
                    {
                    }
                    column(UserName; Gtext_UserName)
                    {
                    }
                    column(UserMailCaption; UserMailLbl)
                    {
                    }
                    column(UserMail; Gtext_UserMail)
                    {
                    }
                    column(Pied1; Text015)
                    {
                    }
                    column(Pied2; Gtext_CodeEtabl + ' - ' + Gtext_CodeAgence + ' - ' + Gtext_NumCompte + ' - ' + Gtext_CleRIB)
                    {
                    }
                    column(Pied3; STRSUBSTNO(Text023, CompanyInfo.IBAN, CompanyInfo."SWIFT Code"))
                    {
                    }
                    column(Pied4; Text016 + ' ' + Gtext_NameBanque + ' - ' + Gtext_Adresse + ' -  ' + Gtext_Adresse2 + '  -  ' + Gtext_PostCode + ' ' + Gtext_City)
                    {
                    }
                    column(Pied5; Text017)
                    {
                    }
                    column(Pied6; Text018)
                    {
                    }
                    column(Pied7; Text0181)
                    {
                    }
                    column(Pied8; Text019 + ' ' + CompanyInfo.Name + ' ' + Text027)
                    {
                    }
                    column(Pied9; Text028)
                    {
                    }
                    column(Pied10; CompanyInfo.Name + ' ' + CompanyInfo."Name 2" + ' ' + CompanyInfo.Address + ' ' + CompanyInfo."Address 2" + ' ' + CompanyInfo."Post Code" + ' ' + CompanyInfo.City + ' ' + Text013 + CompanyInfo."Phone No." + ' - FAX : ' + CompanyInfo."Fax No.")
                    {
                    }
                    column(Pied11; CompanyInfo."Legal Form" + ' ' + Text011 + ' ' + CompanyInfo."Stock Capital" + ' - ' + CompanyInfo."Trade Register" + ' - SIRET ' + CompanyInfo."Registration No." + ' - ' + CompanyInfo."APE Code" + ' - ' + Text012 + ' ' + CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(Gtext_TitreL; Gtext_TitreL)
                    {
                    }
                    column(Gtext_TitreR; Gtext_TitreR)
                    {
                    }
                    dataitem(DimensionLoop1; 2000000026)
                    {
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(Number_DimensionLoop1; DimensionLoop1.Number)
                        {
                        }
                        column(HdrDimsCaption; HdrDimsCaptionLbl)
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
                            IF NOT ShowInternalInfoV THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(LineAmt_SalesInvLine; "Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(Desc_SalesInvLine; Description)
                        {
                        }
                        column(No_SalesInvLine; "No.")
                        {
                        }
                        column(Quantity_SalesInvLine; Quantity)
                        {
                        }
                        column(UnitofMeasure_SalesInvLine; "Unit of Measure")
                        {
                        }
                        column(UnitPrice_SalesInvLine; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 2;
                        }
                        column(LineDisc_SalesInvLine; "Line Discount %")
                        {
                        }
                        column(VATIdentifier_SalesInvLine; "VAT Identifier")
                        {
                        }
                        column(PostedShipmentDate; FORMAT(PostedShipmentDate))
                        {
                        }
                        column(Type_SalesInvLine; FORMAT("Sales Invoice Line".Type))
                        {
                        }
                        column(GetTotalLineAmt; GetTotalLineAmount)
                        {
                        }
                        column(GetTotalAmtIncVAT; GetTotalAmountIncVAT)
                        {
                        }
                        column(InvDiscAmt; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(TotalSubTotal; TotalSubTotal)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvoiceDiscAmt; TotalInvoiceDiscountAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(Amt_SalesInvLine; Amount)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(TotalAmt; TotalAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AmtIncludingVATAmt_SalesInvLine; "Amount Including VAT" - Amount)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(AmtInclVAT_SalesInvLine; "Amount Including VAT")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(VATAmtText_SalesInvLine; TempVATAmountLine.VATAmountText())
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(TotalAmtInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmtVAT; TotalAmountVAT)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseDisc_SalesInvHdr; "Sales Invoice Header"."VAT Base Discount %")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalPaymentDiscOnVAT; TotalPaymentDiscountOnVAT)
                        {
                            AutoFormatType = 1;
                        }
                        column(LineNo_SalesInvLine; "Line No.")
                        {
                        }
                        column(UnitPriceCaption; UnitPriceCaptionLbl)
                        {
                        }
                        column(DiscPercentCaption; DiscPercentCaptionLbl)
                        {
                        }
                        column(AmtCaption; AmtCaptionLbl)
                        {
                        }
                        column(PostedShpDateCaption; PostedShpDateCaptionLbl)
                        {
                        }
                        column(InvDiscAmtCaption; InvDiscAmtCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(PmtDiscVATCaption; PmtDiscVATCaptionLbl)
                        {
                        }
                        column(Desc_SalesInvLineCaption; FIELDCAPTION(Description))
                        {
                        }
                        column(No_SalesInvLineCaption; FIELDCAPTION("No."))
                        {
                        }
                        column(Quantity_SalesInvLineCaption; FIELDCAPTION(Quantity))
                        {
                        }
                        column(UnitofMeasure_SalesInvLineCaption; FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(VATIdentifier_SalesInvLineCaption; FIELDCAPTION("VAT Identifier"))
                        {
                        }
                        column(DejaFactureCaption; DejaFactureLbl)
                        {
                        }
                        column(DejaFacture; Gdec_DejaFacture)
                        {
                        }
                        column(ResteAFacturerCaption; ResteAFacturerLbl)
                        {
                        }
                        column(ResteAFacturer; Gdec_ResteAFacture)
                        {
                        }
                        dataitem("Sales Shipment Buffer"; 2000000026)
                        {
                            DataItemTableView = SORTING(Number);
                            column(SalesShipmentBufferPostingDate; FORMAT(TempSalesShipmentBuffer."Posting Date"))
                            {
                            }
                            column(SalesShipmentBufferQty; TempSalesShipmentBuffer.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(ShpCaption; ShpCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN
                                    TempSalesShipmentBuffer.FindFirst()
                                ELSE
                                    TempSalesShipmentBuffer.NEXT();
                            end;

                            trigger OnPreDataItem()
                            begin
                                TempSalesShipmentBuffer.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
                                TempSalesShipmentBuffer.SETRANGE("Line No.", "Sales Invoice Line"."Line No.");

                                SETRANGE(Number, 1, TempSalesShipmentBuffer.COUNT);
                            end;
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                            column(DimText1; DimText)
                            {
                            }
                            column(LineDimsCaption; LineDimsCaptionLbl)
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
                                IF NOT ShowInternalInfoV THEN
                                    CurrReport.BREAK();

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Sales Invoice Line"."Dimension Set ID");
                            end;
                        }
                        dataitem(AsmLoop; Integer)
                        {
                            DataItemTableView = SORTING(Number);
                            column(TempPostedAsmLineUOMCode; GetUOMText(TempPostedAsmLine."Unit of Measure Code"))
                            {
                            }
                            column(TempPostedAsmLineQty; TempPostedAsmLine.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(TempPostedAsmLineVariantCode; BlanksForIndent() + TempPostedAsmLine."Variant Code")
                            {
                            }
                            column(TempPostedAsmLineDesc; BlanksForIndent() + TempPostedAsmLine.Description)
                            {
                            }
                            column(TempPostedAsmLineNo; BlanksForIndent() + TempPostedAsmLine."No.")
                            {
                            }

                            trigger OnAfterGetRecord()
                            var
                                ItemTranslation: Record "Item Translation";
                            begin
                                IF Number = 1 THEN
                                    TempPostedAsmLine.FINDSET()
                                ELSE
                                    TempPostedAsmLine.NEXT();

                                IF ItemTranslation.GET(TempPostedAsmLine."No.",
                                     TempPostedAsmLine."Variant Code",
                                     "Sales Invoice Header"."Language Code")
                                THEN
                                    TempPostedAsmLine.Description := ItemTranslation.Description;
                            end;

                            trigger OnPreDataItem()
                            begin
                                CLEAR(TempPostedAsmLine);
                                IF NOT DisplayAssemblyInformation THEN
                                    CurrReport.BREAK();
                                CollectAsmInformation();
                                CLEAR(TempPostedAsmLine);
                                SETRANGE(Number, 1, TempPostedAsmLine.COUNT);
                            end;
                        }
                        dataitem(ShipmentDatas; Integer)
                        {
                            DataItemTableView = SORTING(Number);
                            column(NoShipmentText; NoShipmentText)
                            {
                            }
                            column(NoShipmentDatas1; NoShipmentDatas[1])
                            {
                            }
                            column(NoShipmentDatas2; NoShipmentDatas[2])
                            {
                            }
                            column(NoShipmentDatas3; NoShipmentDatas[3])
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                CLEAR(NoShipmentDatas);
                                NoShipmentNumLoop := 0;
                                IF Number = 1 THEN BEGIN
                                    ShipmentInvoiced.FindFirst();
                                    NoShipmentText := Text10800;
                                    REPEAT
                                        NoShipmentNumLoop := NoShipmentNumLoop + 1;
                                        NoShipmentDatas[NoShipmentNumLoop] := ShipmentInvoiced."Shipment No.";
                                    UNTIL (ShipmentInvoiced.NEXT() = 0) OR (NoShipmentNumLoop = 3);
                                END ELSE BEGIN
                                    NoShipmentText := '';
                                    REPEAT
                                        NoShipmentNumLoop := NoShipmentNumLoop + 1;
                                        NoShipmentDatas[NoShipmentNumLoop] := ShipmentInvoiced."Shipment No.";
                                    UNTIL (ShipmentInvoiced.NEXT() = 0) OR (NoShipmentNumLoop = 3);
                                END;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT IncludeShptNo THEN
                                    CurrReport.BREAK();

                                IF ShipmentInvoiced.COUNT < 1 THEN
                                    CurrReport.BREAK();
                                ShipmentDatas.SETRANGE(Number, 1, ROUND(ShipmentInvoiced.COUNT / 3, 1, '>'));
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            //MODIF JX-AUD 04/02/2013
                            //IF "Line Amount" <> 0 THEN
                            //BEGIN
                            Grec_SalesLineArchive.RESET();
                            Grec_SalesLineArchive.SETRANGE(Grec_SalesLineArchive."Document No.", "Sales Invoice Header"."Order No.");
                            Grec_SalesLineArchive.SETRANGE(Grec_SalesLineArchive."Line No.", "Line No.");
                            Grec_SalesLineArchive.SETRANGE(Grec_SalesLineArchive."Qty. to Invoice", Quantity);
                            IF Grec_SalesLineArchive.FINDLAST() THEN
                                Gint_version := Grec_SalesLineArchive."Version No.";
                            //END;
                            //Fin MODIF JX-AUD 04/02/2013

                            PostedShipmentDate := 0D;
                            IF Quantity <> 0 THEN
                                PostedShipmentDate := FindPostedShipmentDate();

                            IF (Type = Type::"G/L Account") AND (NOT ShowInternalInfoV) THEN
                                "No." := '';

                            TempVATAmountLine.INIT();
                            TempVATAmountLine."VAT Identifier" := "VAT Identifier";
                            TempVATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            TempVATAmountLine."Tax Group Code" := "Tax Group Code";
                            TempVATAmountLine."VAT %" := "VAT %";
                            TempVATAmountLine."VAT Base" := Amount;
                            TempVATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            TempVATAmountLine."Line Amount" := "Line Amount";
                            IF "Allow Invoice Disc." THEN
                                TempVATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            TempVATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            TempVATAmountLine."VAT Clause Code" := "VAT Clause Code";
                            TempVATAmountLine.InsertLine();

                            TotalSubTotal += "Line Amount";
                            TotalInvoiceDiscountAmount -= "Inv. Discount Amount";
                            TotalAmount += Amount;
                            TotalAmountVAT += "Amount Including VAT" - Amount;
                            TotalAmountInclVAT += "Amount Including VAT";
                            TotalPaymentDiscountOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");

                            IF IncludeShptNo THEN BEGIN
                                ShipmentInvoiced.RESET();
                                ShipmentInvoiced.SETRANGE("Invoice No.", "Sales Invoice Line"."Document No.");
                                ShipmentInvoiced.SETRANGE("Invoice Line No.", "Sales Invoice Line"."Line No.");
                            END;

                            //MODIF JX-AUD 04/02/2013
                            Gdec_DejaFacture := 0;
                            Gdec_ResteAFacture := 0;
                            //   IF "Sales Invoice Line"."Line Amount" = 0 THEN
                            //   BEGIN
                            Grec_SalesLineArchive.RESET();
                            Grec_SalesLineArchive.SETFILTER(Grec_SalesLineArchive."Document No.", "Sales Invoice Header"."Order No.");
                            Grec_SalesLineArchive.SETFILTER(Grec_SalesLineArchive."Line No.", FORMAT("Sales Invoice Line"."Line No."));
                            Grec_SalesLineArchive.SETFILTER(Grec_SalesLineArchive."Version No.", FORMAT(Gint_version));
                            IF Grec_SalesLineArchive.FIND('+') THEN BEGIN
                                Gdec_DejaFacture := Grec_SalesLineArchive."Quantity Invoiced" * Grec_SalesLineArchive."Unit Price";
                                Gdec_ResteAFacture := (Grec_SalesLineArchive."Outstanding Quantity" * Grec_SalesLineArchive."Unit Price") - ("Line Amount");
                            END;
                            //    END;
                            //Fin MODIF JX-AUD 04/02/2013
                        end;

                        trigger OnPreDataItem()
                        begin
                            TempVATAmountLine.DELETEALL();
                            TempSalesShipmentBuffer.RESET();
                            TempSalesShipmentBuffer.DELETEALL();
                            FirstValueEntryNo := 0;
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) AND (Amount = 0) DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK();
                            SETRANGE("Line No.", 0, "Line No.");

                            GetTotalLineAmount := 0;
                            GetTotalInvDiscAmount := 0;
                            GetTotalAmount := 0;
                            GetTotalAmountIncVAT := 0;
                        end;
                    }
                    dataitem(VATCounter; 2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmtLineVATBase; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvoiceDiscAmt; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; TempVATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATPercentCaption; VATPercentCaptionLbl)
                        {
                        }
                        column(VATBaseCaption; VATBaseCaptionLbl)
                        {
                        }
                        column(VATAmtCaption; VATAmtCaptionLbl)
                        {
                        }
                        column(VATAmtSpecCaption; VATAmtSpecCaptionLbl)
                        {
                        }
                        column(VATIdentCaption; VATIdentCaptionLbl)
                        {
                        }
                        column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(LineAmtCaption; LineAmtCaptionLbl)
                        {
                        }
                        column(InvDiscAmtCaption1; InvDiscAmtCaption1Lbl)
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
                    dataitem(VATClauseEntryCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATClauseVATIdentifier; TempVATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATClauseCode; TempVATAmountLine."VAT Clause Code")
                        {
                        }
                        column(VATClauseDescription; VATClause.Description)
                        {
                        }
                        column(VATClauseDescription2; VATClause."Description 2")
                        {
                        }
                        column(VATClauseAmount; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATClausesCaption; VATClausesCap)
                        {
                        }
                        column(VATClauseVATIdentifierCaption; VATIdentCaptionLbl)
                        {
                        }
                        column(VATClauseVATAmtCaption; VATAmtCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                            IF NOT VATClause.GET(TempVATAmountLine."VAT Clause Code") THEN
                                CurrReport.SKIP();
                            VATClause.TranslateDescription("Sales Invoice Header"."Language Code");
                        end;

                        trigger OnPreDataItem()
                        begin
                            CLEAR(VATClause);
                            SETRANGE(Number, 1, TempVATAmountLine.COUNT);
                        end;
                    }
                    dataitem(VatCounterLCY; 2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmtLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT1; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier1; TempVATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              TempVATAmountLine.GetBaseLCY(
                                "Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code",
                                "Sales Invoice Header"."Currency Factor");
                            VALVATAmountLCY :=
                              TempVATAmountLine.GetAmountLCY(
                                "Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code",
                                "Sales Invoice Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Sales Invoice Header"."Currency Code" = '')
                            THEN
                                CurrReport.BREAK();

                            SETRANGE(Number, 1, TempVATAmountLine.COUNT);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text007 + Text008
                            ELSE
                                VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", 1);
                            CalculatedExchRate := ROUND(1 / "Sales Invoice Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
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
                        column(SelltoCustNo_SalesInvHdr; "Sales Invoice Header"."Sell-to Customer No.")
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
                        column(ShiptoAddrCaption; ShiptoAddrCaptionLbl)
                        {
                        }
                        column(SelltoCustNo_SalesInvHdrCaption; "Sales Invoice Header".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowShippingAddr THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(LineFee; Integer)
                    {
                        DataItemTableView = SORTING(Number) ORDER(Ascending) WHERE(Number = FILTER(1 ..));
                        column(LineFeeCaptionLbl; TempLineFeeNoteOnReportHist.ReportText)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF NOT DisplayAdditionalFeeNoteV THEN
                                CurrReport.BREAK();

                            IF Number = 1 THEN BEGIN
                                IF NOT TempLineFeeNoteOnReportHist.FINDSET() THEN
                                    CurrReport.BREAK()
                            END ELSE
                                IF TempLineFeeNoteOnReportHist.NEXT() = 0 THEN
                                    CurrReport.BREAK();
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN BEGIN
                        CopyText := Text003;
                        OutputNo += 1;
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
                        SalesInvCountPrinted.RUN("Sales Invoice Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopiesV) + Cust."Invoice Copies" + 1;
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                //dev AUD
                Gtext_TitreL := '';
                Gtext_TitreR := '';
                IF DefaultBank.GET(CompanyInfo."Default Bank Account No.") THEN BEGIN

                    Gtext_NameBanque := DefaultBank.Name;
                    Gtext_CodeEtabl := DefaultBank."Bank Branch No.";
                    Gtext_CodeAgence := DefaultBank."Agency Code";
                    Gtext_NumCompte := DefaultBank."Bank Account No.";
                    Gtext_CleRIB := FORMAT(DefaultBank."RIB Key");
                    Gtext_Adresse := DefaultBank.Address;
                    Gtext_Adresse2 := DefaultBank."Address 2";
                    Gtext_City := DefaultBank.City;
                    Gtext_PostCode := DefaultBank."Post Code";

                END ELSE BEGIN

                    Gtext_NameBanque := '';
                    Gtext_CodeEtabl := '';
                    Gtext_CodeAgence := '';
                    Gtext_NumCompte := '';
                    Gtext_CleRIB := '';
                    Gtext_Adresse := '';
                    Gtext_Adresse2 := '';
                    Gtext_City := '';
                    Gtext_PostCode := '';
                END;

                IF SalesPurchPerson.GET("Sales Invoice Header"."Salesperson Code") THEN
                    Gtext_ContactAgence := SalesPurchPerson.Name
                ELSE
                    Gtext_ContactAgence := '';


                IF UserSetup.GET("Sales Invoice Header"."User ID") THEN BEGIN
                    Gtext_UserName := UserSetup."User ID";
                    Gtext_UserMail := UserSetup."E-Mail";
                END ELSE BEGIN
                    Gtext_UserName := '';
                    Gtext_UserMail := '';
                END;

                IF "BC6_Agent" = '' THEN BEGIN

                    CLEAR(BillAddr);

                    CustAddr[1] := "Sales Invoice Header"."Bill-to Name";
                    CustAddr[2] := "Sales Invoice Header"."Bill-to Address";
                    CustAddr[3] := "Sales Invoice Header"."Bill-to Address 2";
                    CustAddr[4] := "Sales Invoice Header"."Bill-to Post Code" + ' ' + "Sales Invoice Header"."Bill-to City";
                    Gtext_RvatRegistrationNo := "Sales Invoice Header"."VAT Registration No."; //MODIF JX-XAD 28/06/2011
                    IF Gtext_RvatRegistrationNo <> '' THEN
                        Gtext_RvatRegistrationNo := Text024 + ' : ' + Gtext_RvatRegistrationNo;
                    Gtext_TitreR := '';
                    IF Grec_CodePays.GET("Sales Invoice Header"."Bill-to Country/Region Code") THEN
                        CustAddr[5] := Grec_CodePays.Name
                    ELSE
                        CustAddr[5] := '';
                    COMPRESSARRAY(CustAddr);

                END ELSE
                    IF Cust.GET("Sales Invoice Header"."BC6_Agent") THEN BEGIN
                        IF "BC6_Paying agent" = TRUE THEN BEGIN
                            CustAddr[1] := Cust.Name;
                            CustAddr[2] := Cust.Address;
                            CustAddr[3] := Cust."Address 2";
                            CustAddr[4] := Cust."Post Code" + ' ' + Cust.City;
                            Gtext_RvatRegistrationNo := Cust."VAT Registration No."; //MODIF JX-XAD 28/06/2011
                            IF Gtext_RvatRegistrationNo <> '' THEN
                                Gtext_RvatRegistrationNo := Text024 + ' : ' + Gtext_RvatRegistrationNo;
                            Gtext_TitreR := Text021 + ' ' + Text029;
                            IF Grec_CodePays.GET(Cust."Country/Region Code") THEN
                                CustAddr[5] := Grec_CodePays.Name
                            ELSE
                                CustAddr[5] := '';
                            COMPRESSARRAY(CustAddr);

                            BillAddr[1] := "Sales Invoice Header"."Bill-to Name";
                            BillAddr[2] := "Sales Invoice Header"."Bill-to Address";
                            BillAddr[3] := "Sales Invoice Header"."Bill-to Address 2";
                            BillAddr[4] := "Sales Invoice Header"."Bill-to Post Code" + ' ' + "Sales Invoice Header"."Bill-to City";
                            Gtext_TitreL := Text022;
                            IF Grec_CodePays.GET("Sales Invoice Header"."Bill-to Country/Region Code") THEN
                                BillAddr[5] := Grec_CodePays.Name
                            ELSE
                                BillAddr[5] := '';
                            COMPRESSARRAY(BillAddr);

                        END ELSE BEGIN
                            CustAddr[1] := "Sales Invoice Header"."Bill-to Name";
                            CustAddr[2] := "Sales Invoice Header"."Bill-to Address";
                            CustAddr[3] := "Sales Invoice Header"."Bill-to Address 2";
                            CustAddr[4] := "Sales Invoice Header"."Bill-to Post Code" + ' ' + "Sales Invoice Header"."Bill-to City";
                            Gtext_RvatRegistrationNo := "Sales Invoice Header"."VAT Registration No."; //MODIF JX-XAD 28/06/2011
                            IF Gtext_RvatRegistrationNo <> '' THEN
                                Gtext_RvatRegistrationNo := Text024 + ' : ' + Gtext_RvatRegistrationNo;
                            Gtext_TitreR := Text022;
                            IF Grec_CodePays.GET("Sales Invoice Header"."Bill-to Country/Region Code") THEN
                                CustAddr[5] := Grec_CodePays.Name
                            ELSE
                                CustAddr[5] := '';
                            COMPRESSARRAY(CustAddr);

                            BillAddr[1] := Cust.Name;
                            BillAddr[2] := Cust.Address;
                            BillAddr[3] := Cust."Address 2";
                            BillAddr[4] := Cust."Post Code" + ' ' + Cust.City;
                            Gtext_TitreL := Text021 + ' ' + Text030;
                            IF Grec_CodePays.GET(Cust."Country/Region Code") THEN
                                BillAddr[5] := Grec_CodePays.Name
                            ELSE
                                BillAddr[5] := '';
                            COMPRESSARRAY(BillAddr);
                        END;
                    END ELSE
                        MESSAGE(Text020);

                //fin dev AUD

                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                IF "Order No." = '' THEN
                    OrderNoText := ''
                ELSE
                    OrderNoText := FIELDCAPTION("Order No.");
                IF "Salesperson Code" = '' THEN BEGIN
                    SalesPurchPerson.INIT();
                    SalesPersonText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Salesperson Code");
                    SalesPersonText := Text000;
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
                //FormatAddr.SalesInvBillTo(CustAddr,"Sales Invoice Header");
                IF NOT Cust.GET("Bill-to Customer No.") THEN
                    CLEAR(Cust);

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
                FormatAddr.SalesInvShipTo(ShipToAddr, CustAddr, "Sales Invoice Header");
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                    IF ShipToAddr[i] <> CustAddr[i] THEN
                        ShowShippingAddr := TRUE;

                GetLineFeeNoteOnReportHist("No.");

                IF LogInteractionV THEN
                    IF NOT CurrReport.PREVIEW THEN
                        IF "Bill-to Contact No." <> '' THEN
                            SegManagement.LogDocument(
                              4, "No.", 0, 0, DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '')
                        ELSE
                            SegManagement.LogDocument(
                              4, "No.", 0, 0, DATABASE::Customer, "Bill-to Customer No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '');
            end;

            trigger OnPreDataItem()
            begin
                Gint_version := 0;//MODIF JX-AUD 04/02/2013
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
                    field(NoOfCopies; NoOfCopiesV)
                    {
                        Caption = 'No. of Copies', Comment = 'FRA="Nombre de copies"';
                        ApplicationArea = All;
                    }
                    field(ShowInternalInfo; ShowInternalInfoV)
                    {
                        Caption = 'Show Internal Information', Comment = 'FRA="Afficher info. internes"';
                        ApplicationArea = All;
                    }
                    field(LogInteraction; LogInteractionV)
                    {
                        Caption = 'Log Interaction', Comment = 'FRA="Journal interaction"';
                        Enabled = LogInteractionEnable;
                        ApplicationArea = All;
                    }
                    field(IncludeShipmentNo; IncludeShptNo)
                    {
                        Caption = 'Include Shipment No.', Comment = 'FRA="Inclure numéro expédition"';
                        ApplicationArea = All;
                    }
                    field(DisplayAsmInformation; DisplayAssemblyInformation)
                    {
                        Caption = 'Show Assembly Components', Comment = 'FRA="Afficher composants d''assemblage"';
                        ApplicationArea = All;
                    }
                    field(DisplayAdditionalFeeNote; DisplayAdditionalFeeNoteV)
                    {
                        Caption = 'Show Additional Fee Note', Comment = 'FRA="Afficher la note de frais supplémentaires"';
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
            InitLogInteraction();
            LogInteractionEnable := LogInteractionV;
        end;
    }

    trigger OnInitReport()
    begin
        GLSetup.GET();
        CompanyInfo.GET();
        SalesSetup.GET();
        CompanyInfo.VerifyAndSetPaymentInfo();
        CASE SalesSetup."Logo Position on Documents" OF
            SalesSetup."Logo Position on Documents"::Left:

                CompanyInfo3.CALCFIELDS(Picture);
            SalesSetup."Logo Position on Documents"::Center:
                BEGIN
                    CompanyInfo1.GET();
                    CompanyInfo1.CALCFIELDS(Picture);
                END;
            SalesSetup."Logo Position on Documents"::Right:
                BEGIN
                    CompanyInfo2.GET();
                    CompanyInfo2.CALCFIELDS(Picture);
                END;
        END;
    end;

    trigger OnPreReport()
    begin

        IF NOT CurrReport.USEREQUESTPAGE THEN
            InitLogInteraction();
    end;

    var
        DefaultBank: Record "Bank Account";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        Grec_CodePays: Record "Country/Region";
        CurrExchRate: Record "Currency Exchange Rate";
        Cust: Record Customer;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        TempLineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist." temporary;
        PaymentTerms: Record "Payment Terms";
        TempPostedAsmLine: Record "Posted Assembly Line" temporary;
        RespCenter: Record "Responsibility Center";
        SalesSetup: Record "Sales & Receivables Setup";
        Grec_SalesLineArchive: Record "Sales Line Archive";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        TempSalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
        ShipmentInvoiced: Record "Shipment Invoiced";
        ShipmentMethod: Record "Shipment Method";
        UserSetup: Record "User Setup";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        VATClause: Record "VAT Clause";
        FormatAddr: Codeunit "Format Address";
        Language: Codeunit Language;
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        SegManagement: Codeunit SegManagement;
        Continue: Boolean;
        DisplayAdditionalFeeNoteV: Boolean;
        DisplayAssemblyInformation: Boolean;
        IncludeShptNo: Boolean;
        LogInteractionV: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        ShowInternalInfoV: Boolean;
        ShowShippingAddr: Boolean;
        PostedShipmentDate: Date;
        CalculatedExchRate: Decimal;
        Gdec_DejaFacture: Decimal;
        Gdec_ResteAFacture: Decimal;
        GetTotalAmount: Decimal;
        GetTotalAmountIncVAT: Decimal;
        GetTotalInvDiscAmount: Decimal;
        GetTotalLineAmount: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        TotalPaymentDiscountOnVAT: Decimal;
        TotalSubTotal: Decimal;
        VALVATAmountLCY: Decimal;
        VALVATBaseLCY: Decimal;
        FirstValueEntryNo: Integer;
        Gint_version: Integer;
        i: Integer;
        NextEntryNo: Integer;
        NoOfCopiesV: Integer;
        NoOfLoops: Integer;
        NoShipmentNumLoop: Integer;
        OutputNo: Integer;
        AmtCaptionLbl: Label 'Amount', Comment = 'FRA="Facturé"';
        BankAccNoCaptionLbl: Label 'Account No.', Comment = 'FRA="N° compte"';
        BankNameCaptionLbl: Label 'Bank', Comment = 'FRA="Banque"';
        DejaFactureLbl: Label 'Already invoiced', Comment = 'FRA="Déjà facturé"';
        DiscPercentCaptionLbl: Label 'Discount %', Comment = 'FRA="% remise"';
        DocDateCaptionLbl: Label 'Document Date', Comment = 'FRA="Date document"';
        DueDateCaptionLbl: Label 'Due Date', Comment = 'FRA="Date d''échéance"';
        EMailCaptionLbl: Label 'E-Mail', Comment = 'FRA="E-mail"';
        GiroNoCaptionLbl: Label 'Giro No.', Comment = 'FRA="N° CCP"';
        HdrDimsCaptionLbl: Label 'Header Dimensions', Comment = 'FRA="Analytique en-tête"';
        HomePageCaptionCap: Label 'Home Page', Comment = 'FRA="Page d''accueil"';
        InvDiscAmtCaption1Lbl: Label 'Invoice Discount Amount', Comment = 'FRA="Montant remise facture"';
        InvDiscAmtCaptionLbl: Label 'Inv. Discount Amount', Comment = 'FRA="Montant remise facture"';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount', Comment = 'FRA="Montant base remise facture"';
        InvoiceNoCaptionLbl: Label 'Invoice No.', Comment = 'FRA="N° facture"';
        LineAmtCaptionLbl: Label 'Line Amount', Comment = 'FRA="Montant ligne"';
        LineDimsCaptionLbl: Label 'Line Dimensions', Comment = 'FRA="Analytique ligne"';
        PageCaptionCap: Label 'Page %1 of %2', Comment = 'FRA="Page %1 de %2"';
        PhoneNoCaptionLbl: Label 'Phone No.', Comment = 'FRA="N° téléphone"';
        PmtDiscVATCaptionLbl: Label 'Payment Discount on VAT', Comment = 'FRA="Escompte sur TVA"';
        PmtTermsDescCaptionLbl: Label 'Payment Terms', Comment = 'FRA="Conditions de paiement"';
        PostedShpDateCaptionLbl: Label 'Posted Shipment Date', Comment = 'FRA="Date expédition validée"';
        PostingDateCaptionLbl: Label 'Posting Date', Comment = 'FRA="Date comptabilisation"';
        ResteAFacturerLbl: Label 'Unit Price', Comment = 'FRA="Reste à facturer"';
        ShiptoAddrCaptionLbl: Label 'Ship-to Address', Comment = 'FRA="Adresse destinataire"';
        ShpCaptionLbl: Label 'Shipment', Comment = 'FRA="Expédition"';
        ShpMethodDescCaptionLbl: Label 'Shipment Method', Comment = 'FRA="Conditions de livraison"';
        SubtotalCaptionLbl: Label 'Subtotal', Comment = 'FRA="Sous-total"';
        Text000: Label 'Salesperson', Comment = 'FRA="Vendeur"';
        Text001: Label 'Total %1', Comment = 'FRA="Total %1"';
        Text002: Label 'Total %1 Incl. VAT', Comment = 'FRA="Total %1 TTC"';
        Text003: Label 'COPY', Comment = 'FRA="COPIE"';
        Text004: Label 'Sales - Invoice %1', Comment = 'FRA="FACTURE"';
        Text006: Label 'Total %1 Excl. VAT', Comment = 'FRA="Total %1 HT"';
        Text007: Label 'VAT Amount Specification in ', Comment = 'FRA="Détail TVA dans"';
        Text008: Label 'Local Currency', Comment = 'FRA="Devise société"';
        Text009: Label 'Exchange rate: %1/%2', Comment = 'FRA="Taux de change : %1/%2"';
        Text010: Label 'Sales - Prepayment Invoice %1', Comment = 'FRA="Ventes - Facture acompte %1"';
        Text011: Label 'with capital of', Comment = 'FRA="au capital de"';
        Text012: Label 'VAT identification No. :', Comment = 'FRA="N° d''identification TVA :"';
        Text013: Label 'Tél. : ';
        Text015: Label 'TVA acquittée sur les encaissements. A votre aimable règlement par virement sur le compte:';
        Text016: Label 'à';
        Text017: Label 'Toute somme non payée à l''échéance pour quelque cause que ce soit, portera intérêt de plein droit, à compter de ladite échéance et jusqu''au paiement intégral de la facture, à un taux égal au';
        Text018: Label 'taux d''intérêt appliqué par la Banque centrale européenne à son opération de refinancement la plus récente majoré de dix (10) points de pourcentage, sans qu''une mise en demeure ne soit';
        Text019: Label 'd''un montant de 40 € couvrant les frais de recouvrement.';
        Text020: Label 'Agent doesn''t exist', Comment = 'FRA="Le mandataire n''existe pas"';
        Text021: Label 'AGENT', Comment = 'FRA="MANDATAIRE"';
        Text022: Label 'ANNOUNCER', Comment = 'FRA="ANNONCEUR"';
        Text023: Label 'IBAN %1 -  BIC %2 ';
        Text024: Label 'VAT Registration No.', Comment = 'FRA="N° identif. intracomm."';
        Text027: Label 'peut demander une indemnité complémentaire, sur présentation des justificatifs afférents, lorsque';
        Text028: Label 'les frais de recouvrement exposés sont supérieurs au montant de l''indemnité forfaitaire. Nos conditions de vente ne prévoient pas d''escompte pour paiement anticipé. ';
        Text029: Label 'payer', Comment = 'FRA="payeur"';
        Text030: Label 'not payer', Comment = 'FRA="non payeur"';
        Text0181: Label 'nécessaire, conformément au dispositions de l''article L 441-6 du Code de Commerce.Toute situation de retard de paiement entrainera, de plein droit, la facturation d''une indemnité forfaitaire';
        Text10800: Label 'ShipmentNo', Comment = 'FRA="NoExpédition"';
        TotalCaptionLbl: Label 'Total', Comment = 'FRA="Total"';
        UnitPriceCaptionLbl: Label 'Unit Price', Comment = 'FRA="Prix unitaire"';
        UserMailLbl: Label 'Mail';
        UserNameLbl: Label 'Emetteur';
        VATAmtCaptionLbl: Label 'VAT Amount', Comment = 'FRA="Montant TVA"';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification', Comment = 'FRA="Détail montant TVA"';
        VATBaseCaptionLbl: Label 'VAT Base', Comment = 'FRA="Base TVA"';
        VATClausesCap: Label 'VAT Clause', Comment = 'FRA="Clause TVA"';
        VATIdentCaptionLbl: Label 'VAT Identifier', Comment = 'FRA="Identifiant TVA"';
        VATPercentCaptionLbl: Label 'VAT %', Comment = 'FRA="% TVA"';
        VATRegNoCaptionLbl: Label 'VAT Registration No.', Comment = 'FRA="N° identif. intracomm."';
        Gtext_CodeEtabl: Text[20];
        NoShipmentDatas: array[3] of Text[20];
        CopyText: Text[30];
        Gtext_CleRIB: Text[30];
        Gtext_NumCompte: Text[30];
        Gtext_PostCode: Text[30];
        Gtext_TitreL: Text[30];
        Gtext_TitreR: Text[30];
        NoShipmentText: Text[30];
        SalesPersonText: Text[30];
        BillAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        CustAddr: array[8] of Text[50];
        Gtext_City: Text[50];
        Gtext_CodeAgence: Text[50];
        Gtext_ContactAgence: Text[50];
        Gtext_NameBanque: Text[50];
        Gtext_RvatRegistrationNo: Text[50];
        Gtext_UserName: Text[50];
        ShipToAddr: array[8] of Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        VALExchRate: Text[50];
        OldDimText: Text[75];
        OrderNoText: Text[80];
        ReferenceText: Text[80];
        VALSpecLCYHeader: Text[80];
        VATNoText: Text[80];
        Gtext_Adresse: Text[100];
        Gtext_Adresse2: Text[100];
        Gtext_UserMail: Text[100];
        DimText: Text[120];

    procedure InitLogInteraction()
    begin
        LogInteractionV := SegManagement.FindInteractTmplCode(4) <> '';
    end;

    procedure FindPostedShipmentDate(): Date
    var
        SalesShipmentBuffer2: Record "Sales Shipment Buffer" temporary;
        SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        NextEntryNo := 1;
        IF "Sales Invoice Line"."Shipment No." <> '' THEN
            IF SalesShipmentHeader.GET("Sales Invoice Line"."Shipment No.") THEN
                EXIT(SalesShipmentHeader."Posting Date");

        IF "Sales Invoice Header"."Order No." = '' THEN
            EXIT("Sales Invoice Header"."Posting Date");

        CASE "Sales Invoice Line".Type OF
            "Sales Invoice Line".Type::Item:
                GenerateBufferFromValueEntry("Sales Invoice Line");
            "Sales Invoice Line".Type::"G/L Account", "Sales Invoice Line".Type::Resource,
          "Sales Invoice Line".Type::"Charge (Item)", "Sales Invoice Line".Type::"Fixed Asset":
                GenerateBufferFromShipment("Sales Invoice Line");
            "Sales Invoice Line".Type::" ":
                EXIT(0D);
        END;

        TempSalesShipmentBuffer.RESET();
        TempSalesShipmentBuffer.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
        TempSalesShipmentBuffer.SETRANGE("Line No.", "Sales Invoice Line"."Line No.");
        IF TempSalesShipmentBuffer.FIND('-') THEN BEGIN
            SalesShipmentBuffer2 := TempSalesShipmentBuffer;
            IF TempSalesShipmentBuffer.NEXT() = 0 THEN BEGIN
                TempSalesShipmentBuffer.GET(
                  SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
                TempSalesShipmentBuffer.DELETE();
                EXIT(SalesShipmentBuffer2."Posting Date");
            END;
            TempSalesShipmentBuffer.CALCSUMS(Quantity);
            IF TempSalesShipmentBuffer.Quantity <> "Sales Invoice Line".Quantity THEN BEGIN
                TempSalesShipmentBuffer.DELETEALL();
                EXIT("Sales Invoice Header"."Posting Date");
            END;
        END ELSE
            EXIT("Sales Invoice Header"."Posting Date");
    end;

    procedure GenerateBufferFromValueEntry(SalesInvoiceLine2: Record "Sales Invoice Line")
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
        Quantity: Decimal;
        TotalQuantity: Decimal;
    begin
        TotalQuantity := SalesInvoiceLine2."Quantity (Base)";
        ValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry.SETRANGE("Document No.", SalesInvoiceLine2."Document No.");
        ValueEntry.SETRANGE("Posting Date", "Sales Invoice Header"."Posting Date");
        ValueEntry.SETRANGE("Item Charge No.", '');
        ValueEntry.SETFILTER("Entry No.", '%1..', FirstValueEntryNo);
        IF ValueEntry.FIND('-') THEN
            REPEAT
                IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") THEN BEGIN
                    IF SalesInvoiceLine2."Qty. per Unit of Measure" <> 0 THEN
                        Quantity := ValueEntry."Invoiced Quantity" / SalesInvoiceLine2."Qty. per Unit of Measure"
                    ELSE
                        Quantity := ValueEntry."Invoiced Quantity";
                    AddBufferEntry(
                      SalesInvoiceLine2,
                      -Quantity,
                      ItemLedgerEntry."Posting Date");
                    TotalQuantity := TotalQuantity + ValueEntry."Invoiced Quantity";
                END;
                FirstValueEntryNo := ValueEntry."Entry No." + 1;
            UNTIL (ValueEntry.NEXT() = 0) OR (TotalQuantity = 0);
    end;

    procedure GenerateBufferFromShipment(SalesInvoiceLine: Record "Sales Invoice Line")
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine2: Record "Sales Invoice Line";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        Quantity: Decimal;
        TotalQuantity: Decimal;
    begin
        TotalQuantity := 0;
        SalesInvoiceHeader.SETCURRENTKEY("Order No.");
        SalesInvoiceHeader.SETFILTER("No.", '..%1', "Sales Invoice Header"."No.");
        SalesInvoiceHeader.SETRANGE("Order No.", "Sales Invoice Header"."Order No.");
        IF SalesInvoiceHeader.FindSet() THEN
            REPEAT
                SalesInvoiceLine2.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                SalesInvoiceLine2.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
                SalesInvoiceLine2.SETRANGE(Type, SalesInvoiceLine.Type);
                SalesInvoiceLine2.SETRANGE("No.", SalesInvoiceLine."No.");
                SalesInvoiceLine2.SETRANGE("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
                IF SalesInvoiceLine2.FindSet() THEN
                    REPEAT
                        TotalQuantity := TotalQuantity + SalesInvoiceLine2.Quantity;
                    UNTIL SalesInvoiceLine2.NEXT() = 0;
            UNTIL SalesInvoiceHeader.NEXT() = 0;

        SalesShipmentLine.SETCURRENTKEY("Order No.", "Order Line No.");
        SalesShipmentLine.SETRANGE("Order No.", "Sales Invoice Header"."Order No.");
        SalesShipmentLine.SETRANGE("Order Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SETRANGE(Type, SalesInvoiceLine.Type);
        SalesShipmentLine.SETRANGE("No.", SalesInvoiceLine."No.");
        SalesShipmentLine.SETRANGE("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
        SalesShipmentLine.SETFILTER(Quantity, '<>%1', 0);

        IF SalesShipmentLine.FindSet() THEN
            REPEAT
                IF "Sales Invoice Header"."Get Shipment Used" THEN
                    CorrectShipment(SalesShipmentLine);
                IF ABS(SalesShipmentLine.Quantity) <= ABS(TotalQuantity - SalesInvoiceLine.Quantity) THEN
                    TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity
                ELSE BEGIN
                    IF ABS(SalesShipmentLine.Quantity) > ABS(TotalQuantity) THEN
                        SalesShipmentLine.Quantity := TotalQuantity;
                    Quantity :=
                      SalesShipmentLine.Quantity - (TotalQuantity - SalesInvoiceLine.Quantity);

                    TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity;
                    SalesInvoiceLine.Quantity := SalesInvoiceLine.Quantity - Quantity;

                    IF SalesShipmentHeader.GET(SalesShipmentLine."Document No.") THEN
                        AddBufferEntry(
                          SalesInvoiceLine,
                          Quantity,
                          SalesShipmentHeader."Posting Date");
                END;
            UNTIL (SalesShipmentLine.NEXT() = 0) OR (TotalQuantity = 0);
    end;

    procedure CorrectShipment(var SalesShipmentLine: Record "Sales Shipment Line")
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        SalesInvoiceLine.SETCURRENTKEY("Shipment No.", "Shipment Line No.");
        SalesInvoiceLine.SETRANGE("Shipment No.", SalesShipmentLine."Document No.");
        SalesInvoiceLine.SETRANGE("Shipment Line No.", SalesShipmentLine."Line No.");
        IF SalesInvoiceLine.FIND('-') THEN
            REPEAT
                SalesShipmentLine.Quantity := SalesShipmentLine.Quantity - SalesInvoiceLine.Quantity;
            UNTIL SalesInvoiceLine.NEXT() = 0;
    end;

    procedure AddBufferEntry(SalesInvoiceLine: Record "Sales Invoice Line"; QtyOnShipment: Decimal; PostingDate: Date)
    begin
        TempSalesShipmentBuffer.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
        TempSalesShipmentBuffer.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
        TempSalesShipmentBuffer.SETRANGE("Posting Date", PostingDate);
        IF TempSalesShipmentBuffer.FIND('-') THEN BEGIN
            TempSalesShipmentBuffer.Quantity := TempSalesShipmentBuffer.Quantity + QtyOnShipment;
            TempSalesShipmentBuffer.MODIFY();
            EXIT;
        END;

        TempSalesShipmentBuffer."Document No." := SalesInvoiceLine."Document No.";
        TempSalesShipmentBuffer."Line No." := SalesInvoiceLine."Line No.";
        TempSalesShipmentBuffer."Entry No." := NextEntryNo;
        TempSalesShipmentBuffer.Type := SalesInvoiceLine.Type;
        TempSalesShipmentBuffer."No." := SalesInvoiceLine."No.";
        TempSalesShipmentBuffer.Quantity := QtyOnShipment;
        TempSalesShipmentBuffer."Posting Date" := PostingDate;
        TempSalesShipmentBuffer.INSERT();
        NextEntryNo := NextEntryNo + 1
    end;

    local procedure DocumentCaption(): Text[250]
    begin
        IF "Sales Invoice Header"."Prepayment Invoice" THEN
            EXIT(Text010);
        EXIT(Text004);
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; IncludeShptNo: Boolean; DisplAsmInfo: Boolean)
    begin
        NoOfCopiesV := NewNoOfCopies;
        ShowInternalInfoV := NewShowInternalInfo;
        LogInteractionV := NewLogInteraction;
        IncludeShptNo := IncludeShptNo;
        DisplayAssemblyInformation := DisplAsmInfo;
    end;

    procedure CollectAsmInformation()
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        SalesShipmentLine: Record "Sales Shipment Line";
        ValueEntry: Record "Value Entry";
    begin
        TempPostedAsmLine.DELETEALL();
        IF "Sales Invoice Line".Type <> "Sales Invoice Line".Type::Item THEN
            EXIT;
        ValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
        ValueEntry.SETRANGE("Document Type", ValueEntry."Document Type"::"Sales Invoice");
        ValueEntry.SETRANGE("Document Line No.", "Sales Invoice Line"."Line No.");
        ValueEntry.SETRANGE(Adjustment, FALSE);
        IF NOT ValueEntry.FINDSET() THEN
            EXIT;
        REPEAT
            IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") THEN
                IF ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Shipment" THEN BEGIN
                    SalesShipmentLine.GET(ItemLedgerEntry."Document No.", ItemLedgerEntry."Document Line No.");
                    IF SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader) THEN BEGIN
                        PostedAsmLine.SETRANGE("Document No.", PostedAsmHeader."No.");
                        IF PostedAsmLine.FINDSET() THEN
                            REPEAT
                                TreatAsmLineBuffer(PostedAsmLine);
                            UNTIL PostedAsmLine.NEXT() = 0;
                    END;
                END;
        UNTIL ValueEntry.NEXT() = 0;
    end;

    procedure TreatAsmLineBuffer(PostedAsmLine: Record "Posted Assembly Line")
    begin
        CLEAR(TempPostedAsmLine);
        TempPostedAsmLine.SETRANGE(Type, PostedAsmLine.Type);
        TempPostedAsmLine.SETRANGE("No.", PostedAsmLine."No.");
        TempPostedAsmLine.SETRANGE("Variant Code", PostedAsmLine."Variant Code");
        TempPostedAsmLine.SETRANGE(Description, PostedAsmLine.Description);
        TempPostedAsmLine.SETRANGE("Unit of Measure Code", PostedAsmLine."Unit of Measure Code");
        IF TempPostedAsmLine.FINDFIRST() THEN BEGIN
            TempPostedAsmLine.Quantity += PostedAsmLine.Quantity;
            TempPostedAsmLine.MODIFY();
        END ELSE BEGIN
            CLEAR(TempPostedAsmLine);
            TempPostedAsmLine := PostedAsmLine;
            TempPostedAsmLine.INSERT();
        END;
    end;

    procedure GetUOMText(UOMCode: Code[10]): Text[10]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        IF NOT UnitOfMeasure.GET(UOMCode) THEN
            EXIT(UOMCode);
        EXIT(UnitOfMeasure.Description);
    end;

    procedure BlanksForIndent(): Text[10]
    begin
        EXIT(PADSTR('', 2, ' '));
    end;

    local procedure GetLineFeeNoteOnReportHist(SalesInvoiceHeaderNo: Code[20])
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Customer: Record Customer;
        LineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist.";
    begin
        TempLineFeeNoteOnReportHist.DELETEALL();
        CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SETRANGE("Document No.", SalesInvoiceHeaderNo);
        IF NOT CustLedgerEntry.FINDFIRST() THEN
            EXIT;

        IF NOT Customer.GET(CustLedgerEntry."Customer No.") THEN
            EXIT;

        LineFeeNoteOnReportHist.SETRANGE("Cust. Ledger Entry No", CustLedgerEntry."Entry No.");
        LineFeeNoteOnReportHist.SETRANGE("Language Code", Customer."Language Code");
        IF LineFeeNoteOnReportHist.FINDSET() THEN
            REPEAT
                TempLineFeeNoteOnReportHist.INIT();
                TempLineFeeNoteOnReportHist.COPY(LineFeeNoteOnReportHist);
                TempLineFeeNoteOnReportHist.INSERT();
            UNTIL LineFeeNoteOnReportHist.NEXT() = 0
        ELSE BEGIN
            LineFeeNoteOnReportHist.SETRANGE("Language Code", Language.GetUserLanguageCode());
            IF LineFeeNoteOnReportHist.FINDSET() THEN
                REPEAT
                    TempLineFeeNoteOnReportHist.INIT();
                    TempLineFeeNoteOnReportHist.COPY(LineFeeNoteOnReportHist);
                    TempLineFeeNoteOnReportHist.INSERT();
                UNTIL LineFeeNoteOnReportHist.NEXT() = 0;
        END;
    end;
}

