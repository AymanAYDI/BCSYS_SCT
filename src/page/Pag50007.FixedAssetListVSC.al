page 50007 "BC6_Fixed Asset List VSC"
{
    // //CREATION LAB du 07/11/08
    // //Nouveau formulaire pour ligne achat
    // 
    // //JX-AUD du 30/05/2013
    // //Ajour du code Sous-classe Immo

    Caption = 'Fixed Asset List', Comment = 'FRA="Liste des immobilisations"';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Fixed Asset";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
                field("FA Subclass Code"; Rec."FA Subclass Code")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Search Description"; Rec."Search Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("FA Location Code"; Rec."FA Location Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

