pageextension 50092 "BC6_PurchaseQuoteSubform" extends "Purchase Quote Subform" //97
{
    //TODO: un variable a été modifié: Array[8] devient Array[10],
    //field "VAT Prod. Posting Group" a faire
    layout
    {
        modify(Description)
        {
            Visible = true;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = false;
        }
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
            //BlankZero = true;
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
        addfirst(Control1)
        {
            field("BC6_Line No."; Rec."Line No.")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;
            }
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
            field("BC6_Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify(SelectMultiItems)
        {
            Visible = false;
        }
        modify(DocAttach)
        {
            Visible = false;
        }
        addfirst(processing)
        {
        }
    }

    var
        UpdateAllowedVar: Boolean;
        Text000: label 'Unable to run this function while in View mode.';

    procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt();
    end;

    procedure UpdateAllowed(): Boolean
    begin
        if UpdateAllowedVar = false then begin
            MESSAGE(Text000);
            exit(false);
        end;
        exit(true);
    end;

    procedure ShowPrices()
    var
        PurchHeader: Record "Purchase Header";
        PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
    begin
        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLinePrice(PurchHeader, Rec);
    end;

    procedure ShowLineDisc()
    var
        PurchHeader: Record "Purchase Header";
        PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
    begin
        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLineLineDisc(PurchHeader, Rec);
    end;
}
