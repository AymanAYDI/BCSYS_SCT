page 50014 "BC6_VSC historic"
{
    Caption = 'VSC historic';
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "BC6_VSC historic";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    Editable = false;
                    OptionCaption = 'Invoice,Receipt,Credit Memo';
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Date time"; Rec."Date time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
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

    /// <summary>
    /// InitForm.
    /// </summary>
    /// <param name="PRec_Historic">Record "BC6_VSC historic".</param>
    procedure InitForm(PRec_Historic: Record "BC6_VSC historic")
    begin
        Rec := PRec_Historic;
    end;
}
