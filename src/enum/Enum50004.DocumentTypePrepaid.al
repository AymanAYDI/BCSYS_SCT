enum 50004 "BC6_Document Type Prepaid"
{
    Extensible = false;
    Caption = 'Document Type Prepaid', Comment = 'FRA="Type Document Prépayé"';

    value(0; " ")
    {
        Caption = ' ', Locked = true;
    }
    value(1; Quote)
    {
        Caption = 'Quote', Comment = 'FRA="Devis"';
    }
    value(2; Order)
    {
        Caption = 'Order', Comment = 'FRA="Commande"';
    }
    value(3; FAP)
    {
        Caption = 'FAP', Comment = 'FRA="FAP"';
    }
}
