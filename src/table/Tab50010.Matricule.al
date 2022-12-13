table 50010 "BC6_Matricule"
{
    Caption = 'Matricule', Comment = 'FRA="Matricule"';
    DataClassification = CustomerContent;
    DrillDownPageId = "BC6_Matricule list";
    LookupPageId = "BC6_Matricule list";

    fields
    {
        field(1; "Matricule No."; Text[20])
        {
            Caption = 'Code Matricule', Comment = 'FRA="Code Matricule"';
            DataClassification = CustomerContent;
        }
        field(2; "Provider name"; Text[110])
        {
            Caption = 'Nom prestataire', Comment = 'FRA="Nom prestataire"';
            DataClassification = CustomerContent;
        }
        field(3; "Provider first name"; Text[110])
        {
            Caption = 'Prénom prestataire', Comment = 'FRA="Prénom prestataire"';
            DataClassification = CustomerContent;
        }
        field(4; "Society code"; Code[50])
        {
            Caption = 'Society code', Comment = 'FRA="Code société sous traitante"';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key50000; "Matricule No.")
        {
            Clustered = true;
        }
        key(Key50001; "Provider name", "Provider first name")
        {
        }
    }

    fieldgroups
    {
        fieldgroup("BC6_DropDown"; "Matricule No.", "Provider name", "Provider first name")
        {
        }
    }
}
