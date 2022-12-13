tableextension 50028 "BC6_PurchaseHeader" extends "Purchase Header" //38
{
    fields
    {
        field(50000; "BC6_Lines Amount"; Decimal)
        {
            FieldClass = FlowField;
            AutoFormatExpression = "Currency Code";
            CalcFormula = sum("Purchase Line"."Line Amount" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
            Caption = 'Montant des lignes', Comment = 'FRA="Montant des lignes"';
            Editable = false;
        }
        field(50001; "BC6_Original user"; Code[50])
        {
            Caption = 'Original user', Comment = 'FRA="Utilisateur initial"';
            Editable = true;
            TableRelation = "User Setup";
            DataClassification = CustomerContent;
        }
        field(50002; "BC6_Creation date"; Date)
        {
            Caption = 'Creation date', Comment = 'FRA="Date de création"';
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
            TableRelation = "BC6_Matricule";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Modif JX-AUD du 17/02/2012
                TESTFIELD(Status, Status::Open);
                if "BC6_Matricule No." <> xRec."BC6_Matricule No." then
                    UpdatePurchLines(FIELDCAPTION("BC6_Matricule No."), true);
            end;
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

            trigger OnValidate()
            begin
                //Modif JX-AUD du 25/02/2013
                if Grec_QualificationFAP.GET("BC6_Status Code") then
                    "BC6_Status description" := Grec_QualificationFAP."Description status";
                //Fin Modif JX-AUD du 25/02/2013
            end;
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
            Caption = 'Yooz Token link', Comment = 'FRA="Yooz Token link"';
            Editable = false;
            ExtendedDatatype = URL;
            DataClassification = CustomerContent;
        }
        field(50016; "BC6_Total Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line"."Line Amount" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
            Caption = 'Total HT', Comment = 'FRA="Total HT"';
            Editable = false;
        }
        field(50017; "BC6_Total Amount Incl. VAT"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line"."Amount Including VAT" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
            Caption = 'Total TTC', Comment = 'FRA="Total TTC"';
            Editable = false;
        }
        field(50018; "BC6_Receipt Status"; enum "BC6_Receipt Status")
        {
            Caption = 'Statut réception', Comment = 'FRA="Statut réception"';
            DataClassification = CustomerContent;
        }
        field(50019; "BC6_Total Quantity"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line".Quantity where("Document Type" = field("Document Type"), "Document No." = field("No.")));
            Caption = 'Total Quantité', Comment = 'FRA="Total Quantité"';
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(50020; "BC6_Total Quantity Received"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line"."Quantity Received" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
            Caption = 'Total Quantité reçue', Comment = 'FRA="Total Quantité reçue"';
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(50030; "BC6_Document Prepaid"; Boolean)
        {
            Caption = 'Document PréPayé', Comment = 'FRA="Document PréPayé"';
            DataClassification = CustomerContent;
        }
        field(50031; "BC6_Amount Prepaid"; Decimal)
        {
            Caption = 'Montant PréPayé', Comment = 'FRA="Montant PréPayé"';
            DataClassification = CustomerContent;
        }
        field(50032; "BC6_Document Type Prepaid"; enum "BC6_Document Type Prepaid")
        {
            Caption = 'Type Document Prépayé', Comment = 'FRA="Type Document Prépayé"';
            DataClassification = CustomerContent;
        }
        field(50033; "BC6_Document No. Prepaid"; Code[20])
        {
            Caption = 'N° Document Prépayé', Comment = 'FRA="N° Document Prépayé"';
            DataClassification = CustomerContent;
        }
        field(50034; "BC6_Free comment CDG"; Text[50])
        {
            Caption = 'Free comment', Comment = 'FRA="Commentaire libre"';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        /*key(Key1;"Document Type","Assigned User ID","BC6_Receipt Status")
        {
        }*/
    }
    procedure SendToPostingOk(PostingCodeunitID: Integer)
    begin
        // Migration Nav 2015 : Facture déjà vérifier par le spécifique
        codeunit.RUN(PostingCodeunitID, Rec);
    end;

    var
        Grec_QualificationFAP: Record "BC6_FAP Status";
}
