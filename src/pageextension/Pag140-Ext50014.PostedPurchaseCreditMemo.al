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
                Caption = 'Modify dimension', Comment = 'FRA="Modifier axe"';
                action("période")
                {
                    Caption = 'period', Comment = 'FRA="période"';
                    ApplicationArea = All;
                    Image = Period;

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
                Caption = '&Line', Comment = 'FRA="&Ligne"';
                separator(Action90)
                {
                }
            }
        }
    }

    var
        ModifierAxe: Report "Modifier axe période avoirs";
    // ModifierAxesAvoir: Report "Modifier axes avoir";
    trigger OnOpenPage()
    var
        FunctionsMgt: Codeunit BC6_FunctionsMgt;
    begin
        //D‚but Modif JX-XAD du 05/08/2008
        //Filtrer sur le (ou les) utilisateur(s) li‚s au droit de l'utilisateur courant (voir table des paramŠtres utilisateur)
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("User ID", FunctionsMgt.jx_GetPurchasesFilter());
        Rec.FILTERGROUP(0);
        //Fin Modif JX-XAD du 05/08/2008
    end;
}
