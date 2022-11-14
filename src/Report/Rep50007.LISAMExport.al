report 50007 "BC6_LISAM Export"
{
    Caption = 'LISAM';
    ApplicationArea = All;
    UsageCategory = Tasks;
    UseRequestPage = false;
    ProcessingOnly = true;
    trigger OnInitReport()
    var
        LISAM: xmlport "BC6_LISAM";
    begin
        LISAM.TextEncoding := TextEncoding::Windows;
        LISAM.Run();
    end;

}
