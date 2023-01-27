page 50034 "BC6_Magnitude"
{
    // //CREATION JX-AUD du 15/12/2010
    // //Formulaire pour afficher la table Magnitude Correspondence 50009
    PageType = List;
    SourceTable = "BC6_Magnitude correspondence";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Magnitude';
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Line No."; Rec."Line No.")
                {
                    Caption = 'Line No.', Comment = 'FRA="N° ligne"';
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Rubric; Rec."Rubric")
                {
                    Caption = 'Rubric', Comment = 'FRA="Rubrique"';
                    ApplicationArea = All;
                }
                field(Level; Rec."Level")
                {
                    Caption = 'Level', Comment = 'FRA="Niveau"';
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    Caption = 'Account No.', Comment = 'FRA="N° compte"';
                    ApplicationArea = All;
                }
                field(Sign; Rec."Sign")
                {
                    Caption = 'Amount balance', Comment = 'FRA="Montant solde"';
                    ApplicationArea = All;
                }
            }
        }
    }
}

