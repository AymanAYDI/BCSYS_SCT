pageextension 50086 "BC6_PurchaseCreditMemos" extends "Purchase Credit Memos" //9309
{
    layout
    {
        modify("Vendor Authorization No.")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }

        addafter("Vendor Authorization No.")
        {
            field("BC6_Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = all;
            }
            field("BC6_Lines Amount"; Rec."BC6_Lines Amount")
            {
                ApplicationArea = all;
            }
            field("BC6_Assigned User ID"; Rec."Assigned User ID")
            {
                ApplicationArea = all;
            }
        }
        addafter("Job Queue Status")
        {
            field("BC6_Creation date"; Rec."BC6_Creation date")
            {
                ApplicationArea = all;
            }
            field(BC6_Litige; Rec."BC6_Litige")
            {
                ApplicationArea = all;
            }
            field("BC6_Status Code"; Rec."BC6_Status Code")
            {
                ApplicationArea = all;
            }
            field("BC6_Status description"; Rec."BC6_Status description")
            {
                ApplicationArea = all;
            }
            field("BC6_Free comment"; Rec."BC6_Free comment")
            {
                ApplicationArea = all;
            }
            field("BC6_Register amount"; Rec."BC6_Register amount")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        modify(SendApprovalRequest)
        {
            Caption = 'Send A&pproval Request', Comment = 'FRA="Approbation d''avoir"';
        }
        modify(CancelApprovalRequest)
        {
            Caption = 'Cancel Approval Re&quest', Comment = 'FRA="Annuler l''approbation"';
        }
    }
    var
        FunctionsMgt: Codeunit "BC6_FunctionsMgt";

    trigger OnOpenPage()
    begin
        //Début Modif JX-XAD du 11/06/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Assigned User ID", FunctionsMgt.jx_GetPurchasesFilter());
        Rec.FILTERGROUP(0);
        //Fin Modif JX-XAD du 11/06/2008
    end;
}
