tableextension 50026 "BC6_SalesHeader" extends "Sales Header" //36
{
    fields
    {
        field(50000; BC6_Agent; Code[20])
        {
            Caption = 'Agent', Comment = 'FRA="Mandataire"';
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;
        }
        field(50001; "BC6_Paying agent"; Boolean)
        {
            Caption = 'Paying agent', Comment = 'FRA="Mandataire payeur"';
            DataClassification = CustomerContent;
        }
    }

    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[10] of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    var
        DimMgt: Codeunit DimensionManagement;
}
