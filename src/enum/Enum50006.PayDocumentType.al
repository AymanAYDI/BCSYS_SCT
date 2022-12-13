enum 50006 "BC6_Pay Document Type"
{
    Extensible = false;
    Caption = 'Pay Document Type', Comment = 'FRA="Type Document payé"';

    value(0; Invoice)
    {
        Caption = 'Invoice', Comment = 'FRA="Facture enregistrée"';
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
