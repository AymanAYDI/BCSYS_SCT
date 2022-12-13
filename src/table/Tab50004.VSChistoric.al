table 50004 "BC6_VSC historic"
{
    Caption = 'Historique VSC', Comment = 'FRA="Historique VSC"';
    DataClassification = CustomerContent;
    LookupPageId = "BC6_Purch. Invoice Subform VSC";

    fields
    {
        field(1; Type; enum "BC6_VSC Historic Type")
        {
            Caption = 'Type', Comment = 'FRA="Type"';
            Description = 'Type de document';
            DataClassification = CustomerContent;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.', Comment = 'FRA="N°"';
            Description = 'N° de document';
            DataClassification = CustomerContent;
        }
        field(3; "Date time"; DateTime)
        {
            Caption = 'Date time', Comment = 'FRA="Date heure"';
            DataClassification = CustomerContent;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description', Comment = 'FRA="Description"';
            DataClassification = CustomerContent;
        }
        field(5; "User ID"; Code[50])
        {
            Caption = 'User ID', Comment = 'FRA="Code utilisateur"';
            DataClassification = CustomerContent;
        }
        field(6; Comments; Text[100])
        {
            Caption = 'Comments', Comment = 'FRA="Commentaires"';
            Description = 'Commentaires éditables par la compta';
            DataClassification = CustomerContent;
        }
        field(7; "Assigned User ID"; Code[50])
        {
            Caption = 'Assigned User ID', Comment = 'FRA="Code utilisateur affecté"';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key50000; Type, "No.", "Date time")
        {
            Clustered = true;
        }
    }
}
