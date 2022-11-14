pageextension 50098 "BC6_GetPostDocPInvLnSubform" extends "Get Post.Doc - P.InvLn Subform"
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
                Caption = 'Dimensions';
                Image = Dimensions;
                ShortCutKey = 'Alt+D';
                trigger OnAction()
                begin
                    Rec.ModifyDimensions();
                end;
            }
        }
    }
}
