page 50016 "BC6_F.A. Tracking"
{
    // ----------------------------------- V 1.2 -----------------------------------
    // CREATION JX-XAD 29/01/2010
    // Suivi des affectations immo
    // 
    // //MODIF LAB DU 12/02/2010
    // //ajout du champ service
    // 
    // //MODIF LAB DU 17/02/2010
    // //Code utilisateur obligatoire
    // 
    // //MODIF AUD DU 15/10/2010
    // //Changement des en têtes emplacement immo et salarié
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'F.A. Tracking', Comment = 'FRA="Suivi des immos."';
    PageType = List;
    SourceTable = "BC6_F.A. Tracking";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Fixed Asset No."; Rec."Fixed Asset No.")
                {
                    ApplicationArea = All;
                }
                field(Service; Rec."Service")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec."Description")
                {
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
                field("type of equipment"; Rec."Type of equipment")
                {
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("User name"; Rec."User name")
                {
                    ApplicationArea = All;
                }
                field("User status"; Rec."User status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("release date"; Rec."Release date")
                {
                    ApplicationArea = All;
                }
                field(Manager; Rec."Manager")
                {
                    ApplicationArea = All;
                }
                field("Location 1"; Rec."Location 1")
                {
                    Caption = 'Location 1', Comment = 'FRA="Emplacement immo"';
                    ApplicationArea = All;
                }
                field("Location 2"; Rec."Location 2")
                {
                    Caption = 'Location 2', Comment = 'FRA="Emplacement salarié"';
                    ApplicationArea = All;
                }
                field("Fixed asst linked"; Rec."Fixed asst linked")
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec."Comments")
                {
                    ApplicationArea = All;
                }
                field(Company; Rec."Company")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    trigger OnModifyRecord(): Boolean
    begin
        IF ((Rec."User status" = Rec."User status"::"Salarié CDD") OR
           (Rec."User status" = Rec."User status"::Presta)) AND (Rec."Release date" = 0D) THEN BEGIN
            ERROR(Text001, "Fixed Asset No.");
            exit(false);
        END;
        if "User name" = '' then begin
            ERROR(Text002, "Fixed Asset No.");
            exit(false);
        end;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        Lrec_SuiviImmos.RESET();
        IF Lrec_SuiviImmos.FIND('-') THEN
            REPEAT
                IF ((Lrec_SuiviImmos."User status" = Lrec_SuiviImmos."User status"::"Salarié CDD") OR
                   (Lrec_SuiviImmos."User status" = Lrec_SuiviImmos."User status"::Presta))
                   AND (Lrec_SuiviImmos."Release date" = 0D) THEN BEGIN
                    ERROR(Text001, Lrec_SuiviImmos."Fixed Asset No.");
                    exit(false);
                END;
                IF Lrec_SuiviImmos."User name" = '' THEN BEGIN
                    ERROR(Text002, Lrec_SuiviImmos."Fixed Asset No.");
                    exit(false);
                END;
            UNTIL Lrec_SuiviImmos.NEXT() = 0;
    end;

    var
        Lrec_SuiviImmos: Record "BC6_F.A. Tracking";
        Text001: Label 'Please select a release date for fixed asset No. %1', Comment = 'FRA="Veuillez sélectionner une date de sortie pour immobilisation n° %1"';
        Text002: Label 'Please select a user for fixed asset No. %1', Comment = 'FRA="Veuillez sélectionner un utilisateur pour immobilisation n° %1"';

}

