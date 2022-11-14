tableextension 50028 "BC6_PurchaseHeader" extends "Purchase Header" //38
{
    fields
    {
        field(50000; "BC6_Lines Amount"; Decimal)
        {
            FieldClass = FlowField;
            AutoFormatExpression = "Currency Code";
            CalcFormula = sum("Purchase Line"."Line Amount" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
            Caption = 'Montant des lignes';
            Editable = false;
        }
        field(50001; "BC6_Original user"; Code[50])
        {
            Caption = 'Original user';
            Editable = true;
            TableRelation = "User Setup";
            DataClassification = CustomerContent;
        }
        field(50002; "BC6_Creation date"; Date)
        {
            Caption = 'Creation date';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(50003; "BC6_Invoice receipt date"; Date)
        {
            Caption = 'Invoice receipt date';
            DataClassification = CustomerContent;
        }
        field(50005; "BC6_Matricule No."; Code[20])
        {
            Caption = 'Code matricule';
            TableRelation = "BC6_Matricule";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Modif JX-AUD du 17/02/2012
                TESTFIELD(Status, Status::Open);
                if "BC6_Matricule No." <> xRec."BC6_Matricule No." then
                    UpdatePurchLines(FIELDCAPTION("BC6_Matricule No."), true);
                //TODO: non migré
                //mise à jour des champs Nom prestataire et Prénom prestataire du contrat
                // IF Grec_Matricule.GET("BC6_Matricule No.") THEN BEGIN
                //     IF Grec_Contract.GET("Quote No.") OR Grec_Contract.GET("No.") THEN BEGIN
                //         Grec_Contract."BC6_Nom prestataire" := Grec_Matricule."BC6_Provider name";
                //         Grec_Contract."BC6_Prénom prestataire" := Grec_Matricule."BC6_Provider first name";
                //         Grec_Contract.MODIFY;
                //     END;
                //END;
                //Fin modif JX-AUD du 17/02/2012
            end;
        }
        field(50006; "BC6_Free comment"; Text[50])
        {
            Caption = 'Free comment';
            DataClassification = CustomerContent;
        }
        field(50007; "BC6_Status Code"; Code[30])
        {
            Caption = 'Qualification Code';
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
            Caption = 'Qualification Description';
            DataClassification = CustomerContent;
        }
        field(50009; "BC6_Register amount"; Decimal)
        {
            Caption = 'Montant à enregistrer';
            DataClassification = CustomerContent;
        }
        field(50010; BC6_Import; Boolean)
        {
            Caption = 'Import';
            DataClassification = CustomerContent;
        }
        field(50011; "BC6_Import Vendor Email"; Text[250])
        {
            Caption = 'Import vendor email';
            DataClassification = CustomerContent;
        }
        field(50012; BC6_Litige; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50013; "BC6_BC No."; Code[20])
        {
            Caption = 'BC No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50014; "BC6_Yooz No."; Code[20])
        {
            Caption = 'No. Yooz';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50015; "BC6_Yooz Token link"; Text[250])
        {
            Caption = 'Yooz Token link';
            Editable = false;
            ExtendedDatatype = URL;
            DataClassification = CustomerContent;
        }
        field(50016; "BC6_Total Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line"."Line Amount" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
            Caption = 'Total HT';
            Editable = false;
        }
        field(50017; "BC6_Total Amount Incl. VAT"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line"."Amount Including VAT" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
            Caption = 'Total TTC';
            Editable = false;
        }
        field(50018; "BC6_Receipt Status"; enum "BC6_Receipt Status")
        {
            Caption = 'Statut réception';
            DataClassification = CustomerContent;
        }
        field(50019; "BC6_Total Quantity"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line".Quantity where("Document Type" = field("Document Type"), "Document No." = field("No.")));
            Caption = 'Total Quantité';
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(50020; "BC6_Total Quantity Received"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line"."Quantity Received" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
            Caption = 'Total Quantité reçue';
            DecimalPlaces = 0 : 2;
            Editable = false;
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
        field(50032; "BC6_Document Type Prepaid"; enum "BC6_Document Type Prepaid")
        {
            Caption = 'Type Document Prépayé';
            DataClassification = CustomerContent;
        }
        field(50033; "BC6_Document No. Prepaid"; Code[20])
        {
            Caption = 'N° Document Prépayé';
            DataClassification = CustomerContent;
        }
        field(50034; "BC6_Free comment CDG"; Text[50])
        {
            Caption = 'Free comment';
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
        //TODO: "BC6_Contract" non migré
        //Grec_Contract: Record "BC6_Contract";
        Grec_QualificationFAP: Record "BC6_FAP Status";
}
