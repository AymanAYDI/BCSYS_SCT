page 50038 "BC6_Yooz Parameters"
{
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Yooz Parameters', Comment = 'FRA="Paramètres Yooz"';
    PageType = Card;
    SourceTable = "BC6_Yooz Parameters";

    layout
    {
        area(content)
        {
            group("Paramètres Yooz")
            {
                field("Yooz Export Path"; Rec."Yooz Export Path")
                {
                    ApplicationArea = All;
                }
                field("Yooz Import Path"; Rec."Yooz Import Path")
                {
                    ApplicationArea = All;
                }
                field("Yooz Imported File Path"; Rec."Yooz Imported File Path")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        IF NOT Rec.GET() THEN BEGIN
            Rec.INIT();
            Rec.INSERT();
        END;
    end;
}

