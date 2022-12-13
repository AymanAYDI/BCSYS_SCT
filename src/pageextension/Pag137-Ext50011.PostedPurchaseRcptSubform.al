pageextension 50011 "BC6_PostedPurchaseRcptSubform" extends "Posted Purchase Rcpt. Subform" //137
{
    //Permissions=TableData 17=rm; TODO
    // MODIF JX-XAD 04/05/2010
    // Ajout d'une fonction dans le cadre de la modification analytique
    actions
    {
        modify(Dimensions)
        {
            Visible = false;
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
                    Rec.BC6_ModifyDimensions();
                end;
            }
        }
    }
    procedure ReturnRecord(var Prec_PurchRcptLine: Record "Purch. Rcpt. Line")
    begin
        Prec_PurchRcptLine := Rec;
    end;
}

