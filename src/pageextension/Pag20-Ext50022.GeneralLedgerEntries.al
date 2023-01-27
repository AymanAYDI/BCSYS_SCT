pageextension 50022 "BC6_GeneralLedgerEntries" extends "General Ledger Entries" //20
{
    layout
    {
        addfirst(Control1)
        {
            field("BC6_Transaction No."; Rec."Transaction No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Entry No."; Rec."Entry No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Gen. Prod. Posting Group")
        {
            field("BC6_VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
            {
                ApplicationArea = All;
            }
        }
        addafter("Credit Amount")
        {
            field(BC6_Letter; Rec.Letter)
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("BC6_Letter Date"; Rec."Letter Date")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
        addafter("Bal. Account No.")
        {
            field(BC6_Gtext_CodeAxe; Gtext_CodeAxe)
            {
                Caption = 'Code intragroupe', Comment = 'FRA="Code intragroupe"';
                ApplicationArea = All;
            }
            field("BC6_Source No. 2"; Rec."Source No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("FA Entry No.")
        {
            field("BC6_External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
            }
        }
        modify("Entry No.")
        {
            Visible = false;
        }
    }
    actions
    {
        addafter("Value Entries")
        {
            action("BC6_Modifier axes analytiques")
            {
                Caption = 'Modify dimensions', Comment = 'FRA="Modifier Axes analytiques"';
                ApplicationArea = All;
                Image = ChangeDimensions;

                trigger OnAction()
                begin
                    if Rec."Source Type" = Rec."Source Type"::"Fixed Asset" then
                        ERROR(Text001);
                    Rec."BC6_ModifyDimensions"();
                end;
            }
        }
    }

    var
        Grec_DefaultDimension: Record "Default Dimension";
        Grecord_GeneralLedgerSetup: Record "General Ledger Setup";
        Grec_NEntetefacturefournisseur: Record "Purch. Inv. Header";
        Gcode_Axe: Code[20];
        Text001: label 'This type of G/L Entry is blocked by modification of dimensions', Comment = 'FRA="Ce type d''écriture est bloqué en modification analytique"';
        Gtext_CodeAxe: Text[30];

    trigger OnAfterGetRecord()
    begin
        //Modif JX-AUD du 18/01/12
        Gtext_CodeAxe := '';
        if Rec."Source Type" = Rec."Source Type"::Vendor then
            if Grec_DefaultDimension.GET(23, Rec."Source No.", Gcode_Axe) then
                Gtext_CodeAxe := Grec_DefaultDimension."Dimension Value Code"
            else
                Gtext_CodeAxe := '';
        if Rec."Source Type" = Rec."Source Type"::Customer then
            if Grec_DefaultDimension.GET(18, Rec."Source No.", Gcode_Axe) then
                Gtext_CodeAxe := Grec_DefaultDimension."Dimension Value Code"
            else
                Gtext_CodeAxe := '';
        if (Rec."Source Type" = Rec."Source Type"::Vendor) and
        (Rec."Document Type" = Rec."Document Type"::Invoice) then
            Grec_NEntetefacturefournisseur.GET(Rec."Document No.")
        else
            CLEAR(Grec_NEntetefacturefournisseur);
    end;

    trigger OnOpenPage()
    begin
        //Modif JX-AUD du 03/01/2012
        IF Grecord_GeneralLedgerSetup.FIND('-') THEN
            Gcode_Axe := Grecord_GeneralLedgerSetup."Shortcut Dimension 8 Code";
    end;
}
