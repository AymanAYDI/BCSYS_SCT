tableextension 50038 "BC6_PurchaseLineArchive" extends "Purchase Line Archive" //5110
{
    fields
    {
        field(50005; "BC6_Matricule No."; Code[20])
        {
            Caption = 'Code matricule';
            DataClassification = CustomerContent;
        }
    }
}

