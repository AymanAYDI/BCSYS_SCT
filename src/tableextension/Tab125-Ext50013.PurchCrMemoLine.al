tableextension 50013 "BC6_PurchCrMemoLine" extends "Purch. Cr. Memo Line" //125
{
    fields
    {
        field(50005; "BC6_BC6 Matricule No."; Code[20])
        {
            Caption = 'Code matricule';
            DataClassification = CustomerContent;
        }
    }

    procedure "BC6_ModifyDimensions"()
    VAR
        lUpdateDim: Report "BC6_Modifier axes avoir";
        DimMgt: Codeunit DimensionManagement;
        lNewDimSet: Integer;
    begin
        lNewDimSet := DimMgt.EditDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2 %3', TABLECAPTION, "Document No.", "Line No."));
        IF "Dimension Set ID" <> lNewDimSet THEN BEGIN
            CLEAR(lUpdateDim);
            lUpdateDim.SetPostedInvoice(Rec, lNewDimSet);
            lUpdateDim.RUN();
        END;
    end;

    procedure "BC6 ModifyLineDimensions"()
    var
        FromPurchCrMemoLine: Record "Purch. Cr. Memo Line";
        GetPostDocPCrMemoLnSbfrm: Page "Get Post.Doc-P.Cr.MemoLn Sbfrm";
    begin
        GetPostDocPCrMemoLnSbfrm.GetSelectedLine(FromPurchCrMemoLine);
        FromPurchCrMemoLine."BC6_ModifyDimensions"();
    end;

    procedure "BC6 ShowShortcutDimCode"(var ShortcutDimCode: array[10] of Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        //Modif JX-VSC4.0-PBD du 26/01/15 ARRAY [8] => ARRAY[10]
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;


}

