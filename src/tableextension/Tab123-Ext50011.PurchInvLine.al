tableextension 50011 "BC6_PurchInvLine" extends "Purch. Inv. Line" //123
{
    fields
    {
        field(50005; "BC6_Matricule No."; Code[20])
        {
            Caption = 'Code matricule';
            DataClassification = CustomerContent;
        }
    }
    procedure ModifyDimensions()
    var
        lUpdateDim: Report "BC6_Modifier axes facture";
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
