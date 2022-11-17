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
        modify("No.")
        {
            ShowMandatory = TypeChosen;
        }

        modify("Location Code")
        {
            Visible = false;
        }
        modify(Quantity)
        {
            ShowMandatory = TypeChosen;
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
        modify("Direct Unit Cost")
        {
            ShowMandatory = TypeChosen;
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
            Visible = false;
        }
        modify(ShortcutDimCode8)
        {
            Visible = true;
        }
        modify("Total Amount Excl. VAT")
        {
            CaptionClass = DocumentTotals.GetTotalExclVATCaption(PurchHeader."Currency Code");
            Style = Subordinate;
            StyleExpr = RefreshMessageEnabled;
        }
        modify("Total VAT Amount")
        {
            CaptionClass = DocumentTotals.GetTotalVATCaption(PurchHeader."Currency Code");
            Style = Subordinate;
            StyleExpr = RefreshMessageEnabled;
        }
        modify("Total Amount Incl. VAT")
        {
            CaptionClass = DocumentTotals.GetTotalInclVATCaption(PurchHeader."Currency Code");
            StyleExpr = TotalAmountStyle;
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
        modify("Allow Invoice Disc.")
        {
            Visible = false;
        }

        modify("Inv. Discount Amount")
        {
            Visible = false;
        }
        modify("Inv. Disc. Amount to Invoice")
        {
            Visible = false;
        }
        modify("Requested Receipt Date")
        {
            Visible = false;
        }
        modify("Promised Receipt Date")
        {
            Visible = false;
        }
        modify("Planned Receipt Date")
        {
            Visible = false;
        }
        modify("Expected Receipt Date")
        {
            Visible = false;
        }
        modify("Order Date")
        {
            Visible = false;
        }
        modify("Lead Time Calculation")
        {
            Visible = false;
        }
        modify("Blanket Order No.")
        {
            Visible = false;
        }
        modify("Blanket Order Line No.")
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
        modify(Control37)
        {
            Visible = false;
        }
        modify(AmountBeforeDiscount)
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

        addfirst(Control1)
        {
            field("BC6_Line No."; Rec."Line No.")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
        addafter("Inbound Whse. Handling Time")
        {
            field("BC6_Document No."; Rec."Document No.")
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
        addafter("Total Amount Incl. VAT")
        {
            field(BC6_RefreshTotals; RefreshMessageText)
            {
                DrillDown = true;
                Editable = false;
                Enabled = RefreshMessageEnabled;
                ShowCaption = false;
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    DocumentTotals.PurchaseRedistributeInvoiceDiscountAmounts(Rec, VATAmount, TotalPurchaseLine);
                    CurrPage.UPDATE(false);
                end;
            }
        }
        modify("Job Remaining Qty.")
        {
            BlankZero = true;
            Visible = false;
        }
    }
    actions
    {
        modify(SelectMultiItems)
        {
            Visible = false;
        }
        modify(DocumentLineTracking)
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
        modify(BlanketOrder)
        {
            Visible = false;
        }
    }

    var
        PurchHeader: Record "Purchase Header";
        DocumentTotals: Codeunit "Document Totals";
        PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
        RefreshMessageEnabled: Boolean;
        TypeChosen: Boolean;
        ShortcutDimCode: array[10] of Code[20];
        RefreshMessageText: Text;
        TotalAmountStyle: Text;

    procedure CalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Calc.Discount", Rec);
    end;

    procedure ShowPrices()
    begin
        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLinePrice(PurchHeader, Rec);
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(false);
        if (Rec.Type = Rec.Type::"Charge (Item)") and (Rec."No." <> xRec."No.") and
           (xRec."No." <> '')
        then
            CurrPage.SAVERECORD();
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    begin
        InsertExtendedText(false);
    end;
}
