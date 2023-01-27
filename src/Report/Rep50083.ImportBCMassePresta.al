report 50083 "BC6_Import BC Masse Presta"
{
    Caption = 'Import BC Masse Presta';
    ApplicationArea = All;
    UsageCategory = Tasks;
    UseRequestPage = false;
    ProcessingOnly = true;
    trigger OnInitReport()
    var
        MassePresta: xmlport "BC6_Import BC Masse Presta";
    begin
        MassePresta.TextEncoding := TextEncoding::Windows;
        MassePresta.Run();
    end;

}
