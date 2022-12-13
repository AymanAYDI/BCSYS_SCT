tableextension 50005 "BC6_SalesInvoiceLine" extends "Sales Invoice Line" //113
{
    procedure "ModifyDimensions"();
    VAR
        lUpdateDim: Report "Modifier axes facture ventes";
        lNewDimSet: Integer;
        DimMgt: Codeunit DimensionManagement;
    BEGIN
        lNewDimSet := DimMgt.EditDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2 %3', TABLECAPTION, "Document No.", "Line No."));
        IF "Dimension Set ID" <> lNewDimSet THEN BEGIN
            CLEAR(lUpdateDim);
            lUpdateDim.SetPostedInvoice(Rec, lNewDimSet);
            lUpdateDim.RUN();
        END;
    END;
}

