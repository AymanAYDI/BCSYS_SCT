report 50018 "BC6_Contrepassation des FNP"
{
    // CEATION JX-XAD 27/10/2008
    // Contrepassation des FNP dans la feuille de comptabilité générale.
    //
    // JX-XAD 05/06/2009
    // Traduction en Anglais
    //
    // //Modif JX-AUD du 05/02/2013
    // //Retraitement des ajout des lignes analytiques

    Caption = 'Reversal of invoices not received', Comment = 'FRA="Contrepassation des FNP"';
    ProcessingOnly = true;

    dataset
    {
        dataitem("G/L Entry"; 17)
        {
            DataItemTableView = sorting("Entry No.");

            trigger OnAfterGetRecord()
            begin

                //Insertion ligne CREDIT
                Grec_FeuilleComptaEXTFNP.INIT();
                Gint_Ligne += 10000;
                Grec_FeuilleComptaEXTFNP."Line No." := Gint_Ligne;
                Grec_FeuilleComptaEXTFNP."Document No." := Gcode_NoEXTFNP;
                Grec_FeuilleComptaEXTFNP."External Document No." := PADSTR("External Document No.", 20);
                Grec_FeuilleComptaEXTFNP.VALIDATE("Source Code", Gcode_CodeJournal);
                Grec_FeuilleComptaEXTFNP.VALIDATE("Account No.", "G/L Account No.");
                Grec_FeuilleComptaEXTFNP.VALIDATE(Grec_FeuilleComptaEXTFNP."Posting Date", Gdate_Compta);
                Grec_FeuilleComptaEXTFNP.VALIDATE(Grec_FeuilleComptaEXTFNP."Document Date", "Document Date");
                if ("G/L Entry"."Debit Amount" <> 0) then
                    Grec_FeuilleComptaEXTFNP.VALIDATE("Credit Amount", "G/L Entry"."Debit Amount")
                else
                    Grec_FeuilleComptaEXTFNP.VALIDATE("Debit Amount", "G/L Entry"."Credit Amount");
                Grec_FeuilleComptaEXTFNP.Description := Description;
                Grec_FeuilleComptaEXTFNP."BC6_Vendor No." := "G/L Entry"."BC6_Vendor No.";
                Grec_FeuilleComptaEXTFNP.VALIDATE(Grec_FeuilleComptaEXTFNP."Gen. Bus. Posting Group", '');
                Grec_FeuilleComptaEXTFNP.VALIDATE(Grec_FeuilleComptaEXTFNP."Gen. Prod. Posting Group", '');
                Grec_FeuilleComptaEXTFNP.VALIDATE(Grec_FeuilleComptaEXTFNP."VAT Bus. Posting Group", '');
                Grec_FeuilleComptaEXTFNP.VALIDATE(Grec_FeuilleComptaEXTFNP."VAT Prod. Posting Group", '');
                //  InsérérAnalytique();   Modification NAv 2015
                Grec_FeuilleComptaEXTFNP."Dimension Set ID" := "Dimension Set ID";
                //  InsérérAnalytique();   Modification NAv 2015
                Grec_FeuilleComptaEXTFNP."Dimension Set ID" := "Dimension Set ID";
                Grec_FeuilleComptaEXTFNP.INSERT();
                //Gcode_NoEXTFNP := INCSTR(Gcode_NoEXTFNP);
            end;

            trigger OnPreDataItem()
            begin
                Grec_LigneNoSouche.RESET();
                Grec_LigneNoSouche.SETFILTER(Grec_LigneNoSouche."Series Code", 'FNP');
                Grec_LigneNoSouche.SETFILTER(Grec_LigneNoSouche.Open, '%1', true);
                if Grec_LigneNoSouche.FIND('-') then
                    Gcode_NoFNP := Grec_LigneNoSouche."Last No. Used";

                SETFILTER("G/L Entry"."Document No.", '%1', Gcode_NoFNP);

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
                field("Date de comptabilisation"; Gdate_Compta)
                {
                    ApplicationArea = All;
                    Caption = 'Date de comptabilisation', Comment = 'FRA="Date de comptabilisation"';
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        Grec_FeuilleComptaEXTFNP.SETRANGE("Journal Template Name", Grec_FeuilleComptaEXTFNP."Journal Template Name");
        Grec_FeuilleComptaEXTFNP.SETRANGE("Journal Batch Name", Grec_FeuilleComptaEXTFNP."Journal Batch Name");
        if (Grec_FeuilleComptaEXTFNP.COUNT > 0) then
            if not CONFIRM(Text002) then
                ERROR(Text003);
        Grec_FeuilleComptaEXTFNP.DELETEALL();
        Grec_FeuilleComptaEXTFNP.LOCKTABLE();
        Gcode_NoEXTFNP := Grec_FeuilleComptaEXTFNP."Document No.";
        Gcode_CodeJournal := Grec_FeuilleComptaEXTFNP."Source Code";

        if Grec_GenJnlBatch.GET(Grec_FeuilleComptaEXTFNP."Journal Template Name", Grec_FeuilleComptaEXTFNP."Journal Batch Name") then
            if Grec_GenJnlBatch."No. Series" <> 'EXTFNP' then
                ERROR(Text001);
    end;

    var
        Grec_GenJnlBatch: Record "Gen. Journal Batch";
        Grec_FeuilleComptaEXTFNP: Record "Gen. Journal Line";
        Grec_LigneNoSouche: Record "No. Series Line";
        Gcode_CodeJournal: Code[10];
        Gcode_NoEXTFNP: Code[20];
        Gcode_NoFNP: Code[20];
        Gdate_Compta: Date;
        Gint_Ligne: Integer;
        Text001: label 'This sheet is not a reversal of invoices not received.', Comment = 'FRA="Cette feuille n''est pas destinée à la contrepassation des FNP."';
        Text002: label 'This sheet is not empty.\\All data being entered will be replaced.\\Would you like to continue ?', Comment = 'FRA="Cette feuille n''est pas vide.\\Toutes les données actuellement saises seront remplacées.\\Souhaitez-vous tout de même poursuivre ?"';
        Text003: label 'Operation canceled', Comment = 'FRA="Opération annulée"';

    procedure SetEXTFNPJnlLine(FeuilleComptaEXTFNP: Record "Gen. Journal Line")
    begin
        Grec_FeuilleComptaEXTFNP := FeuilleComptaEXTFNP;
    end;
}
