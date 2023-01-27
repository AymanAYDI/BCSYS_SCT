page 50024 "BC6_User code"
{
    // CREATION JX-XAD 17/04/2010
    // Formulaire des codes utilisateurs utilisé pour la gestion des contrats

    Caption = 'User code', Comment = 'FRA="Code utilisateur"';
    PageType = List;
    SourceTable = "User Setup";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                Editable = false;
                ShowCaption = false;
                field("User ID"; Rec."User ID")
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

