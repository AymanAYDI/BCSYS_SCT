report 50008 "BC6_Solde BC Masse"
{
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Solde BC Masse';
    dataset
    {
        dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
        {
            DataItemTableView = sorting("Document No.", "Line No.") where("Qty. Rcd. Not Invoiced" = filter(<> 0));

            trigger OnAfterGetRecord()
            begin
                if not Grec_PurchRcptHeader.GET("Purch. Rcpt. Line"."Document No.") then
                    CurrReport.SKIP()
                else
                    if not GDimSetEntry.GET("Dimension Set ID", 'PERIODE') then
                        CurrReport.SKIP()
                    else
                        if (GDimSetEntry."Dimension Value Code" < Gtext_AxePeriodeDebut) or (GDimSetEntry."Dimension Value Code" > Gtext_AxePeriodeFin) then
                            CurrReport.SKIP()
                        else begin
                            //creation  de l'en tête de facture si Numero de reception différent
                            Window.UPDATE(1, "Document No.");
                            if "Purch. Rcpt. Line"."Document No." <> Gtext_NumReception then begin
                                TempVendorInvNo.RESET();
                                TempVendorInvNo.SETRANGE("Vendor No.", Grec_PurchRcptHeader."Pay-to Vendor No.");
                                if not TempVendorInvNo.FINDFIRST() then begin
                                    VendorNo += 1;
                                    TempVendorInvNo."Entry No." := VendorNo;
                                    TempVendorInvNo."Vendor No." := Grec_PurchRcptHeader."Pay-to Vendor No.";
                                    TempVendorInvNo.INSERT();
                                end;

                                if TempVendorInvNo."External Document No." = '' then begin
                                    Grec_PurchInvoiceHeader.RESET();
                                    Grec_PurchInvoiceHeader.SETCURRENTKEY("Vendor Invoice No.");
                                    Grec_PurchInvoiceHeader.SETFILTER(Grec_PurchInvoiceHeader."Vendor Invoice No.", Gtext_NomFactureFournisseur + '*');
                                    if Grec_PurchInvoiceHeader.FINDLAST() then
                                        TempVendorInvNo."External Document No." := Grec_PurchInvoiceHeader."Vendor Invoice No." + '0';
                                end;
                                if TempVendorInvNo."External Document No." <> '' then
                                    TempVendorInvNo."External Document No." := INCSTR(TempVendorInvNo."External Document No.")
                                else begin
                                    Gint_NumG += 1;
                                    TempVendorInvNo."External Document No." := Gtext_NomFactureFournisseur + '' + GetInvoiceVendorNo(Gint_NumG) + '';
                                end;
                                TempVendorInvNo.MODIFY();

                                Grec_PurchaseHeader.INIT();
                                Grec_PurchaseHeader.SetHideValidationDialog(true);
                                Grec_PurchaseHeader.TRANSFERFIELDS(Grec_PurchRcptHeader);
                                Grec_PurchaseHeader.VALIDATE(Grec_PurchaseHeader."Document Type", Grec_PurchaseHeader."Document Type"::Invoice);
                                Grec_PurchaseHeader."No. Series" := 'PI';
                                Grec_PurchaseHeader."Posting No. Series" := 'PPI';
                                Grec_PurchaseHeader."Receiving No. Series" := 'PR';
                                Grec_PurchaseHeader."No." := NoSeriesMgt.GetNextNo('PI', "Posting Date", true);
                                Grec_PurchaseHeader.VALIDATE("No.");
                                Grec_PurchaseHeader.INSERT();
                                Grec_Vendor.GET(Grec_PurchRcptHeader."Buy-from Vendor No.");
                                if Grec_Vendor.Blocked <> Grec_Vendor.Blocked::" " then begin
                                    MESSAGE('Le fournisseur ' + Grec_Vendor."No." + ' est bloqué ' + "Purch. Rcpt. Line"."Document No.");
                                    CurrReport.SKIP();
                                end;
                                Grec_PurchaseHeader."BC6_Original user" := USERID;
                                Grec_PurchaseHeader."Assigned User ID" := USERID;
                                Grec_PurchaseHeader.VALIDATE("Buy-from Vendor No.", Grec_PurchRcptHeader."Buy-from Vendor No.");
                                Grec_PurchaseHeader.VALIDATE("Pay-to Vendor No.", Grec_PurchRcptHeader."Pay-to Vendor No.");
                                Grec_PurchaseHeader.VALIDATE("Posting Date", Gdate_DateCompta);
                                Grec_PurchaseHeader."Your Reference" := Gtext_VotreReference;
                                Grec_PurchaseHeader."Vendor Invoice No." := TempVendorInvNo."External Document No.";
                                Grec_PurchaseHeader.MODIFY();
                            end;
                            //insertion de la ligne de reception sur la facture créée
                            PurchHeader.GET(PurchHeader."Document Type"::Invoice, Grec_PurchaseHeader."No.");
                            Grec_PurchRcptLine.SETRANGE("Document No.", "Document No.");
                            Grec_PurchRcptLine.SETRANGE("Line No.", "Line No.");
                            CLEAR(GetReceipts);
                            GetReceipts.SetPurchHeader(PurchHeader);
                            GetReceipts.CreateInvLines(Grec_PurchRcptLine);

                            //mise en mémoire du numéro de reception pour eviter de créer un nouvelle facture si plusieurs lignes de réception
                            Gtext_NumReception := "Purch. Rcpt. Line"."Document No.";
                        end;
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE();
            end;

            trigger OnPreDataItem()
            begin
                if (Gtext_AxePeriodeDebut > Gtext_AxePeriodeFin) or (Gtext_AxePeriodeFin < Gtext_AxePeriodeDebut) then
                    ERROR('Veuillez vérifier les axes "Axe période début" et "Axe période de fin"');

                Gtext_NumReception := '';

                Window.OPEN(Text50000);
            end;
        }
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Invoice));

            trigger OnAfterGetRecord()
            var
                lToPost: Boolean;
            begin
                //mettre le coût unitaire à jour pour les lignes de réception avant validation de la facture
                Grec_PurchaseLine.SETFILTER("Document Type", FORMAT("Document Type"::Invoice));
                Grec_PurchaseLine.SETFILTER("Document No.", "No.");
                if Grec_PurchaseLine.FINDFIRST() then
                    repeat
                        if (Grec_PurchaseLine.Type <> Grec_PurchaseLine.Type::" ") then begin
                            Grec_PurchaseLine.VALIDATE(Grec_PurchaseLine."Direct Unit Cost", 0);
                            Grec_PurchaseLine.VALIDATE(Grec_PurchaseLine."Line Discount %", 0);
                            Grec_PurchaseLine.VALIDATE(Grec_PurchaseLine."Unit Cost (LCY)", 0);
                            Grec_PurchaseLine.MODIFY();
                        end;
                    until Grec_PurchaseLine.NEXT() = 0;

                lToPost := true;
                //valider la facture
                if not Grec_PurchaseLine.FINDFIRST() then
                    lToPost := false
                else begin
                    Grec_PurchaseLine.SETFILTER("Qty. to Invoice", '<>%1', 0);
                    if not Grec_PurchaseLine.FINDFIRST() then
                        lToPost := false;
                end;
                if lToPost then
                    PurchPost.RUN("Purchase Header");
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("Your Reference", Gtext_VotreReference);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(Gtext_AxePeriodeDebutV; Gtext_AxePeriodeDebut)
                {
                    Caption = 'Axe période début';
                    ApplicationArea = All;
                }
                field(Gtext_AxePeriodeFinV; Gtext_AxePeriodeFin)
                {
                    Caption = 'Axe période fin';
                    ApplicationArea = All;
                }
                field(Gtext_NomFactureFournisseurV; Gtext_NomFactureFournisseur)
                {
                    Caption = 'Nom facture fournisseur';
                    ApplicationArea = All;
                }
                field(Gtext_VotreReferenceV; Gtext_VotreReference)
                {
                    Caption = 'Votre référence';
                    ApplicationArea = All;
                }
                field(Gdate_DateComptaV; Gdate_DateCompta)
                {
                    Caption = 'Date comptabilisation';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        Gtext_AxePeriodeDebut := '1501';
        Gtext_AxePeriodeFin := '1512';
        Gtext_NomFactureFournisseur := 'SOLDE BC2015-';
        Gtext_VotreReference := 'Solde BC2015 en masse';
        Gdate_DateCompta := 20311215D;
    end;

    trigger OnPostReport()
    begin
        MESSAGE('Le traitement est terminé');
        CurrReport.QUIT();
    end;

    var
        GDimSetEntry: Record "Dimension Set Entry";
        Grec_PurchInvoiceHeader: Record "Purch. Inv. Header";
        Grec_PurchRcptHeader: Record "Purch. Rcpt. Header";
        Grec_PurchRcptLine: Record "Purch. Rcpt. Line";
        Grec_PurchaseHeader: Record "Purchase Header";
        PurchHeader: Record "Purchase Header";
        Grec_PurchaseLine: Record "Purchase Line";
        Grec_Vendor: Record Vendor;
        TempVendorInvNo: Record "Vendor Ledger Entry" temporary;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GetReceipts: Codeunit "Purch.-Get Receipt";
        PurchPost: Codeunit "Purch.-Post";
        Gdate_DateCompta: Date;
        Window: Dialog;
        Gint_NumG: Integer;
        VendorNo: Integer;
        Text50000: label 'Réception N° #1################';
        Gtext_AxePeriodeDebut: Text[4];
        Gtext_AxePeriodeFin: Text[4];
        Gtext_NomFactureFournisseur: Text[20];
        Gtext_NumReception: Text[30];
        Gtext_VotreReference: Text[30];

    procedure SetPurchHeader(var PurchHeader2: Record "Purchase Header")
    begin
        PurchHeader.GET(PurchHeader2."Document Type", PurchHeader2."No.");
        PurchHeader.TESTFIELD("Document Type", PurchHeader."Document Type"::Invoice);
    end;

    procedure GetInvoiceVendorNo(Gint_num: Integer) Gtext_Num: Text[30]
    begin
        case true of
            STRLEN(FORMAT(Gint_num)) = 1:
                Gtext_Num := '0000' + FORMAT(Gint_num);
            STRLEN(FORMAT(Gint_num)) = 2:
                Gtext_Num := '000' + FORMAT(Gint_num);
            STRLEN(FORMAT(Gint_num)) = 3:
                Gtext_Num := '00' + FORMAT(Gint_num);
            STRLEN(FORMAT(Gint_num)) = 4:
                Gtext_Num := '0' + FORMAT(Gint_num);
            STRLEN(FORMAT(Gint_num)) = 5:
                Gtext_Num := FORMAT(Gint_num);
        end;
    end;
}
