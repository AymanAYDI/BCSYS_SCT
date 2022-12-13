tableextension 50037 "BC6_PurchaseHeaderArchive" extends "Purchase Header Archive" //5109
{
    fields
    {
        field(50000; "BC6_Lines Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            CalcFormula = sum("Purchase Line"."Line Amount" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
            Caption = 'Montant des lignes', Comment = 'FRA="Montant des lignes"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "BC6_Original user"; Code[50])
        {
            Caption = 'Original user', Comment = 'FRA="Original user"';
            Editable = true;
            TableRelation = "User Setup";
            DataClassification = CustomerContent;
        }
        field(50002; "BC6_Creation date"; Date)
        {
            Caption = 'Creation date', Comment = 'FRA="Creation date"';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(50003; "BC6_Invoice receipt date"; Date)
        {
            Caption = 'Invoice receipt date', Comment = 'FRA="Date réception facture"';
            DataClassification = CustomerContent;
        }
        field(50005; "BC6_Matricule No."; Code[20])
        {
            Caption = 'Code matricule', Comment = 'FRA="Code matricule"';
            DataClassification = CustomerContent;
        }
        field(50006; "BC6_Free comment"; Text[50])
        {
            Caption = 'Free comment', Comment = 'FRA="Commentaire libre"';
            DataClassification = CustomerContent;
        }
        field(50007; "BC6_Status Code"; Code[30])
        {
            Caption = 'Qualification Code', Comment = 'FRA="Code statut"';
            TableRelation = "BC6_FAP Status";
            DataClassification = CustomerContent;
        }
        field(50008; "BC6_Status description"; Text[50])
        {
            Caption = 'Qualification Description', Comment = 'FRA="Libellé statut"';
            DataClassification = CustomerContent;
        }
        field(50009; "BC6_Register amount"; Decimal)
        {
            Caption = 'Montant à enregistrer', Comment = 'FRA="Montant à enregistrer"';
            DataClassification = CustomerContent;
        }
        field(50010; BC6_Import; Boolean)
        {
            Caption = 'Import', Comment = 'FRA="Import"';
            DataClassification = CustomerContent;
        }
        field(50011; "BC6_Import Vendor Email"; Text[250])
        {
            Caption = 'Import vendor email', Comment = 'FRA="Email import fournisseur"';
            DataClassification = CustomerContent;
        }
        field(50012; BC6_Litige; Boolean)
        {
            Caption = 'Litige', Comment = 'FRA="Litige"';
            DataClassification = CustomerContent;
        }
    }
}
