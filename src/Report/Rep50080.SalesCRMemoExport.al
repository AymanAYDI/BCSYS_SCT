report 50080 "BC6_Sales_CR.Memo_Export"
{
    ApplicationArea = All;
    Caption = 'Sales_CR.Memo_Export', Comment = 'FRA="Export_Avoirs_ventes"';
    UsageCategory = ReportsAndAnalysis;
    UseRequestPage = false;
    ProcessingOnly = true;
    trigger OnInitReport()
    var
        SalesCRMemoExport: xmlport "BC6_Sales_CR.Memo_Export";
    begin
        SalesCRMemoExport.TextEncoding := TextEncoding::Windows;
        SalesCRMemoExport.Run();
    end;
}
