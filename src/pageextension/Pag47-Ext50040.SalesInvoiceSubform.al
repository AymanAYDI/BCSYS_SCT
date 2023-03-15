pageextension 50040 "BC6_SalesInvoiceSubform" extends "Sales Invoice Subform" //47
{
    // // modif LAB du 30/08/2010
    // // Ajout des champs en visible : groupe compta produit et groupe compta produit TVA
    // 
    // //Modif JX-VSC4.0-PBD du 26/01/15
    layout
    {
        addafter(Nonstock)
        {
            field("BC6_Gen. Prod. Posting Group2"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
            }
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
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
                Rec.BC6_ShowShortcutDimCode(ShortcutDimCode);
            end;
        }
        modify(Description)
        {
            trigger OnAfterValidate()
            begin
                Rec.BC6_ShowShortcutDimCode(ShortcutDimCode);
            end;
        }
        modify("Job No.")
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

