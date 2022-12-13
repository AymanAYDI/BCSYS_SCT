tableextension 50006 "BC6_SalesCrMemoHeader" extends "Sales Cr.Memo Header" //114
{
    fields
    {
        field(50000; BC6_Agent; Code[20])
        {
            Caption = 'Agent', Comment = 'FRA="Mandataire"';
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;
        }
        field(50001; "BC6_Paying agent"; Boolean)
        {
            Caption = 'Paying agent', Comment = 'FRA="Mandataire payeur"';
            DataClassification = CustomerContent;
        }
    }
}
