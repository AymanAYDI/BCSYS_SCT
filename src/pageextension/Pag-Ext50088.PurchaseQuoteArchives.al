pageextension 50088 "BC6_PurchaseQuoteArchives" extends "Purchase Quote Archives"
{
    var
        FunctionsMgt: Codeunit "BC6_FunctionsMgt";

    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Assigned User ID", FunctionsMgt.jx_GetPurchasesFilter());
        Rec.FILTERGROUP(0);
    end;
}
