enum 50007 "BC6_Droits acces doc. achat"
{
    Extensible = false;
    Caption = 'Droits acces doc. achat', Comment = 'FRA="Droits acces doc. achat"';

    value(0; Utilisateur)
    {
        Caption = 'User', Comment = 'FRA="Utilisateur"';
    }
    value(1; "Sous-Responsable")
    {
        Caption = 'Deputy head', Comment = 'FRA="Sous-Responsable"';
    }
    value(2; Responsable)
    {
        Caption = 'Responsible', Comment = 'FRA="Responsable"';
    }
    value(3; Admin)
    {
        Caption = 'Admin', Comment = 'FRA="Admin"';
    }
}
