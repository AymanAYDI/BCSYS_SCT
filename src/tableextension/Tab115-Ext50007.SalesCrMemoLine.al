tableextension 50007 "BC6_SalesCrMemoLine" extends "Sales Cr.Memo Line" //115
{
    procedure "BC6_ModifyDimensions"()
    var
        lUpdateDim: Report "BC6_Modifier axes avoir ventes";
        DimMgt: Codeunit DimensionManagement;
        lNewDimSet: Integer;
    begin
        lNewDimSet := DimMgt.EditDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2 %3', TABLECAPTION, "Document No.", "Line No."));
        if "Dimension Set ID" <> lNewDimSet then begin
            CLEAR(lUpdateDim);
            lUpdateDim.SetPostedInvoice(Rec, lNewDimSet);
            lUpdateDim.RUN();
        end;
    end;
}
