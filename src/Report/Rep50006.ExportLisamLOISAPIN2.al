report 50006 "BC6_Export Lisam-LOI SAPIN 2"
{
    ApplicationArea = All;
    Caption = 'Export Lisam-LOI SAPIN 2';
    UsageCategory = ReportsAndAnalysis;
    UseRequestPage = false;
    ProcessingOnly = true;
    trigger OnInitReport()
    var
        ExportLisamLOI: xmlport "BC6_Export Lisam-LOI SAPIN 2";
    begin
        ExportLisamLOI.TextEncoding := TextEncoding::Windows;
        ExportLisamLOI.Run();
    end;
}
