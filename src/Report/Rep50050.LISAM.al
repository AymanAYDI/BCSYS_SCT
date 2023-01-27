report 50050 "BC6_LISAM"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/LISAM.rdl';
    caption = 'LISAM', Comment = 'FRA="LISAM"';
    dataset
    {
        dataitem(DataItem1000000004; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = const(1));
            MaxIteration = 1;
            column("USERID"; USERID)
            {
            }
            column(Text002; Text002)
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
            column(User__Caption; User__CaptionLbl)
            {
            }
            column(Date__Caption; Date__CaptionLbl)
            {
            }
            column(Order_No_Caption; Order_No_CaptionLbl)
            {
            }
            column(Doc_No_Caption; Doc_No_CaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(CreditCaption; CreditCaptionLbl)
            {
            }
            column(DebitCaption; DebitCaptionLbl)
            {
            }
            column(ConsoCaption; ConsoCaptionLbl)
            {
            }
            column(Dim4Caption; Dim4CaptionLbl)
            {
            }
            column(Dim3Caption; Dim3CaptionLbl)
            {
            }
            column(Dim2Caption; Dim2CaptionLbl)
            {
            }
            column(Dim1Caption; Dim1CaptionLbl)
            {
            }
            column(PeriodCaption; PeriodCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(AccountCaption; AccountCaptionLbl)
            {
            }
            column(PieceCaption; PieceCaptionLbl)
            {
            }
            column(Source_CodeCaption; Source_CodeCaptionLbl)
            {
            }
            column(DateCaption_Control1000000009; DateCaption_Control1000000009Lbl)
            {
            }

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET();
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);

                if Grecord_GeneralLedgerSetup.FIND('-') then begin
                    Gcode_Axe1 := Grecord_GeneralLedgerSetup."Shortcut Dimension 3 Code";
                    Gcode_Axe2 := Grecord_GeneralLedgerSetup."Shortcut Dimension 4 Code";
                    Gcode_Axe3 := Grecord_GeneralLedgerSetup."Shortcut Dimension 5 Code";
                    Gcode_Axe4 := Grecord_GeneralLedgerSetup."Shortcut Dimension 6 Code";
                    Gcode_Axe5 := Grecord_GeneralLedgerSetup."Shortcut Dimension 7 Code";
                    Gcode_Axe6 := Grecord_GeneralLedgerSetup."Shortcut Dimension 8 Code";
                end;
            end;
        }
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = sorting("Posting Date");
            RequestFilterFields = "Posting Date", "G/L Account No.";
            column(G_L_Entry__G_L_Entry___Debit_Amount_; "G/L Entry"."Debit Amount")
            {
            }
            column(G_L_Entry__G_L_Entry___Credit_Amount_; "G/L Entry"."Credit Amount")
            {
            }
            column(G_L_Entry__G_L_Entry__Amount; "G/L Entry".Amount)
            {
            }
            column(Gcode_Tiers; Gcode_Tiers)
            {
            }
            column(Gtext_Description; Gtext_Description)
            {
            }
            column(G_L_Entry__G_L_Entry___G_L_Account_No__; "G/L Entry"."G/L Account No.")
            {
            }
            column(G_L_Entry__G_L_Entry___Document_No__; "G/L Entry"."Document No.")
            {
            }
            column(G_L_Entry__G_L_Entry___Source_Code_; "G/L Entry"."Source Code")
            {
            }
            column(G_L_Entry__G_L_Entry___Posting_Date_; "G/L Entry"."Posting Date")
            {
            }
            column(Gtext_Axe1; Gtext_Axe1)
            {
            }
            column(Gtext_Axe2; Gtext_Axe2)
            {
            }
            column(Gtext_Axe3; Gtext_Axe3)
            {
            }
            column(Gtext_Axe4; Gtext_Axe4)
            {
            }
            column(Gtext_Axe5; Gtext_Axe5)
            {
            }
            column(Gtext_Axe6; Gtext_Axe6)
            {
            }
            column(G_L_Entry__G_L_Entry___External_Document_No__; "G/L Entry"."External Document No.")
            {
            }
            column(Gtext_ListeBC; Gtext_ListeBC)
            {
            }
            column(G_L_Entry_Entry_No_; "Entry No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Grec_DimSetEntry.RESET();
                Grec_DimSetEntry.SETRANGE("Dimension Set ID", "Dimension Set ID");
                Grec_DimSetEntry.SETRANGE("Dimension Code", Gcode_Axe1);
                if Grec_DimSetEntry.FINDFIRST()
                  then
                    Gtext_Axe1 := Grec_DimSetEntry."Dimension Value Code"
                else
                    Gtext_Axe1 := '';

                Grec_DimSetEntry.RESET();
                Grec_DimSetEntry.SETRANGE("Dimension Set ID", "Dimension Set ID");
                Grec_DimSetEntry.SETRANGE("Dimension Code", Gcode_Axe2);
                if Grec_DimSetEntry.FINDFIRST()
                  then
                    Gtext_Axe2 := Grec_DimSetEntry."Dimension Value Code"
                else
                    Gtext_Axe2 := '';

                Grec_DimSetEntry.RESET();
                Grec_DimSetEntry.SETRANGE("Dimension Set ID", "Dimension Set ID");
                Grec_DimSetEntry.SETRANGE("Dimension Code", Gcode_Axe3);
                if Grec_DimSetEntry.FINDFIRST()
                  then
                    Gtext_Axe3 := Grec_DimSetEntry."Dimension Value Code"
                else
                    Gtext_Axe3 := '';

                Grec_DimSetEntry.RESET();
                Grec_DimSetEntry.SETRANGE("Dimension Set ID", "Dimension Set ID");
                Grec_DimSetEntry.SETRANGE("Dimension Code", Gcode_Axe4);
                if Grec_DimSetEntry.FINDFIRST()
                  then
                    Gtext_Axe4 := Grec_DimSetEntry."Dimension Value Code"
                else
                    Gtext_Axe4 := '';

                Grec_DimSetEntry.RESET();
                Grec_DimSetEntry.SETRANGE("Dimension Set ID", "Dimension Set ID");
                Grec_DimSetEntry.SETRANGE("Dimension Code", Gcode_Axe5);
                if Grec_DimSetEntry.FINDFIRST()
                  then
                    Gtext_Axe5 := Grec_DimSetEntry."Dimension Value Code"
                else
                    Gtext_Axe5 := '';

                Grec_DimSetEntry.RESET();
                Grec_DimSetEntry.SETRANGE("Dimension Set ID", "Dimension Set ID");
                Grec_DimSetEntry.SETRANGE("Dimension Code", Gcode_Axe6);
                if Grec_DimSetEntry.FINDFIRST()
                  then
                    Gtext_Axe6 := Grec_DimSetEntry."Dimension Value Code"
                else
                    Gtext_Axe6 := '';

                //Recherche du tiers
                Gcode_Tiers := '';
                if "G/L Entry"."Source No." <> '' then
                    Gcode_Tiers := "G/L Entry"."Source No."
                else
                    if "G/L Entry"."External Document No." <> '' then begin
                        Gtext_ExtDoc := CONVERTSTR("G/L Entry"."External Document No.", '-', ',');
                        Gtext_ExtDoc := SELECTSTR(1, Gtext_ExtDoc);
                        if Grec_PurchHeader.GET(Grec_PurchHeader."Document Type"::Quote, Gtext_ExtDoc) then
                            Gcode_Tiers := Grec_PurchHeader."Buy-from Vendor No."
                        else
                            if Grec_PurchHeader.GET(Grec_PurchHeader."Document Type"::Order, Gtext_ExtDoc) then
                                Gcode_Tiers := Grec_PurchHeader."Buy-from Vendor No."
                            else
                                if Grec_SalesHeader.GET(Grec_SalesHeader."Document Type"::Quote, Gtext_ExtDoc) then
                                    Gcode_Tiers := Grec_SalesHeader."Sell-to Customer No."
                                else
                                    if Grec_SalesHeader.GET(Grec_SalesHeader."Document Type"::Order, Gtext_ExtDoc) then
                                        Gcode_Tiers := Grec_SalesHeader."Sell-to Customer No."
                                    else
                                        if Grec_SalesInvHeader.GET(Gtext_ExtDoc) then
                                            Gcode_Tiers := Grec_SalesInvHeader."Sell-to Customer No."
                                        else
                                            if Grec_PurchInvHeader.GET(Gtext_ExtDoc) then
                                                Gcode_Tiers := Grec_PurchInvHeader."Buy-from Vendor No.";
                    end;

                //Liste de BC pour une facture
                if "G/L Entry"."Document Type" = "G/L Entry"."Document Type"::Invoice then begin
                    //Gtext_ListeBC := 'facture';
                    //Recherche des commandes liées à la facture
                    Gint_NbOrders := Gunit_LinksBetweenDocument.SearchOrdersFA("G/L Entry"."Document No.", Gcode_Order);
                    Gtext_ListeBC := '';

                    for i := 1 to Gint_NbOrders do
                        if i > 1 then
                            Gtext_ListeBC += ';';
                    Gtext_ListeBC += Gcode_Order[i];

                end else
                    Gtext_ListeBC := '';

                //Modif JX-AUD du 31/05/11

                Gtext_Description := "G/L Entry".Description;

                //factures ventes
                if Grec_SalesInvoiceHeader.GET("G/L Entry"."Document No.") then begin
                    Grec_SalesInvoiceLine.RESET();
                    Grec_SalesInvoiceLine.SETRANGE("Document No.", Grec_SalesInvoiceHeader."No.");
                    Grec_SalesInvoiceLine.SETRANGE("Dimension Set ID", "Dimension Set ID");
                    if Grec_SalesInvoiceLine.FINDFIRST() then
                        Gtext_Description := Grec_SalesInvoiceLine.Description;

                    Grec_DimSetEntry.RESET();
                    Grec_DimSetEntry.SETRANGE("Dimension Set ID", Grec_SalesInvoiceLine."Dimension Set ID");
                    Grec_DimSetEntry.SETRANGE("Dimension Code", 'RESERVE');
                    if Grec_DimSetEntry.FINDFIRST() then
                        Gcode_AxeReserve := Grec_DimSetEntry."Dimension Value Code";
                end;

                //avoirs ventes
                if Grec_SalesCrMemoHeader.GET("G/L Entry"."Document No.") then begin
                    Grec_SalesCrMemoLine.RESET();
                    Grec_SalesCrMemoLine.SETRANGE("Document No.", Grec_SalesCrMemoHeader."No.");
                    Grec_SalesCrMemoLine.SETRANGE("Dimension Set ID", "Dimension Set ID");
                    if Grec_SalesCrMemoLine.FINDFIRST() then
                        Gtext_Description := Grec_SalesCrMemoLine.Description;

                    Grec_DimSetEntry.RESET();
                    Grec_DimSetEntry.SETRANGE("Dimension Set ID", Grec_SalesInvoiceLine."Dimension Set ID");
                    Grec_DimSetEntry.SETRANGE("Dimension Code", 'RESERVE');
                    if Grec_DimSetEntry.FINDFIRST() then
                        Gcode_AxeReserve := Grec_DimSetEntry."Dimension Value Code";
                end;

                //Fin Modif JX-AUD du 31/05/11
            end;
        }
    }
    trigger OnInitReport()
    begin
        Gbool_AfficherEnTete := true;
    end;

    var
        CompanyInfo: Record "Company Information";
        Grec_DimSetEntry: Record "Dimension Set Entry";
        Grecord_GeneralLedgerSetup: Record "General Ledger Setup";
        Grec_PurchInvHeader: Record "Purch. Inv. Header";
        Grec_PurchHeader: Record "Purchase Header";
        Grec_SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        Grec_SalesCrMemoLine: Record "Sales Cr.Memo Line";
        Grec_SalesHeader: Record "Sales Header";
        Grec_SalesInvHeader: Record "Sales Invoice Header";
        Grec_SalesInvoiceHeader: Record "Sales Invoice Header";
        Grec_SalesInvoiceLine: Record "Sales Invoice Line";
        Gunit_LinksBetweenDocument: Codeunit "BC6_Links Between Documents";
        Gbool_AfficherEnTete: Boolean;
        Gcode_Axe1: Code[20];
        Gcode_Axe2: Code[20];
        Gcode_Axe3: Code[20];
        Gcode_Axe4: Code[20];
        Gcode_Axe5: Code[20];
        Gcode_Axe6: Code[20];
        Gcode_AxeReserve: Code[20];
        Gcode_Order: array[100] of Code[20];
        Gcode_Tiers: Code[20];
        Gint_NbOrders: Integer;
        i: Integer;
        AccountCaptionLbl: label 'Account', Comment = 'FRA="Compte"';
        AmountCaptionLbl: label 'Amount', Comment = 'FRA="Solde"';
        ConsoCaptionLbl: label 'Conso', Comment = 'FRA="Conso"';
        CreditCaptionLbl: label 'Credit', Comment = 'FRA="Credit"';
        Date__CaptionLbl: label 'Date :', Comment = 'FRA="Date"';
        DateCaption_Control1000000009Lbl: label 'Date', Comment = 'FRA="Date"';
        DateCaptionLbl: label 'Date', Comment = 'FRA="tiers - Contrepartie"';
        DebitCaptionLbl: label 'Debit', Comment = 'FRA="Debit"';
        DescriptionCaptionLbl: label 'Description', Comment = 'FRA="Libelle"';
        Dim1CaptionLbl: label 'Dim1', Comment = 'FRA="Axe1"';
        Dim2CaptionLbl: label 'Dim2', Comment = 'FRA="Axe2"';
        Dim3CaptionLbl: label 'Dim3', Comment = 'FRA="Axe3"';
        Dim4CaptionLbl: label 'Dim4', Comment = 'FRA="Axe4"';
        Doc_No_CaptionLbl: label 'Doc No.', Comment = 'FRA="N° Doc"';
        Order_No_CaptionLbl: label 'Order No.', Comment = 'FRA="N° de BC"';
        PeriodCaptionLbl: label 'Period', Comment = 'FRA="Periode"';
        PieceCaptionLbl: label 'Piece', Comment = 'FRA="Piece"';
        Source_CodeCaptionLbl: label 'Source Code', Comment = 'FRA="Origine"';
        Text002: label 'Vendor Statement', Comment = 'FRA="LISAM"';
        Text004: label 'at', Comment = 'FRA="à"';
        User__CaptionLbl: label 'User :', Comment = 'FRA="Utilisateur :"';
        Gtext_Axe1: Text[30];
        Gtext_Axe2: Text[30];
        Gtext_Axe3: Text[30];
        Gtext_Axe4: Text[30];
        Gtext_Axe5: Text[30];
        Gtext_Axe6: Text[30];
        Gtext_ExtDoc: Text[50];
        Gtext_Description: Text[100];
        Gtext_ListeBC: Text[1024];
}
