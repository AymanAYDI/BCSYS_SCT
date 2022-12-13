enum 50000 "BC6_VSC Historic Type"
{
    Extensible = false;
    Caption = 'Type', Comment = 'FRA="Type"';

    value(0; Invoice)
    {
        Caption = 'Invoice', Comment = 'FRA="Facture"';
    }
    value(1; Receipt)
    {
        Caption = 'Receipt', Comment = 'FRA="Reception"';
    }
    value(2; "Credit Memo")
    {
        Caption = 'Credit Memo', Comment = 'FRA="Avoir"';
    }
}
