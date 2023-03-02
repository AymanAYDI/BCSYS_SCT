report 50088 "BC6_Cash Pooling"
{
    Caption = 'Cash Pooling', Comment = 'FRA="Cash Pooling"';
    ApplicationArea = All;
    UsageCategory = Tasks;
    UseRequestPage = false;
    ProcessingOnly = true;

    trigger OnInitReport()
    var
        CashPooling: xmlport "BC6_Cash Pooling";
    begin
        CashPooling.TextEncoding := TextEncoding::Windows;
        CashPooling.Run();
    end;
}
