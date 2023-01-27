tableextension 50042 "BC6_SalesCue" extends "Sales Cue" //9053
{
    fields
    {
        field(50000; "BC6_Sales Orders"; Integer)
        {
            FieldClass = FlowField;
            AccessByPermission = tabledata "Sales Shipment Header" = R;
            CalcFormula = count("Sales Header" where("Document Type" = FILTER(Order)));
            Caption = 'Sales Orders', Comment = 'FRA="Commandes vente"';
            Editable = false;

        }
    }
}

