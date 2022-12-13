xmlport 50022 "BC6_Yooz Export Payment Nos."
{
    Caption = 'Yooz Export Payment Nos.', Comment = 'FRA="Export des numéros Yooz d''un bordereau"';
    schema
    {
        textelement(Root)
        {
            tableelement(Yooz; "Payment Header")
            {
                AutoSave = false;
                AutoUpdate = false;
                AutoReplace = false;
                trigger OnAfterGetRecord()
                begin
                    Yooz.FctYooz(TRUE);
                    Yooz.GET(Yooz."No.");
                    Gtext_Champ1 := '';
                    YoozTable.RESET();
                    YoozTable.SETRANGE("No.", Yooz."No.");
                    IF YoozTable.FINDFIRST() THEN
                        REPEAT
                            Gtext_Champ1 := Gtext_Champ1 + YoozTable."Applied Yooz No.";
                        UNTIL YoozTable.NEXT() = 0;
                end;
            }
            textelement(Gtext_Champ1)
            {

            }
        }
    }
    VAR
        PaymentLine_G: Record "Payment Line";
        YoozTable: Record "BC6_No. Yooz";
        YoozNo_G: Text;
        Text001: Label 'Yooz Invoices are integrated', Comment = 'FRA="Numéros Yooz du bordereau exportés"';

    LOCAL PROCEDURE FctYoozNo();
    BEGIN
        YoozNo_G := '';
        PaymentLine_G.RESET();
        PaymentLine_G.SETRANGE("No.", Yooz."No.");
        IF PaymentLine_G.FINDFIRST() THEN
            REPEAT
                YoozNo_G := YoozNo_G + PaymentLine_G."BC6_Applied Yooz No.";
            UNTIL PaymentLine_G.NEXT() = 0;
    END;

}
