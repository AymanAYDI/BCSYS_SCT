pageextension 50089 "BC6_PurchaseOrderArchives" extends "Purchase Order Archives"
{
    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Assigned User ID", FunctionsMgt.jx_GetPurchasesFilter());
        Rec.FILTERGROUP(0);
    end;

    var
        FunctionsMgt: Codeunit "BC6_FunctionsMgt";
}
