report 50034 "BC6_LISAM (quick) VAT"
{
    ApplicationArea = All;
    Caption = 'LISAM (quick) VAT';
    UsageCategory = Tasks;
    UseRequestPage = false;
    ProcessingOnly = true;
    trigger OnInitReport()
    var
        LISAMquickVAT: xmlport "BC6_LISAM (quick) VAT";
    begin
        LISAMquickVAT.TextEncoding := TextEncoding::Windows;
        LISAMquickVAT.Run();
    end;

}
