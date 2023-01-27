report 50071 "BC6_Draft notice VSC 2"
{
    // NAVFR5.00,JX-VSC1.0-XAD,JX-VSC1.1-AUD,JX-VSC1.2-XAD
    // 
    // CREATION JDD-XD 03 Octobre 2008
    // Créée à partir du report 10868
    // 
    // MODIF JDD-XD 09/02/2009
    // Suppression de la valeur absolue sur le montant pour laisser apparaître le signe sur l'état
    // 
    // MODIF JDD-XD le 09/03/2009
    // Correction bug Microsoft suite appel support partnersource :
    // changement de la variable dans le TransHeader et le transfooter (DraftAmount)
    // 
    // //modif AUD du 22/04/2009
    // //traduction des champs Anglais/Français
    // 
    // -------------------------------------- V 1.2 --------------------------------------
    // 
    // //AJOUT JX-XAD 21/04/2010
    // //Traitement du nom du responsable et du téléphone à faire apparaître
    // 
    // //MODIF JX-XAD 03/05/2010
    // //Calcul du montant total directement par rapport aux lignes qui apparaissent sur l'état (avec la variable Gdec_TotalAmount)
    // 
    // -------------------------------------- V 2.0 --------------------------------------
    // //AJOUT JX-AUD 07/06/2012
    // //Modifications du nom du responsable et du téléphone
    // 
    // //JX-AUD du 02/07/2013
    // //Remplacement de Nilma par Rabia
    // 
    // //JX-AUD du 11/02/14
    // //Modification pour aller rechercher l'IBAN lorsque le compte bancaire n'est pas celui par défaut.
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/DraftnoticeVSC2.rdl';

    Caption = 'Draft notice', Comment = 'FRA="Avis de virement 2"';

    dataset
    {
        dataitem("Payment Lines1"; "Payment Line")
        {
            DataItemTableView = SORTING("No.", "Line No.");
            MaxIteration = 1;
            RequestFilterFields = "No.", "Account Type", "Account No.";
            column(Payment_Lines1_No_; "No.")
            {
            }
            column(Payment_Lines1_Line_No_; "Line No.")
            {
            }
            column(Bank_Account_Buffer_Customer_No_; "Account No.")
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
            column(Vendor_No_; "Account No.")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem("Payment Line"; "Payment Line")
                {
                    DataItemLink = "No." = FIELD("No."), "Account No." = FIELD("Account No.");
                    DataItemLinkReference = "Payment Lines1";
                    DataItemTableView = SORTING("No.", "Account No.", "Bank Branch No.", "Agency Code", "Bank Account No.", "Payment Address Code");
                    column(VendAddr_1_; VendAddr[1])
                    {
                    }
                    column(VendAddr_2_; VendAddr[2])
                    {
                    }
                    column(VendAddr_3_; VendAddr[3])
                    {
                    }
                    column(VendAddr_4_; VendAddr[4])
                    {
                    }
                    column(VendAddr_5_; VendAddr[5])
                    {
                    }
                    column(VendAddr_6_; VendAddr[6])
                    {
                    }
                    column(VendAddr_7_; VendAddr[7])
                    {
                    }
                    column(CompanyInformation_City_____Text007_FORMAT_TODAY_0_4_; CompanyInformation.City + ' ' + Text007 + FORMAT(TODAY, 0, 4))
                    {
                    }
                    column(Gtxt_Vendor; Gtxt_Vendor)
                    {
                    }
                    column(CompanyInformation_Picture; CompanyInformation.Picture)
                    {
                    }
                    column(Payment_Line__Payment_Line___Account_No__; "Payment Line"."Account No.")
                    {
                    }
                    column(Payment_Line__Payment_Line___No__; "Payment Line"."No.")
                    {
                    }
                    column(HeaderText; HeaderText)
                    {
                    }
                    column(CompanyInformation__Legal_Form______Text006_____CompanyInformation__Stock_Capital_; CompanyInformation."Legal Form" + ' ' + Text006 + ' ' + CompanyInformation."Stock Capital")
                    {
                    }
                    column(DataItem1000000011; CompanyInformation.Address + ' ' + CompanyInformation."Address 2" + ' ' + CompanyInformation."Post Code" + ' ' + CompanyInformation.City)
                    {
                    }
                    column(CompanyInformation__Trade_Register_; CompanyInformation."Trade Register")
                    {
                    }
                    column(Text008_CompanyInformation__Phone_No_______FAX_____CompanyInformation__Fax_No__; Text008 + CompanyInformation."Phone No." + ' - FAX : ' + CompanyInformation."Fax No.")
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
                    column(PrintCurrencyCode; "Currency Code")
                    {
                    }
                    column("Gtxt_TélComptabilité"; Gtxt_TélComptabilité)
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
                    column(STATEMENT_OF_TRANSFERCaption; STATEMENT_OF_TRANSFERCaptionLbl)
                    {
                    }
                    column(Invoice_No_Caption; Invoice_No_CaptionLbl)
                    {
                    }
                    column(Invoice_DateCaption; Invoice_DateCaptionLbl)
                    {
                    }
                    column(Remaining_Amount__Control1120059Caption; Remaining_Amount__Control1120059CaptionLbl)
                    {
                    }
                    column(Draft_Notice_AmountCaption; Draft_Notice_AmountCaptionLbl)
                    {
                    }
                    column(SERVICE_COMPTABLECaption; SERVICE_COMPTABLECaptionLbl)
                    {
                    }
                    column(Payment_Line_Line_No_; "Line No.")
                    {
                    }
                    column(Payment_Line_Payment_Address_Code; "Payment Address Code")
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
                    dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
                    {
                        CalcFields = "Remaining Amount";
                        DataItemLink = "Vendor No." = FIELD("Account No."), "Applies-to ID" = FIELD("Applies-to ID");
                        DataItemLinkReference = "Payment Line";
                        DataItemTableView = SORTING("Document No.");
                        column(Vendor_Ledger_Entry__Currency_Code_; "Currency Code")
                        {
                        }
                        column(Remaining_Amount__Control1120059; -"Remaining Amount")
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Vendor_Ledger_Entry__External_Document_No__; "External Document No.")
                        {
                        }
                        column(Vendor_Ledger_Entry__Vendor_Ledger_Entry___Document_Date_; "Vendor Ledger Entry"."Document Date")
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

                        trigger OnAfterGetRecord()
                        begin
                            IF "Payment Line"."Applies-to ID" = '' THEN
                                CurrReport.SKIP();
                            IF "Currency Code" = '' THEN
                                "Currency Code" := GLSetup."LCY Code";

                            DraftCounting := DraftCounting + 1;

                            Gdec_TotalAmount += (-"Remaining Amount");
                        end;

                        trigger OnPreDataItem()
                        begin
                            VSCSettings.GET();
                            Gtxt_ResponsableComptable := VSCSettings."Draft Account. Dep. Manag";
                            Gtxt_TélComptabilité := VSCSettings."Draft Account. Dep. Phone";
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

                        IF NOT Vendor.GET("Account No.") THEN
                            Vendor.INIT();
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
                    end;
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
                PaymtHeader.GET("No.");
                PaymtHeader.CALCFIELDS("Payment Class Name");
                PostingDate := PaymtHeader."Posting Date";

                Gtxt_IBAN := '';
                Gtxt_SWIFT := '';

                IF Grec_Vendor.GET("Account No.") THEN
                    //MODIF JX-AUD du 11/02/14
                    //IF Grec_VendorBankAccount.GET("Payment Line"."Account No.",Grec_Vendor."Default Bank Account Code") THEN
                    IF Grec_VendorBankAccount.GET("Account No.", "Bank Account Code") THEN BEGIN //MODIF JX-AUD du 11/02/14
                        Gtxt_IBAN := Grec_VendorBankAccount.IBAN;
                        Gtxt_SWIFT := Grec_VendorBankAccount."SWIFT Code";
                    END;

                HeaderTextVN := STRSUBSTNO(Text004, "Bank Branch No.",
                  "Agency Code", "Bank Account No.", "RIB Key", FORMAT(PostingDate, 0, 4));
                DraftCounting := 0;
                HeaderTextVI := STRSUBSTNO(Text005, Gtxt_IBAN, Gtxt_SWIFT, FORMAT(PostingDate, 0, 4));
                DraftCounting := 0;

                IF COPYSTR("No.", 1, 2) = 'VN' THEN
                    HeaderText := HeaderTextVN
                ELSE
                    HeaderText := HeaderTextVI;
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
                field("Nombre de copies"; CopiesNumber)
                {
                    ApplicationArea = All;
                    Caption = 'Nombre de copies';
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
        CompanyInformation.CALCFIELDS(CompanyInformation.Picture);

        FormatAddress.Company(CompanyAddr, CompanyInformation);
        GLSetup.GET();
    end;

    var
        BankAccountBuffer: Record "Bank Account Buffer";
        VSCSettings: Record "BC6_VSC Settings";
        CompanyInformation: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        PaymtHeader: Record "Payment Header";
        Grec_Vendor: Record Vendor;
        Vendor: Record Vendor;
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
        CodeCaptionLbl: Label 'Code';
        Draft_Notice_AmountCaptionLbl: Label 'Draft Notice Amount', Comment = 'FRA="TOTAL"';
        Invoice_DateCaptionLbl: Label 'Invoice Date', Comment = 'FRA="Date de facture"';
        Invoice_No_CaptionLbl: Label 'Invoice No.', Comment = 'FRA="N° de facture"';
        Payment_Line__Payment_Line___No__CaptionLbl: Label 'Draft No.', Comment = 'FRA="N° virement"';
        Remaining_Amount__Control1120059CaptionLbl: Label 'Amount', Comment = 'FRA="Montant"';
        SERVICE_COMPTABLECaptionLbl: Label 'SERVICE COMPTABLE', Comment = 'FRA="Service comptabilité"';
        STATEMENT_OF_TRANSFERCaptionLbl: Label 'STATEMENT OF TRANSFER', Comment = 'FRA="RELEVE DES VIREMENTS"';
        Text000: Label 'You must specify a transfer number.', Comment = 'FRA="Vous devez spécifier un numéro de virement."';
        Text001: Label 'COPY', Comment = 'FRA="COPIE"';
        Text004: Label 'We inform you that a transfer to your bank account (RIB : %1 %2 %3 %4) has been done on %5.', Comment = 'FRA="Nous vous informons que nous avons viré sur votre compte numéro %1 %2 %3 %4 en date de valeur du %5, la somme dont le détail figure ci-dessous."';
        Text005: Label 'We inform you that a transfer to your bank account %1 %2 ) has been done on %3.', Comment = 'FRA="Nous vous informons que nous avons viré sur votre compte numéro %1 %2 en date de valeur du %3, la somme dont le détail figure ci-dessous."';
        Text006: Label 'with capital of', Comment = 'FRA="au capital de"';
        Text007: Label ', ', Comment = 'FRA=", le "';
        Text008: Label 'Phone : ', Comment = 'FRA="Tél. : "';
        Vendor_CaptionLbl: Label 'Vendor ', Comment = 'FRA="Fournisseur"';
        HeaderText1: Text;
        CopyText: Text[30];
        Gtxt_IBAN: Text[50];
        Gtxt_ResponsableComptable: Text[100];
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

