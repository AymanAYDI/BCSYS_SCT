report 50021 "BC6_Yooz Purch. Inv.&CrM. Imp"
{
    ApplicationArea = All;
    Caption = 'Yooz Purch. Inv.&CrM. Imp', Comment = 'FRA="Modifier axe période avoirs"';
    UsageCategory = Tasks;
    UseRequestPage = false;
    ProcessingOnly = true;
    trigger OnInitReport()
    var
        YoozPurchInv: xmlport "BC6_Yooz Purch. Inv.&CrM. Imp";
    begin
        YoozPurchInv.TextEncoding := TextEncoding::Windows;
        YoozPurchInv.Run();
    end;

}
