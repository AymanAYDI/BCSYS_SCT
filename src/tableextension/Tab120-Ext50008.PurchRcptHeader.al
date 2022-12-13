tableextension 50008 "BC6_PurchRcptHeader" extends "Purch. Rcpt. Header" //120
{
    fields
    {
        field(50005; "BC6_Matricule No."; Code[20])
        {
            Caption = 'Code matricule';
            DataClassification = CustomerContent;
        }
        field(50030; "BC6_Document Prepaid"; Boolean)
        {
            Caption = 'Document PréPayé';
            DataClassification = CustomerContent;
        }
        field(50031; "BC6_Amount Prepaid"; Decimal)
        {
            Caption = 'Montant PréPayé';
            DataClassification = CustomerContent;
        }
        field(50032; "BC6_Document Type Prepaid"; Option)
        {
            Caption = 'Type Document Prépayé';
            OptionCaption = ' ,Quote,Order,FAP', Comment = 'FRA=" ,Devis,Commande,FAP"';
            OptionMembers = " ",Quote,Order,FAP;
            DataClassification = CustomerContent;
        }
        field(50033; "BC6_Document No. Prepaid"; Code[20])
        {
            Caption = 'N° Document Prépayé';
            DataClassification = CustomerContent;
        }
    }
}

