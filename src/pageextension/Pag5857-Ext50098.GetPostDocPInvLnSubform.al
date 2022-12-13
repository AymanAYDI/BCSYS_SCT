pageextension 50098 "BC6_GetPostDocPInvLnSubform" extends "Get Post.Doc - P.InvLn Subform" //5857
{
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
                AccessByPermission = tabledata Dimension = R;
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
}
