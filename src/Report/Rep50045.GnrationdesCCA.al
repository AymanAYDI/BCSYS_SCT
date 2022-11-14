report 50045 "BC6_Génération des CCA"
{
    Caption = 'Generation of invoices not received';
    ProcessingOnly = true;

    dataset
    {
        dataitem("G/L Entry Charges"; "G/L Entry")
        {
            DataItemTableView = sorting("Entry No.");

            trigger OnAfterGetRecord()
            begin
                if Amount = 0 then
                    CurrReport.SKIP();

                InsérerCharges();
            end;

            trigger OnPreDataItem()
            begin
                //DEBUT MODIF JX-XAD le 07/02/2011
                //SETFILTER("Posting Date",'..%2',Gdate_Compta);//filtre sur la data compta
                SETFILTER("Posting Date", '%1..%2', Gdate_Debut, Gdate_Compta);//filtre sur la data compta
                //FIN MODIF JX-XAD le 07/02/2011

                SETFILTER("G/L Entry Charges"."G/L Account No.", '6*');//filtre sur les comptes 6*

                //DEBUT AJOUT JX-XAD 11/05/2011
                //IF Gtext_DocExclus <> '' THEN //Modif JX-AUD du 25/11/11
                //  SETFILTER("G/L Entry Charges"."Document No.",'<>cca004&<>excca00004');
                //SETFILTER("G/L Entry Charges"."Document No.",Gtext_DocExclus); //Modif JX-AUD du 25/11/11
                //Modif JX-AUD du 25/11/11

                //MESSAGE(RetourneFiltreCCA(Gtext_DocExclus_CCAPremiere, Gtext_DocExclus_CCADerniere)
                //+'&' +RetourneFiltreEXCCA(Gtext_DocExclus_EXCCAPremiere,Gtext_DocExclus_EXCCADerniere));
                SETFILTER("G/L Entry Charges"."Document No.", RetourneFiltreCCA(Gtext_DocExclus_CCAPremiere, Gtext_DocExclus_CCADerniere)
                + RetourneFiltreEXCCA(Gtext_DocExclus_EXCCAPremiere, Gtext_DocExclus_EXCCADerniere));
                //Fin modif JX-AUD du 25/11/11
                //FIN AJOUT JX-XAD 11/05/2011
            end;
        }
        dataitem("G/L Entry Produits"; "G/L Entry")
        {
            DataItemTableView = sorting("Entry No.");

            trigger OnAfterGetRecord()
            begin
                if Amount = 0 then
                    CurrReport.SKIP();

                InsérerProduits();
            end;

            trigger OnPreDataItem()
            begin
                //DEBUT MODIF JX-XAD le 07/02/2011
                //SETFILTER("Posting Date",'..%2',Gdate_Compta);//filtre sur la data compta
                SETFILTER("Posting Date", '%1..%2', Gdate_Debut, Gdate_Compta);//filtre sur la data compta
                //FIN MODIF JX-XAD le 07/02/2011

                SETFILTER("G/L Entry Produits"."G/L Account No.", '7*');//filtre sur les comptes 7*

                //DEBUT AJOUT JX-XAD 11/05/2011 //Modif JX-AUD du 25/11/11
                //IF Gtext_DocExclus <> '' THEN
                //  SETFILTER("G/L Entry Produits"."Document No.",'<>cca004&<>excca00004');
                //SETFILTER("G/L Entry Produits"."Document No.",Gtext_DocExclus); //Modif JX-AUD du 25/11/11
                //Modif JX-AUD du 25/11/11
                SETFILTER("G/L Entry Produits"."Document No.", RetourneFiltreCCA(Gtext_DocExclus_CCAPremiere, Gtext_DocExclus_CCADerniere)
                + RetourneFiltreEXCCA(Gtext_DocExclus_EXCCAPremiere, Gtext_DocExclus_EXCCADerniere));
                //SETFILTER("G/L Entry Produits"."Document No.", RetourneFiltreCCA(Gtext_DocExclus_CCAPremiere, Gtext_DocExclus_CCADerniere));
                //SETFILTER("G/L Entry Produits"."Document No.", RetourneFiltreEXCCA(Gtext_DocExclus_EXCCAPremiere,Gtext_DocExclus_EXCCADerniere));
                //Fin modif JX-AUD du 25/11/11
                //FIN AJOUT JX-XAD 11/05/2011
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("Date de début"; Gdate_Debut)
                    {
                        ApplicationArea = All;
                    }
                    field("Date de fin (Date Compta.)"; Gdate_Compta)
                    {
                        ApplicationArea = All;
                    }
                    field("Période"; Gcode_ValeurAxe)
                    {
                        ApplicationArea = All;
                    }
                }
                group("Filtre Documents Exclus")
                {
                    field("Première CCA"; Gtext_DocExclus_CCAPremiere)
                    {
                        ApplicationArea = All;
                    }
                    field("Dernière CCA"; Gtext_DocExclus_CCADerniere)
                    {
                        ApplicationArea = All;
                    }
                    field("Première EXCCA"; Gtext_DocExclus_EXCCAPremiere)
                    {
                        ApplicationArea = All;
                    }
                    field("Dernière EXCCA"; Gtext_DocExclus_EXCCADerniere)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        Gint_Ligne := 0;
        Gdec_TotalCharges := 0;
        Gdec_TotalProduits := 0;
    end;

    trigger OnPostReport()
    begin
        if Gdec_TotalCharges <> 0 then begin
            //***************** Insertion ligne Total des charges comptabilisées d'avance  *****************
            Grec_FeuilleComptaCCA.INIT();

            //JX-ABE-08/12/2017
            //  Gint_Ligne += 10000;
            Gint_Ligne += 100;
            //Fin modif JX-ABE-08/12/2017

            Grec_FeuilleComptaCCA."Line No." := Gint_Ligne;
            Grec_FeuilleComptaCCA."Document No." := Gcode_NoCCA;
            Grec_FeuilleComptaCCA."External Document No." := '';
            Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."Source Code", Gcode_CodeJournal);
            Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."Account No.", '48601510');
            Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."Posting Date", Gdate_Compta);
            Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."Document Date", 0D);
            Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."Debit Amount", Gdec_TotalCharges);
            //IF Grec_Fournisseur.GET("Buy-from Vendor No.") THEN
            //  Grec_FeuilleComptaCCA.Description := PADSTR(Grec_Fournisseur.Name+'-'+Description,50);
            //Grec_FeuilleComptaCCA."Vendor No." := '';
            //Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."Gen. Bus. Posting Group",'');
            //Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."Gen. Prod. Posting Group",'');
            //Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."VAT Bus. Posting Group",'');
            //Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."VAT Prod. Posting Group",'');
            Grec_FeuilleComptaCCA.INSERT();
        end;

        if Gdec_TotalProduits <> 0 then begin
            //***************** Insertion ligne Total des charges comptabilisées d'avance  *****************
            Grec_FeuilleComptaCCA.INIT();

            //JX-ABE-08/12/2017
            // Gint_Ligne += 10000;
            Gint_Ligne += 100;
            //Fin modif-JX-ABE-08/12/2017

            Grec_FeuilleComptaCCA."Line No." := Gint_Ligne;
            Grec_FeuilleComptaCCA."Document No." := Gcode_NoCCA;
            Grec_FeuilleComptaCCA."External Document No." := '';
            Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."Source Code", Gcode_CodeJournal);
            Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."Account No.", '48701510');
            Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."Posting Date", Gdate_Compta);
            Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."Document Date", 0D);
            Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."Credit Amount", Gdec_TotalProduits);
            //IF Grec_Fournisseur.GET("Buy-from Vendor No.") THEN
            //  Grec_FeuilleComptaCCA.Description := PADSTR(Grec_Fournisseur.Name+'-'+Description,50);
            //Grec_FeuilleComptaCCA."Vendor No." := '';
            //Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."Gen. Bus. Posting Group",'');
            //Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."Gen. Prod. Posting Group",'');
            //Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."VAT Bus. Posting Group",'');
            //Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."VAT Prod. Posting Group",'');
            Grec_FeuilleComptaCCA.INSERT();
        end;
    end;

    trigger OnPreReport()
    begin
        Grec_FeuilleComptaCCA.SETRANGE("Journal Template Name", Grec_FeuilleComptaCCA."Journal Template Name");
        Grec_FeuilleComptaCCA.SETRANGE("Journal Batch Name", Grec_FeuilleComptaCCA."Journal Batch Name");
        if (Grec_FeuilleComptaCCA.COUNT > 0) then
            if not CONFIRM(Text002) then
                ERROR(Text003);
        Grec_FeuilleComptaCCA.DELETEALL();
        Grec_FeuilleComptaCCA.LOCKTABLE();
        Gcode_NoCCA := Grec_FeuilleComptaCCA."Document No.";
        Gcode_CodeJournal := Grec_FeuilleComptaCCA."Source Code";

        if Grec_GenJnlBatch.GET(Grec_FeuilleComptaCCA."Journal Template Name", Grec_FeuilleComptaCCA."Journal Batch Name") then
            if Grec_GenJnlBatch."No. Series" <> 'CCA' then
                ERROR(Text001);

        if Gcode_ValeurAxe = '' then
            ERROR(Text004);
    end;

    var
        GDimSetEntry: Record "Dimension Set Entry";
        Grec_EcritureCompta: Record "G/L Entry";
        Grec_GenJnlBatch: Record "Gen. Journal Batch";
        Grec_FeuilleComptaCCA: Record "Gen. Journal Line";
        Grec_NoSeries: Record "No. Series Line";
        Gtext_And: Boolean;
        Gcode_CodeJournal: Code[10];
        Gcode_AxeEcriture: Code[20];
        Gcode_CCA: Code[20];
        Gcode_DebutCCA: Code[20];
        Gcode_DebutEXTCCA: Code[20];
        Gcode_ExtCCA: Code[20];
        Gcode_FinCCA: Code[20];
        Gcode_FinEXTCCA: Code[20];
        Gcode_NoCCA: Code[20];
        Gcode_ValeurAxe: Code[20];
        Gdate_Compta: Date;
        Gdate_Debut: Date;
        Gdec_TotalCharges: Decimal;
        Gdec_TotalProduits: Decimal;
        Gint_CCADerniere: Integer;
        Gint_CCAPremiere: Integer;
        Gint_EXCCADerniere: Integer;
        Gint_EXCCAPremiere: Integer;
        Gint_Ligne: Integer;
        i: Integer;
        Text001: label 'This sheet is not intended to invoices not received';
        Text002: label 'This sheet is not empty.\\All data being entered will be replaced.\\Would you like to continue?';
        Text003: label 'Operation canceled';
        Text004: label 'please fill the ''Periode'' axis';
        Gtext_DocExclus_CCADerniere: Text[30];
        Gtext_DocExclus_CCAPremiere: Text[30];
        Gtext_DocExclus_EXCCADerniere: Text[30];
        Gtext_DocExclus_EXCCAPremiere: Text[30];
        Gtext_ExDocExclus: Text[250];

    procedure SetCCAJnlLine(FeuilleComptaCCA: Record "Gen. Journal Line")
    begin
        Grec_FeuilleComptaCCA := FeuilleComptaCCA;
    end;

    procedure "InsérerCharges"()
    begin

        if GDimSetEntry.GET("G/L Entry Charges"."Dimension Set ID", 'PERIODE') then
            Gcode_AxeEcriture := GDimSetEntry."Dimension Value Code"
        else
            Gcode_AxeEcriture := '';

        if Gcode_AxeEcriture > Gcode_ValeurAxe then begin
            //***************** Insertion ligne Charges *****************
            Grec_FeuilleComptaCCA.INIT();

            // JX-ABE-08/12/2017
            // Gint_Ligne += 10000;
            Gint_Ligne += 100;
            // JX-ABE-08/12/2017

            Grec_FeuilleComptaCCA."Line No." := Gint_Ligne;
            Grec_FeuilleComptaCCA."Document No." := Gcode_NoCCA;
            Grec_FeuilleComptaCCA."External Document No." := PADSTR("G/L Entry Charges"."Document No.", 20);
            Grec_FeuilleComptaCCA.VALIDATE("Source Code", Gcode_CodeJournal);
            Grec_FeuilleComptaCCA.VALIDATE("Account No.", "G/L Entry Charges"."G/L Account No.");
            Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."Posting Date", Gdate_Compta);
            Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."Document Date", "G/L Entry Charges"."Posting Date");
            if "G/L Entry Charges"."Credit Amount" <> 0 then
                Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."Debit Amount", "G/L Entry Charges"."Credit Amount")
            else
                Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."Credit Amount", "G/L Entry Charges"."Debit Amount");
            Gdec_TotalCharges += Grec_FeuilleComptaCCA."Credit Amount" - Grec_FeuilleComptaCCA."Debit Amount";

            //DEBUT MODIF JX-XAD le 07/02/2011
            if "G/L Entry Charges"."BC6_Vendor No." <> '' then
                Grec_FeuilleComptaCCA."BC6_Vendor No." := "G/L Entry Charges"."BC6_Vendor No."
            else
                Grec_FeuilleComptaCCA."BC6_Vendor No." := "G/L Entry Charges"."Source No.";
            //FIN MODIF JX-XAD le 07/02/2011

            Grec_FeuilleComptaCCA.Description := "G/L Entry Charges".Description;

            Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."Gen. Bus. Posting Group", '');
            Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."Gen. Prod. Posting Group", '');
            Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."VAT Bus. Posting Group", '');
            Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."VAT Prod. Posting Group", '');
            Grec_FeuilleComptaCCA."Dimension Set ID" := "G/L Entry Charges"."Dimension Set ID";
            Grec_FeuilleComptaCCA.INSERT();
        end;
    end;

    procedure "InsérerProduits"()
    begin

        if GDimSetEntry.GET("G/L Entry Produits"."Dimension Set ID", 'PERIODE') then
            Gcode_AxeEcriture := GDimSetEntry."Dimension Value Code"
        else
            Gcode_AxeEcriture := '';

        if Gcode_AxeEcriture > Gcode_ValeurAxe then begin
            //***************** Insertion ligne Produit *****************
            Grec_FeuilleComptaCCA.INIT();

            // Gint_Ligne += 10000;
            //JX-ABE-08/12/2017
            Gint_Ligne += 100;
            //Fin-Modif-JX-ABE-08/12/2017

            Grec_FeuilleComptaCCA."Line No." := Gint_Ligne;
            Grec_FeuilleComptaCCA."Document No." := Gcode_NoCCA;
            Grec_FeuilleComptaCCA."External Document No." := PADSTR("G/L Entry Produits"."Document No.", 20);
            Grec_FeuilleComptaCCA.VALIDATE("Source Code", Gcode_CodeJournal);
            Grec_FeuilleComptaCCA.VALIDATE("Account No.", "G/L Entry Produits"."G/L Account No.");
            Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."Posting Date", Gdate_Compta);
            Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."Document Date", "G/L Entry Produits"."Posting Date");
            if "G/L Entry Produits"."Credit Amount" <> 0 then
                Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."Debit Amount", "G/L Entry Produits"."Credit Amount")
            else
                Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."Credit Amount", "G/L Entry Produits"."Debit Amount");
            Gdec_TotalProduits += Grec_FeuilleComptaCCA."Debit Amount" - Grec_FeuilleComptaCCA."Credit Amount";

            //DEBUT MODIF JX-XAD le 07/02/2011
            if "G/L Entry Produits"."BC6_Customer No." <> '' then
                Grec_FeuilleComptaCCA."BC6_Customer No." := "G/L Entry Produits"."BC6_Customer No."
            else
                Grec_FeuilleComptaCCA."BC6_Customer No." := "G/L Entry Produits"."Source No.";
            //FIN MODIF JX-XAD le 07/02/2011

            Grec_FeuilleComptaCCA.Description := "G/L Entry Produits".Description;

            Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."Gen. Bus. Posting Group", '');
            Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."Gen. Prod. Posting Group", '');
            Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."VAT Bus. Posting Group", '');
            Grec_FeuilleComptaCCA.VALIDATE(Grec_FeuilleComptaCCA."VAT Prod. Posting Group", '');
            Grec_FeuilleComptaCCA."Dimension Set ID" := "G/L Entry Produits"."Dimension Set ID";
            Grec_FeuilleComptaCCA.INSERT();
        end;
    end;

    procedure CalculeExtCCA()
    begin
        //DEBUT AJOUT JX-XAD 11/05/2011
        /*
        EVALUATE(Gdate_DebutAnneeCompta,'01/01/'+FORMAT(DATE2DWY(Gdate_Compta,3)));
        EVALUATE(Gdate_FinAnneeCompta,'31/12/'+FORMAT(DATE2DWY(Gdate_Compta,3)));

        Grec_EcritureCompta.RESET;

        Grec_EcritureCompta.SETFILTER(Grec_EcritureCompta."Posting Date",'>=%1&<=%2',Gdate_DebutAnneeCompta,Gdate_FinAnneeCompta);
        Grec_EcritureCompta.SETFILTER(Grec_EcritureCompta."Document No.",'EXCCA*');
        IF Grec_EcritureCompta.FIND('-') THEN
          Gcode_ExtCCA := Grec_EcritureCompta."Document No."
        ELSE
          Gcode_ExtCCA := '';

        RequestOptionsForm.No_ExtCCA.UPDATE;
        */
        //FIN AJOUT JX-XAD 11/05/2011
    end;

    procedure Init_CCA()
    begin
        //DEBUT AJOUT JX-XAD 11/05/2011

        Gcode_DebutEXTCCA := '';
        Gcode_FinEXTCCA := '';
        if Grec_NoSeries.GET('EXTCCA', 100) then begin
            Gcode_DebutEXTCCA := Grec_NoSeries."Starting No.";
            Gcode_FinEXTCCA := Grec_NoSeries."Ending No.";
        end;
        Gcode_DebutCCA := '';
        Gcode_FinCCA := '';
        if Grec_NoSeries.GET('CCA', 100) then begin
            Gcode_DebutCCA := Grec_NoSeries."Starting No.";
            Gcode_FinCCA := Grec_NoSeries."Ending No.";
        end;

        Grec_EcritureCompta.RESET();
        Grec_EcritureCompta.SETFILTER(Grec_EcritureCompta."Posting Date", '>=%1&<=%2', Gdate_Debut, Gdate_Compta);
        Grec_EcritureCompta.SETFILTER(Grec_EcritureCompta."Document No.", COPYSTR(Gcode_DebutCCA, 1, 4) + '*');
        if Grec_EcritureCompta.FIND('+') then
            Gcode_CCA := Grec_EcritureCompta."Document No."
        else
            Gcode_CCA := '';

        Grec_EcritureCompta.SETFILTER(Grec_EcritureCompta."Document No.", COPYSTR(Gcode_DebutEXTCCA, 1, 6) + '*');
        if Grec_EcritureCompta.FIND('+') then
            Gcode_ExtCCA := Grec_EcritureCompta."Document No."
        else
            Gcode_ExtCCA := '';

        Gtext_ExDocExclus := '<>';
        if (Gcode_CCA <> '') then begin
            Gtext_ExDocExclus += Gcode_CCA;
            if (Gcode_ExtCCA <> '') then begin
                Gtext_ExDocExclus += '&<>' + Gcode_ExtCCA;
            end;
        end else
            if (Gcode_ExtCCA <> '') then begin
                Gtext_ExDocExclus += Gcode_ExtCCA;
            end else begin
                Gtext_ExDocExclus := '';
            end;

        //RequestOptionsForm.No_CCA.UPDATE; //Modif JX-AUD du 25/11/11

        //FIN AJOUT JX-XAD 11/05/2011
    end;

    procedure RetourneFiltreCCA(CCAPremiere: Text[30]; CCADerniere: Text[30]) FiltreCCA: Text[1024]
    begin
        //Modif JX-AUD du 25/11/11
        //CCAPremiere := COPYSTR(CCAPremiere,4,5);
        //CCADerniere := COPYSTR(CCADerniere,4,5);
        FiltreCCA := '';
        FiltreCCA := '<>';
        i := 0;
        Gtext_And := false;

        if ((CCAPremiere = '') and (CCADerniere = '')) then begin
            FiltreCCA := '';
            Gtext_And := false;
            //CurrReport.BREAK;
        end else begin
            if (EVALUATE(Gint_CCAPremiere, CCAPremiere)) and (EVALUATE(Gint_CCADerniere, CCADerniere)) then begin
                //MESSAGE(FORMAT(Gint_CCAPremiere) + ' ' +FORMAT(Gint_CCADerniere));

                if Gint_CCAPremiere < Gint_CCADerniere then begin
                    for i := Gint_CCAPremiere to Gint_CCADerniere do begin
                        if not (i = Gint_CCADerniere) then begin
                            FiltreCCA += 'CCA' + RetourneNbZero(STRLEN(FORMAT(i))) + FORMAT(i) + '&<>';
                        end else begin
                            FiltreCCA += 'CCA' + RetourneNbZero(STRLEN(FORMAT(i))) + FORMAT(i) + '';
                        end;
                    end;
                end;

                if Gint_CCAPremiere > Gint_CCADerniere then begin
                    for i := Gint_CCADerniere to Gint_CCAPremiere do begin
                        if not (i = Gint_CCAPremiere) then begin
                            FiltreCCA += 'CCA' + RetourneNbZero(STRLEN(FORMAT(i))) + FORMAT(i) + '&<>';
                        end else begin
                            FiltreCCA += 'CCA' + RetourneNbZero(STRLEN(FORMAT(i))) + FORMAT(i) + '';
                        end;
                    end;
                end;

                if Gint_CCAPremiere = Gint_CCADerniere then begin
                    FiltreCCA += 'CCA' + RetourneNbZero(STRLEN(FORMAT(Gint_CCAPremiere))) + FORMAT(Gint_CCAPremiere) + '';
                end;

                Gtext_And := true;
            end;
        end;
        //Fin modif JX-AUD du 25/11/11
    end;

    procedure RetourneFiltreEXCCA(EXCCAPremiere: Text[30]; EXCCADerniere: Text[30]) FiltreEXCCA: Text[1024]
    begin
        //Modif JX-AUD du 25/11/11
        //EXCCAPremiere := COPYSTR(EXCCAPremiere,6,5);
        //EXCCADerniere := COPYSTR(EXCCADerniere,6,5);
        FiltreEXCCA := '';
        if Gtext_And = true then begin
            FiltreEXCCA := '&<>';
        end else
            FiltreEXCCA := '<>';

        i := 0;
        if ((EXCCAPremiere = '') and (EXCCADerniere = '')) then begin
            FiltreEXCCA := '';
            //CurrReport.SKIP;
        end else begin
            if (EVALUATE(Gint_EXCCAPremiere, EXCCAPremiere)) and (EVALUATE(Gint_EXCCADerniere, EXCCADerniere)) then begin
                //MESSAGE(FORMAT(Gint_EXCCAPremiere) + ' ' +FORMAT(Gint_EXCCADerniere));
                if Gint_EXCCAPremiere < Gint_EXCCADerniere then begin
                    for i := Gint_EXCCAPremiere to Gint_EXCCADerniere do begin
                        if not (i = Gint_EXCCADerniere) then begin
                            FiltreEXCCA += 'EXCCA' + RetourneNbZero(STRLEN(FORMAT(i))) + FORMAT(i) + '&<>';
                        end else begin
                            FiltreEXCCA += 'EXCCA' + RetourneNbZero(STRLEN(FORMAT(i))) + FORMAT(i) + '';
                        end;
                    end;
                end;

                if Gint_EXCCAPremiere > Gint_EXCCADerniere then begin
                    for i := Gint_EXCCADerniere to Gint_EXCCAPremiere do begin
                        if not (i = Gint_EXCCAPremiere) then begin
                            FiltreEXCCA += 'EXCCA' + RetourneNbZero(STRLEN(FORMAT(i))) + FORMAT(i) + '&<>';
                        end else begin
                            FiltreEXCCA += 'EXCCA' + RetourneNbZero(STRLEN(FORMAT(i))) + FORMAT(i) + '';
                        end;
                    end;
                end;

                if Gint_EXCCAPremiere = Gint_EXCCADerniere then begin
                    FiltreEXCCA += 'EXCCA' + RetourneNbZero(STRLEN(FORMAT(Gint_EXCCAPremiere))) + FORMAT(Gint_EXCCAPremiere) + '';
                end;
            end;
        end;
        //Fin modif JX-AUD du 25/11/11
    end;

    procedure RetourneNbZero(Gint_Nb: Integer) NbZero: Text[4]
    begin
        //Modif JX-AUD du 25/11/11
        case Gint_Nb of
            1:
                NbZero := '0000';
            2:
                NbZero := '000';
            3:
                NbZero := '00';
            4:
                NbZero := '0';
            5:
                NbZero := '';
        end;
        //Fin modif JX-AUD du 25/11/11
    end;
}
