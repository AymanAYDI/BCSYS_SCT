report 50084 "BC6_VTime"
{
    Caption = 'VTime', Comment = 'FRA="Import prestataires (VTIME)"';
    ApplicationArea = All;
    UsageCategory = Tasks;
    UseRequestPage = false;
    ProcessingOnly = true;
    trigger OnInitReport()
    var
        VTime: xmlport "BC6_VTime";
    begin
        VTime.TextEncoding := TextEncoding::Windows;
        VTime.Run();
    end;
}
