page 50053 "BC6_Mail Setup"
{
    PageType = List;
    SourceTable = "BC6_Mail Setup";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Mail Setup';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Mail Type"; Rec."Mail Type")
                {
                    ApplicationArea = All;
                }
                field(Subject; Rec."Subject")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        // area(processing)
        // {
        //     action("Modifier Mail Type")
        //     {
        //         Caption = 'Modifier Mail Type';
        //         Image = MailSetup;
        //         Promoted = true;
        //         PromotedCategory = Process;
        //         PromotedIsBig = true;
        //         ApplicationArea = All;

        //         trigger OnAction()
        //         var
        //             NavPad: Codeunit "BC6_NavPad Management";
        //         begin
        //             //TODO: Statut A vérifier a  migrer ou non dans l'excel pour le codeunit 50009 "NavPad Management" qui utilise l'automation waldoNavpad
        //             //NavPad.EditMailText(Rec);
        //         end;
        //     }
        // }
    }
}