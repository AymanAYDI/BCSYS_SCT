page 50048 "BC6_VSC Settings"
{
    Caption = 'VSC Settings';
    PageType = Card;
    SourceTable = "BC6_VSC Settings";
    ApplicationArea = All;
    UsageCategory = Tasks;
    layout
    {
        area(content)
        {
            group("PDF BC Path")
            {
                Caption = 'PDF Instance';
                field("Use Temporary Path"; Rec."BCUse Temporary Path")
                {
                    ApplicationArea = All;
                }
                field("BC Path"; Rec."BC Path")
                {
                    ApplicationArea = All;
                }
            }
            group("BC Test Mode")
            {
                Caption = 'PDF Instance';
                field("BBC Test Mode>"; Rec."BC Test Mode")
                {
                    ApplicationArea = All;
                }
                field("BC E-Mail Test"; Rec."BC E-Mail Test")
                {
                    ApplicationArea = All;
                }
            }
            group("Draft Notice")
            {
                Caption = 'PDF Instance';
                field("Draft Account. Depart. Manager"; Rec."Draft Account. Dep. Manag")
                {
                    ApplicationArea = All;
                }
                field("Draft Account. Depart. Phone"; Rec."Draft Account. Dep. Phone")
                {
                    ApplicationArea = All;
                }
            }
            group("Get URL")
            {
                Caption = 'PDF Instance';
                field("URL Type"; Rec."URL Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}
