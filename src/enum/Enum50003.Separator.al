enum 50003 "BC6_Separator"
{
    Extensible = false;
    Caption = 'Separator', Comment = 'FRA="Separator"';

    value(0; " ")
    {
        //Caption = '', Comment = 'FRA=" "';
        Caption = '';
    }
    value(1; Space)
    {
        Caption = 'Space', Comment = 'FRA="Space"';
    }
    value(2; "Carriage Return")
    {
        Caption = 'Carriage Return', Comment = 'FRA="Carriage Return"';
    }
}
