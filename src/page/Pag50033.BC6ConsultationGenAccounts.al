page 50033 "BC6 Consultation Gen. Accounts"
{
    Caption = 'Consultation General Accounts', Comment = 'FRA="Consultation des comptes généraux"';
    PageType = NavigatePage;
    SourceTable = "G/L Account";
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    layout
    {
        area(content)
        {
            field("Choisissez les comptes à imprimer"; Choice)
            {
                Editable = false;
                ShowCaption = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Comptes 401*")
            {
                Caption = 'Comptes 401*';
                ApplicationArea = All;
                Image = Action;

                trigger OnAction()
                begin
                    Grec_GLEntry.RESET();
                    Grec_GLEntry.SETFILTER("G/L Account No.", '%1', '401*');
                    REPORT.RUNMODAL(REPORT::"BC6_Consult general accounts", TRUE, FALSE, Grec_GLEntry);
                    CurrPage.CLOSE();
                end;
            }
            action("Comptes 411*")
            {
                Image = NewChartOfAccounts;
                ApplicationArea = All;
                Caption = 'Comptes 411*';


                trigger OnAction()
                begin
                    Grec_GLEntry.RESET();
                    Grec_GLEntry.SETFILTER("G/L Account No.", '%1', '411*');
                    REPORT.RUNMODAL(REPORT::"BC6_Consult general accounts", TRUE, FALSE, Grec_GLEntry);
                    CurrPage.CLOSE();
                end;
            }
            action("Comptes 408*")
            {
                Image = Account;
                ApplicationArea = All;
                Caption = 'Comptes 408*';

                trigger OnAction()
                begin
                    Grec_GLEntry.RESET();
                    Grec_GLEntry.SETFILTER("G/L Account No.", '%1', '408*');
                    REPORT.RUNMODAL(REPORT::"Consult general accounts (FNP)", TRUE, FALSE, Grec_GLEntry);
                    CurrPage.CLOSE();
                end;
            }
            action("Comptes 418*")
            {
                Image = BankAccount;
                ApplicationArea = All;
                Caption = 'Comptes 418*';

                trigger OnAction()
                begin
                    Grec_GLEntry.RESET();
                    Grec_GLEntry.SETFILTER("G/L Account No.", '%1', '418*');
                    REPORT.RUNMODAL(REPORT::"Consult general accounts (FAE)", TRUE, FALSE, Grec_GLEntry);
                    CurrPage.CLOSE();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Choice := 'Choisissez les comptes à imprimer';
    end;

    var
        Grec_GLEntry: Record "G/L Entry";
        Choice: Text;
}

