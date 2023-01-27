table 50006 "BC6_F.A. Tracking"
{
    // ----------------------------------- V 1.2 -----------------------------------
    // CREATION JX-XAD 29/01/2010
    // Suivi des affectations immo
    // 
    // //MODIF LAB DU 12/02/2010
    // //ajout du champ service
    // //Inversion Option Presta et CDI
    // 
    // MODIF LAB DU 17/02/2010
    // ajout du test d'utilisateur
    // 
    // //MODIF JX-AUD du 14/10/10
    // //rajout MAJ "Location 2" de OnValidate()

    Caption = 'F.A. Tracking';
    DataClassification = CustomerContent;
    LookupPageId = "BC6_F.A. Tracking";

    fields
    {
        field(1; "Fixed Asset No."; Code[20])
        {
            Caption = 'Fixed Asset No.';
            NotBlank = true;
            TableRelation = "Fixed Asset"."No.";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                IF Grec_FixedAsset.GET("Fixed Asset No.") THEN BEGIN
                    "Description" := Grec_FixedAsset.Description;
                    "Serial No." := Grec_FixedAsset."Serial No.";
                    "Type of equipment" := Grec_FixedAsset."FA Subclass Code";
                    Grec_PurchaseLine.RESET();
                    Grec_PurchaseLine.SETFILTER(Grec_PurchaseLine."Document Type", '%1', Grec_PurchaseLine."Document Type"::Order);
                    Grec_PurchaseLine.SETFILTER(Grec_PurchaseLine."No.", '%1', "Fixed Asset No.");
                    IF Grec_PurchaseLine.FIND('-') THEN BEGIN
                        "Order No." := Grec_PurchaseLine."Document No.";
                        IF Grec_Vendor.GET(Grec_PurchaseLine."Buy-from Vendor No.") THEN
                            "Vendor No." := Grec_Vendor.Name;
                    END;
                    "Company" := COMPANYNAME;
                    "Location 1" := "Location 1"::Autres;
                END;
            end;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Serial No."; Text[30])
        {
            Caption = 'Serial No.';
            DataClassification = CustomerContent;
        }
        field(4; "Type of equipment"; Code[10])
        {
            Caption = 'type of equipment';
            TableRelation = "FA Subclass".Code;
            DataClassification = CustomerContent;
        }
        field(5; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            DataClassification = CustomerContent;
        }
        field(6; "Vendor No."; Text[50])
        {
            Caption = 'Vendor No.';
            DataClassification = CustomerContent;
        }
        field(7; "User name"; Text[60])
        {
            Caption = 'User name';
            TableRelation = "BC6_Users-Staff"."Full name";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //DEBUT MODIF JX-XAD 07/09/2010
                Grec_Users.RESET();
                Grec_Users.SETFILTER(Grec_Users."Full name", '%1', "User name");

                IF Grec_Users.FIND('-') THEN BEGIN
                    "User status" := Grec_Users."User status";
                    "Release date" := Grec_Users."Release date";
                    "Location 2" := Grec_Users."Location 2";//MODIF JX-AUD du 14/10/10
                END;
                //FIN MODIF JX-XAD 07/09/2010
            end;
        }
        field(8; "User status"; Option)
        {
            Caption = 'User status';
            OptionCaption = 'External employee,Employee fixed-term contract,Employee permanent contract';
            OptionMembers = Presta,"Salarié CDD","Salarié CDI";
            DataClassification = CustomerContent;
        }
        field(9; Manager; Text[50])
        {
            Caption = 'Manager';
            TableRelation = "BC6_Users-Staff"."Full name";
            DataClassification = CustomerContent;
        }
        field(10; "Release date"; Date)
        {
            Caption = 'release date';
            DataClassification = CustomerContent;
        }
        field(11; "Location 1"; Option)
        {
            Caption = 'Location 1';
            OptionCaption = 'Lille,Nantes,Paris,Other';
            OptionMembers = Lille,Nantes,Paris,Autres;
            DataClassification = CustomerContent;
        }
        field(12; "Location 2"; Text[50])
        {
            Caption = 'Location 2';
            DataClassification = CustomerContent;
        }
        field(13; "Fixed asst linked"; Text[30])
        {
            Caption = 'Fixed asst linked';
            DataClassification = CustomerContent;
        }
        field(14; Comments; Text[200])
        {
            Caption = 'Comments';
            DataClassification = CustomerContent;
        }
        field(15; Company; Text[30])
        {
            Caption = 'Company';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16; Service; Option)
        {
            Caption = 'Service';
            OptionCaption = 'CSI,PROD-LILLE,PROD-NANTES,PROD-PARIS,OTHER';
            OptionMembers = CSI,"PROD-LILLE","PROD-NANTES","PROD-PARIS",AUTRE;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key50000; "Fixed Asset No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Grec_Users: Record "BC6_Users-Staff";
        Grec_FixedAsset: Record "Fixed Asset";
        Grec_PurchaseLine: Record "Purchase Line";
        Grec_Vendor: Record Vendor;

}

