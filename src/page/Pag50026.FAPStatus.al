page 50026 "BC6_FAP Status"
{
    // //Creation JX-AUD du 23/04/2013
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'FAP Status';
    PageType = Card;
    SourceTable = "BC6_FAP Status";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Status No."; Rec."Status No.")
                {
                    Caption = 'Code Statut';
                    ApplicationArea = All;
                }
                field("Description status"; Rec."Description status")
                {
                    Caption = 'Description qualification';
                    ApplicationArea = All;
                }
                field(Bloked; Rec.Bloked)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
