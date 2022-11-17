page 50099 "BC6_Company Picture"
{
    PageType = CardPart;
    SourceTable = "Company Information";
    Caption = 'Company Picture';

    layout
    {
        area(content)
        {
            field(Picture; Rec.Picture)
            {
                Caption = 'Picture';
                ShowCaption = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}
