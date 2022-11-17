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

    //Unsupported feature: Property Modification (SourceTableView) on ""Purch. Invoice Subform"(Page 55)".

    layout
    {
        modify("No.")
        {
            ShowMandatory = TypeChosen;
        }

        modify("Line Discount %")
        {
            Visible = false;
        }
        modify("Qty. to Assign")
        {
            BlankZero = true;
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
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
        modify(ShortcutDimCode7)
        {
            Visible = true;
        }
        modify(ShortcutDimCode8)
        {
            Visible = true;
        }
        modify(FilteredTypeField)
        {
            Visible = false;
        }
        modify("Variant Code")
        {
            Visible = false;
        }

        modify("VAT Prod. Posting Group")
        {
            Visible = false;
        }
        modify(Description)
        {
            Visible = false;
        }

        modify("Location Code")
        {
            Visible = false;
        }

        modify(Quantity)
        {
            Visible = false;
        }
        modify("Unit of Measure Code")
        {
            Visible = false;
        }
        modify("Unit of Measure")
        {
            Visible = false;
        }
        modify("Direct Unit Cost")
        {
            Visible = false;
        }
        modify("Line Amount")
        {
            Visible = false;
        }
        modify("Allow Invoice Disc.")
        {
            Visible = false;
        }
        modify("Inv. Discount Amount")
        {
            Visible = false;
        }
        modify("Deferral Code")
        {
            Visible = false;
        }

        modify("Document No.")
        {
            Visible = false;
        }
        modify("Line No.")
        {
            Visible = false;
        }
        modify(Control39)
        {
            Visible = false;
        }
        modify(Control33)
        {
            Visible = false;
        }
        modify(AmountBeforeDiscount)
        {
            Visible = false;
        }
        modify(InvoiceDiscountAmount)
        {
            Visible = false;
        }
        modify("Invoice Disc. Pct.")
        {
            Visible = false;
        }
        modify(Control15)
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
                CaptionClass = '1,2,9';
                Visible = true;
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
            field("BC6_Gen. Prod. Posting Group2"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
            }
            field("BC6_VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    RedistributeTotalsOnAfterValidate();
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
            field(BC6_Quantity; Rec.Quantity)
            {
                BlankZero = true;
                ShowMandatory = TypeChosen;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    RedistributeTotalsOnAfterValidate();
                end;
            }
            field("BC6_Unit of Measure Code"; Rec."Unit of Measure Code")
            {
                Visible = false;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    RedistributeTotalsOnAfterValidate();
                end;
            }
            field("BC6_Unit of Measure"; ReC."Unit of Measure")
            {
                Editable = false;
                Visible = true;
                ApplicationArea = All;
            }
            field("BC6_Direct Unit Cost"; Rec."Direct Unit Cost")
            {
                BlankZero = true;
                ShowMandatory = TypeChosen;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    RedistributeTotalsOnAfterValidate();
                end;
            }
            field("BC6_Line Amount"; Rec."Line Amount")
            {
                BlankZero = true;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    RedistributeTotalsOnAfterValidate();
                end;
            }
            field("BC6_Amount Including VAT"; ReC."Amount Including VAT")
            {
                Visible = false;
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
        modify(DeferralSchedule)
        {
            Visible = false;
        }
        modify(DocAttach)
        {
            Visible = false;
        }
    }

    var
        PurchHeader: Record "Purchase Header";
        PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
        TypeChosen: Boolean;
        ShortcutDimCode: array[10] of Code[20];

    procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt();
    end;

    procedure ShowPrices()
    begin
        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLinePrice(PurchHeader, Rec);
    end;

    procedure ShowLineDisc()
    begin
        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLineLineDisc(PurchHeader, Rec);
    end;

    procedure JX_InsertDescriptInHisto() Rtxt_Description: Text[50]
    var
        Lrec_PurchLines: Record "Purchase Line";
    begin
        //Début Ajout JX-XAD le 20/11/2009
        Lrec_PurchLines.SETFILTER(Lrec_PurchLines."Document Type", '%1', Rec."Document Type");
        Lrec_PurchLines.SETFILTER(Lrec_PurchLines."Document No.", '%1', Rec."Document No.");

        if Lrec_PurchLines.FIND('-') then
            Rtxt_Description := Lrec_PurchLines.Description;
        //Fin Ajout JX-XAD le 20/11/2009
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    begin
        InsertExtendedText(false);
    end;

    local procedure RedistributeTotalsOnAfterValidate()
    begin
        CurrPage.SAVERECORD();

        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
        if DocumentTotals.PurchaseCheckNumberOfLinesLimit(PurchHeader) then
            DocumentTotals.PurchaseRedistributeInvoiceDiscountAmounts(Rec, VATAmount, TotalPurchaseLine);
        CurrPage.UPDATE();
    end;

    procedure JX_GetPurchLines(var Prec_PurchLines: Record "Purchase Line")
    begin
        Prec_PurchLines.SETFILTER(Prec_PurchLines."Document Type", '%1', Rec."Document Type");
        Prec_PurchLines.SETFILTER(Prec_PurchLines."Document No.", '%1', Rec."Document No.");
    end;
}
