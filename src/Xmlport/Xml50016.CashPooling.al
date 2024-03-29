xmlport 50016 "BC6_Cash Pooling"
{
    Caption = 'Cash Pooling', Comment = 'FRA="Cash Pooling"';
    Direction = Import;
    Format = VariableText;
    FieldSeparator = '|';
    UseRequestPage = false;
    FileName = '*.csv';

    schema
    {
        textelement(Root)
        {
            tableelement(CashPooling; Integer)
            {
                AutoSave = false;
                AutoUpdate = false;
                AutoReplace = false;
                textelement(Gtext_Champ1)
                {
                    trigger OnAfterAssignVariable()
                    begin
                        Grec_FeuilleCashPooling.CHANGECOMPANY(COMPANYNAME);
                        Grec_CompanyInfo.CHANGECOMPANY(COMPANYNAME);
                    end;
                }
                textelement(Gtext_Champ2)
                {
                }
                textelement(Gtext_Champ3)
                {
                }
                textelement(Gtext_Champ4)
                {
                }
                textelement(Gtext_Champ5)
                {
                }
                textelement(Gtext_Champ6)
                {
                }
                textelement(Gtext_Champ7)
                {
                }
                textelement(Gtext_Champ8)
                {
                }
                textelement(Gtext_Champ9)
                {
                }
                textelement(Gtext_Champ10)
                {
                }
                textelement(Gtext_Champ11)
                {
                }
                textelement(Gtext_Champ12)
                {
                }
                textelement(Gtext_Champ13)
                {
                }
                trigger OnBeforeInsertRecord()
                begin
                    TempGrec_GlobalTable.RESET();
                    TempGrec_GlobalTable.SETFILTER(TempGrec_GlobalTable.Description, 'OK');

                    //Pour chaque société, tester le code société et si il correspond, renseigner la feuille de compta
                    if TempGrec_GlobalTable.FindSet() then
                        repeat

                            Grec_CompanyInfo.CHANGECOMPANY(TempGrec_GlobalTable."Document No.");
                            Grec_CompanyInfo.GET();
                            if Grec_CompanyInfo."IC Partner Code" = Gtext_Champ1 then begin
                                TempGrec_GlobalTable."Posting date" := TODAY;

                                Grec_FeuilleCashPooling.CHANGECOMPANY(TempGrec_GlobalTable."Document No.");

                                //initialisation de la ligne
                                Grec_FeuilleCashPooling.INIT();
                                Grec_FeuilleCashPooling."Journal Template Name" := Gcode_JournalTemplateName;
                                Grec_FeuilleCashPooling."Journal Batch Name" := Gcode_JournalBatchName;

                                //d‚finition des champs
                                if EVALUATE(Grec_FeuilleCashPooling."Line No.", TempGrec_GlobalTable."Account No.") then begin
                                    TempGrec_GlobalTable."Account No." := FORMAT(Grec_FeuilleCashPooling."Line No." + 10000);
                                    TempGrec_GlobalTable.MODIFY();
                                end;

                                Gtext_AccountNo := Gtext_Champ10;

                                if EVALUATE(varDecimal, CONVERTSTR(Gtext_Champ12, '.', ',')) and (Gtext_Champ8 = 'C') then begin
                                    Gdec_CreditAmount := varDecimal;
                                    Grec_FeuilleCashPooling."Credit Amount" := Gdec_CreditAmount;
                                end;

                                if EVALUATE(varDecimal, CONVERTSTR(Gtext_Champ12, '.', ',')) and (Gtext_Champ8 = 'D') then begin
                                    Gdec_DebitAmount := varDecimal;
                                    Grec_FeuilleCashPooling."Debit Amount" := Gdec_DebitAmount;
                                end;

                                if EVALUATE(varInteger, COPYSTR(Gtext_Champ9, 1, 4)) then
                                    Gint_Year := varInteger;

                                if EVALUATE(varInteger, COPYSTR(Gtext_Champ9, 5, 2)) then
                                    Gint_Month := varInteger;

                                if EVALUATE(varInteger, COPYSTR(Gtext_Champ9, 7, 2)) then
                                    Gint_Day := varInteger;

                                Gdate_PostingDate := DMY2DATE(Gint_Day, Gint_Month, Gint_Year);
                                Grec_FeuilleCashPooling."Posting Date" := Gdate_PostingDate;
                                Grec_FeuilleCashPooling."Account No." := Gtext_AccountNo;
                                Grec_FeuilleCashPooling."Account Type" := Grec_FeuilleCashPooling."Account Type"::"G/L Account";
                                Grec_FeuilleCashPooling."Document No." := TempGrec_GlobalTable."External document No.";
                                Grec_FeuilleCashPooling."Source Code" := 'COMPTA';
                                Grec_FeuilleCashPooling."Posting Date" := Gdate_PostingDate;
                                Grec_FeuilleCashPooling."Account No." := Gtext_AccountNo;

                                Grec_FeuilleCashPooling.Description := Gtext_Champ5;

                                //insertion ligne
                                Grec_FeuilleCashPooling.INSERT();
                            end;
                        until TempGrec_GlobalTable.NEXT() = 0
                    else
                        ERROR(Text004)
                end;
            }
        }
    }
    var
        TempGrec_GlobalTable: Record "BC6_Global temporary table" TEMPORARY;
        Grec_Company: Record Company;
        Grec_CompanyInfo: Record "Company Information";
        Grec_GenJnlBatch: Record "Gen. Journal Batch";
        Grec_FeuilleCashPooling: Record "Gen. Journal Line";
        Grec_NoSeriesLine: Record "No. Series Line";
        Gcode_JournalBatchName: Code[10];
        Gcode_JournalTemplateName: Code[10];
        Gdate_PostingDate: Date;
        Gdec_CreditAmount: Decimal;
        Gdec_DebitAmount: Decimal;
        varDecimal: Decimal;
        Gint_Compteur: Integer;
        Gint_Day: Integer;
        Gint_Month: Integer;
        Gint_Year: Integer;
        varInteger: Integer;
        Text004: label 'No company accounting sheet contains named C-POOL', Comment = 'FRA="Aucune société ne contient de feuille de comptabilité nommée C-POOL"';
        Gtext_AccountNo: Text[20];

    trigger OnPreXMLport()
    begin

        Gint_Compteur := 0;
        Grec_CompanyInfo.GET();

        Gcode_JournalTemplateName := 'GÉNÉRAL';
        Gcode_JournalBatchName := 'C-POOL';

        TempGrec_GlobalTable.DELETEALL();
        Grec_Company.RESET();

        //Pour chaque société, déterminer si elle est paramétrée avec C-POOL, et initialiser le Nø doc et le nø ligne
        if Grec_Company.FIND('-') then
            repeat
                TempGrec_GlobalTable.INIT();
                TempGrec_GlobalTable."Document No." := Grec_Company.Name;

                Grec_FeuilleCashPooling.CHANGECOMPANY(Grec_Company.Name);
                Grec_NoSeriesLine.CHANGECOMPANY(Grec_Company.Name);
                Grec_GenJnlBatch.CHANGECOMPANY(Grec_Company.Name);

                if Grec_GenJnlBatch.GET(Gcode_JournalTemplateName, Gcode_JournalBatchName) then begin
                    TempGrec_GlobalTable.Description := 'OK';

                    Grec_FeuilleCashPooling.RESET();
                    Grec_FeuilleCashPooling.SETFILTER(Grec_FeuilleCashPooling."Journal Template Name", Gcode_JournalTemplateName);
                    Grec_FeuilleCashPooling.SETFILTER(Grec_FeuilleCashPooling."Journal Batch Name", Gcode_JournalBatchName);
                    if Grec_FeuilleCashPooling.FIND('+') then begin
                        TempGrec_GlobalTable."Account No." := FORMAT(Grec_FeuilleCashPooling."Line No." + 10000);
                        TempGrec_GlobalTable."External document No." := INCSTR(Grec_FeuilleCashPooling."Document No.");
                    end else begin
                        TempGrec_GlobalTable."Account No." := '10000';
                        Grec_NoSeriesLine.RESET();
                        Grec_NoSeriesLine.SETFILTER(Grec_NoSeriesLine."Series Code", Gcode_JournalBatchName);
                        Grec_NoSeriesLine.SETFILTER(Grec_NoSeriesLine.Open, '%1', true);
                        if Grec_NoSeriesLine.FIND('-') then
                            if Grec_NoSeriesLine."Last No. Used" <> '' then
                                TempGrec_GlobalTable."External document No." := INCSTR(Grec_NoSeriesLine."Last No. Used")
                            else
                                TempGrec_GlobalTable."External document No." := Grec_NoSeriesLine."Starting No.";
                    end;
                end;

                TempGrec_GlobalTable.INSERT();
            until Grec_Company.NEXT() = 0;

        Grec_FeuilleCashPooling.CHANGECOMPANY(COMPANYNAME);
        Grec_GenJnlBatch.CHANGECOMPANY(COMPANYNAME);
        Grec_NoSeriesLine.CHANGECOMPANY(COMPANYNAME);
    end;

    procedure SetCPOOLJnlLine(FeuilleCashPooling: Record "Gen. Journal Line");
    begin
        Grec_FeuilleCashPooling := FeuilleCashPooling;
    end;
}
