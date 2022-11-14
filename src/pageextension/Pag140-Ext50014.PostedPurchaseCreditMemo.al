pageextension 50014 "BC6_PostedPurchaseCreditMemo" extends "Posted Purchase Credit Memo" //140
{
    layout
    {
        addafter("Buy-from Contact")
        {
            field("BC6_Matricule No."; Rec."BC6_Matricule No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("No. Printed")
        {
            field(BC6_Litige; Rec."BC6_Litige")
            {
                ApplicationArea = All;
            }
            field("BC6_BC No."; Rec."BC6_BC No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Yooz No."; Rec."BC6_Yooz No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Yooz Token link"; Rec."BC6_Yooz Token link")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(Approvals)
        {
            group("BC6_Modifier axe")
            {
                Caption = 'Modify dimension';
                action("période")
                {
                    Caption = 'period';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ModifierAxe.SetPostedCreditMemo(Rec);
                        ModifierAxe.RUNMODAL();
                        CLEAR(ModifierAxe);
                    end;
                }
            }
            group("BC6_&Ligne")
            {
                Caption = '&Line';
                separator(Action90)
                {
                }
            }
        }
    }

    var
        ModifierAxe: Report "Modifier axe période avoirs";
    // ModifierAxesAvoir: Report "Modifier axes avoir";
}
