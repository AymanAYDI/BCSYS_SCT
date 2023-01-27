report 50040 "BC6_Listing BC AC-VSCT"
{
    // CREATION JX-LAB du 31/03/2010
    // 
    // MODIF JX-XAD 15/04/2011
    // Traitement des axes analytiques VFEC
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/ListingBCACVSCT.rdl';
    Caption = 'Listing of orders AC-VSCT', Comment = 'FRA="Listing BC AC-VSCT"';
    ShowPrintStatus = true;
    ApplicationArea = All;
    UsageCategory = Lists;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE("Purchaser Code" = CONST('AC-VSCT'));
            column(Vendor_No_; "No.")
            {
            }
            dataitem("Purchase Header"; "Purchase Header")
            {
                DataItemLink = "Buy-from Vendor No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.") ORDER(Ascending);
                PrintOnlyIfDetail = true;
                RequestFilterFields = "Document Date";
                column(No_Caption; No_CaptionLbl)
                {
                }
                column(Issue_dateCaption; Issue_dateCaptionLbl)
                {
                }
                column(issuer_nameCaption; issuer_nameCaptionLbl)
                {
                }
                column(DescriptionCaption; DescriptionCaptionLbl)
                {
                }
                column(QuantityCaption; QuantityCaptionLbl)
                {
                }
                column(ReceivedCaption; ReceivedCaptionLbl)
                {
                }
                column(InvoicedCaption; InvoicedCaptionLbl)
                {
                }
                column(VATCaption; VATCaptionLbl)
                {
                }
                column(AmountCaption; AmountCaptionLbl)
                {
                }
                column(Amount_including_VATCaption; Amount_including_VATCaptionLbl)
                {
                }
                column(Dim__1Caption; Dim__1CaptionLbl)
                {
                }
                column(Dim__2Caption; Dim__2CaptionLbl)
                {
                }
                column(Dim__3Caption; Dim__3CaptionLbl)
                {
                }
                column(Dim__4Caption; Dim__4CaptionLbl)
                {
                }
                column(Vendor_codeCaption; Vendor_codeCaptionLbl)
                {
                }
                column(Vendor_nameCaption; Vendor_nameCaptionLbl)
                {
                }
                column(Order_No_Caption; Order_No_CaptionLbl)
                {
                }
                column(Dim__0Caption; Dim__0CaptionLbl)
                {
                }
                column(Purchase_Header_Document_Type; "Document Type")
                {
                }
                column(Purchase_Header_No_; "No.")
                {
                }
                column(Purchase_Header_Buy_from_Vendor_No_; "Buy-from Vendor No.")
                {
                }
                dataitem("Purchase Line"; "Purchase Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") ORDER(Ascending);
                    column(Purchase_Line__No__; "No.")
                    {
                    }
                    column(Purchase_Line_Description; Description)
                    {
                    }
                    column(Purchase_Line_Quantity; Quantity)
                    {
                    }
                    column(Purchase_Line__Purchase_Line___Line_Amount_; "Purchase Line"."Line Amount")
                    {
                    }
                    column(Purchase_Line__Purchase_Line___Quantity_Received_; "Purchase Line"."Quantity Received")
                    {
                    }
                    column(Purchase_Line__Purchase_Line___Quantity_Invoiced_; "Purchase Line"."Quantity Invoiced")
                    {
                    }
                    column(Purchase_Header___Buy_from_Vendor_No__; "Purchase Header"."Buy-from Vendor No.")
                    {
                    }
                    column(Purchase_Header___Buy_from_Vendor_Name_; "Purchase Header"."Buy-from Vendor Name")
                    {
                    }
                    column(Purchase_Header___Document_Date_; "Purchase Header"."Document Date")
                    {
                    }
                    column(Purchase_Header___Assigned_User_ID_; "Purchase Header"."Assigned User ID")
                    {
                    }
                    column(Purchase_Line__Purchase_Line___Amount_Including_VAT_; "Purchase Line"."Amount Including VAT")
                    {
                    }
                    column(Purchase_Line___Amount_Including_VAT___Purchase_Line__Amount; "Purchase Line"."Amount Including VAT" - "Purchase Line".Amount)
                    {
                    }
                    column(Gcode_Axe_1_; Gcode_Axe[1])
                    {
                    }
                    column(Gcode_Axe_2_; Gcode_Axe[2])
                    {
                    }
                    column(Gcode_Axe_3_; Gcode_Axe[3])
                    {
                    }
                    column(Gcode_Axe_4_; Gcode_Axe[4])
                    {
                    }
                    column(Purchase_Header___No__; "Purchase Header"."No.")
                    {
                    }
                    column(Gcode_Axe_5_; Gcode_Axe[5])
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

                    "Purchase Header".SETFILTER("Purchase Header"."Document Type", '%1', "Purchase Header"."Document Type"::Order);
                end;
            }
        }
    }
    var
        CompanyInfo: Record "Company Information";
        Gcode_Axe: array[5] of Code[20];
        Amount_including_VATCaptionLbl: Label 'Amount including VAT', Comment = 'FRA="Montant TTC"';
        AmountCaptionLbl: Label 'Amount', Comment = 'FRA="Montant HT"';
        DescriptionCaptionLbl: Label 'Description', Comment = 'FRA="Désignation"';
        Dim__0CaptionLbl: Label 'Dim. 0', Comment = 'FRA="Axe0"';
        Dim__1CaptionLbl: Label 'Dim. 1', Comment = 'FRA="Axe1"';
        Dim__2CaptionLbl: Label 'Dim. 2', Comment = 'FRA="Axe2"';
        Dim__3CaptionLbl: Label 'Dim. 3', Comment = 'FRA="Axe3"';
        Dim__4CaptionLbl: Label 'Dim. 4', Comment = 'FRA="Axe4"';
        InvoicedCaptionLbl: Label 'Invoiced', Comment = 'FRA="Facturée"';
        Issue_dateCaptionLbl: Label 'Issue date', Comment = 'FRA="Date d''émission"';
        issuer_nameCaptionLbl: Label 'issuer name', Comment = 'FRA="Nom de l''émetteur"';
        No_CaptionLbl: Label 'No.', Comment = 'FRA="N°"';
        Order_No_CaptionLbl: Label 'Order No.', Comment = 'FRA="N° Commande"';
        QuantityCaptionLbl: Label 'Quantity', Comment = 'FRA="Quantité"';
        ReceivedCaptionLbl: Label 'Received', Comment = 'FRA="Reçue"';
        VATCaptionLbl: Label 'VAT', Comment = 'FRA="TVA"';
        Vendor_codeCaptionLbl: Label 'Vendor code', Comment = 'FRA="Code fournisseur"';
        Vendor_nameCaptionLbl: Label 'Vendor name', Comment = 'FRA="Nom du fournisseur"';
}

