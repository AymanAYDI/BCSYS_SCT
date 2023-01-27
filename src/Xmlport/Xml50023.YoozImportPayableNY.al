xmlport 50023 "BC6_Yooz Import Payable NY"
{
    Caption = 'Yooz Import Payable NY', Comment = 'FRA="Yooz import facture payable ex. suivant"';
    Permissions = TableData "Vendor Ledger Entry" = rm,
                TableData "Sales Invoice Header" = rm,
                TableData "Sales Cr.Memo Header" = rm,
                TableData "Purch. Inv. Header" = rm,
                TableData "Purch. Cr. Memo Hdr." = rm;
    Direction = Import;
    Format = VariableText;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    UseRequestPage = false;
    FileName = '*.csv';
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(Yooz; Integer)
            {
                AutoSave = false;
                AutoUpdate = false;
                AutoReplace = false;
                textelement(Gtext_Champ1)
                {
                }
                textelement(Gtext_Champ2)
                {
                }
                textelement(Gtext_Champ9)
                {
                }
                textelement(Gtext_Champ10)
                {
                }
                trigger OnBeforeInsertRecord()
                begin
                    Gint_Compteur := Gint_Compteur + 1;
                    IF (Gint_Compteur > 1) THEN
                        IF Gtext_Champ1 = CompName THEN
                            // Vérification Facture / Facture enregistrée
                            IF COPYSTR(Gtext_Champ2, 1, 3) = 'FAP' THEN
                                IF Grec_PurchaseHeader.GET(Grec_PurchaseHeader."Document Type"::Invoice, Gtext_Champ2) THEN BEGIN
                                    Grec_PurchaseHeader."BC6_Yooz No." := Gtext_Champ9; //Nø Yooz
                                    Grec_PurchaseHeader."BC6_Yooz Token link" := Gtext_Champ10; //Lien Token Yooz
                                    Grec_PurchaseHeader.MODIFY();
                                    NbOk += 1;
                                END
                                ELSE
                                    IF Grec_PurchaseHeader.GET(Grec_PurchaseHeader."Document Type"::"Credit Memo", Gtext_Champ2) THEN BEGIN
                                        Grec_PurchaseHeader."BC6_Yooz No." := Gtext_Champ9; //Nø Yooz
                                        Grec_PurchaseHeader."BC6_Yooz Token link" := Gtext_Champ10; //Lien Token Yooz
                                        Grec_PurchaseHeader.MODIFY();
                                        NbOkAv += 1;
                                    END ELSE
                                        IF Grec_PurchInvHeader.GET(Gtext_Champ2) THEN BEGIN
                                            Grec_PurchInvHeader."BC6_Yooz No." := Gtext_Champ9; //Nø Yooz
                                            Grec_PurchInvHeader."BC6_Yooz Token link" := Gtext_Champ10; //Lien Token Yooz
                                            Grec_PurchInvHeader.MODIFY();
                                            NbOk += 1;
                                            Grec_VendLedgEntry.RESET();
                                            Grec_VendLedgEntry.SETCURRENTKEY("Vendor No.", "Document No.", "Posting Date");
                                            Grec_VendLedgEntry.SETRANGE("Vendor No.", Grec_PurchInvHeader."Pay-to Vendor No.");
                                            Grec_VendLedgEntry.SETRANGE("Document No.", Grec_PurchInvHeader."No.");
                                            Grec_VendLedgEntry.SETRANGE("Document Type", Grec_VendLedgEntry."Document Type"::Invoice);
                                            IF Grec_VendLedgEntry.FINDFIRST() THEN BEGIN
                                                Grec_VendLedgEntry."BC6_Yooz No." := Gtext_Champ9;
                                                Grec_VendLedgEntry."BC6_Yooz Token link" := Gtext_Champ10;
                                                Grec_VendLedgEntry.MODIFY();
                                            END;
                                        END ELSE
                                            IF Grec_PurchCrMemoHeader.GET(Gtext_Champ2) THEN BEGIN
                                                Grec_PurchCrMemoHeader."BC6_Yooz No." := Gtext_Champ9; //Nø Yooz
                                                Grec_PurchCrMemoHeader."BC6_Yooz Token link" := Gtext_Champ10; //Lien Token Yooz
                                                Grec_PurchCrMemoHeader.MODIFY();
                                                NbOkAv += 1;
                                                Grec_VendLedgEntry.RESET();
                                                Grec_VendLedgEntry.SETCURRENTKEY("Vendor No.", "Document No.", "Posting Date");
                                                Grec_VendLedgEntry.SETRANGE("Vendor No.", Grec_PurchInvHeader."Pay-to Vendor No.");
                                                Grec_VendLedgEntry.SETRANGE("Document No.", Grec_PurchInvHeader."No.");
                                                Grec_VendLedgEntry.SETRANGE("Document Type", Grec_VendLedgEntry."Document Type"::"Credit Memo");
                                                IF Grec_VendLedgEntry.FINDFIRST() THEN BEGIN
                                                    Grec_VendLedgEntry."BC6_Yooz No." := Gtext_Champ9;
                                                    Grec_VendLedgEntry."BC6_Yooz Token link" := Gtext_Champ10;
                                                    Grec_VendLedgEntry.MODIFY();
                                                END;
                                            END;
                END;
            }
        }
    }
    VAR
        Grec_PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        Grec_PurchInvHeader: Record "Purch. Inv. Header";
        Grec_PurchaseHeader: Record "Purchase Header";
        Grec_VendLedgEntry: Record "Vendor Ledger Entry";
        Gint_Compteur: Integer;
        NbOComp: Integer;
        NbOk: Integer;
        NbOkAv: Integer;
        Text001: Label 'Yooz Invoices are integrated', Comment = 'FRA="%1 facture(s) Yooz importée(s). %2 avoir(s) importé(s)."';
        Text002: Label '%1 imported Yooz invoice (s). \%2 invoice to import into companies %3.', Comment = 'FRA="%1 facture(s) Yooz importée(s).\%2 facture(s) à importer dans les sociétés %3."';
        CompName: Text;
        OComp: Text;

    trigger OnPreXMLport()
    begin
        CASE COMPANYNAME OF
            'VFEC':
                CompName := 'VSCG';
            'Agence':
                CompName := 'AGVSC';
            'VSC':
                CompName := 'VSC';
            'VSCT':
                CompName := 'VSCT';
        END;
    end;

    trigger OnPostXMLport()
    begin
        IF NbOComp = 0 THEN
            MESSAGE(STRSUBSTNO(Text001, NbOk, NbOkAv))
        ELSE
            MESSAGE(STRSUBSTNO(Text002, NbOk, NbOComp, OComp));
    end;
}
