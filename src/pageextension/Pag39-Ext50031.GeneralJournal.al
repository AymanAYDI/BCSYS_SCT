pageextension 50031 "BC6_GeneralJournal" extends "General Journal" //39
{
    Caption = 'General Journal', Comment = 'FRA="Feuille comptabilité"';
    PromotedActionCategories = 'New,Process,Report,Bank,Application,Payroll';
    layout
    {
        modify("External Document No.")
        {
            Visible = true;
        }
        addfirst(Control1)
        {
            field("BC6_Line No."; Rec."Line No.")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
        addafter("Account No.")
        {
            field("BC6_Vendor No."; Rec."BC6_Vendor No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Customer No."; Rec."BC6_Customer No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(ShortcutDimCode8)
        {
            field("ShortcutDimCode[9]"; ShortcutDimCode[9])
            {
                CaptionClass = '1,2,9';
                Visible = false;
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    Rec.LookupShortcutDimCode(9, ShortcutDimCode[9]);
                end;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(9, ShortcutDimCode[9]);
                end;
            }
            field("ShortcutDimCode[10]"; ShortcutDimCode[10])
            {
                CaptionClass = '1,2,10';
                Visible = false;
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    Rec.LookupShortcutDimCode(10, ShortcutDimCode[10]);
                end;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(10, ShortcutDimCode[10]);
                end;
            }
        }
    }
    actions
    {
        modify("Test Report")
        {
            Visible = false;
        }
        modify(Post)
        {
            Visible = false;
        }
        modify(PostAndPrint)
        {
            Visible = false;
        }
        addfirst(Navigation)
        {
            group(BC6_CCA)
            {
                Caption = 'CCA', Comment = 'FRA="CCA"';
                action("BC6_Contrepasser les CCA")
                {
                    Caption = 'reverse invoices not received', Comment = 'FRA="Contrepasser les CCA"';
                    Ellipsis = true;
                    Image = Action;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ContrepasserCCA.SetEXTCCAJnlLine(Rec);
                        ContrepasserCCA.RUNMODAL();
                        CLEAR(ContrepasserCCA);
                    end;
                }
                action("Générer les CCA")
                {
                    Caption = 'generate invoices not received', Comment = 'FRA="Générer les CCA"';
                    ApplicationArea = All;
                    Image = Action;

                    trigger OnAction()
                    begin
                        GenererCCA.SetCCAJnlLine(Rec);
                        GenererCCA.RUNMODAL();
                        CLEAR(GenererCCA);
                    end;
                }
            }
            group(BC6_FNP)
            {
                Caption = 'FNP', Comment = 'FRA="FNP"';
                action("BC6_Contrepasser les FNP")
                {
                    Caption = 'reverse invoices not received', Comment = 'FRA="Contrepasser les FNP"';
                    Ellipsis = true;
                    ApplicationArea = All;
                    Image = Action;

                    trigger OnAction()
                    begin
                        ContrepasserFNP.SetEXTFNPJnlLine(Rec);
                        ContrepasserFNP.RUNMODAL();
                        CLEAR(ContrepasserFNP);
                    end;
                }
                action("Générer les FNP")
                {
                    Caption = 'generate invoices not received', Comment = 'FRA="Générer les FNP"';
                    ApplicationArea = All;
                    Image = Action;

                    trigger OnAction()
                    begin
                        GenererFNP.SetFNPJnlLine(Rec);
                        GenererFNP.RUNMODAL();
                        CLEAR(GenererFNP);
                    end;
                }
            }
        }
        addafter(ImportPayrollFile)
        {
            action("BC6_Import fichier compta. externe")
            {
                Caption = 'Import fichier compta. externe', Comment = 'FRA="Import fichier compta. externe"';
                Image = Import;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CLEAR(GénérerImportOD);
                    GénérerImportOD.SetODPaieJnlLine(Rec);
                    GénérerImportOD.RUN();
                end;
            }
        }
        addafter(SaveAsStandardJournal)
        {
            action("BC6_Test Report")
            {
                Caption = 'Test Report', Comment = 'FRA="Impression test"';
                Image = TestReport;
                Ellipsis = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    if Rec."Journal Batch Name" = 'C-POOL' then
                        Gcu_CheckJnlLine.ValidateLines(Rec."Journal Template Name", Rec."Journal Batch Name");
                    Gcu_CheckJnlLine.CheckGenJnlLines(Rec."Journal Template Name", Rec."Journal Batch Name");
                    ReportPrint.PrintGenJnlLine(Rec);
                end;
            }
        }
        addafter("BC6_Test Report")
        {
            action(BC6_Post)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'P&ost', Comment = 'FRA="&Valider"';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                ShortCutKey = 'F9';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.', Comment = 'FRA="Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books."';

                trigger OnAction()
                begin
                    if Rec."Journal Batch Name" = 'C-POOL' then
                        Gcu_CheckJnlLine.ValidateLines(Rec."Journal Template Name", Rec."Journal Batch Name");
                    Gcu_CheckJnlLine.CheckGenJnlLines(Rec."Journal Template Name", Rec."Journal Batch Name");
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", Rec);
                    CurrentJnlBatchName := Rec.GETRANGEMAX("Journal Batch Name");
                    CurrPage.UPDATE(false);
                end;
            }
        }
        addafter("BC6_Post")
        {
            action(BC6_PostAndPrint)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Post and &Print', Comment = 'FRA="Valider et i&mprimer"';
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                ShortCutKey = 'Shift+F9';
                ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.', Comment = 'FRA="Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out."';
                trigger OnAction()
                begin
                    if Rec."Journal Batch Name" = 'C-POOL' then
                        Gcu_CheckJnlLine.ValidateLines(Rec."Journal Template Name", Rec."Journal Batch Name");
                    Gcu_CheckJnlLine.CheckGenJnlLines(Rec."Journal Template Name", Rec."Journal Batch Name");
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post+Print", Rec);
                    CurrentJnlBatchName := Rec.GETRANGEMAX("Journal Batch Name");
                    CurrPage.UPDATE(false);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCodeV(ShortcutDimCode);
    end;

    var
        ContrepasserCCA: Report "BC6_Contrepassation des CCA";
        ContrepasserFNP: Report "BC6_Contrepassation des FNP";
        GenererCCA: Report "BC6_Génération des CCA";
        GenererFNP: Report "BC6_Génération des FNP";
        Gcu_CheckJnlLine: Codeunit "BC6_CheckJnlLine";
        ReportPrint: Codeunit "Test Report-Print";
        GénérerImportOD: XMLport "BC6_Import OD Paye";
        CurrentJnlBatchName: Code[10];
        ShortcutDimCode: array[10] of code[20];
}
