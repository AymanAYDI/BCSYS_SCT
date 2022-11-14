report 50046 "BC6_Contrepassation des CCA"
{
    Caption = 'Reversal of invoices not received';
    ProcessingOnly = true;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = sorting("Entry No.");

            trigger OnAfterGetRecord()
            begin

                //Insertion ligne CREDIT
                Grec_FeuilleComptaEXTCCA.INIT();
                //JX-ABE-08/11/2017
                // Gint_Ligne += 10000;
                Gint_Ligne += 100;
                //Fin-modif-JX-ABE-08/11/2017
                Grec_FeuilleComptaEXTCCA."Line No." := Gint_Ligne;
                Grec_FeuilleComptaEXTCCA."Document No." := Gcode_NoEXTCCA;
                Grec_FeuilleComptaEXTCCA."External Document No." := PADSTR("External Document No.", 20);
                Grec_FeuilleComptaEXTCCA.VALIDATE("Source Code", Gcode_CodeJournal);
                Grec_FeuilleComptaEXTCCA.VALIDATE("Account No.", "G/L Account No.");
                Grec_FeuilleComptaEXTCCA.VALIDATE(Grec_FeuilleComptaEXTCCA."Posting Date", Gdate_Compta);
                Grec_FeuilleComptaEXTCCA.VALIDATE(Grec_FeuilleComptaEXTCCA."Document Date", "Document Date");
                if ("G/L Entry"."Debit Amount" <> 0) then
                    Grec_FeuilleComptaEXTCCA.VALIDATE("Credit Amount", "G/L Entry"."Debit Amount")
                else
                    Grec_FeuilleComptaEXTCCA.VALIDATE("Debit Amount", "G/L Entry"."Credit Amount");
                Grec_FeuilleComptaEXTCCA.Description := Description;
                Grec_FeuilleComptaEXTCCA."BC6_Vendor No." := "G/L Entry"."BC6_Vendor No.";
                Grec_FeuilleComptaEXTCCA."BC6_Customer No." := "G/L Entry"."BC6_Customer No.";
                Grec_FeuilleComptaEXTCCA.VALIDATE(Grec_FeuilleComptaEXTCCA."Gen. Bus. Posting Group", '');
                Grec_FeuilleComptaEXTCCA.VALIDATE(Grec_FeuilleComptaEXTCCA."Gen. Prod. Posting Group", '');
                Grec_FeuilleComptaEXTCCA.VALIDATE(Grec_FeuilleComptaEXTCCA."VAT Bus. Posting Group", '');
                Grec_FeuilleComptaEXTCCA.VALIDATE(Grec_FeuilleComptaEXTCCA."VAT Prod. Posting Group", '');
                // Migration 2015 - Plus d'insertion de l'analytique - Utilisation zone Dimension Set ID
                // InsérérAnalytique();
                Grec_FeuilleComptaEXTCCA."Dimension Set ID" := "G/L Entry"."Dimension Set ID";
                Grec_FeuilleComptaEXTCCA.INSERT();
            end;

            trigger OnPreDataItem()
            begin
                Grec_LigneNoSouche.RESET();
                Grec_LigneNoSouche.SETFILTER(Grec_LigneNoSouche."Series Code", 'CCA');
                Grec_LigneNoSouche.SETFILTER(Grec_LigneNoSouche.Open, '%1', true);
                if Grec_LigneNoSouche.FIND('-') then
                    Gcode_NoCCA := Grec_LigneNoSouche."Last No. Used";

                SETFILTER("G/L Entry"."Document No.", '%1', Gcode_NoCCA);

                Gint_Ligne := 0;
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
                    field("Date de comptabilisation"; Gdate_Compta)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        Grec_FeuilleComptaEXTCCA.SETRANGE("Journal Template Name", Grec_FeuilleComptaEXTCCA."Journal Template Name");
        Grec_FeuilleComptaEXTCCA.SETRANGE("Journal Batch Name", Grec_FeuilleComptaEXTCCA."Journal Batch Name");
        if (Grec_FeuilleComptaEXTCCA.COUNT > 0) then
            if not CONFIRM(Text002) then
                ERROR(Text003);
        Grec_FeuilleComptaEXTCCA.DELETEALL();
        Grec_FeuilleComptaEXTCCA.LOCKTABLE();
        Gcode_NoEXTCCA := Grec_FeuilleComptaEXTCCA."Document No.";
        Gcode_CodeJournal := Grec_FeuilleComptaEXTCCA."Source Code";

        if Grec_GenJnlBatch.GET(Grec_FeuilleComptaEXTCCA."Journal Template Name", Grec_FeuilleComptaEXTCCA."Journal Batch Name") then
            if Grec_GenJnlBatch."No. Series" <> 'EXTCCA' then
                ERROR(Text001);
    end;

    var
        Grec_GenJnlBatch: Record "Gen. Journal Batch";
        Grec_FeuilleComptaEXTCCA: Record "Gen. Journal Line";
        Grec_LigneNoSouche: Record "No. Series Line";
        Gcode_CodeJournal: Code[10];
        Gcode_NoCCA: Code[20];
        Gcode_NoEXTCCA: Code[20];
        Gdate_Compta: Date;
        Gint_Ligne: Integer;
        Text001: label 'This sheet is not a reversal of invoices not received.';
        Text002: label 'This sheet is not empty.\\All data being entered will be replaced.\\Would you like to continue ?';
        Text003: label 'Operation canceled';

    procedure SetEXTCCAJnlLine(FeuilleComptaEXTCCA: Record "Gen. Journal Line")
    begin
        Grec_FeuilleComptaEXTCCA := FeuilleComptaEXTCCA;
    end;
}
