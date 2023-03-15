pageextension 50093 "BC6_PurchCrMemoSubform" extends "Purch. Cr. Memo Subform" //98
{
    layout
    {
        modify("Invoice Discount Amount")
        {
            Visible = false;
        }
        modify("Invoice Disc. Pct.")
        {
            Visible = false;
        }
        modify(Control23)
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

            field("BC6_Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                Visible = false;
                ApplicationArea = All;
            }

            field("BC6_VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                Visible = false;
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

    procedure JX_InsertDescriptInHisto() Rtxt_Description: Text[50]
    var
        Lrec_PurchLines: Record "Purchase Line";
    begin
        //Début Ajout JX-XAD le 15/01/2010
        Lrec_PurchLines.SETFILTER(Lrec_PurchLines."Document Type", '%1', Rec."Document Type");
        Lrec_PurchLines.SETFILTER(Lrec_PurchLines."Document No.", '%1', Rec."Document No.");

        if Lrec_PurchLines.FindFirst() then
            Rtxt_Description := Lrec_PurchLines.Description;
        //Fin Ajout JX-XAD le 15/01/2010
    end;

    procedure JX_GetPurchLines(var Prec_PurchLines: Record "Purchase Line")
    begin
        Prec_PurchLines.SETFILTER(Prec_PurchLines."Document Type", '%1', Rec."Document Type");
        Prec_PurchLines.SETFILTER(Prec_PurchLines."Document No.", '%1', Rec."Document No.");
    end;
}
