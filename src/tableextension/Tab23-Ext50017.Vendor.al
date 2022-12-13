tableextension 50017 "BC6_Vendor" extends Vendor //23
{
    fields
    {
        field(50000; "BC6_Registration No."; Code[15])
        {
            Caption = 'Registration No.', Comment = 'FRA="N° SIRET/Immat."';
            DataClassification = CustomerContent;
        }
        field(50010; "BC6_Default Bank Account Code"; Code[10])
        {
            Caption = 'Default Bank Account Code', Comment = 'FRA="Code compte bancaire par défaut"';
            TableRelation = "Vendor Bank Account".Code where("Vendor No." = field("No."));
            DataClassification = CustomerContent;
        }
    }
}
