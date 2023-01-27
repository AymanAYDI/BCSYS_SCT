report 50020 "BC6_Period axe update on GJL"
{
    Caption = 'Period axe update on GJL', Comment = 'FRA="Mise à jour axe PERIODE sur LFC"';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Gen. Journal Line"; 81)
        {
            DataItemTableView = sorting("Journal Template Name", "Journal Batch Name", "Line No.") where("Journal Template Name" = const('IMMOBILISA'), "Journal Batch Name" = const('DEFAUT'));
            trigger OnAfterGetRecord()
            begin
                i += 1;
                Window.UPDATE(1, i);

                if GDimSetEntry.GET("Dimension Set ID", 'PERIODE') then begin
                    TempSetEntry.DELETEALL();
                    GOldID := "Dimension Set ID";
                    GDimSetEntry.SETRANGE("Dimension Set ID");
                    if GDimSetEntry.FINDFIRST() then
                        repeat
                            TempSetEntry := GDimSetEntry;
                            if TempSetEntry."Dimension Code" = 'PERIODE' then
                                TempSetEntry."Dimension Value Code" := Gcode_Periode;
                            if GDimValue.GET('PERIODE', Gcode_Periode) then
                                TempSetEntry."Dimension Value ID" := GDimValue."Dimension Value ID";
                            TempSetEntry.INSERT();
                        until GDimSetEntry.NEXT() = 0;
                    "Dimension Set ID" := Gcu_Dimension.GetDimensionSetID(TempSetEntry);
                    MODIFY();
                end else begin
                    "Dimension Set ID" := Gcu_Dimension1.SetNewDimIDSpec("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", GCode_DimCode, GCode_DimValueCode);
                    MODIFY();
                end;
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE();
            end;

            trigger OnPreDataItem()
            begin
                GCode_DimCode[1] := 'PERIODE';
                GCode_DimValueCode[1] := Gcode_Periode;
                Window.UPDATE(2, COUNT);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field("Section Axe Période"; Gcode_Periode)
                {
                    TableRelation = "Dimension Value".Code where("Dimension Code" = const('PERIODE'));
                    ApplicationArea = All;
                    Caption = 'Section Axe Période', Comment = 'FRA="Section Axe Période"';
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        Window.OPEN('#1###/#2###');
    end;

    var
        GDimSetEntry: Record "Dimension Set Entry";
        TempSetEntry: Record "Dimension Set Entry" temporary;
        GDimValue: Record "Dimension Value";
        Gcu_Dimension1: Codeunit "BC6_FunctionsMgt";
        Gcu_Dimension: Codeunit DimensionManagement;
        Gcode_Periode: Code[4];
        GCode_DimCode: array[50] of Code[20];
        GCode_DimValueCode: array[50] of Code[20];
        Window: Dialog;
        GOldID: Integer;
        i: Integer;
}
