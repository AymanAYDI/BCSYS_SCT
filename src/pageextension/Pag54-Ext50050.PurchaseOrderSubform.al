pageextension 50050 "BC6_PurchaseOrderSubform" extends "Purchase Order Subform" //54
{
    // Modif JX-LAB du 18/09/2008
    // Mise en visible des champs analytiques
    //
    // Modif JX-LAB du 30/10/2008
    // Personalisation des colonnes visibles
    //
    // //Modif JX-VSC4.0-PBD du 26/01/15

    layout
    {
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Reserved Quantity")
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
        modify("VAT Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Invoice Discount Amount")
        {
            Visible = false;
        }
        modify("Invoice Disc. Pct.")
        {
            Visible = false;
        }
        modify("Line Discount %")
        {
            Visible = false;
        }

        addafter(ShortcutDimCode8)
        {
            field("ShortcutDimCode[9]"; ShortcutDimCode[9])
            {
                CaptionClass = '1,2,9';
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
                CaptionClass = '1,2,10';
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
            field("BC6_Requested Receipt Date"; Rec."Requested Receipt Date")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("BC6_Promised Receipt Date"; Rec."Promised Receipt Date")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("BC6_Planned Receipt Date"; Rec."Planned Receipt Date")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("BC6_Expected Receipt Date"; Rec."Expected Receipt Date")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("BC6_Order Date"; Rec."Order Date")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("BC6_Lead Time Calculation"; Rec."Lead Time Calculation")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("BC6_VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
            {
                Visible = true;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    RedistributeTotalsOnAfterValidate();
                end;
            }
            field("BC6_Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
            }
            field("BC6_Blanket Order No."; Rec."Blanket Order No.")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("BC6_Blanket Order Line No."; Rec."Blanket Order Line No.")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                Rec.ShowShortcutDimCodeV(ShortcutDimCode)
            end;
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCodeV(ShortcutDimCode)
    end;

    var
        ShortcutDimCode: array[10] of Code[20];
}
