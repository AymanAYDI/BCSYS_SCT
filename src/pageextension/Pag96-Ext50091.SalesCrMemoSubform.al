pageextension 50091 "BC6_SalesCrMemoSubform" extends "Sales Cr. Memo Subform" //96
{
    layout
    {
        addafter("No.")
        {
            field("BC6_Gen. Prod. Posting Group2"; Rec."Gen. Prod. Posting Group")
            {
                Visible = true;
                ApplicationArea = All;
            }
            field("BC6_BC6 VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
            {
                ApplicationArea = all;
                Visible = true;

                trigger OnValidate()
                begin
                    RedistributeTotalsOnAfterValidate();
                end;
            }
        }
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
        modify("Job No.")
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

