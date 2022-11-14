report 50073 "BC6_Yooz Export Vendor"
{
    ApplicationArea = All;
    Caption = 'Yooz Export Vendor', Comment = 'FRA="Yooz export fournisseurs"';
    UsageCategory = Tasks;
    UseRequestPage = false;
    ProcessingOnly = true;
    trigger OnInitReport()
    var
        YoozExportVendor: xmlport "BC6_Yooz Export Vendor";
    begin
        YoozExportVendor.TextEncoding := TextEncoding::Windows;
        YoozExportVendor.Run();
    end;

}
