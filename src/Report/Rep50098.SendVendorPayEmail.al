report 50098 "BC6_Send Vendor Pay. E-mail"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/SendVendorPaymentsEmail.rdl';

    dataset
    {
        dataitem("Payment Header"; "Payment Header")
        {
            RequestFilterFields = "No.";
            column(PaymentHeader_No; "Payment Header"."No.")
            {
            }
            column(CompanyInfo_Adress; RecGCompanyInfo.Address)
            {
            }
            column(CompanyInfo_Picture; RecGCompanyInfo.Picture)
            {
            }
            column(ObjectCaption; ObjectCaptionLbl)
            {
            }
            column(MessieursCaption; MessieursCaptionLbl)
            {
            }
            column(Text001; STRSUBSTNO(Text001, "Payment Header"."Document Date"))
            {
            }
            column(PaymentRefCaption; PaymentRefCaptionLbl)
            {
            }
            column(PaymentHeader_Amount; STRSUBSTNO(Text002, "Payment Header".Amount))
            {
            }
            column(Text003; Text003)
            {
            }
            column(CompanyInfoDetails; STRSUBSTNO(Text005, RecGCompanyInfo.Name, RecGCompanyInfo."Legal Form", RecGCompanyInfo."Stock Capital"))
            {
            }
            column(CompanyInfoAddress; STRSUBSTNO(Text006, RecGCompanyInfo.Address, RecGCompanyInfo."Address 2", RecGCompanyInfo."Post Code", RecGCompanyInfo.City))
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(AccountingServiceCaption; AccountingServiceCaptionLbl)
            {
            }
            column(DecGTotalAmount; DecGTotalAmount)
            {
            }
            dataitem("Payment Line"; "Payment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = WHERE("Account Type" = FILTER(Vendor));
                column(PaymentLine_No; "No.")
                {
                }
                column(PaymentLine_LineNo; "Line No.")
                {
                }
                column(Vendor_Name; RecGVendor.Name)
                {
                }
                column(Vendor_Address; RecGVendor.Address)
                {
                }
                column(Vendor_Address2; RecGVendor."Address 2")
                {
                }
                column(Vendor_PostCode; RecGVendor."Post Code")
                {
                }
                column(Vendor_City; RecGVendor.City)
                {
                }
                column(PaymentLine_IBAN; IBAN)
                {
                }
                column(Today; STRSUBSTNO(Text004, FORMAT(TODAY)))
                {
                }
                column(LocationCaption; LocationCaptionLbl)
                {
                }
                column(VendorNoCaption; VendorNoCaptionLbl)
                {
                }
                column(VendorNo; "Payment Line"."Account No.")
                {
                }
                column(TypeCaption; TypeCaptionLbl)
                {
                }
                column(DocNoCaption; DocNoCaptionLbl)
                {
                }
                column(YoozNoCaption; YoozNoCaptionLbl)
                {
                }
                column(InvoiceDateCaption; InvoiceDateCaptionLbl)
                {
                }
                column(AmountCaption; AmountCaptionLbl)
                {
                }
                column(CurrencyCaption; CurrencyCaptionLbl)
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
                {
                    DataItemLink = "Vendor No." = FIELD("Account No."),
                                   "Applies-to ID" = FIELD("Document No.");
                    column(VendLedgEntry_EntryNo; "Entry No.")
                    {
                    }
                    column(VendLedgEntry_DocType; "Document Type")
                    {
                    }
                    column(VendLedgEntry_ExternalDocNo; "External Document No.")
                    {
                    }
                    column(VendLedgEntry_DocDate; FORMAT("Document Date", 0, 4))
                    {
                    }
                    column(VendLedgEntry_Amount; DecGAmount)
                    {
                    }
                    column(VendLedgEntry_YoozNo; "BC6_Yooz No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CALCFIELDS(Amount);
                        DecGAmount := Amount * -1;
                    end;

                    trigger OnPreDataItem()
                    var
                        Yooz: Text[250];
                    begin
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    DecGTotalAmount += "Payment Line".Amount;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Account No.", CodGVendorNo);

                    DecGTotalAmount := 0;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        RecGCompanyInfo.GET;
        RecGCompanyInfo.CALCFIELDS(Picture);
    end;

    trigger OnPreReport()
    begin
        RecGVendor.GET(CodGVendorNo);
    end;

    var
        RecGCompanyInfo: Record "Company Information";
        ObjectCaptionLbl: Label 'Objet : Avis de virement bancaire';
        MessieursCaptionLbl: Label 'Madame, Monsieur,';
        Text001: Label 'Nous vous informons que nous avons viré, en date du %1, sur votre compte, dont le numéro est :';
        Text002: Label 'Le montant de';
        Text003: Label 'En règlement de :';
        Text004: Label 'Le %1';
        VendorNoCaptionLbl: Label 'N° fournisseur :';
        PaymentRefCaptionLbl: Label 'Réf. Virement :';
        TypeCaptionLbl: Label 'Type';
        DocNoCaptionLbl: Label 'N° doc';
        YoozNoCaptionLbl: Label 'N° interne';
        InvoiceDateCaptionLbl: Label 'Date facture';
        AmountCaptionLbl: Label 'Montant';
        CurrencyCaptionLbl: Label 'EUR';
        TotalCaptionLbl: Label 'Total';
        AccountingServiceCaptionLbl: Label 'Le service comptabilité.';
        PageCaptionLbl: Label 'Page';
        RecGPaymentHeader: Record "Payment Header";
        RecGVendor: Record Vendor;
        LocationCaptionLbl: Label 'A Paris La Défense';
        CodGVendorNo: Code[20];
        Text005: Label '%1 - %2 au capital de %3';
        Text006: Label '%1 %2 %3 %4';
        DecGTotalAmount: Decimal;
        CodGAppliedYoozNo: Code[20];
        DecGAmount: Decimal;
        RecGPurchaseHeader: Record "Purchase Header";

    procedure FctSetVendorNo(CodPVendorNo: Code[20])
    begin
        CodGVendorNo := CodPVendorNo;
    end;
}

