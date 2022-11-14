pageextension 50038 "BC6_SalesOrderSubform" extends "Sales Order Subform"
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
            ShowMandatory = TypeChosen;
            Visible = false;
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
        modify(Quantity)
        {
            ShowMandatory = TypeChosen;
        }
        modify("Reserved Quantity")
        {
            Visible = false;
        }
        modify("Unit Price")
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
        modify("Planned Delivery Date")
        {
            Visible = false;
        }
        modify("Shipment Date")
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
            Visible = false;
        }
        modify(ShortcutDimCode4)
        {
            Visible = false;
        }
        modify(ShortcutDimCode5)
        {
            Visible = true;
        }
        modify(ShortcutDimCode6)
        {
            Visible = false;
        }
        modify(ShortcutDimCode7)
        {
            Visible = false;
        }
        modify(ShortcutDimCode8)
        {
            Visible = false;
        }
        modify("Invoice Discount Amount")
        {
            Style = Subordinate;
            StyleExpr = RefreshMessageEnabled;
        }
        modify("Invoice Disc. Pct.")
        {
            Editable = false;
            Visible = true;
            Style = Subordinate;
            StyleExpr = RefreshMessageEnabled;
        }
        modify("Total Amount Excl. VAT")
        {
            CaptionClass = DocumentTotals.GetTotalExclVATCaption(SalesHeader."Currency Code");
            Style = Subordinate;
            StyleExpr = RefreshMessageEnabled;
        }
        modify("Total VAT Amount")
        {
            CaptionClass = DocumentTotals.GetTotalVATCaption(SalesHeader."Currency Code");
            Style = Subordinate;
            StyleExpr = RefreshMessageEnabled;
        }
        modify("Total Amount Incl. VAT")
        {
            CaptionClass = DocumentTotals.GetTotalInclVATCaption(SalesHeader."Currency Code");
            StyleExpr = TotalAmountStyle;
        }
        modify(FilteredTypeField)
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

        modify("Requested Delivery Date")
        {
            Visible = false;
        }

        modify("Promised Delivery Date")
        {
            Visible = false;
        }

        modify("Planned Shipment Date")
        {
            Visible = false;
        }

        modify("Deferral Code")
        {
            Visible = false;
        }
        modify("TotalSalesLine.""Line Amount""")
        {
            Visible = false;
        }

        addafter(Description)
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
        }
        addafter(ShortcutDimCode8)
        {
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
                    DocumentTotals.SalesRedistributeInvoiceDiscountAmounts(Rec, VATAmount, TotalSalesLine);
                    CurrPage.UPDATE(false);
                end;
            }
        }
    }
    actions
    {
        modify("Select Nonstoc&k Items")
        {
            Caption = 'Nonstoc&k Items';
        }
        modify(SelectMultiItems)
        {
            Visible = false;
        }
        modify("Related Information")
        {
            Visible = false;
        }
        modify(DocAttach)
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
        modify(BlanketOrder)
        {
            Visible = false;
        }
    }

    var
        SalesHeader: Record "Sales Header";
        DocumentTotals: Codeunit "Document Totals";
        [InDataSet]
        ItemPanelVisible: Boolean;
        RefreshMessageEnabled: Boolean;
        TypeChosen: Boolean;
        RefreshMessageText: Text;
        TotalAmountStyle: Text;

    local procedure TypeOnAfterValidate()
    begin
        ItemPanelVisible := Rec.Type = Rec.Type::Item;
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(false);
        if (Rec.Type = Rec.Type::"Charge (Item)") and (Rec."No." <> xRec."No.") and
           (xRec."No." <> '')
        then
            CurrPage.SAVERECORD();

        SaveAndAutoAsmToOrder();

        if Rec.Reserve = Rec.Reserve::Always then begin
            CurrPage.SAVERECORD();
            if (Rec."Outstanding Qty. (Base)" <> 0) and (Rec."No." <> xRec."No.") then begin
                Rec.AutoReserve();
                CurrPage.UPDATE(false);
            end;
        end;
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    begin
        InsertExtendedText(false);
    end;

    local procedure LocationCodeOnAfterValidate()
    begin
        SaveAndAutoAsmToOrder();

        if (Rec.Reserve = Rec.Reserve::Always) and
           (Rec."Outstanding Qty. (Base)" <> 0) and
           (Rec."Location Code" <> xRec."Location Code")
        then begin
            CurrPage.SAVERECORD();
            Rec.AutoReserve();
            CurrPage.UPDATE(false);
        end;
    end;

    local procedure ReserveOnAfterValidate()
    begin
        if (Rec.Reserve = Rec.Reserve::Always) and (Rec."Outstanding Qty. (Base)" <> 0) then begin
            CurrPage.SAVERECORD();
            Rec.AutoReserve();
            CurrPage.UPDATE(false);
        end;
    end;

    local procedure QuantityOnAfterValidate()
    var
        UpdateIsDone: Boolean;
    begin
        if Rec.Type = Rec.Type::Item then
            case Rec.Reserve of
                Rec.Reserve::Always:
                    begin
                        CurrPage.SAVERECORD();
                        Rec.AutoReserve();
                        CurrPage.UPDATE(false);
                        UpdateIsDone := true;
                    end;
                Rec.Reserve::Optional:
                    if (Rec.Quantity < xRec.Quantity) and (xRec.Quantity > 0) then begin
                        CurrPage.SAVERECORD();
                        CurrPage.UPDATE(false);
                        UpdateIsDone := true;
                    end;
            end;

        if (Rec.Type = Rec.Type::Item) and
           (Rec.Quantity <> xRec.Quantity) and
           not UpdateIsDone
        then
            CurrPage.UPDATE(true);
    end;

    local procedure UnitofMeasureCodeOnAfterValida()
    begin
        if Rec.Reserve = Rec.Reserve::Always then begin
            CurrPage.SAVERECORD();
            Rec.AutoReserve();
            CurrPage.UPDATE(false);
        end;
    end;

    local procedure ShipmentDateOnAfterValidate()
    begin
        if (Rec.Reserve = Rec.Reserve::Always) and
           (Rec."Outstanding Qty. (Base)" <> 0) and
           (Rec."Shipment Date" <> xRec."Shipment Date")
        then begin
            CurrPage.SAVERECORD();
            Rec.AutoReserve();
            CurrPage.UPDATE(false);
        end;
    end;
}
