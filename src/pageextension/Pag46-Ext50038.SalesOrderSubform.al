pageextension 50038 "BC6_SalesOrderSubform" extends "Sales Order Subform" //46
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
        modify("Reserved Quantity")
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
        modify("Shipment Date")
        {
            Visible = false;
        }
        modify(ShortcutDimCode5)
        {
            Visible = true;
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
    var
        DocumentTotals: Codeunit "Document Totals";
        RefreshMessageEnabled: Boolean;
        RefreshMessageText: Text;
}
