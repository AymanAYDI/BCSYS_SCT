report 50081 "BC6_Yooz Import Payable NY"
{
    Caption = 'Yooz Import Payable NY', Comment = 'FRA="Yooz import facture payable ex. suivant"';
    ApplicationArea = All;
    UsageCategory = Tasks;
    UseRequestPage = false;
    ProcessingOnly = true;
    trigger OnInitReport()
    var
        ImportPayableNY: xmlport "BC6_Yooz Import Payable NY";
    begin
        ImportPayableNY.TextEncoding := TextEncoding::Windows;
        ImportPayableNY.Run();
    end;

}
