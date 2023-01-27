report 50085 "BC6_FEC Enriched CAC"
{
    Caption = 'FEC Enriched CAC ', Comment = 'FRA="FEC Enrichi CAC"';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Tasks;
    dataset
    {
        dataitem(GLAccount; "G/L Account")
        {
            DataItemTableView = sorting("No.") where("Account Type" = const(Posting));
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                if IncludeOpeningBalances then
                    WriteGLAccountToFile(GLAccount);
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("No.", GLAccNoFilter);
            end;
        }
        dataitem(GLEntry; "G/L Entry")
        {
            DataItemTableView = sorting("Entry No.");

            trigger OnAfterGetRecord()
            begin
                if "Posting Date" <> CLOSINGDATE("Posting Date") then
                    ProcessGLEntry();
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("Posting Date", StartingDateV, EndingDateV);
                //   SETRANGE("Entry Type", "Entry Type"::Definitive);
                SETFILTER("G/L Account No.", GLAccount.GETFILTER("No."));
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
                    field(StartingDate; StartingDateV)
                    {
                        Caption = 'Starting Date', Comment = 'FRA="Date début"';
                        ClosingDates = true;
                        ApplicationArea = All;
                    }
                    field(EndingDate; EndingDateV)
                    {
                        Caption = 'Ending Date', Comment = 'FRA="Date fin"';
                        ClosingDates = true;
                        ApplicationArea = All;
                    }
                    field("Include Opening Balances"; IncludeOpeningBalances)
                    {
                        Caption = 'Include Opening Balances', Comment = 'FRA="Inclure soldes d''ouverture"';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
    trigger OnPostReport()
    begin
        ToFileName := GetFileName();
        Writer.Close();
        FileManagement.DownloadHandler(OutputFileName, '', '', '', ToFileName);
        Clear(oStream);
        ERASE(OutputFileName);
        MESSAGE(FileCreatedMsg);
    end;

    trigger OnPreReport()
    begin
        if StartingDateV = 0D then
            ERROR(MissingStartingDateErr);
        if EndingDateV = 0D then
            ERROR(MissingEndingDateErr);
        if GLAccount.GETFILTER("No.") <> '' then
            GLAccNoFilter := GLAccount.GETFILTER("No.");
        GLEntry.SETRANGE("Posting Date", StartingDateV, EndingDateV);
        //      GLEntry.SETRANGE("Entry Type", GLEntry."Entry Type"::Definitive);
        GLEntry.SETFILTER("G/L Account No.", GLAccNoFilter);
        if GLEntry.ISEMPTY then
            ERROR(NoEntriestoExportErr);

        CreateServerFile();
        WriteHeaderToFile();
    end;

    var
        FileManagement: Codeunit "File Management";
        IncludeOpeningBalances: Boolean;
        CustVendLedgEntryCurrencyCode: Code[10];
        CustVendLedgEntryPartyNo: Code[20];
        PayRecAccount: Code[20];
        GLAccNoFilter: Code[250];
        EndingDateV: Date;
        StartingDateV: Date;
        encoding: DotNet Encoding;
        Writer: DotNet StreamWriter;
        OutputFile: File;
        CurrentTransactionNo: Integer;
        FileCreatedMsg: label 'The text file was created successfully.', Comment = 'FRA="Le fichier texte a bien été créé."';
        InvalidWindowsChrStringTxt: label '""#%&*:<>?\/{|}~';
        MissingEndingDateErr: label 'You must enter an Ending Date.', Comment = 'FRA="Vous devez entrer une date de fin."';
        MissingStartingDateErr: label 'You must enter a Starting Date.', Comment = 'FRA="Vous devez entrer une date de début."';
        NoEntriestoExportErr: label 'There are no entries to export within the defined filter. The file was not created.', Comment = 'FRA="Il n''y a pas d''écriture à exporter dans le filtre défini. Le fichier n''a pas été créé."';
        ServerFileExtensionTxt: label 'TXT';
        oStream: OutStream;
        CustVendLedgEntryPartyName: Text[100];
        CustVendLedgEntryFCYAmount: Text[250];
        OutputFileName: Text;
        ToFileFullName: Text[250];
        ToFileName: Text[250];

    procedure Init(StartingDateValue: Date; EndingDateValue: Date; IncludeOpeningBalancesValue: Boolean; AccNoFilter: Code[250]; ReportFileNameValue: Text[250])
    begin
        StartingDateV := StartingDateValue;
        EndingDateV := EndingDateValue;
        IncludeOpeningBalances := IncludeOpeningBalancesValue;
        GLAccNoFilter := AccNoFilter;
        ToFileFullName := ReportFileNameValue;
    end;

    local procedure CreateServerFile()
    begin
        OutputFileName := FileManagement.ServerTempFileName(ServerFileExtensionTxt);
        if EXISTS(OutputFileName) then
            ERASE(OutputFileName);

        OutputFile.TEXTMODE(true);
        OutputFile.WRITEMODE(true);
        OutputFile.CREATEOUTSTREAM(oStream);

        Writer := Writer.StreamWriter(OutputFileName, false, encoding.Default); // append = FALSE
    end;

    local procedure FindGLRegister(var GLRegister: Record "G/L Register"; EntryNo: Integer)
    begin
        GLRegister.SETFILTER("From Entry No.", '<=%1', EntryNo);
        GLRegister.SETFILTER("To Entry No.", '>=%1', EntryNo);
        GLRegister.FINDFIRST();
    end;

    local procedure FormatAmount(Amount: Decimal): Text[250]
    begin
        exit(FORMAT(Amount, 0, '<Precision,2:2><Sign><Integer><Decimals><comma,,>'));
    end;

    local procedure GetBankLedgerEntryData(BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; var PartyNo: Code[20]; var PartyName: Text[50]; var Amount: Text[250]; var CurrencyCode: Code[10])
    var
        BankAcc: Record "Bank Account";
    begin
        if BankAcc.GET(BankAccountLedgerEntry."Bank Account No.") then begin
            PartyNo := BankAcc."No.";
            PartyName := BankAcc.Name;
        end;
        if BankAccountLedgerEntry."Currency Code" <> '' then begin
            Amount := FormatAmount(ABS(BankAccountLedgerEntry.Amount));
            CurrencyCode := BankAccountLedgerEntry."Currency Code";
        end
    end;

    local procedure GetCustomerLedgerEntryData(CustLedgerEntry: Record "Cust. Ledger Entry"; var PartyNo: Code[20]; var PartyName: Text[100]; var Amount: Text[250]; var CurrencyCode: Code[10])
    var
        Customer: Record "Customer";
        CountOfGLEntriesInTransaction: Integer;
    begin
        if Customer.GET(CustLedgerEntry."Customer No.") then begin
            PartyNo := Customer."No.";
            PartyName := Customer.Name;
        end;

        CountOfGLEntriesInTransaction := GetTransPayRecEntriesCount(CustLedgerEntry."Transaction No.", PayRecAccount);

        if (CustLedgerEntry."Currency Code" <> '') and (CountOfGLEntriesInTransaction = 1) then begin
            CustLedgerEntry.CALCFIELDS("Original Amount");
            Amount := FormatAmount(ABS(CustLedgerEntry."Original Amount"));
            CurrencyCode := CustLedgerEntry."Currency Code";
        end
    end;

    local procedure GetFileName(): Text[250]
    var
        CompanyInformation: Record "Company Information";
        FileName: Text[250];
    begin
        CompanyInformation.GET();
        FileName := FORMAT(CompanyInformation.GetSIREN()) +
          'FEC' +
          GetFormattedDate(EndingDateV) +
          '.txt';
        exit(DELCHR(FileName, '=', InvalidWindowsChrStringTxt));
    end;

    local procedure GetFormattedDate(GLEntryDate: Date): Text[8]
    begin
        if GLEntryDate <> 0D then
            exit(FORMAT(GLEntryDate, 8, '<Year4><Month,2><Day,2>'));
        exit('')
    end;

    local procedure GetOpeningBalance(): Decimal
    begin
        GLAccount.SETFILTER("Date Filter", STRSUBSTNO('..%1', CLOSINGDATE(CALCDATE('<-1D>', StartingDateV))));
        GLAccount.CALCFIELDS("Balance at Date");
        exit(GLAccount."Balance at Date")
    end;

    local procedure GetPayablesAccount(VendorPostingGroupCode: Code[10]): Code[20]
    var
        VendorPostingGroup: Record "Vendor Posting Group";
    begin
        VendorPostingGroup.GET(VendorPostingGroupCode);
        exit(VendorPostingGroup."Payables Account")
    end;

    local procedure GetReceivablesAccount(CustomerPostingGroupCode: Code[10]): Code[20]
    var
        CustomerPostingGroup: Record "Customer Posting Group";
    begin
        CustomerPostingGroup.GET(CustomerPostingGroupCode);
        exit(CustomerPostingGroup."Receivables Account")
    end;

    local procedure GetSourceCodeDesc("Code": Code[10]): Text[100]
    var
        SourceCode: Record "Source Code";
    begin
        if SourceCode.GET(Code) then
            exit(SourceCode.Description);
    end;

    local procedure GetVendorLedgerEntryData(VendorLedgerEntry: Record "Vendor Ledger Entry"; var PartyNo: Code[20]; var PartyName: Text[50]; var Amount: Text[250]; var CurrencyCode: Code[10])
    var
        Vendor: Record Vendor;
        CountOfGLEntriesInTransaction: Integer;
    begin
        if Vendor.GET(VendorLedgerEntry."Vendor No.") then begin
            PartyNo := Vendor."No.";
            PartyName := Vendor.Name;
        end;
        CountOfGLEntriesInTransaction := GetTransPayRecEntriesCount(VendorLedgerEntry."Transaction No.", PayRecAccount);

        if (VendorLedgerEntry."Currency Code" <> '') and (CountOfGLEntriesInTransaction = 1) then begin
            VendorLedgerEntry.CALCFIELDS("Original Amount");
            Amount := FormatAmount(ABS(VendorLedgerEntry."Original Amount"));
            CurrencyCode := VendorLedgerEntry."Currency Code";
        end
    end;

    procedure GetLedgerEntryDataForCustVend(TransactionNo: Integer; var PartyNo: Code[20]; var PartyName: Text[100]; var FCYAmount: Text[250]; var CurrencyCode: Code[10])
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        CustLedgerEntry.SETRANGE("Transaction No.", TransactionNo);
        if CustLedgerEntry.FINDFIRST() then begin
            PayRecAccount := GetReceivablesAccount(CustLedgerEntry."Customer Posting Group");
            CustLedgerEntry.SETFILTER("Customer No.", '<>%1', CustLedgerEntry."Customer No.");
            if CustLedgerEntry.FINDFIRST() then begin
                PartyName := 'multi-clients';
                PartyNo := '*';
            end else
                GetCustomerLedgerEntryData(CustLedgerEntry, PartyNo, PartyName, FCYAmount, CurrencyCode);
            exit;
        end;

        VendorLedgerEntry.SETRANGE("Transaction No.", TransactionNo);
        if VendorLedgerEntry.FINDFIRST() then begin
            PayRecAccount := GetPayablesAccount(VendorLedgerEntry."Vendor Posting Group");
            VendorLedgerEntry.SETFILTER("Vendor No.", '<>%1', VendorLedgerEntry."Vendor No.");
            if VendorLedgerEntry.FINDFIRST() then begin
                PartyName := 'multi-fournisseurs';
                PartyNo := '*';
            end else
                GetVendorLedgerEntryData(VendorLedgerEntry, PartyNo, PartyName, FCYAmount, CurrencyCode);
        end
    end;

    local procedure GetTransPayRecEntriesCount(TransactionNo: Integer; PayRecAccount: Code[20]): Integer
    var
        GLAccNoFilterV: Code[250];
        GLEntryCount: Integer;
    begin
        GLAccNoFilterV := GLEntry.GETFILTER("G/L Account No.");
        GLEntry.SETRANGE("G/L Account No.", PayRecAccount);
        GLEntry.SETRANGE("Transaction No.", TransactionNo);
        GLEntryCount := GLEntry.COUNT;
        GLEntry.SETRANGE("Transaction No.");
        GLEntry.SETFILTER("G/L Account No.", GLAccNoFilterV);
        exit(GLEntryCount)
    end;

    local procedure ProcessGLEntry()
    var
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        GLRegister: Record "G/L Register";
        CurrencyCode: Code[10];
        PartyNo: Code[20];
        PartyName: Text[100];
        FCYAmount: Text[250];
    begin
        if GLEntry."Transaction No." <> CurrentTransactionNo then begin
            ResetTransactionData();
            GetLedgerEntryDataForCustVend(
              GLEntry."Transaction No.",
              CustVendLedgEntryPartyNo,
              CustVendLedgEntryPartyName,
              CustVendLedgEntryFCYAmount,
              CustVendLedgEntryCurrencyCode);

            CurrentTransactionNo := GLEntry."Transaction No.";
        end;

        if BankAccountLedgerEntry.GET(GLEntry."Entry No.") then
            GetBankLedgerEntryData(BankAccountLedgerEntry, PartyNo, PartyName, FCYAmount, CurrencyCode);

        if GLEntry."G/L Account No." = PayRecAccount then begin
            PartyNo := CustVendLedgEntryPartyNo;
            PartyName := CustVendLedgEntryPartyName;
            FCYAmount := CustVendLedgEntryFCYAmount;
            CurrencyCode := CustVendLedgEntryCurrencyCode;
        end;

        FindGLRegister(GLRegister, GLEntry."Entry No.");

        WriteGLEntryToFile(
          GLRegister."No.",
          GLRegister."Creation Date",
          PartyNo,
          PartyName,
          FCYAmount,
          CurrencyCode);
    end;

    local procedure ResetTransactionData()
    begin
        CustVendLedgEntryPartyNo := '';
        CustVendLedgEntryPartyName := '';
        CustVendLedgEntryFCYAmount := '';
        CustVendLedgEntryCurrencyCode := '';
        PayRecAccount := '';
    end;

    local procedure WriteHeaderToFile()
    begin
        //Writer.WriteLine('JournalCode|JournalLib|EcritureNum|EcritureDate|CompteNum|CompteLib|CompAuxNum|CompAuxLib|PieceRef|' +
        //  'PieceDate|EcritureLib|Debit|Credit|EcritureLet|DateLet|ValidDate|Montantdevise|Idevise');

        Writer.WriteLine('JournalCode|JournalLib|EcritureNum|EcritureDate|CompteNum|CompteLib|CompAuxNum|CompAuxLib|PieceRef|' +
          'PieceDate|EcritureLib|Debit|Credit|EcritureLet|DateLet|ValidDate|Montantdevise|Idevise | User ID');
    end;

    local procedure WriteGLAccountToFile(GLAccount: Record "G/L Account")
    var
        CreditAmount: Decimal;
        DebitAmount: Decimal;
        OpeningBalance: Decimal;
    begin
        OpeningBalance := GetOpeningBalance();
        if OpeningBalance = 0 then
            exit;

        if GetOpeningBalance() > 0 then
            DebitAmount := OpeningBalance
        else
            CreditAmount := ABS(OpeningBalance);

        Writer.WriteLine('00000|' +
          'BALANCE OUVERTURE|' +
          '0|' +
          GetFormattedDate(StartingDateV) + '|' +
          GLAccount."No." + '|' +
          GLAccount.Name + '|' +
          '||' +
          '00000|' +
          GetFormattedDate(StartingDateV) + '|' +
          'BAL OUV ' + GLAccount.Name + '|' +
          FormatAmount(DebitAmount) + '|' +
          FormatAmount(CreditAmount) + '|' +
          '||' +
          GetFormattedDate(StartingDateV) +
          '||');
    end;

    local procedure WriteGLEntryToFile(GLRegisterNo: Integer; GLRegisterCreationDate: Date; PartyNo: Code[20]; PartyName: Text[50]; FCYAmount: Text[250]; CurrencyCode: Code[10])
    begin

        //WITH GLEntry DO BEGIN
        //  CALCFIELDS("G/L Account Name");
        //  Writer.WriteLine(
        //    "Source Code" + '|' +
        //    GetSourceCodeDesc("Source Code") + '|' +
        //    FORMAT(GLRegisterNo) + '|' +
        //    GetFormattedDate("Posting Date") + '|' +
        //    "G/L Account No." + '|' +
        //    "G/L Account Name" + '|' +
        //    FORMAT(PartyNo) + '|' +
        //    PartyName + '|' +
        //    "Document No." + '|' +
        //    GetFormattedDate("Document Date") + '|' +
        //    Description + '|' +
        //    FormatAmount("Debit Amount") + '|' +
        //    FormatAmount("Credit Amount") + '|' +
        //    Letter + '|' +
        //    GetFormattedDate("Letter Date") + '|' +
        //    GetFormattedDate(GLRegisterCreationDate) + '|' +
        //    FCYAmount + '|' +
        //    CurrencyCode);
        //END;
        GLEntry.CALCFIELDS("G/L Account Name");
        Writer.WriteLine(
          GLEntry."Source Code" + '|' +
          GetSourceCodeDesc(GLEntry."Source Code") + '|' +
          FORMAT(GLRegisterNo) + '|' +
          GetFormattedDate(GLEntry."Posting Date") + '|' +
          GLEntry."G/L Account No." + '|' +
          GLEntry."G/L Account Name" + '|' +
          FORMAT(PartyNo) + '|' +
          PartyName + '|' +
          GLEntry."Document No." + '|' +
          GetFormattedDate(GLEntry."Document Date") + '|' +
          GLEntry.Description + '|' +
          FormatAmount(GLEntry."Debit Amount") + '|' +
          FormatAmount(GLEntry."Credit Amount") + '|' +
          GLEntry.Letter + '|' +
          GetFormattedDate(GLEntry."Letter Date") + '|' +
          GetFormattedDate(GLRegisterCreationDate) + '|' +
          FCYAmount + '|' +
          CurrencyCode + '|' + GLEntry."User ID");
    end;
}
