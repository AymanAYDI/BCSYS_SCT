page 50032 "BC6 Vendor Bank Acc. subform"
{
    // // Création LAB du 15/07/2010
    // // sous-formulaire pour formulaire récapitulatif des fournisseurs
    // 
    // // MODIF JX-XAD du 10/04/2011
    // // Ajout de la fonnction ReturnRecord (utilisé par le récapitulatif fournisseur)
    // 
    // MODIF JX-XAD 07/06/2011
    // Un bug Nav permet parfois de renseigner certains champs avant d'avoir renseigné le Code.
    // Le code doit absolument être renseigné avant toute chose. Un message apparaît donc et le curseur se positionne sur ce champ.

    Caption = 'Vendor Bank Account Subform', Comment = 'FRA="Sous-fomulaire compte bancaire fourn."';
    PageType = ListPart;
    SourceTable = "Vendor Bank Account";

    layout
    {
        area(content)
        {
            repeater(Control1000000001)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("SWIFT Code"; Rec."SWIFT Code")
                {
                    ApplicationArea = All;
                }
                field(IBAN; Rec.IBAN)
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Change RIB/IBAN"; Rec."BC6_Change RIB/IBAN")
                {
                    ApplicationArea = All;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    Caption = 'Post Code/City', Comment = 'FRA="CP/Ville"';
                    Visible = false;
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bank Branch No."; Rec."Bank Branch No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Agency Code"; Rec."Agency Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("RIB Key"; Rec."RIB Key")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("RIB Checked"; Rec."RIB Checked")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        OnActivateForm();
    end;

    procedure ReturnRecord(var Prec_VendorBankAccount: Record "Vendor Bank Account")
    begin
        Prec_VendorBankAccount := Rec;
    end;

    local procedure OnActivateForm()
    begin
        //DEBUT MODIF JX-XAD 07/06/2011
        IF Rec.Code = '' THEN;
        //FIN MODIF JX-XAD 07/06/2011
    end;
}

