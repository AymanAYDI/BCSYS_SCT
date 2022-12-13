pageextension 50006 "BC6_PostedSalesInvoice" extends "Posted Sales Invoice" //132
{
    // // ajout LAB du 25/08/2010
    // // ajout des champs mandataire et mandataire payeur
    // 
    // //MODIF JX-AUD 24/05/2011
    // //Mise à jour des axes analytiques dans les documents enregistrés
    // //Ajout bouton modification désignation
    // 
    // //Modif JX-AUD du 07/02/2013
    // //Modification du bouton Imprimer pour inclure l'impression des factures forfait
    // //Déplacer du code du bouton Imprimer vers l'item Imprimer facture
    // 
    // // MODIF JX-ABE du 19/10/2016
    // // Masquer les champs suivants : N° contact , Contact donneur d'ordre, N° devis, code vendeur et centre de géstion.
    layout
    {
        modify("Sell-to Contact No.")
        {
            Visible = false;
        }
        modify("Sell-to Contact")
        {
            Editable = false;
            Visible = false;
        }
        modify("Quote No.")
        {
            Visible = false;
        }

        modify("Salesperson Code")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        addafter("Sell-to Contact")
        {
            field(BC6_Agent; Rec."BC6_Agent")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Paying agent"; Rec."BC6_Paying agent")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("&Navigate")
        {
            group("BC6_&Ligne")
            {
                Caption = '&Line', Comment = 'FRA="&Ligne"';
                separator(Action110)
                {
                }
                action("BC6_Modifier axes analytiques")
                {
                    Caption = 'Modify dimensions', Comment = 'FRA="Modifier axes analytiques"';
                    Image = ChangeDimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //MODIF JX-AUD 24/05/2011
                        CurrPage.SalesInvLines.PAGE.ReturnRecord(Grec_SalesInvLine);
                        Grec_SalesInvLine.ModifyDimensions();
                        //Fin MODIF JX-AUD 24/05/2011
                    end;
                }
                action("Modifier désignation")
                {
                    Caption = 'Modify description', Comment = 'FRA="Modifier désignation"';
                    Image = UpdateDescription;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //MODIF JX-AUD 24/05/2011
                        CurrPage.SalesInvLines.PAGE.ReturnRecord(Grec_SalesInvLine);
                        ModifierDesignation.SetPostedInvoice(Grec_SalesInvLine);
                        ModifierDesignation.RUNMODAL();
                        CLEAR(ModifierDesignation);
                        //Fin MODIF JX-AUD 24/05/2011
                    end;
                }
            }
            group("BC6_Imprimer...")
            {
                Caption = 'Print...', Comment = 'FRA="Imprimer..."';
                action("BC6_Imprimer facture")
                {
                    Caption = 'Print Invoice', Comment = 'FRA="Imprimer facture"';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Modif JX-AUD du 07/02/2013
                        CurrPage.SETSELECTIONFILTER(SalesInvHeader);
                        SalesInvHeader.PrintRecords(TRUE);
                        //Fin modif JX-AUD du 07/02/2013
                    end;
                }

                action("BC6_Imprimer facture forfait")
                {
                    Caption = 'Print invoice plan', Comment = 'FRA="Imprimer facture forfait"';
                    Image = ConfirmAndPrint;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Modif JX-AUD du 07/02/2013
                        CurrPage.SETSELECTIONFILTER(SalesInvHeader);
                        REPORT.RUNMODAL(REPORT::"BC6_Facture vente forfait", TRUE, FALSE, SalesInvHeader);
                        //Fin modif JX-AUD du 07/02/2013
                    end;
                }
            }
        }
    }

    var
        SalesInvHeader: Record "Sales Invoice Header";
        Grec_SalesInvLine: Record "Sales Invoice Line";
        ModifierDesignation: Page "BC6_Modification désignation";
}

