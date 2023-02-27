pageextension 50029 "BC6_ItemList" extends "Item List" //31
{
    // //Modif JX-AUD du 08/01/2013
    // //Ajout colonnes axes analytiques
    // 
    // //MODIF JX-AUD du 23/05/2014
    // //Ajout du traitement sur le filtre article en fonction du service de l'utilisateur
    layout
    {
        addafter(Description)
        {
            // field("BC6_Product Group Code"; "Product Group Code")
            // {
            //     ApplicationArea = All;
            // }
        }
        addafter("Indirect Cost %")
        {
            field("ShortcutDimCode[3]"; ShortcutDimCode[3])
            {
                CaptionClass = '1,2,3';
                ApplicationArea = All;
            }
            field("ShortcutDimCode[4]"; ShortcutDimCode[4])
            {
                CaptionClass = '1,2,4';
                ApplicationArea = All;
            }
            field("ShortcutDimCode[5]"; ShortcutDimCode[5])
            {
                CaptionClass = '1,2,5';
                ApplicationArea = All;
            }
            field("ShortcutDimCode[6]"; ShortcutDimCode[6])
            {
                CaptionClass = '1,2,6';
                ApplicationArea = All;
            }
            field("ShortcutDimCode[7]"; ShortcutDimCode[7])
            {
                CaptionClass = '1,2,7';
                ApplicationArea = All;
            }
            field("ShortcutDimCode[8]"; ShortcutDimCode[8])
            {
                CaptionClass = '1,2,8';
                ApplicationArea = All;
            }
        }
    }

    var
        Grecord_LedgerDefaultDimension: Record "Default Dimension";
        Grecord_GeneralLedgerSetup: Record "General Ledger Setup";
        Grec_UserSetup: Record "User Setup";
        Gcode_Service: Code[2];
        Gcode_Axe1: Code[20];
        Gcode_Axe2: Code[20];
        Gcode_Axe3: Code[20];
        Gcode_Axe4: Code[20];
        Gcode_Axe5: Code[20];
        Gcode_Axe6: Code[20];
        ShortcutDimCode: array[8] of Code[20];

    trigger OnAfterGetRecord()
    var
    begin
        //Modif JX-AUD du 08/01/2013
        IF Grecord_LedgerDefaultDimension.GET(27, Rec."No.", Gcode_Axe1)
        THEN
            ShortcutDimCode[3] := Grecord_LedgerDefaultDimension."Dimension Value Code"
        ELSE
            ShortcutDimCode[3] := '';
        IF Grecord_LedgerDefaultDimension.GET(27, Rec."No.", Gcode_Axe2)
        THEN
            ShortcutDimCode[4] := Grecord_LedgerDefaultDimension."Dimension Value Code"
        ELSE
            ShortcutDimCode[4] := '';
        IF Grecord_LedgerDefaultDimension.GET(27, Rec."No.", Gcode_Axe3)
        THEN
            ShortcutDimCode[5] := Grecord_LedgerDefaultDimension."Dimension Value Code"
        ELSE
            ShortcutDimCode[5] := '';
        IF Grecord_LedgerDefaultDimension.GET(27, Rec."No.", Gcode_Axe4)
        THEN
            ShortcutDimCode[6] := Grecord_LedgerDefaultDimension."Dimension Value Code"
        ELSE
            ShortcutDimCode[6] := '';

        IF Grecord_LedgerDefaultDimension.GET(27, Rec."No.", Gcode_Axe5)
        THEN
            ShortcutDimCode[7] := Grecord_LedgerDefaultDimension."Dimension Value Code"
        ELSE
            ShortcutDimCode[7] := '';
        IF Grecord_LedgerDefaultDimension.GET(27, Rec."No.", Gcode_Axe6)
        THEN
            ShortcutDimCode[8] := Grecord_LedgerDefaultDimension."Dimension Value Code"
        ELSE
            ShortcutDimCode[8] := '';
        //Fin modif JX-AUD du 08/01/2013
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Modif JX-AUD du 08/01/2013
        CLEAR(ShortcutDimCode);
        //Fin modif JX-AUD du 08/01/2013
    end;

    trigger OnOpenPage()
    begin
        //Modif JX-AUD du 08/01/2013
        IF Grecord_GeneralLedgerSetup.FIND('-') THEN BEGIN
            Gcode_Axe1 := Grecord_GeneralLedgerSetup."Shortcut Dimension 3 Code";
            Gcode_Axe2 := Grecord_GeneralLedgerSetup."Shortcut Dimension 4 Code";
            Gcode_Axe3 := Grecord_GeneralLedgerSetup."Shortcut Dimension 5 Code";
            Gcode_Axe4 := Grecord_GeneralLedgerSetup."Shortcut Dimension 6 Code";
            Gcode_Axe5 := Grecord_GeneralLedgerSetup."Shortcut Dimension 7 Code";
            Gcode_Axe6 := Grecord_GeneralLedgerSetup."Shortcut Dimension 8 Code";
        END;
        //Fin Modif JX-AUD du 08/01/2013

        //MODIF JX-AUD du 23/05/2014
        IF ((COMPANYNAME = 'VSC') OR (COMPANYNAME = 'VSC - RECETTE')) THEN
            IF Grec_UserSetup.GET(USERID) THEN
                IF Grec_UserSetup."BC6_Service" <> '' THEN
                    Gcode_Service := COPYSTR(Grec_UserSetup."BC6_Service", 1, 2);
        //SETFILTER("Product Group Code", FORMAT(Gcode_Service) + '*'); //TODO:Field 'Product Group Code' is removed
        //FIN MODIF JX-AUD du 23/05/2014
    end;
}

