page 50017 "BC6_Users-Staff"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Users-Staff', Comment = 'FRA="Utilisateurs-Personnels"';
    PageType = List;
    SourceTable = "BC6_Users-Staff";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("First name"; Rec."First name")
                {
                    ApplicationArea = All;
                }
                field("Full name"; Rec."Full name")
                {
                    ApplicationArea = All;
                }
                field("User status"; Rec."User status")
                {
                    ApplicationArea = All;
                }
                field("release date"; Rec."Release date")
                {
                    ApplicationArea = All;
                }
                field("Location 2"; Rec."Location 2")
                {
                    Caption = 'Location 2', Comment = 'FRA="Emplacement salarié"';
                    ApplicationArea = All;
                }
                field(Company; Rec."Company")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

