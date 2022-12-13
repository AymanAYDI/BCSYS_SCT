page 50025 "BC6_Matricule list"
{
    Caption = 'Matricule list', Comment = 'FRA="Liste matricule"';
    PageType = Card;
    SourceTable = "BC6_Matricule";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Matricule No."; Rec."Matricule No.")
                {
                    ApplicationArea = All;
                }
                field("Provider name"; Rec."Provider name")
                {
                    ApplicationArea = All;
                }
                field("Provider first name"; Rec."Provider first name")
                {
                    ApplicationArea = All;
                }
                field("Society code"; Rec."Society code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
