report 50093 "BC6_Sales_Invoice_Export"
{
    ApplicationArea = All;
    Caption = 'Sales_Invoice_Export', Comment = 'FRA="Export_factures_ventes"';
    UsageCategory = ReportsAndAnalysis;
    UseRequestPage = false;
    ProcessingOnly = true;
    trigger OnInitReport()
    var
        SalesInvoiceExport: xmlport "BC6_Sales_Invoice_Export";
    begin
        SalesInvoiceExport.TextEncoding := TextEncoding::Windows;
        SalesInvoiceExport.Run();
    end;
}
