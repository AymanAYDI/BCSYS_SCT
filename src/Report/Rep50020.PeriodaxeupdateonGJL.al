report 50020 "BC6_Period axe update on GJL"
{
    Caption = 'Period axe update on GJL';
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
                    GTempSetEntry.DELETEALL();
                    GOldID := "Dimension Set ID";
                    GDimSetEntry.SETRANGE("Dimension Set ID");
                    if GDimSetEntry.FINDFIRST() then
                        repeat
                            GTempSetEntry := GDimSetEntry;
                            if GTempSetEntry."Dimension Code" = 'PERIODE' then
                                GTempSetEntry."Dimension Value Code" := Gcode_Periode;
                            if GDimValue.GET('PERIODE', Gcode_Periode) then
                                GTempSetEntry."Dimension Value ID" := GDimValue."Dimension Value ID";
                            GTempSetEntry.INSERT();
                        until GDimSetEntry.NEXT() = 0;
                    "Dimension Set ID" := Gcu_Dimension.GetDimensionSetID(GTempSetEntry);
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
                    Caption = 'Section Axe Période';
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
        GTempSetEntry: Record "Dimension Set Entry" temporary;
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
