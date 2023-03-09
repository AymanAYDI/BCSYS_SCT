codeunit 50020 "BC6_Update ledger Entry"
{
    Permissions = tabledata "G/L Entry" = rimd;

    var
        LEntry: Record "G/L Entry";

    trigger OnRun()
    var
    begin
        LEntry.SETRANGE("Entry No.", 841171);
        LEntry.SETRANGE("Document No.", 'NDF01943');
        IF LEntry.FINDFIRST() THEN BEGIN
            LEntry.Description := 'NDF 10/2022 DAVID BROTTET - Trajet Dom-Gare';
            LEntry.MODIFY(TRUE);
            MESSAGE('Success');
        END;
    end;
}
