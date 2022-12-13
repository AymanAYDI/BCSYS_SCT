pageextension 50055 "BC6_GetReceiptLines" extends "Get Receipt Lines" //5709
{
    // Modif JX-XAD du 10/01/2008
    // Ajout de 4 champs dans le formulaire :
    // - Date de comptabilisation de la réception
    // - Nom du fournisseur
    // - N° de commande
    // - N° de commande fournisseur
    // 
    // // Modif LAB du 20/07/2009
    // // Ajout champ "Your reference"
    // 
    // //Modif JX-AUD du 05/04/2011
    // //ajout du champ analytique visible periode
    layout
    {
        modify("Document No.")
        {
            HideValue = "Document No.HideValue";
        }


        addafter("Document No.")
        {
            field("BC6_Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
            }
            field("BC6_Nom Fournisseur"; Rec."BC6_Nom Fournisseur")
            {
                Caption = 'Vendor name', Comment = 'FRA="Nom du fournisseur"';
                ApplicationArea = All;
            }
            field("BC6_Code Utilisateur Commande"; Rec."BC6_Code Utilisateur Commande")
            {
                ApplicationArea = All;
            }
            field("BC6_Order Number"; Rec."BC6_Order Number")
            {
                Caption = 'Order No.', Comment = 'FRA="N° Commande"';
                ApplicationArea = All;
            }
            field("BC6_Your Reference"; Rec."BC6_Your Reference")
            {
                ApplicationArea = All;
            }
            field("BC6_Vendor Order Number"; Rec."BC6_Vendor Order Number")
            {
                Caption = 'Vendor Order No.', Comment = 'FRA="N° Commande fournisseur"';
                ApplicationArea = All;
            }
        }
        addafter("Qty. Rcd. Not Invoiced")
        {
            field("BC6_Axe 0"; Gtext_Axe0)
            {
                CaptionClass = Gtext_ColAxe0;
                MultiLine = true;
                Visible = "Axe 0Visible";
                ApplicationArea = All;
                Caption = 'Axe 0';
            }
        }
    }
    actions
    {
        modify(Dimensions)
        {
            Visible = false;
        }
        addafter(Dimensions)
        {
            action(BC6_Dimensions2)
            {
                AccessByPermission = TableData Dimension = R;
                ApplicationArea = all;
                Caption = 'Dimensions', Comment = 'FRA="Axes analytiques"';
                Image = Dimensions;
                Promoted = true;
                PromotedCategory = Category4;
                ShortCutKey = 'Alt+D';

                trigger OnAction()
                begin
                    Rec."BC6_ModifyDimensions"();
                end;
            }
        }
    }
    var
        Grec_DimSetEntry: Record "Dimension Set Entry";
        Grecord_GeneralLedgerSetup: Record "General Ledger Setup";
        Grec_Dimension: Record Dimension;
        Gtext_Axe0: Text[30];
        Gcode_Axe1: Code[20];
        Gtext_ColAxe0: Text[80];
        [InDataSet]
        "Axe 0Visible": Boolean;
        [InDataSet]
        "Document No.HideValue": Boolean;


    trigger OnAfterGetRecord()
    begin
        "Document No.HideValue" := FALSE;
        IF Grec_DimSetEntry.GET(Rec."Dimension Set ID", Gcode_Axe1) THEN
            Gtext_Axe0 := Grec_DimSetEntry."Dimension Value Code"
        ELSE
            Gtext_Axe0 := '';
    end;

    trigger OnOpenPage()
    begin
        "Axe 0Visible" := TRUE;
        IF Grecord_GeneralLedgerSetup.FindFirst() THEN BEGIN
            Gcode_Axe1 := Grecord_GeneralLedgerSetup."Shortcut Dimension 3 Code";
            IF Grec_Dimension.GET(Gcode_Axe1) THEN
                Gtext_ColAxe0 := Grec_Dimension."Code Caption" ELSE
                "Axe 0Visible" := FALSE;
        END;
    end;
}

