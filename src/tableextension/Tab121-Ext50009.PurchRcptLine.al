tableextension 50009 "BC6_PurchRcptLine" extends "Purch. Rcpt. Line" //121
{
    fields
    {
        field(50000; "BC6_Nom Fournisseur"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Rcpt. Header"."Buy-from Vendor Name" WHERE("No." = field("Document No.")));
            Caption = 'Nom Fournisseur';
        }
        field(50001; "BC6_Order Number"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Rcpt. Header"."Order No." WHERE("No." = FIELD("Document No.")));
            Caption = 'Order Numbe', Comment = 'FRA="N° Commande"';

        }
        field(50002; "BC6_Vendor Order Number"; Code[35])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Rcpt. Header"."Vendor Order No." WHERE("No." = FIELD("Document No.")));
            Caption = 'Vendor Order Number', Comment = 'FRA="N° Commande fournisseur"';

        }
        field(50003; "BC6_Code Utilisateur Commande"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Purchase Header"."Assigned User ID" WHERE("Document Type" = CONST(Order), "No." = FIELD("Order No.")));
            Editable = false;
            Caption = 'Code Utilisateur Commande';
        }
        field(50004; "BC6_Your Reference"; Text[35])
        {
            CalcFormula = Lookup("Purchase Header"."Your Reference" WHERE("Document Type" = CONST(Order), "No." = FIELD("Order No.")));
            Caption = 'Your Reference', Comment = 'FRA="Votre référence"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "BC6_Matricule No."; Code[20])
        {
            Caption = 'Code matricule';
            DataClassification = CustomerContent;
        }
    }
    procedure "BC6_ModifyDimensions"()
    VAR
        lUpdateDim: Report "BC6_Modifier axes réception";
        DimMgt: Codeunit DimensionManagement;
        lNewDimSet: Integer;
    begin
        lNewDimSet := DimMgt.EditDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2 %3', TABLECAPTION, "Document No.", "Line No."));
        IF "Dimension Set ID" <> lNewDimSet THEN BEGIN
            CLEAR(lUpdateDim);
            lUpdateDim.SetPostedInvoice(Rec, lNewDimSet);
            lUpdateDim.RUN();
        END;
    end;
}

