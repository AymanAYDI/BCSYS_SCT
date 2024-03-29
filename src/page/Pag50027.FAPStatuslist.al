page 50027 "BC6_FAP Status list"
{
    // //Creation JX-AUD du 23/04/2013

    Caption = 'FAP Status list', Comment = 'FRA="Liste des statuts FAP"';
    Editable = false;
    PageType = List;
    SourceTable = "BC6_FAP Status";
    SourceTableView = sorting("Status No.") where(Bloked = filter(false));

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Status No."; Rec."Status No.")
                {
                    Caption = 'Code statut', Comment = 'FRA="Code statut"';
                    ApplicationArea = All;
                }
                field("Description status"; Rec."Description status")
                {
                    Caption = 'Description qualification', Comment = 'FRA="Libellé statut"';
                    ApplicationArea = All;
                }
            }
        }
    }
}
