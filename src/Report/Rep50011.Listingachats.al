report 50011 "BC6_Listing achats"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    // CREATION JX-XAD du 13/08/2008
    // Listing de documents d'achats en cours
    // 
    // //modif AUD du 22/04/2009
    // //traduction des champs Anglais/Français
    // 
    // //JX-AUD du 13/05/2013
    // //Agrandissement logo
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/Listingachats.rdl';
    Caption = 'Listing achats';
    dataset
    {
        dataitem("Purchase Header"; 38)
        {
            DataItemTableView = SORTING("Document Type", "No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Document Type", "Buy-from Vendor No.", "Document Date";
            column(Text005; Text005)
            {
            }
            column(Date_____Gtxt_DateDocFilter; 'Date : ' + Gtxt_DateDocFilter)
            {
            }
            column(Text002_____Gtxt_TypeDocFilter; Text002 + ' ' + Gtxt_TypeDocFilter)
            {
            }
            column(Text003_____Gtxt_FournisseurFilter; Text003 + ' ' + Gtxt_FournisseurFilter)
            {
            }
            column("USERID"; USERID)
            {
            }
            column(FORMAT_TODAY_; FORMAT(TODAY))
            {
            }
            column(Text004_____FORMAT_TIME_; Text004 + ' ' + FORMAT(TIME))
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(PH_Buy_from_Vendor_No__; "Buy-from Vendor No.")
            {
            }
            column(PH_No_; "No.")
            {
            }
            column(PH_Document_Date_; "Purchase Header"."Document Date")
            {
            }
            column(PH_Document_Type_; "Purchase Header"."Document Type")
            {
            }
            column(Purchase_Header__Due_Date_; "Due Date")
            {
            }
            column(TOTAL_FORMAT_PH_Document_Type_; 'TOTAL ' + FORMAT("Purchase Header"."Document Type"))
            {
            }
            column(Gdec_TotalDocument; Gdec_TotalDocument)
            {
            }
            column(Reminder_of_the_selectionCaption; Reminder_of_the_selectionCaptionLbl)
            {
            }
            column(Date__Caption; Date__CaptionLbl)
            {
            }
            column(User__Caption; User__CaptionLbl)
            {
            }
            column(Vendor__Caption; Vendor__CaptionLbl)
            {
            }
            column(Document_Date__Caption; Document_Date__CaptionLbl)
            {
            }
            column(Due_Date__Caption; Due_Date__CaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(QtyCaption; QtyCaptionLbl)
            {
            }
            column(UnitCaption; UnitCaptionLbl)
            {
            }
            column(Direct_Unit_CostCaption; Direct_Unit_CostCaptionLbl)
            {
            }
            column(Disc___Caption; Disc___CaptionLbl)
            {
            }
            column(VATCaption; VATCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(Receiv_Caption; Receiv_CaptionLbl)
            {
            }
            column(Purch_Caption; Purch_CaptionLbl)
            {
            }
            dataitem("Purchase Line"; 39)
            {
                DataItemLink = "Document No." = FIELD("No.");
                RequestFilterFields = Quantity;
                column(Purchase_Line__No__; "No.")
                {
                }
                column(Purchase_Line_Description; Description)
                {
                }
                column(Purchase_Line_Quantity; Quantity)
                {
                }
                column(PL_Unit_of_Measure_; "Purchase Line"."Unit of Measure")
                {
                }
                column(PL_Direct_Unit_Cost_; "Purchase Line"."Direct Unit Cost")
                {
                }
                column(PL_Line_Discount___; "Purchase Line"."Line Discount %")
                {
                }
                column(PL_VAT_Identifier_; "Purchase Line"."VAT Identifier")
                {
                }
                column(PL_Line_Amount_; "Purchase Line"."Line Amount")
                {
                }
                column(PL_Quantity_Received_; "Purchase Line"."Quantity Received")
                {
                }
                column(PL_Quantity_Invoiced_; "Purchase Line"."Quantity Invoiced")
                {
                }
                column(PL_Line_Amount__Control1000000009; "Purchase Line"."Line Amount")
                {
                }
                column(TOTAL_FORMAT_Purchase_Header_No_; 'TOTAL ' + FORMAT("Purchase Header"."No."))
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
            }

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET();
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);


                Gtxt_DateDocFilter := "Purchase Header".GETFILTER("Purchase Header"."Document Date");
                Gtxt_TypeDocFilter := "Purchase Header".GETFILTER("Purchase Header"."Document Type");
                Gtxt_FournisseurFilter := "Purchase Header".GETFILTER("Purchase Header"."Buy-from Vendor No.");

                //Début Modif JX-XAD du 11/06/2008
                //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
                FILTERGROUP(2);
                SETFILTER("Assigned User ID", UserMgt.jx_GetPurchasesFilter());
                FILTERGROUP(0);
                //Fin Modif JX-XAD du 11/06/2008
            end;
        }
    }
    var
        CompanyInfo: Record "Company Information";
        UserMgt: Codeunit "BC6_FunctionsMgt";
        Gdec_TotalDocument: Decimal;
        AmountCaptionLbl: Label 'Amount', Comment = 'FRA="Montant"';
        Date__CaptionLbl: Label 'Date :', Comment = 'FRA="Date :"';
        DescriptionCaptionLbl: Label 'Description', Comment = 'FRA="Désignation"';
        Direct_Unit_CostCaptionLbl: Label 'Direct Unit Cost', Comment = 'FRA="Coût unit. direct"';
        Disc___CaptionLbl: Label 'Disc. %', Comment = 'FRA="% Rem."';
        Document_Date__CaptionLbl: Label 'Document Date :', Comment = 'FRA="Date document :"';
        Due_Date__CaptionLbl: Label 'Due Date :', Comment = 'FRA="Date d''échéance :"';
        No_CaptionLbl: Label 'No.', Comment = 'FRA="N°"';
        Purch_CaptionLbl: Label 'Purch.', Comment = 'FRA="Fact."';
        QtyCaptionLbl: Label 'Qty', Comment = 'FRA="Qté"';
        Receiv_CaptionLbl: Label 'Receiv.', Comment = 'FRA="Reçue"';
        Reminder_of_the_selectionCaptionLbl: Label 'Reminder of the selection', Comment = 'FRA="Rappel de la sélection"';
        //Text001: Label 'Page %1';
        Text002: Label 'Document type :', Comment = 'FRA="Type document :"';
        Text003: Label 'Vendor :', Comment = 'FRA="Fournisseur :"';
        Text004: Label 'at', Comment = 'FRA="à"';
        Text005: Label 'Listing of Purchases', Comment = 'FRA="Listing des achats"';
        UnitCaptionLbl: Label 'Unit', Comment = 'FRA="Unité"';
        User__CaptionLbl: Label 'User :', Comment = 'FRA="Utilisateur :"';
        VATCaptionLbl: Label 'VAT', Comment = 'FRA="TVA"';
        Vendor__CaptionLbl: Label 'Vendor :', Comment = 'FRA="Fournisseur :"';
        Gtxt_DateDocFilter: Text;
        Gtxt_FournisseurFilter: Text;
        Gtxt_TypeDocFilter: Text;
}

