pageextension 50054 "BC6_FixedAssetGLJournal" extends "Fixed Asset G/L Journal" //5628
{
    Caption = 'Fixed Asset G/L Journal', Comment = 'FRA="Feuille compta. immo."';
    actions
    {
        addafter("Insert Conv. LCY Rndg. Lines")
        {
            action("Mise à jour Axe Période")
            {
                Caption = 'Mise à jour Axe Période', Comment = 'FRA="se à jour Axe Période"';
                RunObject = report "BC6_Period axe update on GJL";
                ApplicationArea = All;
            }
        }
    }
}
