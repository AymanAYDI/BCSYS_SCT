pageextension 50004 "BC6_GeneralLedgerSetup" extends "General Ledger Setup" //118
{
    // //Modif JX-VSC4.0-PBD du 26/01/15
    // Ajout Axes analytique (Shortcut 9 et 10)
    layout
    {
        addlast(General)
        {
            field("BC6_Default Payment Class"; Rec."BC6_Default Payment Class")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shortcut Dimension 8 Code")
        {
            field("BC6_Shortcut Dimension 9 Code"; Rec."BC6_Shortcut Dimension 9 Code")
            {
                ApplicationArea = All;
            }
            field("BC6_Shortcut Dimension 10 Code"; Rec."BC6_Shortcut Dimension 10 Code")
            {
                Enabled = false;
                Visible = false;
                ApplicationArea = All;
            }
        }
        addafter("Payroll Transaction Import")
        {
            group("BC6_Report Dimension Parameters")
            {
                Caption = 'Paramétrage Axes analytiques - Etats';
                field("BC6_Report Dimension 1"; Rec."BC6_Report Dimension 1")
                {
                    ApplicationArea = All;
                }
                field("BC6_Report Dimension 2"; Rec."BC6_Report Dimension 2")
                {
                    ApplicationArea = All;
                }
                field("BC6_Report Dimension 3"; Rec."BC6_Report Dimension 3")
                {
                    ApplicationArea = All;
                }
                field("BC6_Report Dimension 4"; Rec."BC6_Report Dimension 4")
                {
                    ApplicationArea = All;
                }
                field("BC6_Report Dimension 5"; Rec."BC6_Report Dimension 5")
                {
                    ApplicationArea = All;
                }
            }
        }

    }
}

