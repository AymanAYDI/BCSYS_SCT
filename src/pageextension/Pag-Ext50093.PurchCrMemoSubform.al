pageextension 50093 "BC6_PurchCrMemoSubform" extends "Purch. Cr. Memo Subform"
{
    //TODO: un variable a été modifié: Array[8] devient Array[10]
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
        addafter(Nonstock)
        {
            field("BC6_Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
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
            //TODO: "Gen. Bus. Posting Group" est déjà existe dans la page standard

            field("BC6_Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                Visible = false;
                ApplicationArea = All;
            }
            //TODO: "VAT Bus. Posting Group" est déjà existe dans la page standard

            field("BC6_VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }

    procedure JX_InsertDescriptInHisto() Rtxt_Description: Text[50]
    var
        Lrec_PurchLines: Record "Purchase Line";
    begin
        //Début Ajout JX-XAD le 15/01/2010
        Lrec_PurchLines.SETFILTER(Lrec_PurchLines."Document Type", '%1', Rec."Document Type");
        Lrec_PurchLines.SETFILTER(Lrec_PurchLines."Document No.", '%1', Rec."Document No.");

        if Lrec_PurchLines.FIND('-') then
            Rtxt_Description := Lrec_PurchLines.Description;
        //Fin Ajout JX-XAD le 15/01/2010
    end;

    procedure JX_GetPurchLines(var Prec_PurchLines: Record "Purchase Line")
    begin
        Prec_PurchLines.SETFILTER(Prec_PurchLines."Document Type", '%1', Rec."Document Type");
        Prec_PurchLines.SETFILTER(Prec_PurchLines."Document No.", '%1', Rec."Document No.");
    end;
}
