pageextension 50051 "BC6_PurchInvoiceSubform" extends "Purch. Invoice Subform" //55
{
    // Modif JX-LAB du 18/09/2008
    // Mise en visible des champs analytiques
    //
    // ----------------------------------- V1.2 -----------------------------------
    // Modif JX-XAD du 20/11/2009
    // Ajout d'une fonction JX_InsertDescripionInHisto() renvoyant la première ligne de description destinée à l'historique
    // Ajout d'une fonction JX_GetPurchLines() pour renvoyer le contenu de la facture
    //
    // //Modif JX-VSC4.0-PBD du 26/01/15
    // Ajout Axes analytique (Shortcut 9 et 10)
    //
    // //Modif JX-VSC4.0-PBD du 26/01/15

    layout
    {
        modify("Location Code")
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
        modify("Unit of Measure Code")
        {
            Visible = false;
        }
        modify("Unit of Measure")
        {
            Visible = true;
            Editable = false;
        }
        modify(InvoiceDiscountAmount)
        {
            Visible = false;
        }
        modify("Invoice Disc. Pct.")
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
            field("BC6_Gen. Prod. Posting Group2"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
            }
            field("BC6_VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    DeltaUpdateTotals();
                end;
            }
            field("BC6_Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
            field("BC6_Blanket Order No."; Rec."Blanket Order No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("BC6_Blanket Order Line No."; Rec."Blanket Order Line No.")
            {
                ApplicationArea = All;
                Visible = false;
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
