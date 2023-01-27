xmlport 50025 "BC6_Yz Pch. Inv.&CrM. Imp. Aut"
{
    Caption = 'Yooz Purch. Inv.&CrM. Imp. Aut', Comment = 'FRA="Yooz import facture & Avoir achat Automatique"';
    Format = VariableText;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    UseRequestPage = false;
    FileName = '*.csv';
    Direction = Import;
    schema
    {
        textelement(root)
        {
            tableelement("Yooz"; Integer)
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
                textelement(Gtext_Champ3)
                {
                }
                textelement(Gtext_Champ4)
                {
                }
                textelement(Gtext_Champ5)
                {
                }
                textelement(Gtext_Champ6)
                {
                }
                textelement(Gtext_Champ7)
                {
                }
                textelement(Gtext_Champ8)
                {
                }
                textelement(Gtext_Champ9)
                {
                }
                textelement(Gtext_Champ10)
                {
                }
                textelement(Gtext_Champ11)
                {
                }
                textelement(Gtext_Champ12)
                {
                }
                trigger OnBeforeInsertRecord()
                BEGIN
                    Gint_Compteur := Gint_Compteur + 1;
                    IF (Gint_Compteur > 1) THEN BEGIN
                        CompName := '';
                        CASE Gtext_Champ1 OF
                            'VSCG':
                                CompName := 'VFEC';
                            'AGVSC':
                                CompName := 'Agence';
                            'VSC':
                                CompName := 'VSC';
                            'VSCT':
                                CompName := 'VSCT';
                        END;

                        IF CompName <> '' THEN BEGIN
                            Grec_PurchaseHeader.CHANGECOMPANY(CompName);
                            Grec_PurchaseHeader2.CHANGECOMPANY(CompName);
                            PurchSetup.CHANGECOMPANY(CompName);
                            PurchSetup.GET();
                            NoSeries.CHANGECOMPANY(CompName);
                            LastNoSeriesLine.CHANGECOMPANY(CompName);
                            //On test si la facture Yooz aurait d‚j… ‚t‚ int‚gr‚e
                            Grec_PurchaseHeader2.RESET();
                            Grec_PurchaseHeader2.SETFILTER(Grec_PurchaseHeader2."BC6_Yooz No.", Gtext_Champ9);
                            IF NOT Grec_PurchaseHeader2.FINDFIRST() THEN BEGIN //Si la facture n'y est pas on l'intŠgre
                                NbOk += 1;
                                //Cr‚ation de l'entˆte de la facture achat
                                Grec_PurchaseHeader.INIT();
                                // JX-YOOZ2 13/11/15 Ajout champ document type Facture ou Avoir
                                IF UPPERCASE(Gtext_Champ12) = 'FACTURE' THEN BEGIN
                                    Grec_PurchaseHeader.VALIDATE("Document Type", Grec_PurchaseHeader."Document Type"::Invoice);
                                    Grec_PurchaseHeader."Vendor Invoice No." := Gtext_Champ6; //Nø facture fournisseur
                                    Grec_PurchaseHeader."No." := '';
                                    EVALUATE(Grec_PostingDate, Gtext_Champ3); //Date comptable
                                    Grec_PurchaseHeader."Posting Date" := Grec_PostingDate;
                                    Grec_PurchaseHeader."No. Series" := PurchSetup."Invoice Nos.";
                                    InitSeries(PurchSetup."Invoice Nos.", '', Grec_PurchaseHeader."Posting Date",
                                                                           Grec_PurchaseHeader."No.", Grec_PurchaseHeader."No. Series");
                                END ELSE BEGIN
                                    Grec_PurchaseHeader.VALIDATE("Document Type", Grec_PurchaseHeader."Document Type"::"Credit Memo");
                                    Grec_PurchaseHeader."Vendor Cr. Memo No." := Gtext_Champ6; //Nø avoir fournisseur
                                    Grec_PurchaseHeader."No." := '';
                                    EVALUATE(Grec_PostingDate, Gtext_Champ3); //Date comptable
                                    Grec_PurchaseHeader."Posting Date" := Grec_PostingDate;
                                    Grec_PurchaseHeader."No. Series" := PurchSetup."Credit Memo Nos.";
                                    InitSeries(PurchSetup."Credit Memo Nos.", '', Grec_PurchaseHeader."Posting Date",
                                                                           Grec_PurchaseHeader."No.", Grec_PurchaseHeader."No. Series");
                                END;
                                Grec_PurchaseHeader."Buy-from Vendor No." := Gtext_Champ2;  //entite facturante/cpte feur
                                Grec_PurchaseHeader.INSERT();

                                EVALUATE(Grec_DocumentDate, Gtext_Champ4); //Date document
                                Grec_PurchaseHeader."Document Date" := Grec_DocumentDate;

                                IF (STRPOS(Gtext_Champ5, 'GROUPEVSC\') = 0) OR (STRPOS(Gtext_Champ5, '\') = 0) THEN
                                    Gtext_Champ5 := 'GROUPEVSC\' + Gtext_Champ5;
                                Grec_PurchaseHeader."Assigned User ID" := Gtext_Champ5; //Code collaborateur affect‚

                                Grec_PurchaseHeader."Vendor Invoice No." := Gtext_Champ6; //Nø facture fournisseur
                                EVALUATE(Gdec_AmoutExlVAT, Gtext_Champ7); //Montant HT
                                Grec_PurchaseHeader."BC6_Register amount" := Gdec_AmoutExlVAT;
                                Grec_PurchaseHeader."BC6_BC No." := Gtext_Champ8;  //Nø bon de commande
                                Grec_PurchaseHeader."BC6_Yooz No." := Gtext_Champ9; //Nø Yooz
                                Grec_PurchaseHeader."BC6_Yooz Token link" := Gtext_Champ10; //Lien Token Yooz
                                EVALUATE(Grec_ReceiptInvoiceDate, Gtext_Champ11); //Daten de scan yooz
                                Grec_PurchaseHeader."BC6_Invoice receipt date" := Grec_ReceiptInvoiceDate;
                                Grec_PurchaseHeader.MODIFY();
                            END;
                        END ELSE BEGIN
                            NbOComp += 1;
                            IF STRPOS(OComp, Gtext_Champ1) = 0 THEN
                                IF OComp = '' THEN
                                    OComp := Gtext_Champ1
                                ELSE
                                    OComp := OComp + '/' + Gtext_Champ1;
                        END;
                    END;
                END;
            }
        }
    }
    VAR
        NoSeries: Record "No. Series";
        LastNoSeriesLine: Record "No. Series Line";
        Grec_PurchaseHeader: Record "Purchase Header";
        Grec_PurchaseHeader2: Record "Purchase Header";
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesCodeV: Code[10];
        TryNoSeriesCode: Code[10];
        WarningNoSeriesCode: Code[10];
        Grec_DocumentDate: Date;
        Grec_PostingDate: Date;
        Grec_ReceiptInvoiceDate: Date;
        Gdec_AmoutExlVAT: Decimal;
        Gint_Compteur: Integer;
        NbOComp: Integer;
        NbOk: Integer;
        Text000: Label '"You may not enter numbers manually. "', Comment = 'FRA="Vous ne souhaitez peut-être pas entrer les numéros manuellement."';
        Text001: Label 'If you want to enter numbers manually, please activate %1 in %2 %3.', Comment = 'FRA="Si vous souhaitez entrer les numéros manuellement, vous devez activer %1 dans %2 %3."';
        Text002: Label '"It is not possible to assign numbers automatically. "', Comment = 'FRA="Il n''est pas possible d''attribuer automatiquement des numéros. "';
        Text003: Label 'If you want the program to assign numbers automatically, please activate %1 in %2 %3.', Comment = 'FRA="Si vous souhaitez que le programme attribue automatiquement des numéros, vous devez activer %1 %2 dans %3."';
        Text004: Label 'You cannot assign new numbers from the number series %1 on %2.', Comment = 'FRA="Vous ne pouvez pas attribuer de nouveaux numéros à partir de la souche de numéros %1 dans %2."';
        Text005: Label 'You cannot assign new numbers from the number series %1.', Comment = 'FRA="Vous ne pouvez pas attribuer de nouveaux numéros à partir de la souche de numéros %1."';
        Text006: Label 'You cannot assign new numbers from the number series %1 on a date before %2.', Comment = 'FRA="Vous ne pouvez pas attribuer de nouveaux numéros à partir de la souche de numéros %1 pour une date antérieure au %2."';
        Text007: Label 'You cannot assign numbers greater than %1 from the number series %2.', Comment = 'FRA="Vous ne pouvez pas attribuer de numéros supérieurs à %1 à partir de la souche de numéros %2."';
        Text010: Label 'The number %1 cannot be extended to more than 20 characters.', Comment = 'FRA="Le numéro %1 ne peut pas être étendu à plus de 20 caractères."';
        Text020: Label 'Yooz Invoices are integrated', Comment = 'FRA="%1 facture(s) Yooz importée(s)."';
        Text021: Label '%1 imported Yooz invoice (s). \%2 invoice (s) to import into companies %3.', Comment = 'FRA="%1 facture(s) Yooz importée(s).\%2 facture(s) à importer dans les sociétés %3."';
        CompName: Text;
        OComp: Text;

    trigger OnPostXMLport()
    BEGIN
        IF GUIALLOWED THEN
            IF NbOComp = 0 THEN
                MESSAGE(STRSUBSTNO(Text020, NbOk))
            ELSE
                MESSAGE(STRSUBSTNO(Text021, NbOk, NbOComp, OComp));
    END;

    PROCEDURE InitSeries(DefaultNoSeriesCode: Code[10]; OldNoSeriesCode: Code[10]; NewDate: Date; VAR NewNo: Code[20]; VAR NewNoSeriesCode: Code[10]);
    BEGIN
        IF NewNo = '' THEN BEGIN
            NoSeries.GET(DefaultNoSeriesCode);
            IF NOT NoSeries."Default Nos." THEN
                ERROR(
                  Text002 +
                  Text003,
                  NoSeries.FIELDCAPTION("Default Nos."), NoSeries.TABLECAPTION, NoSeries.Code);
            IF OldNoSeriesCode <> '' THEN BEGIN
                NoSeriesCodeV := DefaultNoSeriesCode;
                FilterSeries();
                NoSeries.Code := OldNoSeriesCode;
                IF NOT NoSeries.FIND() THEN
                    NoSeries.GET(DefaultNoSeriesCode);
            END;
            NewNo := GetNextNo(NoSeries.Code, NewDate, TRUE);
            NewNoSeriesCode := NoSeries.Code;
        END ELSE
            TestManual(DefaultNoSeriesCode);
    END;

    LOCAL PROCEDURE FilterSeries();
    VAR
        NoSeriesRelationship: Record "No. Series Relationship";
    BEGIN
        NoSeries.RESET();
        NoSeriesRelationship.SETRANGE(Code, NoSeriesCodeV);
        IF NoSeriesRelationship.FINDSET() THEN
            REPEAT
                NoSeries.Code := NoSeriesRelationship."Series Code";
                NoSeries.MARK := TRUE;
            UNTIL NoSeriesRelationship.NEXT() = 0;
        NoSeries.GET(NoSeriesCodeV);
        NoSeries.MARK := TRUE;
        NoSeries.MARKEDONLY := TRUE;
    END;

    PROCEDURE GetNextNo(NoSeriesCode: Code[10]; SeriesDate: Date; ModifySeries: Boolean): Code[20];
    BEGIN
        EXIT(GetNextNo3(NoSeriesCode, SeriesDate, ModifySeries, FALSE));
    END;

    PROCEDURE GetNextNo3(NoSeriesCode: Code[10]; SeriesDate: Date; ModifySeries: Boolean; NoErrorsOrWarnings: Boolean): Code[20];
    VAR
        NoSeriesLine: Record "No. Series Line";
    BEGIN
        IF SeriesDate = 0D THEN
            SeriesDate := WORKDATE();

        IF ModifySeries OR (LastNoSeriesLine."Series Code" = '') THEN BEGIN
            IF ModifySeries THEN
                NoSeriesLine.LOCKTABLE();
            NoSeries.GET(NoSeriesCode);
            SetNoSeriesLineFilter(NoSeriesLine, NoSeriesCode, SeriesDate);
            IF NOT NoSeriesLine.FINDFIRST() THEN BEGIN
                IF NoErrorsOrWarnings THEN
                    EXIT('');
                NoSeriesLine.SETRANGE("Starting Date");
                IF NOT NoSeriesLine.ISEMPTY THEN
                    ERROR(
                      Text004,
                      NoSeriesCode, SeriesDate);
                ERROR(
                  Text005,
                  NoSeriesCode);
            END;
        END ELSE
            NoSeriesLine := LastNoSeriesLine;

        IF NoSeries."Date Order" AND (SeriesDate < NoSeriesLine."Last Date Used") THEN BEGIN
            IF NoErrorsOrWarnings THEN
                EXIT('');
            ERROR(
              Text006,
              NoSeries.Code, NoSeriesLine."Last Date Used");
        END;
        NoSeriesLine."Last Date Used" := SeriesDate;
        IF NoSeriesLine."Last No. Used" = '' THEN BEGIN
            IF NoErrorsOrWarnings AND (NoSeriesLine."Starting No." = '') THEN
                EXIT('');
            NoSeriesLine.TESTFIELD("Starting No.");
            NoSeriesLine."Last No. Used" := NoSeriesLine."Starting No.";
        END ELSE
            IF NoSeriesLine."Increment-by No." <= 1 THEN
                NoSeriesLine."Last No. Used" := INCSTR(NoSeriesLine."Last No. Used")
            ELSE
                IncrementNoText(NoSeriesLine."Last No. Used", NoSeriesLine."Increment-by No.");
        IF (NoSeriesLine."Ending No." <> '') AND
           (NoSeriesLine."Last No. Used" > NoSeriesLine."Ending No.")
        THEN BEGIN
            IF NoErrorsOrWarnings THEN
                EXIT('');
            ERROR(
              Text007,
              NoSeriesLine."Ending No.", NoSeriesCode);
        END;
        IF (NoSeriesLine."Ending No." <> '') AND
           (NoSeriesLine."Warning No." <> '') AND
           (NoSeriesLine."Last No. Used" >= NoSeriesLine."Warning No.") AND
           (NoSeriesCode <> WarningNoSeriesCode) AND
           (TryNoSeriesCode = '')
        THEN BEGIN
            IF NoErrorsOrWarnings THEN
                EXIT('');
            WarningNoSeriesCode := NoSeriesCode;
            MESSAGE(
              Text007,
              NoSeriesLine."Ending No.", NoSeriesCode);
        END;
        NoSeriesLine.VALIDATE(Open);

        IF ModifySeries THEN
            NoSeriesLine.MODIFY()
        ELSE
            LastNoSeriesLine := NoSeriesLine;
        EXIT(NoSeriesLine."Last No. Used");
    END;

    PROCEDURE TestManual(DefaultNoSeriesCode: Code[10]);
    BEGIN
        IF DefaultNoSeriesCode <> '' THEN BEGIN
            NoSeries.GET(DefaultNoSeriesCode);
            IF NOT NoSeries."Manual Nos." THEN
                ERROR(
                  Text000 +
                  Text001,
                  NoSeries.FIELDCAPTION("Manual Nos."), NoSeries.TABLECAPTION, NoSeries.Code);
        END;
    END;

    PROCEDURE SetNoSeriesLineFilter(VAR NoSeriesLine: Record "No. Series Line"; NoSeriesCode: Code[10]; StartDate: Date);
    BEGIN
        IF StartDate = 0D THEN
            StartDate := WORKDATE();
        NoSeriesLine.RESET();
        NoSeriesLine.SETCURRENTKEY("Series Code", "Starting Date");
        NoSeriesLine.SETRANGE("Series Code", NoSeriesCode);
        NoSeriesLine.SETRANGE("Starting Date", 0D, StartDate);
        IF NoSeriesLine.FINDLAST() THEN BEGIN
            NoSeriesLine.SETRANGE("Starting Date", NoSeriesLine."Starting Date");
            NoSeriesLine.SETRANGE(Open, TRUE);
        END;
    END;

    LOCAL PROCEDURE IncrementNoText(VAR No: Code[20]; IncrementByNo: Decimal);
    VAR
        DecimalNo: Decimal;
        EndPos: Integer;
        StartPos: Integer;
        NewNo: Text[30];
    BEGIN
        GetIntegerPos(No, StartPos, EndPos);
        EVALUATE(DecimalNo, COPYSTR(No, StartPos, EndPos - StartPos + 1));
        NewNo := FORMAT(DecimalNo + IncrementByNo, 0, 1);
        ReplaceNoText(No, NewNo, 0, StartPos, EndPos);
    END;

    LOCAL PROCEDURE GetIntegerPos(No: Code[20]; VAR StartPos: Integer; VAR EndPos: Integer);
    VAR
        IsDigit: Boolean;
        i: Integer;
    BEGIN
        StartPos := 0;
        EndPos := 0;
        IF No <> '' THEN BEGIN
            i := STRLEN(No);
            REPEAT
                IsDigit := No[i] IN ['0' .. '9'];
                IF IsDigit THEN BEGIN
                    IF EndPos = 0 THEN
                        EndPos := i;
                    StartPos := i;
                END;
                i := i - 1;
            UNTIL (i = 0) OR (StartPos <> 0) AND NOT IsDigit;
        END;
    END;

    LOCAL PROCEDURE ReplaceNoText(VAR No: Code[20]; NewNo: Code[20]; FixedLength: Integer; StartPos: Integer; EndPos: Integer);
    VAR
        EndNo: Code[20];
        StartNo: Code[20];
        ZeroNo: Code[20];
        NewLength: Integer;
        OldLength: Integer;
    BEGIN
        IF StartPos > 1 THEN
            StartNo := COPYSTR(No, 1, StartPos - 1);
        IF EndPos < STRLEN(No) THEN
            EndNo := COPYSTR(No, EndPos + 1);
        NewLength := STRLEN(NewNo);
        OldLength := EndPos - StartPos + 1;
        IF FixedLength > OldLength THEN
            OldLength := FixedLength;
        IF OldLength > NewLength THEN
            ZeroNo := PADSTR('', OldLength - NewLength, '0');
        IF STRLEN(StartNo) + STRLEN(ZeroNo) + STRLEN(NewNo) + STRLEN(EndNo) > 20 THEN
            ERROR(
              Text010,
              No);
        No := StartNo + ZeroNo + NewNo + EndNo;
    END;
}


