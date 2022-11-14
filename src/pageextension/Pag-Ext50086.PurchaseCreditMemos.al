pageextension 50086 "BC6_PurchaseCreditMemos" extends "Purchase Credit Memos"
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
            }
            field("BC6_Lines Amount"; Rec."BC6_Lines Amount")
            {
            }
        }
        addafter("Job Queue Status")
        {
            field("BC6_Creation date"; Rec."BC6_Creation date")
            {
            }
            field(BC6_Litige; Rec."BC6_Litige")
            {
            }
            field("BC6_Status Code"; Rec."BC6_Status Code")
            {
            }
            field("BC6_Status description"; Rec."BC6_Status description")
            {
            }
            field("BC6_Free comment"; Rec."BC6_Free comment")
            {
            }
            field("BC6_Register amount"; Rec."BC6_Register amount")
            {
            }
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