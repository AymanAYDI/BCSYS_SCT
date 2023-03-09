tableextension 50023 "BC6_PurchasesPayablesSetup" extends "Purchases & Payables Setup" //312
{
    fields
    {
        modify("Quote Nos.")
        {
            Caption = 'No. devis', Comment = 'FRA="N° devis"';
        }
        field(50000; "BC6_Max. Amount allowed"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Max. Amount allowed', Comment = 'FRA="Max. Amount allowed"';
        }

        field(50010; "BC6_Entity Code"; Code[20])
        {
            Caption = 'Code Entité', Comment = 'FRA="Code Entité"';
            DataClassification = CustomerContent;
        }
        field(50011; "BC6_Timing Dimension 0"; Code[20])
        {
            Caption = 'Axe 0 dans import Timing', Comment = 'FRA="Axe 0 dans import Timing"';
            TableRelation = Dimension.Code;
            DataClassification = CustomerContent;
        }
        field(50012; "BC6_Timing Dimension 1"; Code[20])
        {
            Caption = 'Axe 1 dans import Timing', Comment = 'FRA="Axe 1 dans import Timing"';
            TableRelation = Dimension.Code;
            DataClassification = CustomerContent;
        }
        field(50013; "BC6_Timing Dimension 2"; Code[20])
        {
            Caption = 'Axe 2 dans import Timing', Comment = 'FRA="Axe 2 dans import Timing"';
            TableRelation = Dimension.Code;
            DataClassification = CustomerContent;
        }
        field(50014; "BC6_Timing Dimension 3"; Code[20])
        {
            Caption = 'Axe 3 dans import Timing', Comment = 'FRA="Axe 3 dans import Timing"';
            TableRelation = Dimension.Code;
            DataClassification = CustomerContent;
        }
        field(50015; "BC6_Verif Dim 0 on Purch. Line"; Boolean)
        {
            Caption = 'Vérifier Existance Section 0 sur ligne Achat', Comment = 'FRA="Vérifier Existance Section 0 sur ligne Achat"';
            DataClassification = CustomerContent;
        }
        field(50016; "BC6_Verif Dim 1 on Purch. Line"; Boolean)
        {
            Caption = 'Vérifier Existance Section 1 sur ligne Achat', Comment = 'FRA="Vérifier Existance Section 1 sur ligne Achat"';
            DataClassification = CustomerContent;
        }
        field(50017; "BC6_Verif Dim 2 on Purch. Line"; Boolean)
        {
            Caption = 'Vérifier Existance Section 2 sur ligne Achat', Comment = 'FRA="Vérifier Existance Section 2 sur ligne Achat"';
            DataClassification = CustomerContent;
        }
        field(50018; "BC6_Verif Dim 3 on Purch. Line"; Boolean)
        {
            Caption = 'Vérifier Existance Section 3 sur ligne Achat', Comment = 'FRA="Vérifier Existance Section 3 sur ligne Achat"';
            DataClassification = CustomerContent;
        }
        field(50020; "BC6_ExcelFile Vend Not Created"; Text[250])
        {
            Caption = 'Fichier Excel Mail Fourn. Non Créé', Comment = 'FRA="Fichier Excel Mail Fourn. Non Créé"';
            DataClassification = CustomerContent;
        }
        field(50030; "BC6_Mail Invoice Path"; Text[250])
        {
            Caption = 'Chemin Mail Envoi Facture', Comment = 'FRA="Chemin Mail Envoi Facture"';
            DataClassification = CustomerContent;
        }
        field(50031; "BC6_Enable Signature Print"; Boolean)
        {
            Caption = 'Enable Signature Print', Comment = 'FRA="Activer impression signature"';
            DataClassification = CustomerContent;
        }
    }
}
