page 50048 "BC6_VSC Settings"
{
    Caption = 'VSC Settings', Comment = 'FRA="Paramètres VSC"';
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
                Caption = 'PDF Instance', Comment = 'FRA="Dossier PDF BC"';
                field("Use Temporary Path"; Rec."BCUse Temporary Path")
                {
                    ApplicationArea = All;
                }
                field("Company Name Import/Export"; Rec."Company Name Import/Export")
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
                Caption = 'PDF Instance', Comment = 'FRA="BC en mode Test"';
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
                Caption = 'PDF Instance', Comment = 'FRA="Avis de virement"';
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
                Caption = 'PDF Instance', Comment = 'FRA="Get URL"';
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
