pageextension 50013 "BC6_PostedPurchInvoiceSubform" extends "Posted Purch. Invoice Subform" //139
{
    // ------------------------------------- V 1.2 ---------------------------------------
    // MODIF JX-XAD 23/03/2010
    // Ajout d'une fonction retournant l'enregistrement courant
    layout
    {
        addafter("Line Amount")
        {
            field("BC6_Posting Group"; Rec."Posting Group")
            {
                ApplicationArea = All;
            }
            field("BC6_Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
            field("BC6_VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                ApplicationArea = All;
            }
            field("BC6_Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
            }
            field("BC6_VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify(Dimensions)
        {
            visible = false;
        }
        addafter(Dimensions)
        {
            action(BC6_Dimensions2)
            {
                AccessByPermission = TableData Dimension = RM;
                ApplicationArea = all;
                Caption = 'Dimensions', Comment = 'FRA="Axes analytiques"';
                Image = Dimensions;
                ShortCutKey = 'Alt+D';
                trigger OnAction()
                begin
                    Rec.BC6_ModifyDimensions();
                end;
            }
        }
    }
    procedure ReturnRecord(var Prec_PurchInvLine: Record "Purch. Inv. Line")
    begin
        Prec_PurchInvLine := Rec;
    end;
}

