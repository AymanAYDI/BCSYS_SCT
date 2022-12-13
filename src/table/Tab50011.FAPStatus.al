table 50011 "BC6_FAP Status"
{
    Caption = 'FAP Status', Comment = 'FRA="Statuts FAP"';
    DataClassification = CustomerContent;
    DrillDownPageId = "BC6_FAP Status";
    LookupPageId = "BC6_FAP Status";

    fields
    {
        field(1; "Status No."; Code[10])
        {
            Caption = 'Code statut', Comment = 'FRA="Code statut"';
            DataClassification = CustomerContent;
        }
        field(2; "Description status"; Text[50])
        {
            Caption = 'Description qualification', Comment = 'FRA="Libellé statut"';
            DataClassification = CustomerContent;
        }
        field(3; Bloked; Boolean)
        {
            Caption = 'Bloqué', Comment = 'FRA="Bloqué"';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key50000; "Status No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup("BC6_DropDown"; "Status No.", "Description status")
        {
        }
    }

    trigger OnDelete()
    begin
        Grec_PurchaseHeader.SETFILTER(Grec_PurchaseHeader."BC6_Status Code", "Status No.");
        if Grec_PurchaseHeader.FindFirst() then
            Error(Text001, "Status No.");
    end;

    var
        Grec_PurchaseHeader: Record "Purchase Header";
        Text001: label 'Impossible to delete because the Qualification No. %1  is used on an Invoice', Comment = 'FRA="Impossible de supprimer le code qualification %1 car il est utilisé sur une facture"';
}
