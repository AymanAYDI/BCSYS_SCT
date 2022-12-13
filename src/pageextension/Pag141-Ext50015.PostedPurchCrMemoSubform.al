pageextension 50015 "BC6_PostedPurchCrMemoSubform" extends "Posted Purch. Cr. Memo Subform" //141
{
    // MODIF JX-XAD 04/05/2010
    // Creation de la fonction ReturnRecord dans le cadre de la modification analytique
    actions
    {
        modify(Dimensions)
        {
            visible = false;
        }
        addafter(Dimensions)
        {
            action(BC6_Dimensions2)
            {
                AccessByPermission = TableData Dimension = RM;
                ApplicationArea = all;
                Caption = 'Dimensions', Comment = 'FRA="Axes analytiques"';
                Image = Dimensions;
                ShortCutKey = 'Alt+D';

                trigger OnAction()
                begin
                    Rec."BC6_ModifyDimensions"();
                end;
            }
        }
    }
    procedure ReturnRecord(var Prec_PurchCrMemoLine: Record "Purch. Cr. Memo Line")
    begin
        Prec_PurchCrMemoLine := Rec;
    end;
}

