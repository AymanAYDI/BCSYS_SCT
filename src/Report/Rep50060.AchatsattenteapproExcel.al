report 50060 "Achats attente appro. (Excel)"
{
    // CREATION JX-XAD du 10/05/2011
    // Listing de documents d'achats en cours qui sont en attente d'approbation pour l'utilisateur séléctionné.
    // Repris du report 50019 et adapté pour Excel
    // 
    // //MODIF JX-AUD du 03/11/11
    // //ajout des axes analytiques sur l'état
    // 
    // //MODIF JX-AUD du 17/08/2012
    // //remise en forme de l'état
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/AchatsattenteapproExcel.rdl';
    Caption = 'Achats attente appro. (Excel)';


    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Document Type", "Buy-from Vendor No.", "Document Date";
            column(Text000; Text000)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(GtextPos5; GtextPos5)
            {
            }
            column(GtextPos4; GtextPos4)
            {
            }
            column(GtextPos3; GtextPos3)
            {
            }
            column(GtextPos2; GtextPos2)
            {
            }
            column(GtextPos1; GtextPos1)
            {
            }
            column(GtextPos0; GtextPos0)
            {
            }
            column(Purchase_Header__Purchase_Header___Document_Type_; "Purchase Header"."Document Type")
            {
            }
            column(Orig__approverCaption; Orig__approverCaptionLbl)
            {
            }
            column(Prev__approverCaption; Prev__approverCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(Direct_Unit_CostCaption; Direct_Unit_CostCaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(Vendor___Caption; Vendor___CaptionLbl)
            {
            }
            column(Purchase_Header_No_; "No.")
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                RequestFilterFields = Quantity;
                column(Purchase_Line_Description; Description)
                {
                }
                column(Purchase_Line_Quantity; Quantity)
                {
                }
                column(Purchase_Line__Purchase_Line___Direct_Unit_Cost_; "Purchase Line"."Direct Unit Cost")
                {
                }
                column(Purchase_Line__Purchase_Line___Line_Amount_; "Purchase Line"."Line Amount")
                {
                }
                column(Gtext_VendorName; Gtext_VendorName)
                {
                }
                column(Gcode_Devis; Gcode_Devis)
                {
                }
                column(Gtext_Axe6; Gtext_Axe6)
                {
                }
                column(Gtext_Axe5; Gtext_Axe5)
                {
                }
                column(Gtext_Axe4; Gtext_Axe4)
                {
                }
                column(Gtext_Axe3; Gtext_Axe3)
                {
                }
                column(Gtext_Axe2; Gtext_Axe2)
                {
                }
                column(Gtext_Axe1; Gtext_Axe1)
                {
                }
                column(ApproPrec; Gcode_ApprobateurPrécédent)
                {
                }
                column(Purchase_Header___Assigned_User_ID_; "Purchase Header"."Assigned User ID")
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
                    IF "Purchase Header"."Document Type" = "Purchase Header"."Document Type"::Quote THEN BEGIN
                        //récupération des codes axe analytique
                        IF Grecord_GeneralLedgerSetup.FIND('-') THEN BEGIN
                            Gcode_Axe[1] := Grecord_GeneralLedgerSetup."Shortcut Dimension 3 Code";
                            Gcode_Axe[2] := Grecord_GeneralLedgerSetup."Shortcut Dimension 4 Code";
                            Gcode_Axe[3] := Grecord_GeneralLedgerSetup."Shortcut Dimension 5 Code";
                            Gcode_Axe[4] := Grecord_GeneralLedgerSetup."Shortcut Dimension 6 Code";
                            Gcode_Axe[5] := Grecord_GeneralLedgerSetup."Shortcut Dimension 7 Code";
                            Gcode_Axe[6] := Grecord_GeneralLedgerSetup."Shortcut Dimension 8 Code";
                        END;


                        IF Grec_DocumentDimension.GET("Dimension Set ID", Gcode_Axe[1])
                        THEN
                            Gtext_Axe1 := Grec_DocumentDimension."Dimension Value Code"
                        ELSE
                            Gtext_Axe1 := '';

                        IF Grec_DocumentDimension.GET("Dimension Set ID", Gcode_Axe[2])
                        THEN
                            Gtext_Axe2 := Grec_DocumentDimension."Dimension Value Code"
                        ELSE
                            Gtext_Axe2 := '';

                        IF Grec_DocumentDimension.GET("Dimension Set ID", Gcode_Axe[3])
                        THEN
                            Gtext_Axe3 := Grec_DocumentDimension."Dimension Value Code"
                        ELSE
                            Gtext_Axe3 := '';

                        IF Grec_DocumentDimension.GET("Dimension Set ID", Gcode_Axe[4])
                        THEN
                            Gtext_Axe4 := Grec_DocumentDimension."Dimension Value Code"
                        ELSE
                            Gtext_Axe4 := '';

                        IF Grec_DocumentDimension.GET("Dimension Set ID", Gcode_Axe[5])
                        THEN
                            Gtext_Axe5 := Grec_DocumentDimension."Dimension Value Code"
                        ELSE
                            Gtext_Axe5 := '';

                        IF Grec_DocumentDimension.GET("Dimension Set ID", Gcode_Axe[6])
                        THEN
                            Gtext_Axe6 := Grec_DocumentDimension."Dimension Value Code"
                        ELSE
                            Gtext_Axe6 := '';

                    END ELSE BEGIN
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
                    END;
                    //Fin Modif-JX-AUD du 03/11/11
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Gbool_ApproOuverte := FALSE;
                Grec_ApprovalEntry.RESET();
                Grec_ApprovalEntry.SETFILTER(Grec_ApprovalEntry."Document No.", "Purchase Header"."No.");
                IF Grec_ApprovalEntry.COUNT = 0 THEN
                    CurrReport.SKIP()
                ELSE
                    IF Grec_ApprovalEntry.FIND('-') THEN
                        REPEAT
                            IF (Grec_ApprovalEntry.Status = Grec_ApprovalEntry.Status::Open)
                               AND (Grec_ApprovalEntry."Approver ID" = Gcode_ChoixApprobateur) THEN BEGIN
                                Gbool_ApproOuverte := TRUE;
                                Gcode_ApprobateurPrécédent := Grec_ApprovalEntry."Approver ID";
                                IF Grec_ApprovalEntry.FIND('<') THEN
                                    Gcode_ApprobateurPrécédent := Grec_ApprovalEntry."Approver ID";
                            END;
                        UNTIL (Grec_ApprovalEntry.NEXT() = 0) OR Gbool_ApproOuverte;

                IF NOT Gbool_ApproOuverte THEN
                    CurrReport.SKIP();

                //Modif JX-AUD du 03/11/11
                //Fin modif JX-AUD du 03/11/11
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET();
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);

                Gtxt_DateDocFilter := "Purchase Header".GETFILTER("Purchase Header"."Document Date");
                Gtxt_TypeDocFilter := "Purchase Header".GETFILTER("Purchase Header"."Document Type");
                Gtxt_FournisseurFilter := "Purchase Header".GETFILTER("Purchase Header"."Buy-from Vendor No.");


                IF Grec_UserSetup.GET(Gcode_ChoixApprobateur) THEN
                    Gtxt_NomApprobateur := Grec_UserSetup."BC6_Nom";

                IF "Purchase Header"."Document Type" = "Purchase Header"."Document Type"::Quote THEN BEGIN
                    GtextPos0 := 'Axe 0';
                    GtextPos1 := 'Axe 1';
                    GtextPos2 := 'Axe 2';
                    GtextPos3 := 'Axe 3';
                    GtextPos4 := 'Axe 4';
                    GtextPos5 := 'Axe 5';
                END ELSE BEGIN

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

                END;
            end;
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
        "Gcode_ApprobateurPrécédent": Code[50];
        Gcode_Axe: array[6] of Code[20];
        Gcode_ChoixApprobateur: Code[20];
        Gcode_Devis: Code[20];
        Gdec_MontantTotalTTC: Decimal;
        Gdec_MontantTTC: Decimal;
        AmountCaptionLbl: Label 'Amount', Comment = 'FRA="Montant HT"';
        DescriptionCaptionLbl: Label 'Description', Comment = 'FRA="Désignation"';
        Direct_Unit_CostCaptionLbl: Label 'Direct Unit Cost', Comment = 'FRA="Coût unitaire"';
        Orig__approverCaptionLbl: Label 'Orig. approver', Comment = 'FRA="Approb. initial"';
        Prev__approverCaptionLbl: Label 'Prev. approver', Comment = 'FRA="Approb. précédent"';
        QuantityCaptionLbl: Label 'Quantity', Comment = 'FRA="Quantité"';
        Text000: Label ' ';
        Vendor___CaptionLbl: Label 'Vendor : ', Comment = 'FRA="Fournisseur"';
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
        Gtext_VendorName: Text[50];
        Gtxt_DateDocFilter: Text[50];
        Gtxt_FournisseurFilter: Text[50];
        Gtxt_NomApprobateur: Text[50];
        Gtxt_TypeDocFilter: Text[50];
}

