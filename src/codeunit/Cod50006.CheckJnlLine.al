/// <summary>
/// Codeunit BC6 CheckJnlLine (ID 50006).
/// </summary>
codeunit 50006 "BC6_CheckJnlLine"
{
    var
        Text001: label 'Error on line %1 document %2 !\\Vendor No. is required for account No. 409';
        Text002: label 'Error on line %1 document %2 !\\Customer No. is required for accounts 416, 418, 419';

    trigger OnRun()
    begin
    end;

    procedure ValidateLines(Pcode_JnlTemplateName: Code[20]; Pcode_JnlBatchName: Code[20]);
    var
        Lrec_DimSetEntry: Record "Dimension Set Entry";
        Lrec_GenJnlLine: Record "Gen. Journal Line";
        Lcode_AccountNo: Code[20];
        Lcode_Code: array[10] of Code[20];
        Lcode_ValueCode: array[10] of Code[20];
        Ldate_PostingDate: Date;
        Ldec_CreditAmount: Decimal;
        Ldec_DebitAmount: Decimal;
        Lint_Counter: Integer;
        Lopt_AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
    begin
        //Validation des lignes de la feuille compta concernant le cash pooling
        Lrec_GenJnlLine.RESET();
        Lrec_GenJnlLine.SETFILTER(Lrec_GenJnlLine."Journal Template Name", '%1', Pcode_JnlTemplateName);
        Lrec_GenJnlLine.SETFILTER(Lrec_GenJnlLine."Journal Batch Name", '%1', Pcode_JnlBatchName);

        if Lrec_GenJnlLine.FIND('-') then
            repeat

                //DEBUT MODIF JX-XAD 02/03/2011
                Lrec_DimSetEntry.RESET();
                Lrec_DimSetEntry.SETRANGE("Dimension Set ID", Lrec_GenJnlLine."Dimension Set ID");
                Lint_Counter := 0;
                if Lrec_DimSetEntry.FINDFIRST() then
                    repeat
                        Lint_Counter += 1;
                        Lcode_Code[Lint_Counter] := Lrec_DimSetEntry."Dimension Code";
                        Lcode_ValueCode[Lint_Counter] := Lrec_DimSetEntry."Dimension Value Code";
                    until Lrec_DimSetEntry.NEXT() = 0;
                //FIN MODIF JX-XAD 02/03/2011
                Ldate_PostingDate := Lrec_GenJnlLine."Posting Date";
                Lopt_AccountType := Lrec_GenJnlLine."Account Type".AsInteger();
                Lcode_AccountNo := Lrec_GenJnlLine."Account No.";
                Ldec_DebitAmount := Lrec_GenJnlLine."Debit Amount";
                Ldec_CreditAmount := Lrec_GenJnlLine."Credit Amount";
                Lrec_GenJnlLine.VALIDATE(Lrec_GenJnlLine."Posting Date", Ldate_PostingDate);
                Lrec_GenJnlLine.VALIDATE(Lrec_GenJnlLine."Account Type", Lopt_AccountType);
                Lrec_GenJnlLine.VALIDATE(Lrec_GenJnlLine."Account No.", Lcode_AccountNo);
                if Ldec_DebitAmount <> 0 then
                    Lrec_GenJnlLine.VALIDATE(Lrec_GenJnlLine."Debit Amount", Ldec_DebitAmount);
                if Ldec_CreditAmount <> 0 then
                    Lrec_GenJnlLine.VALIDATE(Lrec_GenJnlLine."Credit Amount", Ldec_CreditAmount);

                Lrec_GenJnlLine.MODIFY();
            until Lrec_GenJnlLine.NEXT() = 0;

        COMMIT();
    end;

    procedure CheckGenJnlLines(Pcode_JnlTemplateName: Code[20]; Pcode_JnlBatchName: Code[20]);
    var
        Lrec_GenJnlLine: Record "Gen. Journal Line";
    begin

        //V‚rification de la feuille de compta : les nø fourn doivent ˆtre renseign‚s pour les comptes 409, 408 et
        //les nø clien aussi pour les comptes 406, 418 et 419
        Lrec_GenJnlLine.RESET();
        Lrec_GenJnlLine.SETFILTER(Lrec_GenJnlLine."Journal Template Name", '%1', Pcode_JnlTemplateName);
        Lrec_GenJnlLine.SETFILTER(Lrec_GenJnlLine."Journal Batch Name", '%1', Pcode_JnlBatchName);

        if Lrec_GenJnlLine.FIND('-') then
            repeat

                if Lrec_GenJnlLine."Account Type" = Lrec_GenJnlLine."Account Type"::"G/L Account" then begin
                    if (COPYSTR(Lrec_GenJnlLine."Account No.", 1, 3) = '409') or
                       (COPYSTR(Lrec_GenJnlLine."Account No.", 1, 3) = '408') then//MODIF JX-AUD 07/09/2012
                        if Lrec_GenJnlLine."BC6_Vendor No." = '' then
                            ERROR(Text001, Lrec_GenJnlLine."Line No.", Lrec_GenJnlLine."Document No.");
                    if (COPYSTR(Lrec_GenJnlLine."Account No.", 1, 3) = '416') or
                       (COPYSTR(Lrec_GenJnlLine."Account No.", 1, 3) = '418') or
                       (COPYSTR(Lrec_GenJnlLine."Account No.", 1, 3) = '419') then
                        if Lrec_GenJnlLine."BC6_Customer No." = '' then
                            ERROR(Text002, Lrec_GenJnlLine."Line No.", Lrec_GenJnlLine."Document No.");
                end;
            until Lrec_GenJnlLine.NEXT() = 0;
    end;
}
