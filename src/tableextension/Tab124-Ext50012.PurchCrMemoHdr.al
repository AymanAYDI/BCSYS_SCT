tableextension 50012 "BC6_PurchCrMemoHdr" extends "Purch. Cr. Memo Hdr." //124
{
    fields
    {
        field(50005; "BC6_Matricule No."; Code[20])
        {
            Caption = 'Code matricule', Comment = 'FRA="Code matricule"';
            DataClassification = CustomerContent;
        }
        field(50012; BC6_Litige; Boolean)
        {
            Caption = 'Litige', Comment = 'FRA="Litige"';
            DataClassification = CustomerContent;
        }
        field(50013; "BC6_BC No."; Code[20])
        {
            Caption = 'BC No.', Comment = 'FRA="N° BC"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50014; "BC6_Yooz No."; Code[20])
        {
            Caption = 'No. Yooz', Comment = 'FRA="N° Yooz"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50015; "BC6_Yooz Token link"; Text[250])
        {
            Caption = 'Yooz Token link', Comment = 'FRA="Lien Token Yooz"';
            Editable = false;
            ExtendedDatatype = URL;
            DataClassification = CustomerContent;
        }
    }
}
