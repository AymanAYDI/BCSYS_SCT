tableextension 50043 "BC6_PurchaseCue" extends "Purchase Cue" //9055
{
    //TODO: CalcFormula de field 4 "Outstanding Purchase Orders" a été modifié 
    fields
    {
        field(50000; "BC6_Quote Open"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where("Document Type" = CONST(Quote), Status = CONST(Open), "Assigned User ID" = field("BC6_User Filter")));
            Caption = 'Devis Ouvert';
            Editable = false;

        }
        field(50001; "BC6_Quote to Release"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST(Quote), Status = CONST("Pending Approval"), "Assigned User ID" = FIELD("BC6_User Filter")));
            Caption = 'Devis En Appro.';
            Editable = false;

        }
        field(50002; "BC6_Quote to tranform"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST(Quote), Status = CONST(Released), "Assigned User ID" = FIELD("BC6_User Filter")));
            Caption = 'Devis à Transformer en BC';
            Editable = false;

        }
        field(50003; "BC6_All Orders"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST(Order), Status = FILTER(Open | Released), "Assigned User ID" = FIELD("BC6_User Filter")));
            Caption = 'Tous mes BC';
            Editable = false;

        }
        field(50004; "BC6_Invoice To Approve"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST(Invoice), "BC6_Status Code" = CONST('08'), "Assigned User ID" = FIELD("BC6_User Filter"), Status = CONST(Open)));
            Caption = 'Factures à approuver';
            Editable = false;

        }
        field(50005; "BC6_Credit Memo To Approve"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST("Credit Memo"), "Assigned User ID" = FIELD("BC6_User Filter"), Status = CONST(Open)));
            Caption = 'Avoirs à approuver';
            Editable = false;

        }
        field(50006; "BC6_Order To Receipt"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST(Order), "Assigned User ID" = FIELD("BC6_User Filter"), "BC6_Receipt Status" = FILTER(' ' | "Not receive" | "Partially receive")));
            Caption = 'BC à réceptionner';
            Editable = false;

        }
        field(50007; BC6_Invoices; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST(Invoice), "BC6_Status Code" = FILTER(01 .. 08 | 10 .. 11 | 20), "Assigned User ID" = FIELD("BC6_User Filter")));
            Caption = 'Invoices';
            Editable = false;

        }
        field(50010; "BC6_User Filter"; Code[50])
        {
            Caption = 'Filtre Utilisateur';
            FieldClass = FlowFilter;
            TableRelation = "User Setup"."User ID";
        }
    }
}

