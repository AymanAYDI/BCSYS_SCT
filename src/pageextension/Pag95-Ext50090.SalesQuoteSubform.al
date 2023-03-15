pageextension 50090 "BC6_SalesQuoteSubform" extends "Sales Quote Subform" //95
{
    layout
    {
        addafter(ShortcutDimCode8)
        {
            field("ShortcutDimCode[9]"; ShortcutDimCode[9])
            {
                CaptionClass = '1,50000,9';
                Visible = false;
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    Rec.LookupShortcutDimCode(9, ShortcutDimCode[9]);
                end;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(9, ShortcutDimCode[9]);
                end;
            }
            field("ShortcutDimCode[10]"; ShortcutDimCode[10])
            {
                CaptionClass = '1,50000,10';
                Enabled = false;
                Visible = false;
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    Rec.LookupShortcutDimCode(10, ShortcutDimCode[10]);
                end;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(10, ShortcutDimCode[10]);
                end;
            }
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                Rec.BC6_ShowShortcutDimCode(ShortcutDimCode)
            end;
        }
        modify(Description)
        {
            trigger OnAfterValidate()
            begin
                Rec.BC6_ShowShortcutDimCode(ShortcutDimCode)
            end;
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.BC6_ShowShortcutDimCode(ShortcutDimCode)
    end;

    var
        ShortcutDimCode: array[10] of Code[20];
}
