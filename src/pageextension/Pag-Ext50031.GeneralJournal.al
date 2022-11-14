pageextension 50031 "BC6_GeneralJournal" extends "General Journal"
{
    Caption = 'General Journal';
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
        addafter(ShortcutDimCode7)
        {
            field("ShortcutDimCode[3]"; ShortcutDimCode[3])
            {
                CaptionClass = '1,2,3';
                Visible = false;
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    Rec.LookupShortcutDimCode(3, ShortcutDimCode[3]);
                end;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                end;
            }
            field("ShortcutDimCode[4]"; ShortcutDimCode[4])
            {
                CaptionClass = '1,2,4';
                Visible = false;
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    Rec.LookupShortcutDimCode(4, ShortcutDimCode[4]);
                end;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                end;
            }
            field("ShortcutDimCode[5]"; ShortcutDimCode[5])
            {
                CaptionClass = '1,2,5';
                Visible = false;
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    Rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                end;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                end;
            }
            field("ShortcutDimCode[6]"; ShortcutDimCode[6])
            {
                CaptionClass = '1,2,6';
                Visible = false;
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    Rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                end;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                end;
            }
            field("ShortcutDimCode[7]"; ShortcutDimCode[7])
            {
                CaptionClass = '1,2,7';
                Visible = false;
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    Rec.LookupShortcutDimCode(7, ShortcutDimCode[7]);
                end;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                end;
            }
            field("ShortcutDimCode[8]"; ShortcutDimCode[8])
            {
                CaptionClass = '1,2,8';
                Visible = false;
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    Rec.LookupShortcutDimCode(8, ShortcutDimCode[8]);
                end;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                end;
            }
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
            Promoted = true;
            PromotedCategory = Process;
        }
        modify(PostAndPrint)
        {
            promoted = true;
            PromotedCategory = Process;
            Visible = false;
        }
        addfirst(Navigation)
        {
            group(BC6_CCA)
            {
                Caption = 'CCA';
                action("BC6_Contrepasser les CCA")
                {
                    Caption = 'reverse invoices not received';
                    Ellipsis = true;
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
                    Caption = 'generate invoices not received';
                    ApplicationArea = All;

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
                Caption = 'FNP';
                action("BC6_Contrepasser les FNP")
                {
                    Caption = 'reverse invoices not received';
                    Ellipsis = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ContrepasserFNP.SetEXTFNPJnlLine(Rec);
                        ContrepasserFNP.RUNMODAL();
                        CLEAR(ContrepasserFNP);
                    end;
                }
                action("Générer les FNP")
                {
                    Caption = 'generate invoices not received';
                    ApplicationArea = All;

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
                Caption = 'Import fichier compta. externe';
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
                Caption = 'Test Report';
                Image = TestReport;
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
                Caption = 'P&ost';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                ShortCutKey = 'F9';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

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
                Caption = 'Post and &Print';
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                ShortCutKey = 'Shift+F9';
                ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';
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
    var
        ContrepasserCCA: Report "BC6_Contrepassation des CCA";
        ContrepasserFNP: Report "BC6_Contrepassation des FNP";
        GenererCCA: Report "BC6_Génération des CCA";
        GenererFNP: Report "BC6_Génération des FNP";
        Gcu_CheckJnlLine: Codeunit "BC6_CheckJnlLine";
        ReportPrint: Codeunit "Test Report-Print";
        "GénérerImportOD": XMLport "BC6_Import OD Paye";
        CurrentJnlBatchName: Code[10];
}
