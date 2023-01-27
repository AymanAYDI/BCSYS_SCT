table 50007 "BC6_Users-Staff"
{
    // ----------------------------------- V 1.2 -----------------------------------
    // CREATION JX-XAD 29/01/2010
    // Projet : Suivi des affectations immo
    // Formulaire lié à la table "Utilisateurs-Personnels" qui est partagée entre toutes les sociétés
    // 
    // //MODIF JX-AUD du 15/10/10
    // //Rajout des champs Statut utilisateur, Date de sortie, Emplacement salarié, Société
    // //Modification des triggers correspondants
    // //Champs de table remis en anglais

    Caption = 'Users-Staff';
    DataPerCompany = false;
    DataClassification = CustomerContent;
    LookupPageId = "BC6_Users-Staff";

    fields
    {
        field(1; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
            NotBlank = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Last Name" = '' then
                    Validate("Full name", "First name")
                else
                    if "First name" = '' then
                        Validate("Full name", "Last Name")
                    else
                        Validate("Full name", "Last Name" + ' ' + "First name");
            end;
        }
        field(2; "First name"; Text[30])
        {
            Caption = 'First name';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Last Name" = '' then
                    Validate("Full name", "First name")
                else
                    if "First name" = '' then
                        Validate("Full name", "Last Name")
                    else
                        Validate("Full name", "Last Name" + ' ' + "First name");
            end;
        }
        field(3; "Full name"; Text[60])
        {
            Caption = 'Full name';
            Editable = false;
            NotBlank = false;
            DataClassification = CustomerContent;
        }
        field(4; "User status"; Option)
        {
            Caption = 'User status';
            OptionCaption = 'External employee,Employee fixed-term contract,Employee permanent contract';
            OptionMembers = Presta,"Salarié CDD","Salarié CDI";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //MODIF LAB DU 01/09/2010
                //ajout du test d'utilisateur

                if "User status" = Rec."User status"::"Salarié CDI" then
                    Validate("Release date", 99990101D)
                else
                    Validate("Release date", 20500101D);

                //FIN MODIF LAB DU 01/09/2010

                //DEBUT MODIF JX-XAD DU 07/09/2010
                Grec_FA_Tracking.RESET();
                Grec_FA_Tracking.SETFILTER(Grec_FA_Tracking."User name", '%1', "Full name");
                if Grec_FA_Tracking.FIND('-') then
                    repeat
                        Grec_FA_Tracking."User status" := "User status";
                        Grec_FA_Tracking.MODIFY();
                    until Grec_FA_Tracking.NEXT() = 0;
                //FIN MODIF JX-XAD DU 07/09/2010
            end;
        }
        field(5; "release date"; Date)
        {
            Caption = 'release date';
            InitValue = 20500101D;
            NotBlank = true;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //DEBUT MODIF JX-XAD DU 07/09/2010
                Grec_FA_Tracking.RESET();
                Grec_FA_Tracking.SETFILTER(Grec_FA_Tracking."User name", '%1', "Full name");
                IF Grec_FA_Tracking.FIND('-') THEN
                    REPEAT
                        Grec_FA_Tracking."release date" := "Release date";
                        Grec_FA_Tracking.MODIFY();
                    UNTIL Grec_FA_Tracking.NEXT() = 0;
                //FIN MODIF JX-XAD DU 07/09/2010
            end;
        }
        field(6; "Location 2"; Text[50])
        {
            Caption = 'Location 2';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Modif Jx-AUD du 14/10/10
                Grec_FA_Tracking.RESET();
                Grec_FA_Tracking.SETFILTER(Grec_FA_Tracking."User name", '%1', "Full name");
                IF Grec_FA_Tracking.FIND('-') THEN
                    REPEAT
                        Grec_FA_Tracking."Location 2" := "Location 2";
                        Grec_FA_Tracking.MODIFY();
                    UNTIL Grec_FA_Tracking.NEXT() = 0;

                //FIN Modif JX-AUD du 14/10/10
            end;
        }
        field(7; Company; Text[30])
        {
            Caption = 'Company';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key50000; "Last Name", "First name", "Full name")
        {
            Clustered = true;
        }
        key(Key50001; "Full name")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Grec_FA_Tracking: Record "BC6_F.A. Tracking";
}

