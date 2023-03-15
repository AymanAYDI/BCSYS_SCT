pageextension 50092 "BC6_PurchaseQuoteSubform" extends "Purchase Quote Subform" //97
{
    layout
    {
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Unit of Measure Code")
        {
            Visible = false;
        }
        modify("Unit of Measure")
        {
            Visible = true;
            Editable = false;
        }
        modify("Unit Cost (LCY)")
        {
            Editable = false;
        }
        modify("Unit Price (LCY)")
        {
            Editable = false;
        }
        modify("Line Discount %")
        {
            Visible = false;
        }
        modify("Line Amount")
        {
            Editable = false;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify(ShortcutDimCode3)
        {
            Visible = true;
        }

        modify(ShortcutDimCode4)
        {
            Visible = true;
        }

        modify(ShortcutDimCode5)
        {
            Visible = true;
        }

        modify(ShortcutDimCode6)
        {
            Visible = true;
        }
        modify(ShortcutDimCode8)
        {
            Visible = true;
        }

        modify("Invoice Discount Amount")
        {
            Visible = false;
        }
        modify("Invoice Disc. Pct.")
        {
            Visible = false;
        }
        modify(Control17)
        {
            Visible = false;
        }
        modify("Total Amount Excl. VAT")
        {
            Visible = false;
        }

        modify("Total VAT Amount")
        {
            Visible = false;
        }
        modify("Total Amount Incl. VAT")
        {
            Visible = false;
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
            field("BC6_Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
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
        modify("Job Task No.")
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
