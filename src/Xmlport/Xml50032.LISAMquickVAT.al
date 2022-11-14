xmlport 50032 "BC6_LISAM (quick) VAT"
{
    Caption = 'LISAM (quick) VAT';
    Direction = Export;
    TextEncoding = WINDOWS;
    Format = VariableText;
    FieldDelimiter = '<None>';
    FieldSeparator = '[;]';
    TableSeparator = '<NewLine>';
    FileName = 'LISAMQUICK.CSV';
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(Header; 2000000026)
            {
                textelement(Gtext_NomChamp)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    Gtext_NomChamp := 'Date;Origine;Pièce;Compte;Libellé;Période;Axe 1;Axe 2;Axe 3;Axe 4;Conso;Débit;Crédit;Solde;Tiers-Contrepartie;N° doc;Groupe compta. marché;Montant TVA;Groupe compta. produit TVA';
                end;
            }
            tableelement(GLEntry; 17)
            {
                fieldelement(PostingDate; GLEntry."Posting Date")
                {
                }
                fieldelement(SourceCode; GLEntry."Source Code")
                {
                }
                fieldelement(DocumentNo; GLEntry."Document No.")
                {
                }
                fieldelement(GLAccount; GLEntry."G/L Account No.")
                {
                }
                textelement(Gtext_Description)
                {
                }
                textelement(Gtext_Axe1)
                {
                }
                textelement(Gtext_Axe2)
                {
                }
                textelement(Gtext_Axe3)
                {
                }
                textelement(Gtext_Axe4)
                {
                }
                textelement(Gtext_Axe5)
                {
                }
                textelement(Gtext_Axe6)
                {
                }
                textelement(Gtext_DebitAmount)
                {
                }
                textelement(Gtext_CreditAmount)
                {
                }
                textelement(Gtext_Amount)
                {
                }
                textelement(Gcode_Tiers)
                {
                }
                fieldelement(ExternalDoc; GLEntry."External Document No.")
                {
                }
                fieldelement(GenBusPostingGrp; GLEntry."Gen. Bus. Posting Group")
                {
                }
                textelement(Gtext_VATAmount)
                {
                }
                fieldelement(VatProdPostingGrp; GLEntry."VAT Prod. Posting Group")
                {
                }
                textelement(Gtext_Axe7)
                {
                }
                textelement(Gtext_Axe8)
                {
                }
                trigger OnPreXMLItem()
                begin
                    if Grecord_GeneralLedgerSetup.FIND('-') then begin
                        Gcode_Axe1 := Grecord_GeneralLedgerSetup."Shortcut Dimension 3 Code";
                        Gcode_Axe2 := Grecord_GeneralLedgerSetup."Shortcut Dimension 4 Code";
                        Gcode_Axe3 := Grecord_GeneralLedgerSetup."Shortcut Dimension 5 Code";
                        Gcode_Axe4 := Grecord_GeneralLedgerSetup."Shortcut Dimension 6 Code";
                        Gcode_Axe5 := Grecord_GeneralLedgerSetup."Shortcut Dimension 7 Code";
                        Gcode_Axe6 := Grecord_GeneralLedgerSetup."Shortcut Dimension 8 Code";
                        Gcode_Axe7 := Grecord_GeneralLedgerSetup."BC6_Shortcut Dimension 9 Code";
                        Gcode_Axe8 := Grecord_GeneralLedgerSetup."BC6_Shortcut Dimension 10 Code";
                    end;
                end;

                trigger OnAfterGetRecord()
                begin
                    Gtext_Description := CONVERTSTR(GLEntry.Description, ';', ',');
                    Gtext_DebitAmount := "Gcu_ANSI-ASCII".Ascii2Ansi(FORMAT(GLEntry."Debit Amount"));
                    Gtext_CreditAmount := "Gcu_ANSI-ASCII".Ascii2Ansi(FORMAT(GLEntry."Credit Amount"));
                    Gtext_Amount := "Gcu_ANSI-ASCII".Ascii2Ansi(FORMAT(GLEntry.Amount));
                    Gtext_VATAmount := "Gcu_ANSI-ASCII".Ascii2Ansi(FORMAT(GLEntry."VAT Amount"));

                    FctRetrieveDim(GLEntry."Dimension Set ID");

                    //Recherche du tiers
                    Gcode_Tiers := '';
                    if GLEntry."Source No." <> '' then
                        Gcode_Tiers := GLEntry."Source No."
                    else begin
                        if GLEntry."External Document No." <> '' then begin

                            //Modif ABE du 20/11/2015
                            //r‚duction longueur doc extern car 35 et Nø doc achat et ventes 20
                            // Gtext_ExtDoc := CONVERTSTR("G/L Entry"."External Document No.", '-', ',');
                            Gtext_ExtDoc := PADSTR(CONVERTSTR(GLEntry."External Document No.", '-', ','), 20);
                            //Fin modif ABE du 20/11/2015

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
                    end;

                    //Modif JX-AUD du 31/05/11

                    Gtext_Description := CONVERTSTR(GLEntry.Description, ';', ',');

                    //factures ventes
                    if Grec_SalesInvoiceHeader.GET(GLEntry."Document No.") then begin

                        if Grecord_LedgerEntryDimension.GET(GLEntry."Dimension Set ID", 'RESERVE') then
                            Gcode_AxeReserve := Grecord_LedgerEntryDimension."Dimension Value Code";

                        Grec_SalesInvoiceLine.RESET();
                        Grec_SalesInvoiceLine.SETRANGE("Document No.", Grec_SalesInvoiceHeader."No.");
                        Grec_SalesInvoiceLine.SETRANGE("Dimension Set ID", GLEntry."Dimension Set ID");
                        if Grec_SalesInvoiceLine.FINDFIRST() then begin
                            Gtext_Description := CONVERTSTR(Grec_SalesInvoiceLine.Description, ';', ',');
                            FctRetrieveDim(Grec_SalesInvoiceLine."Dimension Set ID");
                        end else begin
                            Grec_SalesInvoiceLine.RESET();
                            Grec_SalesInvoiceLine.SETRANGE("Document No.", Grec_SalesInvoiceHeader."No.");
                            Grec_SalesInvoiceLine.SETRANGE(Amount, ABS(GLEntry.Amount));
                            if Grec_SalesInvoiceLine.FINDFIRST() then begin
                                Gtext_Description := CONVERTSTR(Grec_SalesInvoiceLine.Description, ';', ',');
                                FctRetrieveDim(Grec_SalesInvoiceLine."Dimension Set ID");
                                if Grecord_LedgerEntryDimension.GET(Grec_SalesInvoiceLine."Dimension Set ID", 'RESERVE') then
                                    Gcode_AxeReserve := Grecord_LedgerEntryDimension."Dimension Value Code";
                            end;
                        end;
                    end;

                    //avoirs ventes
                    if Grec_SalesCrMemoHeader.GET(GLEntry."Document No.") then begin

                        if Grecord_LedgerEntryDimension.GET(GLEntry."Dimension Set ID", 'RESERVE') then
                            Gcode_AxeReserve := Grecord_LedgerEntryDimension."Dimension Value Code";

                        Grec_SalesCrMemoLine.RESET();
                        Grec_SalesCrMemoLine.SETRANGE("Document No.", Grec_SalesCrMemoHeader."No.");
                        Grec_SalesCrMemoLine.SETRANGE("Dimension Set ID", GLEntry."Dimension Set ID");
                        if Grec_SalesCrMemoLine.FINDFIRST() then begin
                            Gtext_Description := CONVERTSTR(Grec_SalesCrMemoLine.Description, ';', ',');
                            FctRetrieveDim(Grec_SalesCrMemoLine."Dimension Set ID");
                        end else begin
                            Grec_SalesCrMemoLine.RESET();
                            Grec_SalesCrMemoLine.SETRANGE("Document No.", Grec_SalesCrMemoHeader."No.");
                            Grec_SalesCrMemoLine.SETRANGE(Amount, ABS(GLEntry.Amount));
                            if Grec_SalesCrMemoLine.FINDFIRST() then begin
                                Gtext_Description := CONVERTSTR(Grec_SalesCrMemoLine.Description, ';', ',');
                                FctRetrieveDim(Grec_SalesCrMemoLine."Dimension Set ID");
                                if Grecord_LedgerEntryDimension.GET(Grec_SalesCrMemoLine."Dimension Set ID", 'RESERVE') then
                                    Gcode_AxeReserve := Grecord_LedgerEntryDimension."Dimension Value Code";
                            end;
                        end;
                    end;

                    //factures achat
                    if Grec_PurchInvoiceHeader.GET(GLEntry."Document No.") then begin

                        if Grecord_LedgerEntryDimension.GET(GLEntry."Dimension Set ID", 'RESERVE') then
                            Gcode_AxeReserve := Grecord_LedgerEntryDimension."Dimension Value Code";

                        Grec_PurchInvoiceLine.RESET();
                        Grec_PurchInvoiceLine.SETRANGE("Document No.", Grec_PurchInvoiceHeader."No.");
                        Grec_PurchInvoiceLine.SETRANGE("Dimension Set ID", GLEntry."Dimension Set ID");
                        if Grec_PurchInvoiceLine.FINDFIRST() then begin
                            Gtext_Description := CONVERTSTR(Grec_PurchInvoiceLine.Description, ';', ',');
                            FctRetrieveDim(Grec_PurchInvoiceLine."Dimension Set ID");
                        end else begin
                            Grec_PurchInvoiceLine.RESET();
                            Grec_PurchInvoiceLine.SETRANGE("Document No.", Grec_PurchInvoiceHeader."No.");
                            Grec_PurchInvoiceLine.SETRANGE(Amount, ABS(GLEntry.Amount));
                            if Grec_PurchInvoiceLine.FINDFIRST() then begin
                                Gtext_Description := CONVERTSTR(Grec_PurchInvoiceLine.Description, ';', ',');
                                FctRetrieveDim(Grec_PurchInvoiceLine."Dimension Set ID");
                                if Grecord_LedgerEntryDimension.GET(Grec_PurchInvoiceLine."Dimension Set ID", 'RESERVE') then
                                    Gcode_AxeReserve := Grecord_LedgerEntryDimension."Dimension Value Code";
                            end;
                        end;
                    end;

                    //avoirs achat
                    if Grec_PurchCrMemoHeader.GET(GLEntry."Document No.") then begin

                        if Grecord_LedgerEntryDimension.GET(GLEntry."Dimension Set ID", 'RESERVE') then
                            Gcode_AxeReserve := Grecord_LedgerEntryDimension."Dimension Value Code";

                        Grec_PurchCrMemoLine.RESET();
                        Grec_PurchCrMemoLine.SETRANGE("Document No.", Grec_PurchCrMemoHeader."No.");
                        Grec_PurchCrMemoLine.SETRANGE("Dimension Set ID", GLEntry."Dimension Set ID");
                        if Grec_PurchCrMemoLine.FINDFIRST() then begin
                            Gtext_Description := CONVERTSTR(Grec_PurchCrMemoLine.Description, ';', ',');
                            FctRetrieveDim(Grec_PurchCrMemoLine."Dimension Set ID");
                        end else begin
                            Grec_PurchCrMemoLine.RESET();
                            Grec_PurchCrMemoLine.SETRANGE("Document No.", Grec_PurchCrMemoHeader."No.");
                            Grec_PurchCrMemoLine.SETRANGE(Amount, ABS(GLEntry.Amount));
                            if Grec_PurchCrMemoLine.FINDFIRST() then begin
                                Gtext_Description := CONVERTSTR(Grec_PurchCrMemoLine.Description, ';', ',');
                                FctRetrieveDim(Grec_PurchCrMemoLine."Dimension Set ID");
                                if Grecord_LedgerEntryDimension.GET(Grec_PurchCrMemoLine."Dimension Set ID", 'RESERVE') then
                                    Gcode_AxeReserve := Grecord_LedgerEntryDimension."Dimension Value Code";
                            end;
                        end;
                    end;
                end;
            }
        }
    }
    var
        Grecord_LedgerEntryDimension: Record "Dimension Set Entry";
        Grecord_GeneralLedgerSetup: Record "General Ledger Setup";
        Grec_PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        Grec_PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        Grec_PurchInvHeader: Record "Purch. Inv. Header";
        Grec_PurchInvoiceHeader: Record "Purch. Inv. Header";
        Grec_PurchInvoiceLine: Record "Purch. Inv. Line";
        Grec_PurchHeader: Record "Purchase Header";
        Grec_SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        Grec_SalesCrMemoLine: Record "Sales Cr.Memo Line";
        Grec_SalesHeader: Record "Sales Header";
        Grec_SalesInvHeader: Record "Sales Invoice Header";
        Grec_SalesInvoiceHeader: Record "Sales Invoice Header";
        Grec_SalesInvoiceLine: Record "Sales Invoice Line";
        "Gcu_ANSI-ASCII": Codeunit "BC6_ANSI_ASCII converter";
        Gcode_Axe1: Code[20];
        Gcode_Axe2: Code[20];
        Gcode_Axe3: Code[20];
        Gcode_Axe4: Code[20];
        Gcode_Axe5: Code[20];
        Gcode_Axe6: Code[20];
        Gcode_Axe7: Code[20];
        Gcode_Axe8: Code[20];
        Gcode_AxeReserve: Code[20];
        Gtext_ExtDoc: Text[50];

    local procedure FctRetrieveDim(piDimSetID: Integer);
    begin
        if Grecord_LedgerEntryDimension.GET(piDimSetID, Gcode_Axe1)
        then
            Gtext_Axe1 := Grecord_LedgerEntryDimension."Dimension Value Code"
        else
            Gtext_Axe1 := '';

        if Grecord_LedgerEntryDimension.GET(piDimSetID, Gcode_Axe2)
        then
            Gtext_Axe2 := Grecord_LedgerEntryDimension."Dimension Value Code"
        else
            Gtext_Axe2 := '';

        if Grecord_LedgerEntryDimension.GET(piDimSetID, Gcode_Axe3)
        then
            Gtext_Axe3 := Grecord_LedgerEntryDimension."Dimension Value Code"
        else
            Gtext_Axe3 := '';

        if Grecord_LedgerEntryDimension.GET(piDimSetID, Gcode_Axe4)
        then
            Gtext_Axe4 := Grecord_LedgerEntryDimension."Dimension Value Code"
        else
            Gtext_Axe4 := '';

        if Grecord_LedgerEntryDimension.GET(piDimSetID, Gcode_Axe5)
        then
            Gtext_Axe5 := Grecord_LedgerEntryDimension."Dimension Value Code"
        else
            Gtext_Axe5 := '';

        if Grecord_LedgerEntryDimension.GET(piDimSetID, Gcode_Axe6)
        then
            Gtext_Axe6 := Grecord_LedgerEntryDimension."Dimension Value Code"
        else
            Gtext_Axe6 := '';

        if Grecord_LedgerEntryDimension.GET(piDimSetID, Gcode_Axe7)
        then
            Gtext_Axe7 := Grecord_LedgerEntryDimension."Dimension Value Code"
        else
            Gtext_Axe7 := '';

        if Grecord_LedgerEntryDimension.GET(piDimSetID, Gcode_Axe8)
        then
            Gtext_Axe8 := Grecord_LedgerEntryDimension."Dimension Value Code"
        else
            Gtext_Axe8 := '';
    end;
}
