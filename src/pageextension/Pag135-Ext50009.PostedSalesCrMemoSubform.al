pageextension 50009 "BC6_PostedSalesCrMemoSubform" extends "Posted Sales Cr. Memo Subform" //135
{
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field("BC6_Axe 0"; Gtext_Axe0)
            {
                CaptionClass = Gtext_ColAxe0;
                MultiLine = true;
                Visible = "Axe 0Visible";
                ApplicationArea = All;
            }
            field("BC6_Axe 1"; Gtext_Axe1)
            {
                CaptionClass = Gtext_ColAxe1;
                MultiLine = true;
                Visible = "Axe 1Visible";
                ApplicationArea = All;
            }
            field("BC6_Axe 2"; Gtext_Axe2)
            {
                CaptionClass = Gtext_ColAxe2;
                MultiLine = true;
                Visible = "Axe 2Visible";
                ApplicationArea = All;
            }
            field("BC6_Axe 3"; Gtext_Axe3)
            {
                CaptionClass = Gtext_ColAxe3;
                Caption = '<Axe 3>';
                MultiLine = true;
                Visible = "Axe 3Visible";
                ApplicationArea = All;
            }
            field("BC6_Axe 4"; Gtext_Axe4)
            {
                CaptionClass = Gtext_ColAxe4;
                MultiLine = true;
                Visible = "Axe 4Visible";
                ApplicationArea = All;
            }
            field("BC6_Axe 5"; Gtext_Axe5)
            {
                CaptionClass = Gtext_ColAxe5;
                MultiLine = true;
                Visible = "Axe 5Visible";
                ApplicationArea = All;
            }
        }
    }
    var
        Grec_Dimension: Record Dimension;
        Grecord_GeneralLedgerSetup: Record "General Ledger Setup";
        [InDataSet]
        "Axe 0Visible": Boolean;
        [InDataSet]
        "Axe 1Visible": Boolean;
        [InDataSet]
        "Axe 2Visible": Boolean;
        [InDataSet]
        "Axe 3Visible": Boolean;
        [InDataSet]
        "Axe 4Visible": Boolean;
        [InDataSet]
        "Axe 5Visible": Boolean;
        Gcode_Axe1: Code[20];
        Gcode_Axe2: Code[20];
        Gcode_Axe3: Code[20];
        Gcode_Axe4: Code[20];
        Gcode_Axe5: Code[20];
        Gcode_Axe6: Code[20];
        Gtext_Axe0: Text[30];
        Gtext_Axe1: Text[30];
        Gtext_Axe2: Text[30];
        Gtext_Axe3: Text[30];
        Gtext_Axe4: Text[30];
        Gtext_Axe5: Text[30];
        Gtext_ColAxe0: Text[30];
        Gtext_ColAxe1: Text[30];
        Gtext_ColAxe2: Text[30];
        Gtext_ColAxe3: Text[30];
        Gtext_ColAxe4: Text[30];
        Gtext_ColAxe5: Text[30];

    var
        Grec_DimSetEntry: Record "Dimension Set Entry";

    trigger OnAfterGetRecord()
    begin
        //DEBUT MODIF JX-AUD du 05/04/2011
        if Grec_DimSetEntry.GET(Rec."Dimension Set ID", Gcode_Axe1) then
            Gtext_Axe0 := Grec_DimSetEntry."Dimension Value Code"
        else
            Gtext_Axe0 := '';

        if Grec_DimSetEntry.GET(Rec."Dimension Set ID", Gcode_Axe2) then
            Gtext_Axe1 := Grec_DimSetEntry."Dimension Value Code"
        else
            Gtext_Axe1 := '';

        if Grec_DimSetEntry.GET(Rec."Dimension Set ID", Gcode_Axe3) then
            Gtext_Axe2 := Grec_DimSetEntry."Dimension Value Code"
        else
            Gtext_Axe2 := '';

        if Grec_DimSetEntry.GET(Rec."Dimension Set ID", Gcode_Axe4) then
            Gtext_Axe3 := Grec_DimSetEntry."Dimension Value Code"
        else
            Gtext_Axe3 := '';

        if Grec_DimSetEntry.GET(Rec."Dimension Set ID", Gcode_Axe5) then
            Gtext_Axe4 := Grec_DimSetEntry."Dimension Value Code"
        else
            Gtext_Axe4 := '';

        if Grec_DimSetEntry.GET(Rec."Dimension Set ID", Gcode_Axe6) then
            Gtext_Axe5 := Grec_DimSetEntry."Dimension Value Code"
        else
            Gtext_Axe5 := '';

        //FIN MODIF JX-AUD du 05/04/2011
    end;

    trigger OnOpenPage()
    begin
        //DEBUT MODIF JX-AUD du 05/04/2011
        "Axe 0Visible" := true;
        "Axe 1Visible" := true;
        "Axe 2Visible" := true;
        "Axe 3Visible" := true;
        "Axe 4Visible" := true;
        "Axe 5Visible" := true;

        if Grecord_GeneralLedgerSetup.FIND('-') then begin

            Gcode_Axe1 := Grecord_GeneralLedgerSetup."Shortcut Dimension 3 Code";
            if Grec_Dimension.GET(Gcode_Axe1) then Gtext_ColAxe0 := Grec_Dimension."Code Caption" else "Axe 0Visible" := false;

            Gcode_Axe2 := Grecord_GeneralLedgerSetup."Shortcut Dimension 4 Code";
            if Grec_Dimension.GET(Gcode_Axe2) then Gtext_ColAxe1 := Grec_Dimension."Code Caption" else "Axe 1Visible" := false;

            Gcode_Axe3 := Grecord_GeneralLedgerSetup."Shortcut Dimension 5 Code";
            if Grec_Dimension.GET(Gcode_Axe3) then Gtext_ColAxe2 := Grec_Dimension."Code Caption" else "Axe 2Visible" := false;

            Gcode_Axe4 := Grecord_GeneralLedgerSetup."Shortcut Dimension 6 Code";
            if Grec_Dimension.GET(Gcode_Axe4) then Gtext_ColAxe3 := Grec_Dimension."Code Caption" else "Axe 3Visible" := false;

            Gcode_Axe5 := Grecord_GeneralLedgerSetup."Shortcut Dimension 7 Code";
            if Grec_Dimension.GET(Gcode_Axe5) then Gtext_ColAxe4 := Grec_Dimension."Code Caption" else "Axe 4Visible" := false;

            Gcode_Axe6 := Grecord_GeneralLedgerSetup."Shortcut Dimension 8 Code";
            if Grec_Dimension.GET(Gcode_Axe6) then Gtext_ColAxe5 := Grec_Dimension."Code Caption" else "Axe 5Visible" := false;
        end;
        //FIN MODIF JX-AUD du 05/04/2011
    end;

    procedure ReturnRecord(var Prec_SalesCrMemoLine: Record "Sales Cr.Memo Line")
    begin
        //DEBUT MODIF JX-XAD 24/05/2011
        Prec_SalesCrMemoLine := Rec;
        //FIN MODIF JX-XAD 24/05/2011
    end;
}
