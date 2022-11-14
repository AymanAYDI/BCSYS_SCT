pageextension 50054 "BC6_FixedAssetGLJournal" extends "Fixed Asset G/L Journal"
{
    Caption = 'Fixed Asset G/L Journal';
    actions
    {
        addafter("Insert Conv. LCY Rndg. Lines")
        {
            action("Mise à jour Axe Période")
            {
                Caption = 'Mise à jour Axe Période';
                RunObject = report "BC6_Period axe update on GJL";
                ApplicationArea = All;
            }
        }
    }
}
