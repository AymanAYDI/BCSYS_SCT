pageextension 50038 "BC6_SalesOrderSubform" extends "Sales Order Subform" //46
{
    // //Modif JX-VSC4.0-PBD du 26/01/15
    layout
    {
        modify(Type)
        {
            Visible = false;
        }
        modify("No.")
        {
            Visible = false;
            trigger OnAfterValidate()
            begin
                Rec.BC6_ShowShortcutDimCode(ShortcutDimCode);
            end;
        }
        addafter("Appl.-to Item Entry")
        {
            field("BC6_Document No."; Rec."Document No.")
            {
                Visible = false;
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Line No."; Rec."Line No.")
            {
                Visible = false;
                Editable = false;
                ApplicationArea = All;
            }
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Reserved Quantity")
        {
            Visible = false;
        }
        modify("Line Discount %")
        {
            Visible = false;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify("Planned Delivery Date")
        {
            Visible = false;
        }
        modify("Shipment Date")
        {
            Visible = false;
        }
        modify(ShortcutDimCode5)
        {
            visible = true;
        }
        addafter(Description)
        {
            field(BC6_ShortcutDimCode9; ShortcutDimCode[9])
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
        }
        addafter(ShortcutDimCode8)
        {
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
        modify(Description)
        {
            trigger OnAfterValidate()
            begin
                Rec.BC6_ShowShortcutDimCode(ShortcutDimCode);
            end;
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.BC6_ShowShortcutDimCode(ShortcutDimCode);
    end;

    var
        ShortcutDimCode: array[10] of Code[20];
}
