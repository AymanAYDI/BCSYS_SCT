report 50082 "BC6_Timing"
{
    Caption = 'Timing', Comment = 'FRA="Import timing (VTIME)"';
    ApplicationArea = All;
    UsageCategory = Tasks;
    UseRequestPage = false;
    ProcessingOnly = true;
    trigger OnInitReport()
    var
        Timing: xmlport "BC6_Timing";
    begin
        Timing.TextEncoding := TextEncoding::Windows;
        Timing.Run();
    end;

}
