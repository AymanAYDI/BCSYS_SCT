table 50012 "BC6_Import Group Invoice"
{
    // //JX-AUD CREATION du 10/04/14

    Caption = 'Import Group Invoice', Comment = 'FRA="Import Facture Groupe"';
    DataPerCompany = false;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "BC6 Invoice type"; Option)
        {
            Caption = 'Type facture';
            OptionCaption = 'Purchase,Sale';
            OptionMembers = Purchase,Sale;
            DataClassification = CustomerContent;
        }
        field(2; "BC6 Society code"; Code[20])
        {
            Caption = 'Code société';
            DataClassification = CustomerContent;
        }
        field(3; "BC6 Line No."; Text[30])
        {
            Caption = 'N° ligne';
            DataClassification = CustomerContent;
        }
        field(4; "BC6 Cus. Vend. No."; Code[20])
        {
            Caption = 'N° client/fourn';
            DataClassification = CustomerContent;
        }
        field(5; "BC6 Posting date"; Date)
        {
            Caption = 'Date comptable';
            DataClassification = CustomerContent;
        }
        field(6; "BC6 Document date"; Date)
        {
            Caption = 'Date document';
            DataClassification = CustomerContent;
        }
        field(7; "BC6 Assigned user ID"; Code[50])
        {
            Caption = 'Code utilisateur affecté';
            DataClassification = CustomerContent;
        }
        field(8; "BC6 Your reference"; Text[50])
        {
            Caption = 'Votre référence';
            DataClassification = CustomerContent;
        }
        field(9; "BC6 External doc. No."; Code[20])
        {
            Caption = 'N° doc. externe';
            DataClassification = CustomerContent;
        }
        field(10; "BC6 Invoice No."; Code[20])
        {
            Caption = 'N° facture';
            DataClassification = CustomerContent;
        }
        field(11; "BC6 Line type"; Option)
        {
            Caption = 'Type ligne';
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
            DataClassification = CustomerContent;
        }
        field(12; "BC6 Account No."; Code[20])
        {
            Caption = 'N° compte général';
            DataClassification = CustomerContent;
        }
        field(13; "BC6 Designation"; Text[50])
        {
            Caption = 'Désignation';
            DataClassification = CustomerContent;
        }
        field(14; "BC6 Quantity"; Decimal)
        {
            Caption = 'Quantité';
            DataClassification = CustomerContent;
        }
        field(15; "BC6 Axe 0"; Code[20])
        {
            Caption = 'Axe 0';
            DataClassification = CustomerContent;
        }
        field(16; "BC6 Axe 1"; Code[20])
        {
            Caption = 'Axe 1';
            DataClassification = CustomerContent;
        }
        field(17; "BC6 Axe 2"; Code[20])
        {
            Caption = 'Axe 2';
            DataClassification = CustomerContent;
        }
        field(18; "BC6 Axe 3"; Code[20])
        {
            Caption = 'Axe 3';
            DataClassification = CustomerContent;
        }
        field(19; "BC6 Axe 4"; Code[20])
        {
            Caption = 'Axe 4';
            DataClassification = CustomerContent;
        }
        field(20; "BC6 Axe 5"; Code[20])
        {
            Caption = 'Axe 5';
            DataClassification = CustomerContent;
        }
        field(21; "BC6 Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group', Comment = 'FRA="Groupe compta. Produit"';
            DataClassification = CustomerContent;
        }
        field(22; "BC6 Axe 6"; Code[20])
        {
            Caption = 'Axe 4';
            DataClassification = CustomerContent;
        }
        field(23; "BC6 Axe 7"; Code[20])
        {
            Caption = 'Axe 5';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key50000; "BC6 Invoice type", "BC6 Society code", "BC6 Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

