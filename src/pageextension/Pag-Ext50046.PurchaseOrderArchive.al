pageextension 50046 "BC6_PurchaseOrderArchive" extends "Purchase Order Archive"
{
    // Début Modif JX-XAD du 05/08/2008
    // Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
    //
    // ------------------------------ V1.2 ---------------------------
    // CREATION JX-XAD 26/02/2010
    // Gestion des contrats : ajout du bouton "Contrat"
    //
    // //Modif JX-AUD du 17/02/2012
    // //Ajout du Champs "Matricule" et traitement de celui-ci

    //Unsupported feature: Property Modification (SourceTableView) on ""Purchase Order Archive"(Page 5167)".

    layout
    {
        modify("Buy-from Country/Region Code")
        {
            Visible = false;
        }

        modify("Pay-to City")
        {
            Visible = false;
        }
        modify(Control27)
        {
            Visible = false;
        }
        modify("Pay-to County")
        {
            Visible = false;
        }

        modify("Pay-to Country/Region Code")
        {
            Visible = false;
        }

        modify("Ship-to City")
        {
            Visible = false;
        }
        modify(Control31)
        {
            Visible = false;
        }
        modify("Ship-to County")
        {
            Visible = false;
        }

        modify("Ship-to Country/Region Code")
        {
            Visible = false;
        }
        addafter("Buy-from Contact No.")
        {
            field("BC6_Buy-from City"; Rec."Buy-from City")
            {
                ApplicationArea = All;
            }
        }
        addafter("Buy-from Contact")
        {
            field("BC6_Matricule No."; Rec."BC6_Matricule No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Pay-to Contact No.")
        {
            field("BC6_Pay-to City"; Rec."Pay-to City")
            {
                ApplicationArea = All;
            }
        }
        addafter("Ship-to Name")
        {
            field("BC6_Ship-to City"; Rec."Ship-to City")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify(Card)
        {
            Visible = false;
        }
        addbefore("Dimensions")
        {
            action(BC6_Card)
            {
                RunObject = page "Vendor List";
                RunPageLink = "No." = field("Buy-from Vendor No.");
                Image = EditLines;
                ShortCutKey = 'Shift+F7';
                ApplicationArea = Suite;
                Caption = 'Card';
                ToolTip = 'View or change detailed information about the record on the document or journal line.';
            }
        }
    }
    var
        UserMgt: Codeunit "BC6_FunctionsMgt";

    trigger OnOpenPage()

    begin
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Assigned User ID", UserMgt.jx_GetPurchasesFilter());
        Rec.FILTERGROUP(0);
    end;
}
