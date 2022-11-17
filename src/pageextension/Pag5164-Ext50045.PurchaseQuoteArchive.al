pageextension 50045 "BC6_PurchaseQuoteArchive" extends "Purchase Quote Archive" //5164
{
    // Début Modif JX-XAD du 05/08/2008
    // Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
    //
    // ------------------------------ V1.2 ---------------------------
    // Modif JX-XAD du 26/02/2010
    // Accès au contrat depuis le bouton "Dem. Prix"
    //
    // //Modif JX-AUD du 17/02/2012
    // //Ajout du Champs "Matricule" et traitement de celui-ci

    //Unsupported feature: Property Modification (SourceTableView) on ""Purchase Quote Archive"(Page 5164)".

    layout
    {
        modify("Buy-from City")
        {
            Visible = false;
        }
        modify(Control19)
        {
            Visible = false;
        }
        modify("Buy-from County")
        {
            Visible = false;
        }

        modify("Buy-from Country/Region Code")
        {
            Visible = false;
        }

        modify("Pay-to City")
        {
            Visible = false;
        }
        modify(Control25)
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

        modify(Control31)
        {
            Visible = false;
        }
        modify("Ship-to County")
        {
            Visible = false;
        }

        modify("Ship-to Post Code")
        {
            Visible = false;
        }
        modify("Ship-to Country/Region Code")
        {
            Visible = false;
        }
        addafter("Buy-from Contact No.")
        {
            field("BC6_Matricule No."; Rec."BC6_Matricule No.")
            {
                Editable = false;
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
        addafter(Print)
        {
            action(BC6_Approbations)
            {
                Caption = 'Approbations';
                ApplicationArea = All;

                trigger OnAction()
                var
                    //ApprovalEntries: Page "Approval Request Entries";
                    ApprovalEntries: Page "Approval Entries";
                begin
                    //TODO: La page "Approval Request Entries" ne contient pas la fonction SetFilter(on peut remplacer par la page "Approval Entries"?)
                    //ApprovalEntries.SetFilter(DATABASE::"Purchase Header", Rec."Document Type", Rec."No.");
                    ApprovalEntries.SetRecordFilters(DATABASE::"Purchase Header", Rec."Document Type", Rec."No.");
                    ApprovalEntries.RUN();
                end;
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
