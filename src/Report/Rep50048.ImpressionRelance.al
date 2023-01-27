report 50048 "BC6_Impression Relance"
{
    // //CREATION JX-AUD DU 26/08/2010 à partir Report 117
    // //IMPRESSION RELANCE FACTURE
    //  
    // MODIF JX-XAD 03/09/2010
    // Ajout du Dataitem "Global Temporary Table" afin de diviser la relance en plusieurs,
    // au cas où elle aurait plusieurs mandataires.
    // Le champ Document No. est utilisé pour le n° mandataire (agent)
    // Le champ Account No. est utilisé pour le n° relance
    // Le champ External Document No. est utilisé pour savoir si le mandataire est payeur ou non
    // 
    // //Modif JX-AUD du 28/10/11
    // //Mise en place du N° de facture à la place du N° doc externe dans la colonne N° facture de l'état
    // 
    // //JX-AUD du 13/05/2013
    // //Agrandissement logo
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/ImpressionRelance.rdl';

    Caption = 'Reminder', Comment = 'FRA="Relance"';

    dataset
    {
        dataitem("Issued Reminder Header"; "Issued Reminder Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Reminder';
            column(Issued_Reminder_Header_No_; "No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name + ' ' + CompanyInfo."Name 2")
            {
            }
            column(CompanyAddress; CompanyInfo.Address + ' ' + CompanyInfo."Address 2" + ' ' + CompanyInfo."Post Code" + ' ' + CompanyInfo.City)
            {
            }
            column(CompanyContact; Text023 + CompanyInfo."Phone No." + ' - FAX : ' + CompanyInfo."Fax No.")
            {
            }
            column(CompanyLegal; CompanyInfo."Legal Form" + ' ' + Text021 + ' ' + CompanyInfo."Stock Capital" + ' - ' + CompanyInfo."Trade Register" + ' - SIRET ' + CompanyInfo."Registration No." + ' - ' + CompanyInfo."APE Code" + ' - ' + Text022 + ' ' + CompanyInfo."VAT Registration No.")
            {
            }
            dataitem(Grec_GlobalTemporaryTable; "BC6_Global temporary table")
            {
                DataItemLink = "Account No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(CityDocDate; Gtxt_City + Text015 + ' ' + FORMAT("Issued Reminder Header"."Document Date"))
                {
                }
                column(Gtxt_LNomPays; Gtxt_LNomPays)
                {
                }
                column(Gtext_LCity; Gtext_LCity)
                {
                }
                column(Gtext_LAddress2; Gtext_LAddress2)
                {
                }
                column(Gcode_LPostCode; Gcode_LPostCode)
                {
                }
                column(Gtext_LAddress; Gtext_LAddress)
                {
                }
                column(Gtext_LName; Gtext_LName)
                {
                }
                column(ReminderLevel; "Issued Reminder Header"."Reminder Level")
                {
                }
                column(Gtext_TitreL; Gtext_TitreL)
                {
                }
                column(Gtxt_RNomPays; Gtxt_RNomPays)
                {
                }
                column(Gtext_RCity; Gtext_RCity)
                {
                }
                column(Gcode_RPostCode; Gcode_RPostCode)
                {
                }
                column(Gtext_RAddress2; Gtext_RAddress2)
                {
                }
                column(Gtext_RAddress; Gtext_RAddress)
                {
                }
                column(Gtext_RName; Gtext_RName)
                {
                }
                column(Gtext_TitreR; Gtext_TitreR)
                {
                }
                column(Level_Caption; Level_CaptionLbl)
                {
                }
                column(Grec_GlobalTemporaryTable_Document_No_; "Document No.")
                {
                }
                column(Grec_GlobalTemporaryTable_Line_No_; "Line No.")
                {
                }
                column(Banque; Gtext_NameBanque + ' - ' + Gtext_CodeEtabl + ' - ' + Gtext_CodeAgence + ' - ' + Gtext_NumCompte + ' - ' + Gtext_CleRIB)
                {
                }
                column(Banque_Caption; Text024)
                {
                }
                column(Issued_Reminder_Line__Due_Date_Caption; Issued_Reminder_Line__Due_Date_CaptionLbl)
                {
                }
                column(DescriptionCaption; DescriptionCaptionLbl)
                {
                }
                column(Issued_Reminder_Line__Document_Date_Caption; Issued_Reminder_Line__Document_Date_CaptionLbl)
                {
                }
                column(Issued_Reminder_Line__Document_No__Caption; Issued_Reminder_Line__Document_No__CaptionLbl)
                {
                }
                column(DebitCaption; DebitCaptionLbl)
                {
                }
                column(CreditCaption; CreditCaptionLbl)
                {
                }
                dataitem(IssuedReminderLineTexteDebut; "Issued Reminder Line")
                {
                    DataItemLink = "Reminder No." = FIELD("Account No.");
                    DataItemTableView = SORTING("Reminder No.", "Line No.") WHERE("Line Type" = CONST("Beginning Text"));
                    column(LineNoDeb; IssuedReminderLineTexteDebut."Line No.")
                    {
                    }
                    column(Gtexte_Debut; Gtexte_Debut)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        Gtexte_Debut := IssuedReminderLineTexteDebut.Description;
                    end;
                }
                dataitem(DataItem5444; Integer)
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    dataitem("Issued Reminder Line"; "Issued Reminder Line")
                    {
                        DataItemLink = "Reminder No." = FIELD("No.");
                        DataItemLinkReference = "Issued Reminder Header";
                        DataItemTableView = SORTING("Reminder No.", "Line No.") WHERE(Type = CONST("Customer Ledger Entry"));
                        column(Issued_Reminder_Line__Due_Date_; FORMAT("Due Date"))
                        {
                        }
                        column(Issued_Reminder_Line__Document_Date_; FORMAT("Document Date"))
                        {
                        }
                        column(Issued_Reminder_Line__Issued_Reminder_Line___Remaining_Amount_; "Issued Reminder Line"."Remaining Amount")
                        {
                        }
                        column(Issued_Reminder_Line__Issued_Reminder_Line__Description; "Issued Reminder Line".Description)
                        {
                        }
                        column(Gcode_ExtDoc; Gcode_ExtDoc)
                        {
                        }
                        column(Issued_Reminder_Line__Issued_Reminder_Line__Amount; "Issued Reminder Line".Amount)
                        {
                        }
                        column(Issued_Reminder_Line__Issued_Reminder_Line___Remaining_Amount__Control1000000036; "Issued Reminder Line"."Remaining Amount")
                        {
                        }
                        column(Total__Caption; Total__CaptionLbl)
                        {
                        }
                        column(Issued_Reminder_Line_Reminder_No_; "Reminder No.")
                        {
                        }
                        column(Issued_Reminder_Line_Line_No_; "Line No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            //Début Modif JX-XAD 21/09/2010
                            Gcode_ExtDoc := '';
                            IF Grec_SalesInvoiceHeader.GET("Issued Reminder Line"."Document No.") THEN
                                //Gcode_ExtDoc := Grec_SalesInvoiceHeader."External Document No."     //Modif JX-AUD du 28/10/11
                                  Gcode_ExtDoc := Grec_SalesInvoiceHeader."No."     //Modif JX-AUD du 28/10/11
                            ELSE
                                IF Grec_SalesCrMemoHeader.GET("Issued Reminder Line"."Document No.") THEN
                                    //Gcode_ExtDoc := Grec_SalesCrMemoHeader."External Document No.";    //Modif JX-AUD du 28/10/11
                                    Gcode_ExtDoc := Grec_SalesCrMemoHeader."No.";    //Modif JX-AUD du 28/10/11

                            //Fin Modif JX-XAD 21/09/2010

                            TempVATAmountLine.INIT();
                            TempVATAmountLine."VAT Identifier" := "VAT Identifier";
                            TempVATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            TempVATAmountLine."Tax Group Code" := "Tax Group Code";
                            TempVATAmountLine."VAT %" := "VAT %";
                            TempVATAmountLine."VAT Base" := Amount;
                            TempVATAmountLine."VAT Amount" := "VAT Amount";
                            TempVATAmountLine."Amount Including VAT" := Amount + "VAT Amount";
                            TempVATAmountLine.InsertLine();

                            CASE Type OF
                                Type::"G/L Account":
                                    "Remaining Amount" := Amount;
                                Type::"Customer Ledger Entry":
                                    ReminderInterestAmount := Amount;
                            END;
                            NNC_InterestAmountTotal += ReminderInterestAmount;
                            NNC_RemainingAmountTotal += "Remaining Amount";
                            NNC_VATAmountTotal += "VAT Amount";

                            NNC_InterestAmount := (NNC_InterestAmountTotal + NNC_VATAmountTotal + "Issued Reminder Header"."Additional Fee" -
                              AddFeeInclVAT) / (VATInterest / 100 + 1);
                            NNC_Total := NNC_RemainingAmountTotal + NNC_InterestAmountTotal + NNC_VATAmountTotal - (NNC_InterestAmountTotal +
                            NNC_VATAmountTotal + "Issued Reminder Header"."Additional Fee" - AddFeeInclVAT) / (VATInterest / 100 + 1) * VATInterest / 100 +
                              "Issued Reminder Header"."Additional Fee" - AddFeeInclVAT;
                            NNC_VATAmount := (NNC_InterestAmountTotal + NNC_VATAmountTotal + "Issued Reminder Header"."Additional Fee" - AddFeeInclVAT) /
                              (VATInterest / 100 + 1) * (VATInterest / 100) + AddFeeInclVAT - "Issued Reminder Header"."Additional Fee";
                            NNC_TotalInclVAT := NNC_RemainingAmountTotal + NNC_InterestAmountTotal + NNC_VATAmountTotal;
                        end;

                        trigger OnPreDataItem()
                        begin
                            Gtexte_Debut := '';

                            IF FINDLAST() THEN BEGIN
                                EndLineNo := "Line No." + 1;
                                REPEAT
                                    Continue := ("No. of Reminders" = 0) AND (Type = Type::"Customer Ledger Entry");
                                    EndLineNo := "Line No.";
                                UNTIL (NEXT(-1) = 0) OR NOT Continue;
                            END;

                            TempVATAmountLine.DELETEALL();

                            //DEBUT MODIF JX-XAD 03/09/2010
                            "Issued Reminder Line".SETFILTER("Issued Reminder Line"."BC6_Agent", '%1', Grec_GlobalTemporaryTable."Document No.");
                            //FIN MODIF JX-XAD 03/09/2010

                            SETFILTER("Line No.", '<=%1', EndLineNo);
                        end;
                    }
                    dataitem(IssuedReminderLineTexteFin; "Issued Reminder Line")
                    {
                        DataItemLink = "Reminder No." = FIELD("No.");
                        DataItemLinkReference = "Issued Reminder Header";
                        DataItemTableView = SORTING("Reminder No.", "Line No.") WHERE("Line Type" = CONST("Ending Text"));
                        column(LineNoFin; IssuedReminderLineTexteFin."Line No.")
                        {
                        }
                        column(Gtexte_Fin; Gtexte_Fin)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            Gtexte_Fin := IssuedReminderLineTexteFin.Description;
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                            VALVATBase := TempVATAmountLine."Amount Including VAT" / (1 + TempVATAmountLine."VAT %" / 100);
                            VALVATAmount := TempVATAmountLine."Amount Including VAT" - VALVATBase;
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF TempVATAmountLine.GetTotalVATAmount() = 0 THEN
                                CurrReport.BREAK();

                            SETRANGE(Number, 1, TempVATAmountLine.COUNT);
                        end;
                    }
                    dataitem(VATCounterLCY; Integer)
                    {
                        DataItemTableView = SORTING(Number);

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);

                            VALVATBaseLCY := ROUND(TempVATAmountLine."Amount Including VAT" / (1 + TempVATAmountLine."VAT %" / 100) / CurrFactor);
                            VALVATAmountLCY := ROUND(TempVATAmountLine."Amount Including VAT" / CurrFactor - VALVATBaseLCY);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Issued Reminder Header"."Currency Code" = '') OR
                               (TempVATAmountLine.GetTotalVATAmount() = 0) THEN
                                CurrReport.BREAK();

                            SETRANGE(Number, 1, TempVATAmountLine.COUNT);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text011 + Text012
                            ELSE
                                VALSpecLCYHeader := Text011 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Issued Reminder Header"."Posting Date", "Issued Reminder Header"."Currency Code", 1);
                            CustEntry.SETRANGE("Customer No.", "Issued Reminder Header"."Customer No.");
                            CustEntry.SETRANGE("Document Type", CustEntry."Document Type"::Reminder);
                            CustEntry.SETRANGE("Document No.", "Issued Reminder Header"."No.");
                            IF CustEntry.FINDFIRST() THEN BEGIN
                                CustEntry.CALCFIELDS("Amount (LCY)", Amount);
                                CurrFactor := 1 / (CustEntry."Amount (LCY)" / CustEntry.Amount);
                                VALExchRate := STRSUBSTNO(Text013, ROUND(1 / CurrFactor * 100, 0.000001), CurrExchRate."Exchange Rate Amount");
                            END ELSE BEGIN
                                CurrFactor := CurrExchRate.ExchangeRate("Issued Reminder Header"."Posting Date", "Issued Reminder Header"."Currency Code");
                                VALExchRate := STRSUBSTNO(Text013, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                            END;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    //dev AUD
                    IF Grec_GlobalTemporaryTable."Document No." <> '' THEN BEGIN
                        IF Cust.GET(Grec_GlobalTemporaryTable."Document No.") THEN BEGIN
                            Gtext_RName := Cust.Name;
                            Gtext_RAddress := Cust.Address;
                            Gtext_RAddress2 := Cust."Address 2";
                            Gtext_RCity := Cust.City;
                            Gcode_RPostCode := Cust."Post Code";
                            IF Grec_CodePays.GET(Cust."Country/Region Code") THEN
                                Gtxt_RNomPays := Grec_CodePays.Name
                            ELSE
                                Gtxt_RNomPays := '';
                            IF Grec_GlobalTemporaryTable."Description" = 'OUI' THEN
                                Gtext_TitreR := Text028
                            ELSE
                                Gtext_TitreR := Text026;
                        END;
                    END ELSE BEGIN
                        Gtext_RName := '';
                        Gtext_RAddress := '';
                        Gtext_RAddress2 := '';
                        Gtext_RCity := '';
                        Gcode_RPostCode := '';
                        Gtext_TitreR := '';
                        Gtxt_RNomPays := '';
                    END;
                    //fin dev AUD
                end;
            }

            trigger OnAfterGetRecord()
            var
                CustPostingGroup: Record "Customer Posting Group";
                GLAcc: Record "G/L Account";
                VATPostingSetup: Record "VAT Posting Setup";
            begin

                CurrReport.LANGUAGE := Language.GetLanguageIdOrDefault("Language Code");


                PostedDocDim.SETRANGE("Dimension Set ID", "Dimension Set ID");

                FormatAddr.IssuedReminder(CustAddr, "Issued Reminder Header");

                //DEBUT MODIF JX-XAD 03/09/2010
                Grec_IssuedReminderLine.RESET();
                Grec_IssuedReminderLine.SETFILTER(Grec_IssuedReminderLine."Reminder No.", '%1', "Issued Reminder Header"."No.");
                Grec_IssuedReminderLine.SETFILTER(Grec_IssuedReminderLine."Line Type", '%1', Grec_IssuedReminderLine."Line Type"::"Reminder Line");
                FOR i := 1 TO 100 DO BEGIN
                    Gcode_Agent[i, 1] := 'Agent';
                    Gcode_Agent[i, 2] := '';
                END;

                Gint_CompteurAgent := 1;
                IF Grec_IssuedReminderLine.FIND('-') THEN
                    REPEAT
                        Gcode_Agent[Gint_CompteurAgent, 1] := Grec_IssuedReminderLine."BC6_Agent";
                        Gcode_Agent[Gint_CompteurAgent, 2] := FORMAT(Grec_IssuedReminderLine."BC6_Paying agent");
                        Gint_CompteurAgent += 1;
                    UNTIL Grec_IssuedReminderLine.NEXT() = 0;

                Grec_GlobalTemporaryTable.DELETEALL();

                FOR i := 1 TO Gint_CompteurAgent - 1 DO
                    IF NOT Grec_GlobalTemporaryTable.GET(Gcode_Agent[i, 1], 1) THEN BEGIN
                        Grec_GlobalTemporaryTable.INIT();
                        Grec_GlobalTemporaryTable."Document No." := Gcode_Agent[i, 1];
                        Grec_GlobalTemporaryTable."Line No." := i;
                        Grec_GlobalTemporaryTable."Account No." := "Issued Reminder Header"."No.";
                        Grec_GlobalTemporaryTable."Description" := Gcode_Agent[i, 2];
                        Grec_GlobalTemporaryTable.INSERT();
                    END;
                //FIN MODIF JX-XAD 03/09/2010

                //dev AUD

                IF UserSetup.GET("Issued Reminder Header"."User ID") THEN
                    Gtext_UserName := UserSetup."BC6_Nom"
                ELSE
                    Gtext_UserName := '';

                Gtext_LName := "Issued Reminder Header".Name;
                Gtext_LAddress := "Issued Reminder Header".Address;
                Gtext_LAddress2 := "Issued Reminder Header"."Address 2";
                Gtext_LCity := "Issued Reminder Header".City;
                Gcode_LPostCode := "Issued Reminder Header"."Post Code";
                Gtext_TitreL := Text025;

                IF Grec_CodePays.GET("Issued Reminder Header"."Country/Region Code") THEN
                    Gtxt_LNomPays := Grec_CodePays.Name
                ELSE
                    Gtxt_LNomPays := '';

                //fin dev AUD




                IF "Your Reference" = '' THEN
                    ReferenceText := ''
                ELSE
                    ReferenceText := FIELDCAPTION("Your Reference");
                IF "VAT Registration No." = '' THEN
                    VATNoText := ''
                ELSE
                    VATNoText := FIELDCAPTION("VAT Registration No.");
                IF "Currency Code" = '' THEN BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text000, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text001, GLSetup."LCY Code");
                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text000, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text001, "Currency Code");
                END;

                IF NOT CurrReport.PREVIEW THEN BEGIN
                    IF LogInteractionV THEN
                        SegManagement.LogDocument(
                          8, "No.", 0, 0, DATABASE::Customer, "Customer No.", '', '', "Posting Description", '');
                    IncrNoPrinted();
                END;
                CALCFIELDS("Additional Fee");
                CustPostingGroup.GET("Customer Posting Group");
                IF GLAcc.GET(CustPostingGroup."Additional Fee Account") THEN BEGIN
                    VATPostingSetup.GET("VAT Bus. Posting Group", GLAcc."VAT Prod. Posting Group");
                    AddFeeInclVAT := "Additional Fee" * (1 + VATPostingSetup."VAT %" / 100);
                END ELSE
                    AddFeeInclVAT := "Additional Fee";
                CALCFIELDS("Interest Amount");
                IF "Interest Amount" <> 0 THEN BEGIN
                    GLAcc.GET(CustPostingGroup."Interest Account");
                    VATPostingSetup.GET("VAT Bus. Posting Group", GLAcc."VAT Prod. Posting Group");
                    VATInterest := VATPostingSetup."VAT %";
                END ELSE
                    VATInterest := 0;

                NNC_InterestAmountTotal := 0;
                NNC_RemainingAmountTotal := 0;
                NNC_VATAmountTotal := 0;
                NNC_InterestAmount := 0;
                NNC_Total := 0;
                NNC_VATAmount := 0;
                NNC_TotalInclVAT := 0;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET();
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);

                FormatAddrCodeunit.Company(CompanyAddr, CompanyInfo);

                //dev AUD
                IF DefaultBank.GET(CompanyInfo."Default Bank Account No.") THEN BEGIN

                    Gtext_NameBanque := DefaultBank.Name;
                    Gtext_CodeEtabl := DefaultBank."Bank Branch No.";
                    Gtext_CodeAgence := DefaultBank."Agency Code";
                    Gtext_NumCompte := DefaultBank."Bank Account No.";
                    Gtext_CleRIB := FORMAT(DefaultBank."RIB Key");

                END ELSE BEGIN

                    Gtext_NameBanque := '';
                    Gtext_CodeEtabl := '';
                    Gtext_CodeAgence := '';
                    Gtext_NumCompte := '';
                    Gtext_CleRIB := '';

                END;
                //dev AUD

                //DEBUT MODIF JX-XAD 03/09/2010
                IF COPYSTR(CompanyInfo.City, STRLEN(CompanyInfo.City) - 4, 5) = 'CEDEX' THEN
                    Gtxt_City := COPYSTR(CompanyInfo.City, 1, STRLEN(CompanyInfo.City) - 5)
                ELSE
                    Gtxt_City := CompanyInfo.City;
                //FIN MODIF JX-XAD 03/09/2010
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ShowInternalInfo; ShowInternalInfoV)
                    {
                        Caption = 'Show Internal Information', Comment = 'FRA="Afficher info. internes"';
                        ApplicationArea = All;
                    }
                    field(LogInteraction; LogInteractionV)
                    {
                        Caption = 'Log Interaction', Comment = 'FRA="Journal interaction"';
                        Enabled = LogInteractionEnable;
                        ApplicationArea = All;
                    }
                }
            }
        }
        trigger OnInit()
        begin
            LogInteractionEnable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            LogInteractionV := SegManagement.FindInteractTmplCode(8) <> '';
            LogInteractionEnable := LogInteractionV;
        end;
    }

    labels
    {
        Issued_Reminder_Line__Due_Date_CaptionLbl = 'Echéance';
        DescriptionCaptionLbl = 'Libellé';
        Issued_Reminder_Line__Document_Date_CaptionLbl = 'Date';
        Issued_Reminder_Line__Document_No__CaptionLbl = 'Invoice No.', Comment = 'FRA="N° Facture"';
        DebitCaptionLbl = 'Débit';
        CreditCaptionLbl = 'Crédit';
    }

    trigger OnInitReport()
    begin
        GLSetup.GET();
        Gbool_PremiereFacture := FALSE;
    end;

    var
        DefaultBank: Record "Bank Account";
        CompanyInfo: Record "Company Information";
        Grec_CodePays: Record "Country/Region";
        CurrExchRate: Record "Currency Exchange Rate";
        CustEntry: Record "Cust. Ledger Entry";
        Cust: Record Customer;
        PostedDocDim: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        Grec_IssuedReminderLine: Record "Issued Reminder Line";
        Grec_SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        Grec_SalesInvoiceHeader: Record "Sales Invoice Header";
        UserSetup: Record "User Setup";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        FormatAddr: Codeunit "Format Address";
        FormatAddrCodeunit: Codeunit "Format Address";
        Language: Codeunit Language;
        SegManagement: Codeunit SegManagement;
        Continue: Boolean;
        Gbool_PremiereFacture: Boolean;
        LogInteractionV: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        ShowInternalInfoV: Boolean;
        Gcode_Agent: array[100, 2] of Code[20];
        Gcode_ExtDoc: Code[20];
        Gcode_LPostCode: Code[20];
        Gcode_RPostCode: Code[20];
        AddFeeInclVAT: Decimal;
        CurrFactor: Decimal;
        NNC_InterestAmount: Decimal;
        NNC_InterestAmountTotal: Decimal;
        NNC_RemainingAmountTotal: Decimal;
        NNC_Total: Decimal;
        NNC_TotalInclVAT: Decimal;
        NNC_VATAmount: Decimal;
        NNC_VATAmountTotal: Decimal;
        ReminderInterestAmount: Decimal;
        VALVATAmount: Decimal;
        VALVATAmountLCY: Decimal;
        VALVATBase: Decimal;
        VALVATBaseLCY: Decimal;
        VATInterest: Decimal;
        EndLineNo: Integer;
        Gint_CompteurAgent: Integer;
        i: Integer;
        CreditCaptionLbl: Label 'Credit', Comment = 'FRA="Crédit"';
        DebitCaptionLbl: Label 'Debit', Comment = 'FRA="Débit"';
        DescriptionCaptionLbl: Label 'Description', Comment = 'FRA="Libellé"';
        Issued_Reminder_Line__Document_Date_CaptionLbl: Label 'Date';
        Issued_Reminder_Line__Document_No__CaptionLbl: Label 'Invoice No.', Comment = 'FRA="N° Facture"';
        Issued_Reminder_Line__Due_Date_CaptionLbl: Label 'Term', Comment = 'FRA="Echéance"';
        Level_CaptionLbl: Label 'Level Recovery :', Comment = 'FRA="Niveau de relance :"';
        Text000: Label 'Total %1', Comment = 'FRA="Total %1"';
        Text001: Label 'Total %1 Incl. VAT', Comment = 'FRA="Total %1 TTC"';
        Text011: Label 'VAT Amount Specification in ', Comment = 'FRA="Détail TVA dans "';
        Text012: Label 'Local Currency', Comment = 'FRA="Devise société"';
        Text013: Label 'Exchange rate: %1/%2', Comment = 'FRA="Taux de change : %1/%2"';
        Text015: Label ',', Comment = 'FRA=", le"';
        Text021: Label 'with capital of', Comment = 'FRA="au capital de"';
        Text022: Label 'VAT identification No. :', Comment = 'FRA="N° identification TVA :"';
        Text023: Label 'Phone :', Comment = 'FRA="Tél. : "';
        Text024: Label 'RIB :';
        Text025: Label 'ANNOUNCER', Comment = 'FRA="ANNONCEUR"';
        Text026: Label 'AGENT', Comment = 'FRA="MANDATAIRE"';
        Text028: Label 'PAYING AGENT', Comment = 'FRA="MANDATAIRE PAYEUR"';
        Total__CaptionLbl: Label 'Total :';
        Gtexte_Debut: Text;
        Gtexte_Fin: Text;
        Gtext_CodeEtabl: Text[20];
        Gtext_CleRIB: Text[30];
        Gtext_LCity: Text[30];
        Gtext_NumCompte: Text[30];
        Gtext_RCity: Text[30];
        Gtext_TitreL: Text[30];
        Gtext_TitreR: Text[30];
        ReferenceText: Text[30];
        VATNoText: Text[30];
        CompanyAddr: array[8] of Text[50];
        CustAddr: array[8] of Text[50];
        Gtext_CodeAgence: Text[50];
        Gtext_LAddress: Text[50];
        Gtext_LAddress2: Text[50];
        Gtext_LName: Text[50];
        Gtext_NameBanque: Text[50];
        Gtext_RAddress: Text[50];
        Gtext_RAddress2: Text[50];
        Gtext_RName: Text[50];
        Gtext_UserName: Text[50];
        Gtxt_City: Text[50];
        Gtxt_LNomPays: Text[50];
        Gtxt_RNomPays: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        VALExchRate: Text[50];
        VALSpecLCYHeader: Text[80];
}

