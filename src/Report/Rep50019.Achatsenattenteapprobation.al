report 50019 "Achats en attente approbation"
{
    // CREATION JX-XAD du 03/11/2008
    // Listing de documents d'achats en cours qui sont en attente d'approbation pour l'utilisateur séléctionné.
    // 
    // //modif AUD du 23/04/2009
    // //traduction des champs Anglais/Français
    // 
    // modif JX-XAD du 23/12/2009
    // Ajout de l'approbateur initial
    // 
    // //Modif JX-XAD le 12-01-2010
    // //Recherche de l'administrateur des approbations dans le request form
    // 
    // //MODIF JX-AUD du 03/11/11
    // //ajout des axes analytiques sur l'état
    // 
    // //JX-AUD du 13/05/2013
    // //Agrandissement logo
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/Achatsenattenteapprobation.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Achats en attente approbation';

    dataset
    {
        dataitem(DataItem1000000000; Integer)
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            MaxIteration = 1;
            column(EntTitre; Text008 + ' ' + Gtxt_NomApprobateur)
            {
            }
            column(EntUser; USERID)
            {
            }
            column(EntDate; FORMAT(TODAY))
            {
            }
            column(EntTime; Text007 + ' ' + FORMAT(TIME))
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET();
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);

                IF Grec_UserSetup.GET(Gcode_ChoixApprobateur) THEN
                    Gtxt_NomApprobateur := Grec_UserSetup."BC6_Nom";
            end;
        }
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Document Type", "Buy-from Vendor No.", "Document Date";
            column(DocType; FORMAT("Document Type"))
            {
            }
            column(GrpHdr; Gtxt_Titre)
            {
            }
            column(LigEntAxeCap5; GtextPos5)
            {
            }
            column(LigEntAxeCap4; GtextPos4)
            {
            }
            column(LigEntAxeCap3; GtextPos3)
            {
            }
            column(LigEntAxeCap2; GtextPos2)
            {
            }
            column(LigEntAxeCap1; GtextPos1)
            {
            }
            column(LigEntAxeCap0; GtextPos0)
            {
            }
            column(EntFiltre; EntFiltreLbl)
            {
            }
            column(EntUserCap; EntUserCapLbl)
            {
            }
            column(EntDateCap; EntDateCapLbl)
            {
            }
            column(LigFourCap; LigFourCapLbl)
            {
            }
            column(LigDateCap; LigDateCapLbl)
            {
            }
            column(LigEntDocNoCap; LigEntDocNoCapLbl)
            {
            }
            column(LigEntDescCap; LigEntDescCapLbl)
            {
            }
            column(LigEntQtyCap; LigEntQtyCapLbl)
            {
            }
            column(LigEntUnitCap; LigEntUnitCapLbl)
            {
            }
            column(LigEntCostCap; LigEntCostCapLbl)
            {
            }
            column(LigEntDiscCap; LigEntDiscCapLbl)
            {
            }
            column(LigEntAmtCap; LigEntAmtCapLbl)
            {
            }
            column(LigEntInvCap; LigEntInvCapLbl)
            {
            }
            column(LigAppPrevCap; LigAppPrevCapLbl)
            {
            }
            column(LigEntAmtTTCCap; LigEntAmtTTCCapLbl)
            {
            }
            column(LigAppCap; LigAppCapLbl)
            {
            }
            column(PiedDate; PiedDateLbl)
            {
            }
            column(PiedSign; PiedSignLbl)
            {
            }
            column(EntFiltre3; 'Date : ' + Gtxt_DateDocFilter)
            {
            }
            column(EntFiltre1; Text005 + ' ' + Gtxt_TypeDocFilter)
            {
            }
            column(EntFiltre2; Text006 + ' ' + Gtxt_FournisseurFilter)
            {
            }
            column(LigFour; "Buy-from Vendor No.")
            {
            }
            column(LigDocNo; "No.")
            {
            }
            column(LigDate; "Purchase Header"."Document Date")
            {
            }
            column(LigDocType; "Purchase Header"."Document Type")
            {
            }
            column(LigAppPrev; Gcode_ApprobateurPrécédent)
            {
            }
            column(LigFourName; "Buy-from Vendor Name")
            {
            }
            column(LigApp; Gcode_ApprAssigned)
            {
            }
            column(TotDocType; 'TOTAL ' + FORMAT("Purchase Header"."Document Type"))
            {
            }
            column(TotDocTypeAmt; Gdec_TotalDocument)
            {
            }
            column(TotDocTypeAmtTTC; Gdec_MontantTotalAffichéTTC)
            {
            }
            dataitem("Purchase Line"; 39)
            {
                DataItemLink = "Document No." = FIELD("No.");
                RequestFilterFields = Quantity;
                column(LigNo; "No.")
                {
                }
                column(LigDesc; COPYSTR(Description, 1, 45))
                {
                }
                column(LigQty; Quantity)
                {
                }
                column(LigUnit; "Purchase Line"."Unit of Measure")
                {
                }
                column(LigCost; "Purchase Line"."Direct Unit Cost")
                {
                }
                column(LigDisc; "Purchase Line"."Line Discount %")
                {
                }
                column(LigAmt; "Purchase Line"."Line Amount")
                {
                }
                column(LigQtyInv; "Purchase Line"."Quantity Invoiced")
                {
                }
                column(LigAmtTTC; Gdec_MontantTTC)
                {
                }
                column(LigAxe5; Gtext_Axe6)
                {
                }
                column(LigAxe4; Gtext_Axe5)
                {
                }
                column(LigAxe3; Gtext_Axe4)
                {
                }
                column(LigAxe2; Gtext_Axe3)
                {
                }
                column(LigAxe1; Gtext_Axe2)
                {
                }
                column(LigAxe0; Gtext_Axe1)
                {
                }
                column(TotDocAmt; "Purchase Line"."Line Amount")
                {
                }
                column(TotDoc; 'TOTAL ' + FORMAT("Purchase Header"."No."))
                {
                }
                column(TotDocAmtTTC; Gdec_MontantDocumentTTC)
                {
                }
                column(Purchase_Line_Document_Type; "Document Type")
                {
                }
                column(Purchase_Line_Document_No_; "Document No.")
                {
                }
                column(Purchase_Line_Line_No_; "Line No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //Modif JX-AUD du 03/11/11

                    //récupération des codes axe analytique
                    IF Grecord_GeneralLedgerSetup.FIND('-') THEN BEGIN
                        Gcode_Axe[1] := Grecord_GeneralLedgerSetup."Shortcut Dimension 3 Code";
                        Gcode_Axe[2] := Grecord_GeneralLedgerSetup."Shortcut Dimension 4 Code";
                        Gcode_Axe[3] := Grecord_GeneralLedgerSetup."Shortcut Dimension 5 Code";
                        Gcode_Axe[4] := Grecord_GeneralLedgerSetup."Shortcut Dimension 6 Code";
                        Gcode_Axe[5] := Grecord_GeneralLedgerSetup."Shortcut Dimension 7 Code";
                        Gcode_Axe[6] := Grecord_GeneralLedgerSetup."Shortcut Dimension 8 Code";
                    END;

                    IF Grec_DocumentDimension.GET("Purchase Line"."Dimension Set ID", Gcode_Axe[1]) THEN
                        Gtext_Axe1 := Grec_DocumentDimension."Dimension Value Code"
                    ELSE
                        Gtext_Axe1 := '';

                    IF Grec_DocumentDimension.GET("Purchase Line"."Dimension Set ID", Gcode_Axe[2]) THEN
                        Gtext_Axe2 := Grec_DocumentDimension."Dimension Value Code"
                    ELSE
                        Gtext_Axe2 := '';

                    IF Grec_DocumentDimension.GET("Purchase Line"."Dimension Set ID", Gcode_Axe[3]) THEN
                        Gtext_Axe3 := Grec_DocumentDimension."Dimension Value Code"
                    ELSE
                        Gtext_Axe3 := '';

                    IF Grec_DocumentDimension.GET("Purchase Line"."Dimension Set ID", Gcode_Axe[4]) THEN
                        Gtext_Axe4 := Grec_DocumentDimension."Dimension Value Code"
                    ELSE
                        Gtext_Axe4 := '';

                    IF Grec_DocumentDimension.GET("Purchase Line"."Dimension Set ID", Gcode_Axe[5]) THEN
                        Gtext_Axe5 := Grec_DocumentDimension."Dimension Value Code"
                    ELSE
                        Gtext_Axe5 := '';

                    IF Grec_DocumentDimension.GET("Purchase Line"."Dimension Set ID", Gcode_Axe[6]) THEN
                        Gtext_Axe6 := Grec_DocumentDimension."Dimension Value Code"
                    ELSE
                        Gtext_Axe6 := '';


                    IF Type.AsInteger() > 0 THEN BEGIN
                        Gdec_MontantTTC := "Purchase Line"."Line Amount" + ("Purchase Line"."VAT %" * "Purchase Line"."Line Amount" / 100);
                        Gdec_MontantDocumentTTC += Gdec_MontantTTC;
                        Gdec_MontantTotalTTC += Gdec_MontantTTC;
                        Gint_CompteurTotal += "Purchase Line"."Line Amount";
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            var
                x: Integer;
            begin

                CASE "Purchase Header"."Document Type" OF
                    "Purchase Header"."Document Type"::Quote:
                        Gtxt_Titre := Text002;
                    "Purchase Header"."Document Type"::Invoice:
                        Gtxt_Titre := Text003;
                    "Purchase Header"."Document Type"::"Credit Memo":
                        Gtxt_Titre := Text004;
                END;

                Gbool_ApproOuverte := FALSE;
                Grec_ApprovalEntry.RESET();
                Grec_ApprovalEntry.SETFILTER(Grec_ApprovalEntry."Document No.", "Purchase Header"."No.");
                IF Grec_ApprovalEntry.COUNT = 0 THEN
                    CurrReport.SKIP()
                ELSE
                    IF Grec_ApprovalEntry.FindSet() THEN
                        REPEAT
                            IF ((Grec_ApprovalEntry.Status = Grec_ApprovalEntry.Status::Open) AND (Gcode_ChoixApprobateur = ''))
                              OR
                               ((Grec_ApprovalEntry.Status = Grec_ApprovalEntry.Status::Open) AND (Grec_ApprovalEntry."Approver ID" = Gcode_ChoixApprobateur)) THEN BEGIN
                                Gbool_ApproOuverte := TRUE;
                                Gcode_ApprobateurPrécédent := Grec_ApprovalEntry."Approver ID";
                                IF Grec_ApprovalEntry.FIND('<') THEN
                                    Gcode_ApprobateurPrécédent := Grec_ApprovalEntry."Approver ID";
                            END;
                        UNTIL (Grec_ApprovalEntry.NEXT() = 0) OR Gbool_ApproOuverte;

                Gcode_ApprAssigned := "Purchase Header"."Assigned User ID";
                x := STRPOS(Gcode_ApprAssigned, '\');
                IF x <> 0 THEN
                    Gcode_ApprAssigned := COPYSTR("Purchase Header"."Assigned User ID", x + 1);

                x := STRPOS(Gcode_ApprobateurPrécédent, '\');
                IF x <> 0 THEN
                    Gcode_ApprobateurPrécédent := COPYSTR(Gcode_ApprobateurPrécédent, x + 1);

                IF NOT Gbool_ApproOuverte THEN
                    CurrReport.SKIP();
            end;

            trigger OnPreDataItem()
            begin
                Gtxt_DateDocFilter := "Purchase Header".GETFILTER("Purchase Header"."Document Date");
                Gtxt_TypeDocFilter := "Purchase Header".GETFILTER("Purchase Header"."Document Type");
                Gtxt_FournisseurFilter := "Purchase Header".GETFILTER("Purchase Header"."Buy-from Vendor No.");

                //Modif JX-AUD du 03/11/11

                if "Purchase Header"."Document Type" = "Purchase Header"."Document Type"::Quote then begin
                    GtextPos0 := 'Axe 0';
                    GtextPos1 := 'Axe 1';
                    GtextPos2 := 'Axe 2';
                    GtextPos3 := 'Axe 3';
                    GtextPos4 := 'Axe 4';
                    GtextPos5 := 'Axe 5';
                end else begin

                    GtextPos0 := '';
                    GtextPos1 := '';
                    GtextPos2 := '';
                    GtextPos3 := '';
                    GtextPos4 := '';
                    GtextPos5 := '';
                    Gtext_Axe1 := '';
                    Gtext_Axe2 := '';
                    Gtext_Axe3 := '';
                    Gtext_Axe4 := '';
                    Gtext_Axe5 := '';
                    Gtext_Axe6 := '';

                end;
                //Fin modif JX-AUD du 03/11/11
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field("Filtre Approbateur"; Gcode_ChoixApprobateur)
                {
                    LookupPageID = "User Setup";
                    TableRelation = "User Setup"."User ID" WHERE("BC6_Approbateur" = CONST(true));
                    ApplicationArea = All;
                    Caption = 'Filtre Approbateur';
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        Gdec_MontantTotalTTC := 0;
    end;

    var
        Grec_ApprovalEntry: Record "Approval Entry";
        CompanyInfo: Record "Company Information";
        Grec_DocumentDimension: Record "Dimension Set Entry";
        Grecord_GeneralLedgerSetup: Record "General Ledger Setup";
        Grec_UserSetup: Record "User Setup";
        Gbool_ApproOuverte: Boolean;
        Gcode_Axe: array[6] of Code[20];
        Gcode_ApprAssigned: Code[50];
        "Gcode_ApprobateurPrécédent": Code[50];
        Gcode_ChoixApprobateur: Code[50];
        Gdec_MontantDocumentTTC: Decimal;
        "Gdec_MontantTotalAffichéTTC": Decimal;
        Gdec_MontantTotalTTC: Decimal;
        Gdec_MontantTTC: Decimal;
        Gdec_TotalDocument: Decimal;
        Gint_CompteurTotal: Decimal;
        EntDateCapLbl: Label 'Date :', Comment = 'FRA="Date :"';
        EntFiltreLbl: Label 'Reminder of the selection :', Comment = 'FRA="Rappel de la sélection :"';
        EntUserCapLbl: Label 'User :', Comment = 'FRA="Utilisateur :"';
        LigAppCapLbl: Label 'Orig. approver', Comment = 'FRA="Approb. initial"';
        LigAppPrevCapLbl: Label 'Prev. approver', Comment = 'FRA="Approb. précédent"';
        LigDateCapLbl: Label 'Doc. Date :', Comment = 'FRA="Date doc. :"';
        LigEntAmtCapLbl: Label 'Amount', Comment = 'FRA="Montant HT"';
        LigEntAmtTTCCapLbl: Label 'Including VAT', Comment = 'FRA="Montant TTC"';
        LigEntCostCapLbl: Label 'Direct Unit Cost', Comment = 'FRA="Coût unit."';
        LigEntDescCapLbl: Label 'Description', Comment = 'FRA="Désignation"';
        LigEntDiscCapLbl: Label 'Disc. %', Comment = 'FRA="% Rem."';
        LigEntDocNoCapLbl: Label 'No.', Comment = 'FRA="N°"';
        LigEntInvCapLbl: Label 'Invoiced', Comment = 'FRA="Facturée"';
        LigEntQtyCapLbl: Label 'Quantity', Comment = 'FRA="Quantité"';
        LigEntUnitCapLbl: Label 'Unit', Comment = 'FRA="Unité"';
        LigFourCapLbl: Label 'Vend. : ', Comment = 'FRA="Fourn. :"';
        PiedDateLbl: Label 'Date :', Comment = 'FRA="Date :"';
        PiedSignLbl: Label 'Signature :', Comment = 'FRA="Signature :"';
        Text002: Label 'QUOTES TO POST', Comment = 'FRA="DEVIS A VALIDER"';
        Text003: Label 'INVOICES TO POST', Comment = 'FRA="FACTURES A VALIDER"';
        Text004: Label 'CREDIT MEMO TO POST', Comment = 'FRA="AVOIRS A VALIDER"';
        Text005: Label 'Type Document :', Comment = 'FRA="Type Document :"';
        Text006: Label 'Vendor :', Comment = 'FRA="Fournisseur :"';
        Text007: Label 'at', Comment = 'FRA="à"';
        Text008: Label 'Listing of purchases awaiting approval for', Comment = 'FRA="Listing des achats en attente d''approbation"';
        Gtext_Axe1: Text[30];
        Gtext_Axe2: Text[30];
        Gtext_Axe3: Text[30];
        Gtext_Axe4: Text[30];
        Gtext_Axe5: Text[30];
        Gtext_Axe6: Text[30];
        GtextPos0: Text[30];
        GtextPos1: Text[30];
        GtextPos2: Text[30];
        GtextPos3: Text[30];
        GtextPos4: Text[30];
        GtextPos5: Text[30];
        Gtxt_Titre: Text[30];
        Gtxt_DateDocFilter: Text;
        Gtxt_FournisseurFilter: Text;
        Gtxt_NomApprobateur: Text[50];
        Gtxt_TypeDocFilter: Text;
}

