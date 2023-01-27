report 50017 "Draft recapitulation Vir. Man."
{
    // CREATION JDD-XD 03 Octobre 2008
    // Créée à partir du report 10869
    // 
    // MODIF JDD-XD 09/02/2009
    // Calcul de la somme au niveau du TransHeader
    // 
    // MODIF JDD-XD le 09/03/2009
    // Correction bug Microsoft suite appel support partnersource :
    // changement de la variable dans le TransHeader et le transfooter (DraftAmount)
    // 
    // -------------------------------------- V1.2 --------------------------------------
    // 
    // DEBUT MODIF JX-XAD 19/05/2010
    // Ajout du flag "RIB modifié" qui doit indiquer si le RIB a été modifié depuis le dernier virement
    // 
    // // modif LAB du 26/05/2010
    // // remplacement de oui par date sur modif RIB
    // 
    // //Modif JX-XAD 22/11/2010
    // Gtxt_IBAN et Gtxt_SWIFT sont maintenant initialisés à vide
    // 
    // //Modif JX-AUD du 28/01/14
    // //Changement du Code/pays Region à la place du nom de la banque
    // 
    // //JX-AUD du 11/02/14
    // //Modification pour aller rechercher l'IBAN lorsque le compte bancaire n'est pas celui par défaut.
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/DraftrecapitulationVirMan.rdl';
    Caption = 'Draft recapitulation', Comment = 'FRA="Avis de virement Manuel"';

    dataset
    {
        dataitem("Payment Lines1"; "Payment Line")
        {
            DataItemTableView = SORTING("No.", "Line No.");
            MaxIteration = 1;
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(Payment_Lines1_No_; "No.")
            {
            }
            column(Payment_Lines1_Line_No_; "Line No.")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(CompanyInformation_Picture; CompanyInformation.Picture)
                    {
                    }
                    column(PaymtHeader__No__; PaymtHeader."No.")
                    {
                    }
                    column(STRSUBSTNO_Text001_CopyText_; STRSUBSTNO(Text001, CopyText))
                    {
                    }
                    column(CompanyAddr_1_; CompanyAddr[1])
                    {
                    }
                    column(CompanyAddr_2_; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr_3_; CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr_4_; CompanyAddr[4])
                    {
                    }
                    column(CompanyAddr_5_; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr_6_; CompanyAddr[6])
                    {
                    }
                    column(CompanyInformation__Phone_No__; CompanyInformation."Phone No.")
                    {
                    }
                    column(CompanyInformation__Fax_No__; CompanyInformation."Fax No.")
                    {
                    }
                    column(CompanyInformation__VAT_Registration_No__; CompanyInformation."VAT Registration No.")
                    {
                    }
                    column(FORMAT_PostingDate_0_4_; PostingDate)
                    {
                    }
                    column(BankAccountAddr_4_; BankAccountAddr[4])
                    {
                    }
                    column(BankAccountAddr_5_; BankAccountAddr[5])
                    {
                    }
                    column(BankAccountAddr_6_; BankAccountAddr[6])
                    {
                    }
                    column(BankAccountAddr_7_; BankAccountAddr[7])
                    {
                    }
                    column(BankAccountAddr_3_; BankAccountAddr[3])
                    {
                    }
                    column(BankAccountAddr_2_; BankAccountAddr[2])
                    {
                    }
                    column(BankAccountAddr_1_; BankAccountAddr[1])
                    {
                    }
                    column(PrintCurrencyCode; PrintCurrencyCode())
                    {
                    }
                    column(PaymtHeader__Bank_Branch_No__; PaymtHeader."Bank Branch No.")
                    {
                    }
                    column(PaymtHeader__Agency_Code_; PaymtHeader."Agency Code")
                    {
                    }
                    column(PaymtHeader__Bank_Account_No__; PaymtHeader."Bank Account No.")
                    {
                    }
                    column(PaymtHeader__RIB_Key_; PaymtHeader."RIB Key")
                    {
                    }
                    column(PaymtHeader__National_Issuer_No__; PaymtHeader."National Issuer No.")
                    {
                    }
                    column(PaymtHeader__No__Caption; PaymtHeader__No__CaptionLbl)
                    {
                    }
                    column(CompanyInformation__Phone_No__Caption; CompanyInformation__Phone_No__CaptionLbl)
                    {
                    }
                    column(CompanyInformation__Fax_No__Caption; CompanyInformation__Fax_No__CaptionLbl)
                    {
                    }
                    column(CompanyInformation__VAT_Registration_No__Caption; CompanyInformation__VAT_Registration_No__CaptionLbl)
                    {
                    }
                    column(PrintCurrencyCodeCaption; PrintCurrencyCodeCaptionLbl)
                    {
                    }
                    column(PaymtHeader__Bank_Branch_No__Caption; PaymtHeader__Bank_Branch_No__CaptionLbl)
                    {
                    }
                    column(PaymtHeader__Agency_Code_Caption; PaymtHeader__Agency_Code_CaptionLbl)
                    {
                    }
                    column(PaymtHeader__Bank_Account_No__Caption; PaymtHeader__Bank_Account_No__CaptionLbl)
                    {
                    }
                    column(PaymtHeader__RIB_Key_Caption; PaymtHeader__RIB_Key_CaptionLbl)
                    {
                    }
                    column(PaymtHeader__National_Issuer_No__Caption; PaymtHeader__National_Issuer_No__CaptionLbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(Vendor_NameCaption; Vendor_NameCaptionLbl)
                    {
                    }
                    column(ABS_Amount_Caption; ABS_Amount_CaptionLbl)
                    {
                    }
                    column(Bank_AccountCaption; Bank_AccountCaptionLbl)
                    {
                    }
                    column(IBANCaption; IBANCaptionLbl)
                    {
                    }
                    column(Swift_CodeCaption; Swift_CodeCaptionLbl)
                    {
                    }
                    column(RIB_IBAN_updatedCaption1; RIB_IBAN_updated1CaptionLbl)
                    {
                    }
                    column(RIB_IBAN_updatedCaption2; RIB_IBAN_updated2CaptionLbl)
                    {
                    }
                    column(ReportCaption; ReportCaptionLbl)
                    {
                    }
                    column(ReportCaption_Control1120015; ReportCaption_Control1120015Lbl)
                    {
                    }
                    column(TotalCaption; TotalCaptionLbl)
                    {
                    }
                    column(Done_at__Caption; Done_at__CaptionLbl)
                    {
                    }
                    column(On__Caption; On__CaptionLbl)
                    {
                    }
                    column(Signature__Caption; Signature__CaptionLbl)
                    {
                    }
                    column(Text004; Text004)
                    {
                    }
                    column(Text005; Text005)
                    {
                    }
                    dataitem("Payment Lines"; 10866)
                    {
                        DataItemLink = "No." = FIELD("No.");
                        DataItemLinkReference = "Payment Lines1";
                        DataItemTableView = SORTING("Bc6_Account Name");
                        column(Text008; Text008)
                        {
                        }
                        column(DraftAmount; DraftAmount)
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrintCurrencyCode_Control1120060; PrintCurrencyCode())
                        {
                        }
                        column(Vendor_Name; Vendor.Name)
                        {
                        }
                        column(Gtxt_IBAN; Gtxt_IBAN)
                        {
                        }
                        column(ABS_Amount_; ABS(Amount))
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrintCurrencyCode_Control1120061; PrintCurrencyCode())
                        {
                        }
                        column(Gtxt_SWIFT; Gtxt_SWIFT)
                        {
                        }
                        column(GDate_ChangeRIB; GDate_ChangeRIB)
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Gcode_PaysRegion; Gcode_PaysRegion)
                        {
                        }
                        column(DraftAmount_Control1120036; DraftAmount)
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrintCurrencyCode_Control1120063; PrintCurrencyCode())
                        {
                        }
                        column(DraftAmount_Control1120039; DraftAmount)
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrintDraftCounting; PrintDraftCounting())
                        {
                        }
                        column(PrintCurrencyCode_Control1120064; PrintCurrencyCode())
                        {
                        }
                        column(FORMAT_PostingDate_0_4__Control1120034; PostingDate)
                        {
                        }
                        column(CompanyInformation_City; CompanyInformation.City)
                        {
                        }
                        column(Payment_Lines_No_; "No.")
                        {
                        }
                        column(Payment_Lines_Line_No_; "Line No.")
                        {
                        }
                        column(NoDocToPrint; NoDocToPrint)
                        {
                        }
                        column(DateDoc; DateDoc)
                        {
                        }
                        column(NoDocCaption; NoDocCaption)
                        {
                        }
                        column(DateDocCaption; DateDocCaption)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            Vendor.SETRANGE("No.", "Account No.");
                            IF NOT Vendor.FIND('-') THEN
                                ERROR(Text002, "Account No.");

                            DraftCounting := 1;
                            DraftAmount := ABS(Amount);

                            //DEBUT MODIF JX-XAD 19/05/2010
                            //Ajout du flag "RIB modifié" qui doit indiquer si le RIB a été modifié depuis le dernier virement
                            Gbool_ChangeRIB := FALSE;
                            Grec_PaymentLine.SETCURRENTKEY(Grec_PaymentLine."Posting Date", Grec_PaymentLine."Document No.");
                            Grec_PaymentLine.RESET();
                            Grec_PaymentLine.SETFILTER(Grec_PaymentLine."No.", '<>%1', "Payment Lines"."No.");
                            Grec_PaymentLine.SETFILTER(Grec_PaymentLine."Account No.", '%1', "Payment Lines"."Account No.");
                            Grec_PaymentLine.SETFILTER(Grec_PaymentLine."Bank Account Code", '%1', "Payment Lines"."Bank Account Code");
                            Grec_PaymentLine.SETFILTER(Grec_PaymentLine.Posted, '%1', TRUE);
                            IF Grec_PaymentLine.FIND('+') THEN BEGIN
                                IF Grec_VendorBankAccount2.GET(Grec_PaymentLine."Account No.", Grec_PaymentLine."Bank Account Code") THEN
                                    //Modif Jx-AUD du 28/01/14
                                    //Gcode_PaysRegion := Grec_VendorBankAccount2."Country/Region Code"; //Mis en commentaire JX-AUD 12/02/14
                                    //Fin MODIF JX-AUD du 28/01/14

                                    IF Grec_VendorBankAccount2."BC6_Change RIB/IBAN" > Grec_PaymentLine."Posting Date" THEN
                                        Gbool_ChangeRIB := TRUE;
                            END ELSE BEGIN
                                Grec_PaymentLineArchive.SETCURRENTKEY(Grec_PaymentLineArchive."Posting Date", Grec_PaymentLineArchive."Document No.");
                                Grec_PaymentLineArchive.RESET();
                                Grec_PaymentLineArchive.SETFILTER(Grec_PaymentLineArchive."No.", '<>%1', "Payment Lines"."No.");
                                Grec_PaymentLineArchive.SETFILTER(Grec_PaymentLineArchive."Account No.", '%1', "Payment Lines"."Account No.");
                                Grec_PaymentLineArchive.SETFILTER(Grec_PaymentLineArchive."Bank Account Code", '%1', "Payment Lines"."Bank Account Code");
                                Grec_PaymentLineArchive.SETFILTER(Grec_PaymentLineArchive.Posted, '%1', TRUE);
                                IF Grec_PaymentLineArchive.FIND('+') THEN BEGIN
                                    IF Grec_VendorBankAccount2.GET(Grec_PaymentLineArchive."Account No.", Grec_PaymentLineArchive."Bank Account No.") THEN
                                        //Modif Jx-AUD du 28/01/14
                                        //Gcode_PaysRegion := Grec_VendorBankAccount2."Country/Region Code";  //Mis en commentaire JX-AUD 12/02/14
                                        //Fin MODIF JX-AUD du 28/01/14
                                        IF Grec_VendorBankAccount2."BC6_Change RIB/IBAN" > Grec_PaymentLineArchive."Posting Date" THEN
                                            Gbool_ChangeRIB := TRUE;
                                END ELSE  // Ajout JX-XAD 03/06/2010
                                    Gbool_ChangeRIB := TRUE;
                            END;

                            IF Gbool_ChangeRIB THEN BEGIN

                                // modif LAB du 26/05/2010
                                // remplacement de oui par date sur modif RIB

                                //  Gtext_ChangeRIB := Text007
                                IF Grec_VendorBankAccount2.GET("Payment Lines"."Account No.", "Payment Lines"."Bank Account Code") THEN
                                    // Ajout JX-XAD 03/06/2010
                                    GDate_ChangeRIB := Grec_VendorBankAccount2."BC6_Change RIB/IBAN"

                            END ELSE
                                //  GText_ChangeRIB := '';
                                GDate_ChangeRIB := 0D;
                            // fin modif LAB du 26/05/2010

                            //FIN MODIF JX-XAD 19/05/2010


                            //Modif Jx-AUD du 28/01/14
                            //Fin MODIF JX-AUD du 28/01/14


                            //Début Modif JX-XAD 22/11/2010
                            Gtxt_IBAN := '';
                            Gtxt_SWIFT := '';
                            //Fin Modif JX-XAD 22/11/2010
                            IF Grec_Fournisseur.GET("Payment Lines"."Account No.") THEN
                                //MODIF JX-AUD du 11/02/14
                                //IF Grec_VendorBankAccount.GET("Payment Lines"."Account No.",Grec_Fournisseur."Default Bank Account Code") THEN
                                IF Grec_VendorBankAccount.GET("Payment Lines"."Account No.", "Payment Lines"."Bank Account Code") THEN BEGIN//MODIF JX-AUD
                                    Gtxt_IBAN := Grec_VendorBankAccount.IBAN;
                                    Gtxt_SWIFT := Grec_VendorBankAccount."SWIFT Code";
                                    Gcode_PaysRegion := Grec_VendorBankAccount."Country/Region Code";
                                END;

                            NoDocToPrint := "BC6_Pay Document No.";
                            DateDoc := PostingDate;
                            CASE "BC6_Pay Document Type" OF
                                "BC6_Pay Document Type"::Invoice:
                                    BEGIN
                                        IF PurchInv.GET("BC6_Pay Document No.") THEN
                                            IF PurchInv."Vendor Invoice No." <> '' THEN
                                                NoDocToPrint := PurchInv."Vendor Invoice No.";
                                        DateDoc := PurchInv."Document Date";
                                    END;
                                "BC6_Pay Document Type"::Quote:
                                    IF PurchHeader.GET(PurchHeader."Document Type"::Quote, "BC6_Pay Document No.") THEN
                                        DateDoc := PurchHeader."Document Date";
                                "BC6_Pay Document Type"::Order:
                                    IF PurchHeader.GET(PurchHeader."Document Type"::Order, "BC6_Pay Document No.") THEN
                                        DateDoc := PurchHeader."Document Date";
                                "BC6_Pay Document Type"::FAP:
                                    IF PurchHeader.GET(PurchHeader."Document Type"::Invoice, "BC6_Pay Document No.") THEN
                                        DateDoc := PurchHeader."Document Date";
                            END;
                        end;

                        trigger OnPreDataItem()
                        begin
                            "Payment Lines".SETRANGE("Account Type", "Payment Lines"."Account Type"::Vendor);
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN
                        CopyText := Text006;
                end;

                trigger OnPreDataItem()
                begin
                    LoopsNumber := ABS(CopiesNumber) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, LoopsNumber);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                PaymtHeader.GET("No.");
                PostingDate := PaymtHeader."Posting Date";

                PaymtManagt.PaymentBankAcc(BankAccountAddr, PaymtHeader);
            end;

            trigger OnPreDataItem()
            begin
                "Payment Lines1".SETRANGE("No.", TransfertNo);
            end;
        }
    }
    trigger OnPreReport()
    begin
        TransfertNo := "Payment Lines1".GETFILTER("No.");
        IF TransfertNo = '' THEN
            ERROR(Text000);

        CompanyInformation.GET();
        CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
        FormatAddress.Company(CompanyAddr, CompanyInformation);
    end;

    var
        CompanyInformation: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        PaymtHeader: Record "Payment Header";
        Grec_PaymentLine: Record "Payment Line";
        Grec_PaymentLineArchive: Record "Payment Line Archive";
        PurchInv: Record "Purch. Inv. Header";
        PurchHeader: Record "Purchase Header";
        Grec_Fournisseur: Record Vendor;
        Vendor: Record Vendor;
        Grec_VendorBankAccount: Record "Vendor Bank Account";
        Grec_VendorBankAccount2: Record "Vendor Bank Account";
        FormatAddress: Codeunit "Format Address";
        PaymtManagt: Codeunit "Payment Management";
        Gbool_ChangeRIB: Boolean;
        Gcode_PaysRegion: Code[10];
        TransfertNo: Code[20];
        NoDocToPrint: Code[50];
        DateDoc: Date;
        GDate_ChangeRIB: Date;
        PostingDate: Date;
        DraftAmount: Decimal;
        DraftCounting: Decimal;
        CopiesNumber: Integer;
        LoopsNumber: Integer;
        ABS_Amount_CaptionLbl: Label 'Amount', Comment = 'FRA="Montant"';
        Bank_AccountCaptionLbl: Label 'Bank Account', Comment = 'FRA="Compte bancaire"';
        CompanyInformation__Fax_No__CaptionLbl: Label 'Fax No.', Comment = 'FRA="N° télécopie"';
        CompanyInformation__Phone_No__CaptionLbl: Label 'Phone No.', Comment = 'FRA="N° téléphone"';
        CompanyInformation__VAT_Registration_No__CaptionLbl: Label 'VAT Registration No.', Comment = 'FRA="N° identif. intracomm."';
        DateDocCaption: Label 'Date de document';
        Done_at__CaptionLbl: Label 'Done at :', Comment = 'FRA="Fait à :"';
        IBANCaptionLbl: Label 'IBAN';
        NoDocCaption: Label 'N° Document';
        On__CaptionLbl: Label 'On :', Comment = 'FRA="Le :"';
        PaymtHeader__Agency_Code_CaptionLbl: Label 'Agency Code', Comment = 'FRA="Code guichet"';
        PaymtHeader__Bank_Account_No__CaptionLbl: Label 'Bank Account No.', Comment = 'FRA="N° compte bancaire"';
        PaymtHeader__Bank_Branch_No__CaptionLbl: Label 'Bank Branch No.', Comment = 'FRA="N° établissement"';
        PaymtHeader__National_Issuer_No__CaptionLbl: Label 'National Issuer No.', Comment = 'FRA="N° émetteur national"';
        PaymtHeader__No__CaptionLbl: Label 'Draft No.', Comment = 'FRA="N° virement"';
        PaymtHeader__RIB_Key_CaptionLbl: Label 'RIB Key', Comment = 'FRA="Clé RIB"';
        PrintCurrencyCodeCaptionLbl: Label 'Currency Code', Comment = 'FRA="Code devise"';
        ReportCaption_Control1120015Lbl: Label 'Report', Comment = 'FRA="Etat"';
        ReportCaptionLbl: Label 'Report', Comment = 'FRA="Etat"';
        RIB_IBAN_updated1CaptionLbl: Label 'RIB/IBAN updated', Comment = 'FRA="RIB/IBAN"';
        RIB_IBAN_updated2CaptionLbl: Label 'RIB/IBAN updated', Comment = 'FRA="modifié"';
        Signature__CaptionLbl: Label 'Signature :', Comment = 'FRA="Signature :"';
        Swift_CodeCaptionLbl: Label 'Swift Code', Comment = 'FRA="Code Swift"';
        Text000: Label 'You must specify a transfer number.', Comment = 'FRA="Vous devez spécifier un numéro de virement."';
        Text001: Label 'Draft Recapitulation %1', Comment = 'FRA="Récapitulatif de virement %1"';
        Text002: Label 'Vendor %1 does not exist.', Comment = 'FRA="Le fournisseur %1 n''existe pas."';
        Text004: Label ' DRAFT', Comment = 'FRA=" VIREMENT"';
        Text005: Label ' DRAFTS', Comment = 'FRA=" VIREMENTS"';
        Text006: Label 'COPY', Comment = 'FRA="COPIE"';
        Text008: Label 'Region Code', Comment = 'FRA="Code région"';
        TotalCaptionLbl: Label 'Total', Comment = 'FRA="Total"';
        Vendor_NameCaptionLbl: Label 'Name', Comment = 'FRA="Nom"';
        CopyText: Text[30];
        Gtxt_IBAN: Text[30];
        Gtxt_SWIFT: Text[30];
        BankAccountAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];

    procedure PrintDraftCounting(): Text[30]
    begin
        IF DraftCounting > 1 THEN
            EXIT(FORMAT(DraftCounting) + Text005)
        ELSE
            EXIT(FORMAT(DraftCounting) + Text004);
    end;

    procedure InitRequest(InitDraftNo: Code[20]; InitCopies: Integer)
    begin
        TransfertNo := InitDraftNo;
        CopiesNumber := InitCopies;
    end;

    procedure PrintCurrencyCode(): Code[10]
    begin
        IF "Payment Lines1"."Currency Code" = '' THEN BEGIN
            GLSetup.GET();
            EXIT(GLSetup."LCY Code");
        END ELSE
            EXIT("Payment Lines1"."Currency Code");
    end;
}

