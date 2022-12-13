page 50099 "BC6_Company Picture"
{
    PageType = CardPart;
    SourceTable = "Company Information";
    Caption = 'Company Picture', Comment = 'FRA="Company Picture"';

    layout
    {
        area(content)
        {
            field(Picture; Rec.Picture)
            {
                Caption = 'Picture', Comment = 'FRA="Picture"';
                ShowCaption = false;
                ApplicationArea = All;
            }
        }
    }
}
