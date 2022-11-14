tableextension 50045 "BC6_GeneralLedgerSetup" extends "General Ledger Setup" //98
{
    fields
    {
        field(50000; "BC6_Report Dimension 1"; Code[20])
        {
            Caption = 'Axe 1 dans Etats';
            TableRelation = Dimension.Code;
            DataClassification = CustomerContent;
        }
        field(50001; "BC6_Report Dimension 2"; Code[20])
        {
            Caption = 'Axe 2 dans Etats';
            TableRelation = Dimension.Code;
            DataClassification = CustomerContent;
        }
        field(50002; "BC6_Report Dimension 3"; Code[20])
        {
            Caption = 'Axe 3 dans Etats';
            TableRelation = Dimension.Code;
            DataClassification = CustomerContent;
        }
        field(50003; "BC6_Report Dimension 4"; Code[20])
        {
            Caption = 'Axe 4 dans Etats';
            TableRelation = Dimension.Code;
            DataClassification = CustomerContent;
        }
        field(50004; "BC6_Report Dimension 5"; Code[20])
        {
            Caption = 'Axe 5 dans Etats';
            TableRelation = Dimension.Code;
            DataClassification = CustomerContent;
        }
        field(50020; "BC6_Shortcut Dimension 9 Code"; Code[20])
        {
            AccessByPermission = tabledata "Dimension Combination" = R;
            Caption = 'Shortcut Dimension 8 Code';
            Description = '//Modif JX-VSC4.0-PBD du 26/01/15';
            TableRelation = Dimension;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Modify();
            end;
        }
        field(50021; "BC6_Shortcut Dimension 10 Code"; Code[20])
        {
            AccessByPermission = tabledata "Dimension Combination" = R;
            Caption = 'Shortcut Dimension 8 Code';
            Description = '//Modif JX-VSC4.0-PBD du 26/01/15';
            TableRelation = Dimension;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Modify();
            end;
        }
        field(50060; "BC6_Default Payment Class"; Code[20])
        {
            Caption = 'Type Bordereau par défaut';
            TableRelation = "Payment Class".Code;
            DataClassification = CustomerContent;
        }
    }
}
