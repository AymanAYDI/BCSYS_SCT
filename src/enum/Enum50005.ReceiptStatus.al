enum 50005 "BC6_Receipt Status"
{
    Extensible = false;

    value(0; " ")
    {
        Caption = ' ', Locked = true;
    }
    value(1; "Not receive")
    {
        Caption = 'Not receive';
    }
    value(2; "Partially receive")
    {
        Caption = 'Partially receive';
    }
    value(3; Receive)
    {
        Caption = 'Receive';
    }
}
