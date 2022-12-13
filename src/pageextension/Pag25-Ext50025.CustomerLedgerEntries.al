pageextension 50025 "BC6_CustomerLedgerEntries" extends "Customer Ledger Entries" //25
{
    // MODIF JX-XAD 21/09/2010
    // Ajout champ "N° doc externe"
    // 
    // //Modif JX-AUD du 03/01/2012
    // //Ajout du code axe intragroupe sur chaque ligne

    layout
    {
        addafter("Document No.")
        {
            field("BC6_BC6 External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field(BC6_Gtext_CodeAxe; Gtext_CodeAxe)
            {
                CaptionClass = Gtext_ColAxe;
                Visible = true;
                ApplicationArea = All;
            }
        }
    }


    var
        Grecord_GeneralLedgerSetup: Record "General Ledger Setup";
        Grec_Dimension: Record Dimension;
        Grec_SalesInvoiceLine: Record "Sales Invoice Line";
        Grec_DimSetEntry: Record "Dimension Set Entry";
        Gtext_CodeAxe: Text[30];
        Gcode_Axe: Code[20];
        Gtext_ColAxe: Text[80];
        StyleTxt: Text;
        RemainingAmtLCYVisible: Boolean;

    trigger OnAfterGetRecord()
    begin
        //Modif JX-AUD du 03/01/2012
        Gtext_CodeAxe := '';
        Grec_SalesInvoiceLine.SETFILTER(Grec_SalesInvoiceLine."Document No.", Rec."Document No.");
        IF Grec_SalesInvoiceLine.FindFirst() THEN
            REPEAT
                IF Grec_DimSetEntry.GET(Grec_SalesInvoiceLine."Dimension Set ID", Gcode_Axe) THEN BEGIN
                    Gtext_CodeAxe := Grec_DimSetEntry."Dimension Value Code";
                    EXIT;
                END;
            UNTIL Grec_SalesInvoiceLine.NEXT() = 0
        ELSE
            Gtext_CodeAxe := '';
        //Fin modif JX-AUD du 03/01/2012
        StyleTxt := Rec.SetStyle();
    end;

    trigger OnOpenPage()
    var
    begin
        //Modif JX-AUD du 03/01/2012
        IF Grecord_GeneralLedgerSetup.FindFirst() THEN
            Gcode_Axe := Grecord_GeneralLedgerSetup."Shortcut Dimension 8 Code";
        IF Grec_Dimension.GET(Gcode_Axe) THEN
            Gtext_ColAxe := Grec_Dimension."Code Caption";
        //Fin modif JX-AUD du 03/01/2012
    end;

    procedure SetRemainingAmtLCYToVisible()
    begin
        RemainingAmtLCYVisible := TRUE;
    end;

    procedure GetRemainingAmtLCYVisiblityStatus(): Boolean
    begin
        EXIT(RemainingAmtLCYVisible);
    end;
}

