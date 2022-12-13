enum 50005 "BC6_Receipt Status"
{
    Extensible = false;
    Caption = 'Receipt Status', Comment = 'FRA="Statut réception"';

    value(0; " ")
    {
        Caption = ' ', Locked = true;
    }
    value(1; "Not receive")
    {
        Caption = 'Not receive', Comment = 'FRA="Non réceptionnée"';
    }
    value(2; "Partially receive")
    {
        Caption = 'Partially receive', Comment = 'FRA="Partiellement réceptionnée"';
    }
    value(3; Receive)
    {
        Caption = 'Receive', Comment = 'FRA="Réceptionnée"';
    }
}
