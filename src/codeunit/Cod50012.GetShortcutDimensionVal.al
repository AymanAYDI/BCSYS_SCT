codeunit 50012 "BC6_Get Shortcut Dimension Val"
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    var
        GLSetup: Record "General Ledger Setup";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        DimensionSetEntry: Record "Dimension Set Entry";
        HasGotGLSetup: Boolean;
        WhenGotGLSetup: DateTime;
        GLSetupShortcutDimCode: array[10] of Code[20];

    procedure BC6_GetShortcutDimensions(DimSetID: Integer; var ShortcutDimCode: array[10] of Code[20])
    var
        i: Integer;
    begin
        Clear(ShortcutDimCode);
        if DimSetID = 0 then
            exit;
        BC6_GetGLSetup();
        for i := 9 to 10 do
            if GLSetupShortcutDimCode[i] <> '' then
                ShortcutDimCode[i] := BC6_GetDimSetEntry(DimSetID, GLSetupShortcutDimCode[i]);
    end;

    local procedure BC6_GetDimSetEntry(DimSetID: Integer; DimCode: Code[20]): Code[20]
    begin
        if TempDimSetEntry.Get(DimSetID, DimCode) then
            exit(TempDimSetEntry."Dimension Value Code");
        TempDimSetEntry.Init();
        if DimensionSetEntry.Get(DimSetID, DimCode) then
            TempDimSetEntry := DimensionSetEntry
        else begin
            TempDimSetEntry."Dimension Set ID" := DimSetID;
            TempDimSetEntry."Dimension Code" := DimCode;
        end;
        TempDimSetEntry.Insert();
        exit(TempDimSetEntry."Dimension Value Code");
    end;

    local procedure BC6_GetGLSetup()
    begin
        if WhenGotGLSetup = 0DT then
            WhenGotGLSetup := CurrentDateTime;
        if CurrentDateTime > WhenGotGLSetup + 60000 then
            HasGotGLSetup := false;
        if HasGotGLSetup then
            exit;
        GLSetup.Get();
        GLSetupShortcutDimCode[9] := GLSetup."BC6_Shortcut Dimension 9 Code";
        GLSetupShortcutDimCode[10] := GLSetup."BC6_Shortcut Dimension 10 Code";
        HasGotGLSetup := true;
        WhenGotGLSetup := CurrentDateTime;
    end;

    [EventSubscriber(ObjectType::Table, Database::"General Ledger Setup", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnGLSetupModify(var Rec: Record "General Ledger Setup"; var xRec: Record "General Ledger Setup"; RunTrigger: Boolean)
    begin
        HasGotGLSetup := false;
    end;
}
