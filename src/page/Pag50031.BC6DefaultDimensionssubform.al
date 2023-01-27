page 50031 "BC6 Default Dimensions subform"
{
    // // Création LAB du 15/07/2010
    // // sous-formulaire pour formulaire récapitulatif des fournisseurs

    Caption = 'Default Dimensions Subform', Comment = 'FRA="Sous-formulaire affectations analytiques"';
    DataCaptionExpression = Rec.GetCaption();
    PageType = ListPart;
    SourceTable = "Default Dimension";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Dimension Code"; Rec."Dimension Code")
                {
                    ApplicationArea = All;
                }
                field("Dimension Value Code"; Rec."Dimension Value Code")
                {
                    ApplicationArea = All;
                }
                field("Value Posting"; Rec."Value Posting")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

