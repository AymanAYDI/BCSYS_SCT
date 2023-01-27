report 50086 "BC6_Import Purchase Receipt"
{
    Caption = 'Import Purchase Receipt', Comment = 'FRA="Import Réceptions"';
    ApplicationArea = All;
    UsageCategory = Tasks;
    UseRequestPage = false;
    ProcessingOnly = true;
    trigger OnInitReport()
    var
        ImportPurchase: xmlport "BC6_Import Purchase Receipt";
    begin
        ImportPurchase.TextEncoding := TextEncoding::Windows;
        ImportPurchase.Run();
    end;

}
