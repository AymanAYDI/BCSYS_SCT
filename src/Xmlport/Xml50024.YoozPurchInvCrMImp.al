xmlport 50024 "BC6_Yooz Purch. Inv.&CrM. Imp"
{
    Caption = 'Yooz Purch. Inv.&CrM. Import';
    Direction = Import;
    Format = VariableText;
    FieldDelimiter = '<None>';
    FieldSeparator = '[;]';
    UseRequestPage = false;
    FileName = '*.csv';

    schema
    {
        textelement(root)
        {
            tableelement("Yooz"; 2000000026)
            {
                textelement(Gtext_Champ1) { }
                textelement(Gtext_Champ2) { }
                textelement(Gtext_Champ3) { }
                textelement(Gtext_Champ4) { }
                textelement(Gtext_Champ5) { }
                textelement(Gtext_Champ6) { }
                textelement(Gtext_Champ7) { }
                textelement(Gtext_Champ8) { }
                textelement(Gtext_Champ9) { }
                textelement(Gtext_Champ10) { }
                textelement(Gtext_Champ11) { }
                textelement(Gtext_Champ12) { }
                // AutoSave = false;
                // AutoUpdate = false;
                // AutoReplace = false;
                trigger OnBeforeInsertRecord()
                begin
                    Gint_Compteur := Gint_Compteur + 1;
                    if (Gint_Compteur > 1) then
                        if Gtext_Champ1 = CompName then begin
                            //On test si la facture Yooz aurait d‚j… ‚t‚ int‚gr‚e
                            Grec_PurchaseHeader2.RESET();
                            Grec_PurchaseHeader2.SETFILTER(Grec_PurchaseHeader2."BC6_Yooz No.", Gtext_Champ9);
                            if not Grec_PurchaseHeader2.FINDFIRST() then begin //Si la facture n'y est pas on l'intŠgre
                                NbOk += 1;
                                //Cr‚ation de l'entˆte de la facture achat
                                CLEAR(Grec_PurchaseHeader);
                                Grec_PurchaseHeader.INIT();
                                // JX-YOOZ2 13/11/15 Ajout champ document type Facture ou Avoir
                                if UPPERCASE(Gtext_Champ12) = 'FACTURE' then begin
                                    Grec_PurchaseHeader.VALIDATE("Document Type", Grec_PurchaseHeader."Document Type"::Invoice);
                                    Grec_PurchaseHeader."Vendor Invoice No." := Gtext_Champ6; //Nø facture fournisseur
                                end else begin
                                    Grec_PurchaseHeader.VALIDATE("Document Type", Grec_PurchaseHeader."Document Type"::"Credit Memo");
                                    Grec_PurchaseHeader."Vendor Cr. Memo No." := Gtext_Champ6; //Nø avoir fournisseur
                                end;
                                //
                                Grec_PurchaseHeader.VALIDATE("No.");
                                Grec_PurchaseHeader.VALIDATE("Buy-from Vendor No.", Gtext_Champ2);  //entite facturante/cpte feur
                                Grec_PurchaseHeader.INSERT(true);

                                EVALUATE(Grec_PostingDate, Gtext_Champ3); //Date comptable
                                Grec_PurchaseHeader.VALIDATE("Posting Date", Grec_PostingDate);
                                EVALUATE(Grec_DocumentDate, Gtext_Champ4); //Date document
                                Grec_PurchaseHeader.VALIDATE("Document Date", Grec_DocumentDate);
                                if (STRPOS(Gtext_Champ5, 'GROUPEVSC\') = 0) or (STRPOS(Gtext_Champ5, '\') = 0) then
                                    Gtext_Champ5 := 'GROUPEVSC\' + Gtext_Champ5;
                                Grec_PurchaseHeader.VALIDATE("Assigned User ID", Gtext_Champ5); //Code collaborateur affect‚
                                EVALUATE(Gdec_AmoutExlVAT, Gtext_Champ7); //Montant HT
                                Grec_PurchaseHeader."BC6_Register amount" := Gdec_AmoutExlVAT;
                                Grec_PurchaseHeader."BC6_BC No." := Gtext_Champ8;  //Nø bon de commande
                                Grec_PurchaseHeader."BC6_Yooz No." := Gtext_Champ9; //Nø Yooz
                                Grec_PurchaseHeader."BC6_Yooz Token link" := Gtext_Champ10; //Lien Token Yooz
                                EVALUATE(Grec_ReceiptInvoiceDate, Gtext_Champ11); //Daten de scan yooz
                                Grec_PurchaseHeader."BC6_Invoice receipt date" := Grec_ReceiptInvoiceDate;
                                Grec_PurchaseHeader.MODIFY(true);
                            end;
                        end else begin
                            NbOComp += 1;
                            if STRPOS(OComp, Gtext_Champ1) = 0 then
                                if OComp = '' then
                                    OComp := Gtext_Champ1
                                else
                                    OComp := OComp + '/' + Gtext_Champ1;
                        end;
                end;
            }
        }
    }

    trigger OnPreXMLport()
    begin
        case COMPANYNAME of
            'VFEC':
                CompName := 'VSCG';
            'Agence':
                CompName := 'AGVSC';
            'VSC':
                CompName := 'VSC';
            'VSCT':
                CompName := 'VSCT';
            //BCSYS 021019
            'SNCF-C25':
                CompName := 'SNCFC25';
        end;
    end;

    trigger OnPostXMLport()
    begin
        if NbOComp = 0 then
            MESSAGE(STRSUBSTNO(Text001, NbOk))
        else
            MESSAGE(STRSUBSTNO(Text001, NbOk, NbOComp, OComp));
    end;

    var
        Grec_PurchaseHeader: Record "Purchase Header";
        Grec_PurchaseHeader2: Record "Purchase Header";
        Grec_DocumentDate: Date;
        Grec_PostingDate: Date;
        Grec_ReceiptInvoiceDate: Date;
        Gdec_AmoutExlVAT: Decimal;
        Gint_Compteur: Integer;
        NbOComp: Integer;
        NbOk: Integer;
        Text001: label 'Yooz Invoices are integrated';
        CompName: Text;
        OComp: Text;
}
