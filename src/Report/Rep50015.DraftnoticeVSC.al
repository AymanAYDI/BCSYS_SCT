report 50015 "BC6_Draft notice VSC"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/DraftnoticeVSC.rdl';
    Caption = 'Draft notice', Comment = 'FRA="Virement"';

    dataset
    {
        dataitem("Payment Lines1"; 10866)
        {
            DataItemTableView = SORTING("No.", "Line No.");
            MaxIteration = 1;
            column(Payment_Lines1_No_; "No.")
            {
            }
            column(Payment_Lines1_Line_No_; "Line No.")
            {
            }
            dataitem(Vendor; 23)
            {
                DataItemLink = "No." = FIELD("Account No.");
                DataItemLinkReference = "Payment Lines1";
                DataItemTableView = SORTING("No.");
                PrintOnlyIfDetail = true;
                RequestFilterFields = "No.";
                column(Vendor_No_; "No.")
                {
                }
                dataitem(CopyLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number);
                    dataitem("Bank Account Buffer"; 10869)
                    {
                        DataItemTableView = SORTING("Customer No.", "Bank Branch No.", "Agency Code", "Bank Account No.");
                        column(Bank_Account_Buffer_Customer_No_; "Customer No.")
                        {
                        }
                        column(Bank_Account_Buffer_Bank_Branch_No_; "Bank Branch No.")
                        {
                        }
                        column(Bank_Account_Buffer_Agency_Code; "Agency Code")
                        {
                        }
                        column(Bank_Account_Buffer_Bank_Account_No_; "Bank Account No.")
                        {
                        }
                        dataitem("Payment Line"; 10866)
                        {
                            DataItemLink = "Account No." = FIELD("Customer No."), "Bank Branch No." = FIELD("Bank Branch No."), "Agency Code" = FIELD("Agency Code"), "Bank Account No." = FIELD("Bank Account No.");
                            DataItemLinkReference = "Bank Account Buffer";
                            DataItemTableView = SORTING("No.", "Account No.", "Bank Branch No.", "Agency Code", "Bank Account No.", "Payment Address Code");
                            column(FORMAT_PostingDate_0_4_; FORMAT(PostingDate, 0, 4))
                            {
                            }
                            column(Payment_Lines1___No__; "Payment Lines1"."No.")
                            {
                            }
                            column(PaymtHeader_IBAN; PaymtHeader.IBAN)
                            {
                            }
                            column(VendAddr_7_; VendAddr[7])
                            {
                            }
                            column(PaymtHeader_SWIFT_Code; PaymtHeader."SWIFT Code")
                            {
                            }
                            column(VendAddr_6_; VendAddr[6])
                            {
                            }
                            column(CompanyInformation__VAT_Registration_No__; CompanyInformation."VAT Registration No.")
                            {
                            }
                            column(VendAddr_5_; VendAddr[5])
                            {
                            }
                            column(CompanyInformation__Fax_No__; CompanyInformation."Fax No.")
                            {
                            }
                            column(VendAddr_4_; VendAddr[4])
                            {
                            }
                            column(CompanyInformation__Phone_No__; CompanyInformation."Phone No.")
                            {
                            }
                            column(VendAddr_3_; VendAddr[3])
                            {
                            }
                            column(CompanyAddr_6_; CompanyAddr[6])
                            {
                            }
                            column(VendAddr_2_; VendAddr[2])
                            {
                            }
                            column(CompanyAddr_5_; CompanyAddr[5])
                            {
                            }
                            column(VendAddr_1_; VendAddr[1])
                            {
                            }
                            column(CompanyAddr_4_; CompanyAddr[4])
                            {
                            }
                            column(CompanyAddr_3_; CompanyAddr[3])
                            {
                            }
                            column(CompanyAddr_2_; CompanyAddr[2])
                            {
                            }
                            column(CompanyAddr_1_; CompanyAddr[1])
                            {
                            }
                            column(STRSUBSTNO_Text002_CopyText_; STRSUBSTNO(Text002, CopyText))
                            {
                            }
                            column(PrintCurrencyCode; PrintCurrencyCode())
                            {
                            }
                            column(OutputNo; OutputNo)
                            {
                            }
                            column(Vendor__No__; Vendor."No.")
                            {
                            }
                            column(CopyLoop_Number; CopyLoop.Number)
                            {
                            }
                            column(Bank_Account_Buffer___Agency_Code_; "Bank Account Buffer"."Agency Code")
                            {
                            }
                            column(Bank_Account_Buffer___Customer_No__; "Bank Account Buffer"."Customer No.")
                            {
                            }
                            column(Bank_Account_Buffer___Bank_Branch_No__; "Bank Account Buffer"."Bank Branch No.")
                            {
                            }
                            column(Bank_Account_Buffer___Bank_Account_No__; "Bank Account Buffer"."Bank Account No.")
                            {
                            }
                            column(HeaderText1; HeaderText1)
                            {
                            }
                            column(PrintCurrencyCode_Control1120069; PrintCurrencyCode())
                            {
                            }
                            column(ABS_Amount_; ABS(Amount))
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(Payment_Line__Due_Date_; FORMAT("Due Date"))
                            {
                            }
                            column(PostingDate; FORMAT(PostingDate))
                            {
                            }
                            column(Payment_Line__External_Document_No__; "External Document No.")
                            {
                            }
                            column(PaymtHeader__Payment_Class_Name_; PaymtHeader."Payment Class Name")
                            {
                            }
                            column(Payment_Line__Document_No__; "Document No.")
                            {
                            }
                            column(PrintCurrencyCode_Control1120064; PrintCurrencyCode())
                            {
                            }
                            column(DraftAmount; DraftAmount)
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(TotalDraftAmount; TotalDraftAmount)
                            {
                            }
                            column(Payment_Line_No_; "No.")
                            {
                            }
                            column(Payment_Line_Line_No_; "Line No.")
                            {
                            }
                            column(Payment_Line_Payment_Address_Code; "Payment Address Code")
                            {
                            }
                            column(Payment_Line_Account_No_; "Account No.")
                            {
                            }
                            column(Payment_Line_Bank_Branch_No_; "Bank Branch No.")
                            {
                            }
                            column(Payment_Line_Agency_Code; "Agency Code")
                            {
                            }
                            column(Payment_Line_Bank_Account_No_; "Bank Account No.")
                            {
                            }
                            column(Payment_Line_Applies_to_ID; "Applies-to ID")
                            {
                            }
                            column(Payment_Lines1___No__Caption; Payment_Lines1___No__CaptionLbl)
                            {
                            }
                            column(PaymtHeader__IBAN__Caption; PaymtHeader__IBAN__CaptionLbl)
                            {
                            }
                            column(PaymtHeader__SWIFT_Code__Caption; PaymtHeader__SWIFT_Code__CaptionLbl)
                            {
                            }
                            column(CompanyInformation__VAT_Registration_No__Caption; CompanyInformation__VAT_Registration_No__CaptionLbl)
                            {
                            }
                            column(CompanyInformation__Fax_No__Caption; CompanyInformation__Fax_No__CaptionLbl)
                            {
                            }
                            column(CompanyInformation__Phone_No__Caption; CompanyInformation__Phone_No__CaptionLbl)
                            {
                            }
                            column(PrintCurrencyCodeCaption; PrintCurrencyCodeCaptionLbl)
                            {
                            }
                            column(Draft_Notice_AmountCaption; Draft_Notice_AmountCaptionLbl)
                            {
                            }
                            column(Payment_Line__Payment_Line___No__; "Payment Line"."No.")
                            {
                            }
                            column(Gtxt_Vendor; Gtxt_Vendor)
                            {
                            }
                            column(CompanyInformation_Picture; CompanyInformation.Picture)
                            {
                            }
                            column(Invoice_No_Caption; Invoice_No_CaptionLbl)
                            {
                            }
                            column(SERVICE_COMPTABLECaption; SERVICE_COMPTABLECaptionLbl)
                            {
                            }
                            column(Invoice_DateCaption; Invoice_DateCaptionLbl)
                            {
                            }
                            column(Remaining_Amount__Control1120059Caption; Remaining_Amount__Control1120059CaptionLbl)
                            {
                            }
                            column(Gdec_TotalAmount; Gdec_TotalAmount)
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(Gtxt_ResponsableComptable; Gtxt_ResponsableComptable)
                            {
                            }
                            column("Gtxt_TélComptabilité"; Gtxt_TélComptabilité)
                            {
                            }
                            column(STATEMENT_OF_TRANSFERCaption; STATEMENT_OF_TRANSFERCaptionLbl)
                            {
                            }
                            column(Payment_Line__Payment_Line___No__Caption; Payment_Line__Payment_Line___No__CaptionLbl)
                            {
                            }
                            column(CodeCaption; CodeCaptionLbl)
                            {
                            }
                            column(Vendor_Caption; Vendor_CaptionLbl)
                            {
                            }
                            column(HeaderText; HeaderText)
                            {
                            }
                            column(CompanyInformation__Legal_Form______Text006_____CompanyInformation__Stock_Capital_; CompanyInformation."Legal Form" + ' ' + Text006 + ' ' + CompanyInformation."Stock Capital")
                            {
                            }
                            column(DataItem1000000019; CompanyInformation.Address + ' ' + CompanyInformation."Address 2" + ' ' + CompanyInformation."Post Code" + ' ' + CompanyInformation.City)
                            {
                            }
                            column(CompanyInformation__Trade_Register_; CompanyInformation."Trade Register")
                            {
                            }
                            column(Text008_CompanyInformation__Phone_No_______FAX_____CompanyInformation__Fax_No__; Text008 + CompanyInformation."Phone No." + ' - FAX : ' + CompanyInformation."Fax No.")
                            {
                            }
                            dataitem("Vendor Ledger Entry"; 25)
                            {
                                CalcFields = "Remaining Amount";
                                DataItemLink = "Vendor No." = FIELD("Account No."), "Applies-to ID" = FIELD("Applies-to ID");
                                DataItemLinkReference = "Payment Line";
                                DataItemTableView = SORTING("Document No.");
                                column(HeaderText2; HeaderText2)
                                {
                                }
                                column(ABS__Remaining_Amount__; ABS("Remaining Amount"))
                                {
                                    AutoFormatExpression = "Currency Code";
                                    AutoFormatType = 1;
                                }
                                column(PrintCurrencyCode_Control1120060; PrintCurrencyCode())
                                {
                                }
                                column(Vendor_Ledger_Entry__Currency_Code_; "Currency Code")
                                {
                                }
                                column(ABS__Remaining_Amount___Control1120059; ABS("Remaining Amount"))
                                {
                                    AutoFormatExpression = "Currency Code";
                                    AutoFormatType = 1;
                                }
                                column(Vendor_Ledger_Entry__Document_No__; "Document No.")
                                {
                                }
                                column(Vendor_Ledger_Entry_Description; Description)
                                {
                                }
                                column(Vendor_Ledger_Entry__External_Document_No__; "External Document No.")
                                {
                                }
                                column(Vendor_Ledger_Entry__Posting_Date_; FORMAT("Posting Date"))
                                {
                                }
                                column(Vendor_Ledger_Entry__Due_Date_; FORMAT("Due Date"))
                                {
                                }
                                column(ABS__Remaining_Amount___Control1120036; ABS("Remaining Amount"))
                                {
                                    AutoFormatExpression = "Currency Code";
                                    AutoFormatType = 1;
                                }
                                column(PrintCurrencyCode_Control1120063; PrintCurrencyCode())
                                {
                                }
                                column(Vendor_Ledger_Entry_Entry_No_; "Entry No.")
                                {
                                }
                                column(Vendor_Ledger_Entry_Vendor_No_; "Vendor No.")
                                {
                                }
                                column(Vendor_Ledger_Entry_Applies_to_ID; "Applies-to ID")
                                {
                                }
                                column(Vendor_Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
                                {
                                }
                                column(Vendor_Ledger_Entry_DescriptionCaption; FIELDCAPTION(Description))
                                {
                                }
                                column(Vendor_Ledger_Entry__External_Document_No__Caption; FIELDCAPTION("External Document No."))
                                {
                                }
                                column(Vendor_Ledger_Entry__Posting_Date_Caption; Vendor_Ledger_Entry__Posting_Date_CaptionLbl)
                                {
                                }
                                column(Vendor_Ledger_Entry__Due_Date_Caption; Vendor_Ledger_Entry__Due_Date_CaptionLbl)
                                {
                                }
                                column(ABS__Remaining_Amount___Control1120059Caption; ABS__Remaining_Amount___Control1120059CaptionLbl)
                                {
                                }
                                column(ReportCaption; ReportCaptionLbl)
                                {
                                }
                                column(ReportCaption_Control1120015; ReportCaption_Control1120015Lbl)
                                {
                                }
                                column(Vendor_Ledger_Entry__Vendor_Ledger_Entry___Document_Date_; "Vendor Ledger Entry"."Document Date")
                                {
                                }
                                column(Remaining_Amount__Control1120059; -"Remaining Amount")
                                {
                                    AutoFormatExpression = "Currency Code";
                                    AutoFormatType = 1;
                                }

                                trigger OnAfterGetRecord()
                                begin
                                    IF "Payment Line"."Applies-to ID" = '' THEN
                                        CurrReport.SKIP()
                                        ;
                                    IF "Currency Code" = '' THEN
                                        "Currency Code" := GLSetup."LCY Code";

                                    DraftCounting := DraftCounting + 1;
                                end;

                                trigger OnPreDataItem()
                                begin
                                    //DEBUT AJOUT JX-XAD 21/04/2010
                                    /*IF (COMPANYNAME = 'VSC') OR (COMPANYNAME = 'VSC Test') OR (COMPANYNAME = 'VSCT') OR (COMPANYNAME = 'VSCT Test') THEN
                                    BEGIN
                                      Gtxt_ResponsableComptable := 'Aurélie Lucas';
                                      Gtxt_TélComptabilité := '01 74 54 13 87';
                                    END ELSE IF (COMPANYNAME = 'Agence') OR (COMPANYNAME = 'Agence Test') THEN
                                    BEGIN
                                      Gtxt_ResponsableComptable := 'Noria Gherbi-Hammadou';
                                      Gtxt_TélComptabilité := '01 74 54 13 35';
                                    END ELSE
                                      Gtxt_ResponsableComptable := '';
                                    */
                                    //FIN AJOUT JX-XAD 21/04/2010

                                    //DEBUT AJOUT JX-AUD 07/06/2012
                                    IF (COMPANYNAME = 'VSC') OR (COMPANYNAME = 'Agence') THEN BEGIN
                                        //Gtxt_ResponsableComptable := 'Nilma SAID-DAMAS';//JX-AUD du 02/07/2013
                                        //Gtxt_TélComptabilité := '01 74 54 13 63';//JX-AUD du 02/07/2013
                                        Gtxt_ResponsableComptable := 'Rabia Daulat'; //JX-AUD du 02/07/2013
                                        Gtxt_TélComptabilité := '01 74 54 18 31';//JX-AUD du 02/07/2013

                                    END;

                                    IF (COMPANYNAME = 'VSCT') THEN BEGIN
                                        Gtxt_ResponsableComptable := 'Stéphanie RABEMANANTSOA';
                                        Gtxt_TélComptabilité := '01 74 54 13 87';
                                    END;

                                    IF (COMPANYNAME = 'VFEC') THEN BEGIN //VSC GROUPE
                                        Gtxt_ResponsableComptable := 'Rabia DAULAT';
                                        Gtxt_TélComptabilité := '01 74 54 18 31';
                                    END;
                                    //FIN AJOUT JX-AUD 07/06/2012

                                end;
                            }

                            trigger OnAfterGetRecord()
                            var
                                PaymtAddr: Record "Payment Address";
                                PaymtManagt: Codeunit "Payment Management";
                            begin
                                IF Grec_Vendor.GET("Payment Line"."Account No.") THEN
                                    Gtxt_Vendor := Grec_Vendor.Name
                                ELSE
                                    Gtxt_Vendor := '';
                                HeaderText1 := STRSUBSTNO(Text004, "Bank Account Name", "SWIFT Code",
                                    "Agency Code", IBAN, PostingDate);

                                DraftCounting := 0;

                                TotalDraftAmount := TotalDraftAmount + ABS(Amount);

                                IF "Payment Address Code" = '' THEN
                                    FormatAddress.Vendor(VendAddr, Vendor)
                                ELSE
                                    IF PaymtAddr.GET("Account Type"::Vendor, "Account No.", "Payment Address Code") THEN
                                        PaymtManagt.PaymentAddr(VendAddr, PaymtAddr);

                                DraftAmount := ABS(Amount);
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE("No.", TransfertNo);
                                SETRANGE("Account No.", "Payment Lines1"."Account No.");
                                TotalDraftAmount := 0;

                                Gtxt_IBAN := '';
                                Gtxt_SWIFT := '';

                                IF Grec_Vendor.GET("Payment Line"."Account No.") THEN
                                    //MODIF JX-AUD du 11/02/14
                                    //IF Grec_VendorBankAccount.GET("Payment Line"."Account No.",Grec_Vendor."Default Bank Account Code") THEN
                                    IF Grec_VendorBankAccount.GET("Payment Line"."Account No.", "Payment Line"."Bank Account Code") THEN BEGIN //MODIF JX-AUD du 11/02/14
                                        Gtxt_IBAN := Grec_VendorBankAccount.IBAN;
                                        Gtxt_SWIFT := Grec_VendorBankAccount."SWIFT Code";
                                    END;

                                HeaderTextVN := STRSUBSTNO(Text004, "Payment Line"."Bank Branch No.",
                                  "Payment Line"."Agency Code", "Payment Line"."Bank Account No.", "Payment Line"."RIB Key", FORMAT(PostingDate, 0, 4));
                                DraftCounting := 0;
                                HeaderTextVI := STRSUBSTNO(Text005, Gtxt_IBAN, Gtxt_SWIFT, FORMAT(PostingDate, 0, 4));
                                DraftCounting := 0;

                                IF COPYSTR("Payment Line"."No.", 1, 2) = 'VN' THEN
                                    HeaderText := HeaderTextVN
                                ELSE
                                    HeaderText := HeaderTextVI;
                            end;
                        }
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF Number > 1 THEN BEGIN
                            CopyText := Text001;
                            OutputNo := OutputNo + 1;
                        END;
                    end;

                    trigger OnPreDataItem()
                    begin
                        OutputNo := 1;
                        LoopsNumber := ABS(CopiesNumber) + 1;
                        CopyText := '';
                        SETRANGE(Number, 1, LoopsNumber);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    PaymtLine.RESET();
                    PaymtLine.SETRANGE("No.", TransfertNo);
                    PaymtLine.SETRANGE("Account No.", "No.");
                    IF NOT PaymtLine.FINDFIRST() THEN
                        CurrReport.SKIP();
                end;
            }

            trigger OnAfterGetRecord()
            begin
                PaymtHeader.GET("No.");
                PaymtHeader.CALCFIELDS("Payment Class Name");
                PostingDate := PaymtHeader."Posting Date";

                BankAccountBuffer."Customer No." := "Account No.";
                BankAccountBuffer."Bank Branch No." := "Bank Branch No.";
                BankAccountBuffer."Agency Code" := "Agency Code";
                BankAccountBuffer."Bank Account No." := "Bank Account No.";
                IF NOT BankAccountBuffer.INSERT() THEN;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("No.", TransfertNo);
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
                    Caption = 'Options';
                    field(NumberOfCopies; CopiesNumber)
                    {
                        Caption = 'Number of copies', Comment = 'FRA="Nombre de copies"';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
    trigger OnPostReport()
    begin
        BankAccountBuffer.DELETEALL();
    end;

    trigger OnPreReport()
    begin
        TransfertNo := COPYSTR("Payment Lines1".GETFILTER("No."), 1, MAXSTRLEN(TransfertNo));
        IF TransfertNo = '' THEN
            ERROR(Text000);

        CompanyInformation.GET();
        FormatAddress.Company(CompanyAddr, CompanyInformation);
        GLSetup.GET();
    end;

    var
        BankAccountBuffer: Record "Bank Account Buffer";
        CompanyInformation: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        PaymtHeader: Record "Payment Header";
        PaymtLine: Record "Payment Line";
        Grec_Vendor: Record Vendor;
        Grec_VendorBankAccount: Record "Vendor Bank Account";
        FormatAddress: Codeunit "Format Address";
        TransfertNo: Code[20];
        PostingDate: Date;
        DraftAmount: Decimal;
        DraftCounting: Decimal;
        Gdec_TotalAmount: Decimal;
        TotalDraftAmount: Decimal;
        CopiesNumber: Integer;
        LoopsNumber: Integer;
        OutputNo: Integer;
        ABS__Remaining_Amount___Control1120059CaptionLbl: Label 'Amount', Comment = 'FRA="Montant"';
        CodeCaptionLbl: Label 'Code';
        CompanyInformation__Fax_No__CaptionLbl: Label 'FAX No.', Comment = 'FRA="N° Télécopie"';
        CompanyInformation__Phone_No__CaptionLbl: Label 'Phone No.', Comment = 'FRA="Nø téléphone"';
        CompanyInformation__VAT_Registration_No__CaptionLbl: Label 'VAT Registration No.', Comment = 'FRA="N° identif. intracomm."';
        Draft_Notice_AmountCaptionLbl: Label 'Draft Notice Amount', Comment = 'FRA="TOTAL"';
        HeaderText2: Label 'This transfer is related to these invoices :', Comment = 'FRA="Ce virement est lié aux factures suivantes :"';
        Invoice_DateCaptionLbl: Label 'Invoice Date', Comment = 'FRA="Date de facture"';
        Invoice_No_CaptionLbl: Label 'Invoice No.', Comment = 'FRA="N° de facture"';
        Payment_Line__Payment_Line___No__CaptionLbl: Label 'Draft No.', Comment = 'FRA="N° virement"';
        Payment_Lines1___No__CaptionLbl: Label 'Draft No.', Comment = 'FRA="N° virement"';
        PaymtHeader__IBAN__CaptionLbl: Label 'IBAN', Comment = 'FRA="N° compte international (IBAN)"';
        PaymtHeader__SWIFT_Code__CaptionLbl: Label 'SWIFT Code', Comment = 'FRA="Code SWIFT"';
        PrintCurrencyCodeCaptionLbl: Label 'Currency Code', Comment = 'FRA="Code devise"';
        Remaining_Amount__Control1120059CaptionLbl: Label 'Amount', Comment = 'FRA="Montant"';
        ReportCaption_Control1120015Lbl: Label 'Report', Comment = 'FRA="Etat"';
        ReportCaptionLbl: Label 'Report', Comment = 'FRA="Etat"';
        SERVICE_COMPTABLECaptionLbl: Label 'SERVICE COMPTABLE', Comment = 'FRA="Service comptabilité"';
        STATEMENT_OF_TRANSFERCaptionLbl: Label 'STATEMENT OF TRANSFER', Comment = 'FRA="RELEVE DES VIREMENTS"';
        Text000: Label 'You must specify a transfer number.', Comment = 'FRA="Vous devez spécifier un numéro de virement."';
        Text001: Label 'COPY', Comment = 'FRA="COPIE"';
        Text002: Label 'Draft notice %1', Comment = 'FRA="Avis de virement %1"';
        Text004: Label 'A transfer to your bank account %1 (RIB : %2 %3 %4) has been done on %5.', Comment = 'FRA="Un virement sur votre compte bancaire %1 (RIB : %2 %3 %4) a été effectué le %5."';
        Text005: Label 'Page %1';
        Text006: Label 'with capital of', Comment = 'FRA="au capital de"';
        Text008: Label 'Phone : ', Comment = 'FRA="Tél. : "';
        Vendor_CaptionLbl: Label 'Vendor ', Comment = 'FRA="Fournisseur"';
        Vendor_Ledger_Entry__Due_Date_CaptionLbl: Label 'Due Date', Comment = 'FRA="Date d''échéance"';
        Vendor_Ledger_Entry__Posting_Date_CaptionLbl: Label 'Posting Date', Comment = 'FRA="Date comptabilisation"';
        CopyText: Text;
        HeaderText1: Text;
        Gtxt_IBAN: Text[30];
        Gtxt_ResponsableComptable: Text[30];
        Gtxt_SWIFT: Text[30];
        "Gtxt_TélComptabilité": Text[30];
        CompanyAddr: array[8] of Text[50];
        Gtxt_Vendor: Text[100];
        VendAddr: array[8] of Text[50];
        HeaderText: Text[250];
        HeaderTextVI: Text[250];
        HeaderTextVN: Text[250];

    procedure PrintCurrencyCode(): Code[10]
    begin
        IF "Payment Lines1"."Currency Code" = '' THEN
            EXIT(GLSetup."LCY Code");

        EXIT("Payment Lines1"."Currency Code");
    end;
}

