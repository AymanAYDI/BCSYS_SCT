codeunit 50000 "BC6_Duplicating records"
{
    var
        Grec_DuplicatingList: Record "BC6_Duplicating list"
;
        Grec_CompanyList: Record Company;
        Grec_UserSetup: Record "User Setup";
        text001: label 'ERROR !\\No company has been checked !';
        text002: label 'ERROR !\\Vendor %1 already exists in company %2';
        text003: label 'ERROR !\\Vendor %1 does not exists in company %2 !';
        text005: label 'ERROR !\\Vendor posting group %1 does not exists in company %2';
        text007: label 'ERROR in %1 !\\unable to create account bank %2 related to vendor %3';
        text008: label 'ERROR in %1 !\\unable to create post code/city %2/%3 related to account bank';
        text009: label 'ERROR in %1 !\\Currency code %2, related to account bank, does not exists';
        text010: label 'ERROR in %1 !\\unable to create country code %2 related to vendor';
        text011: label 'ERROR in %1 !\\unable to create language code %2 related to account bank';
        text012: label 'ERROR !\\Payment terms code %1 does not exists in company %2';
        text013: label 'ERROR !\\Invoice discount code %1 does not exists in company %2';
        text014: label 'ERROR !\\Pay-to vendor code %1 does not exists in company %2';
        text015: label 'ERROR !\\Payment method code %1 does not exists in company %2';
        text016: label 'ERROR !\\Business posting group %1 does not exists in company %2';
        text017: label 'ERROR !\\VAT business posting group %1 does not exists in company %2';
        text018: label 'ERROR !\\Purchaser %1 does not exists in company %2';
        text019: label 'ERROR !\\Responsability center %1 does not exists in company %2';
        text020: label 'ERROR !\\IC partner code %1 does not exists in company %2';
        text021: label 'ERROR !\\Location code %1 does not exists in company %2';
        text022: label 'ERROR !\\Shipment method code %1 does not exists in company %2';
        text023: label 'ERROR !\\Base calendar code %1 does not exists in company %2';
        text024: label 'ERROR !\\Currency code %1 does not exists in company %2';
        text025: label 'ERROR in %1!\\unable to create language code %2 related to vendor';
        text026: label 'ERROR in %1!\\unable to create post code/city %2 related to primary contact';
        text027: label 'ERROR in %1!\\Currency code %2, related to primary contact, does not exists';
        text028: label 'ERROR in %1!\\unable to create country code %2 related to primary contact';
        text029: label 'ERROR in %1!\\unable to create language code %2 related to primary contact';
        text030: label 'ERROR in %1!\\unable to create territory code %2 related to primary contact';
        text031: label 'ERROR in %1!\\Vendor %2, related to primary contact, does not exists';
        text032: label 'ERROR in %1!\\Series No. %2, related to primary contact, does not exists';
        text033: label 'ERROR in %1!\\Organizationnal level code %2, related to primary contact, does not exists';
        text034: label 'ERROR in %1!\\Salutation code %2, related to primary contact, does not exists';
        text035: label 'ERREUR dans %1 !\\Impossible de créer le contact principal %2 de la fiche fournisseur';
        text036: label 'CAREFUL !in %1 !\\unable to create business relation between vendor %2 and contact %3';
        text037: label 'CAREFUL in %1! Dimension code %2 was not created';
        text038: label 'CAREFUL in %1 !\\Dimension value code %2 was not created for dimension code %3';
        text039: label 'ERROR !\\G/L account %1 already exists in company %2';
        text040: label 'ERROR !\\G/L account %1 does not exists in company %2';
        text041: label 'ERROR !\\Business posting group%1 does not exists in company %2';
        text042: label 'ERROR !\\Product posting group %1 does not exists in company %2';
        text043: label 'ERROR !\\Tax Area Code %1 does not exists in company %2';
        text044: label 'ERROR !\\Tax group code %1 does not exists in company %2';
        text045: label 'ERROR !\\VAT business posting group %1 does not exists in company %2';
        text046: label 'ERROR !\\VAT product posting group %1 does not exists in company %2';
        text047: label 'ERROR !\\Default IC partner G/L account %1 doest not exists in company %2';
        text049: label 'ERROR !\\General product posting group %1 does not exist in company %2';
        text050: label 'ERROR in %1 !\\unable to create origin country code %2 related to this item';
        text051: label 'ERROR !\\Item %1 already exists in company %2';
        text052: label 'ERROR !\\Item %1 does not exists in company %2 !';
        text053: label 'ERROR in %1 !\\unable to create purch. country code %2 related to this item';
        text054: label 'ERROR in %1!\\unable to create unit of measure %2 related to this item';
        text055: label 'ERROR in %1!\\unable to create sale unit of measure %2 related to this item';
        text056: label 'ERROR in %1!\\unable to create purch. unit of measure %2 related to this item';
        text057: label 'ERROR in %1 !\\unable to create unit code %2';
        text058: label 'ERROR !\\Inventory posting group %1 does not exist in company %2';
        text059: label 'ERROR !\\Item Discount Group No. %1 does not exist in company %2';
        text060: label 'ERROR !\\Vendor N° %1 does not exist in company %2';
        text061: label 'ERROR !\\Alternative Item No. %1 does not exist in company %2';
        text062: label 'ERROR !\\Tariff No. %1 does not exist in company %2';
        text063: label 'ERROR !\\VAT business posting group (price) %1 does not exist in company %2';
        text064: label 'ERROR !\\No. series %1 does not exist in company %2';
        text065: label 'ERROR !\\Tax group %1 does not exist in company %2';
        text066: label 'ERROR !\\VAT product posting group %1 does not exist in company %2';
        text067: label 'ERROR !\\Serial Nos. %1 does not exist in company %2';
        text068: label 'ERROR !\\Manufacturer code %1 does not exist in company %2';
        text069: label 'ERROR !\\Item category code %1 does not exist in company %2';
        text071: label 'ERROR !\\Service item group %1 does not exist in company %2';
        text072: label 'ERROR !\\Item tracking code %1 does not exist in company %2';
        text073: label 'ERROR !\\Lot No. %1 does not exist in company %2';
        text074: label 'ERROR !\\Special equipment %1 does not exist in company %2';
        text075: label 'ERROR !\\Put-away template %1 does not exist in company %2';
        text076: label 'ERROR !\\Phys invt counting period code %1 does not exist in company %2';
        text077: label 'ERROR in %1 !\\Unable to create put-away unit of measure %2 related to this item';
        text080: label 'ERROR !\\Routing No. %1 does not exist in company %2';
        text081: label 'ERROR !\\Production BOM No. %1 does not exist in company %2';
        text082: label 'Vendor';
        text083: label 'G/L Account';
        text084: label 'Item';
        text085: label 'The card';
        text086: label 'will be duplicated in the following company :';
        text088: label 'Can you confirm the duplication ?';
        text089: label 'CAREFUL in %1 !\\Global dimension 1 %2 code %3 can not be duplicated';
        text090: label 'CAREFUL in %1 !\\Global dimension 2 %2 code %3 can not be duplicated';
        text091: label 'Bank account';
        text092: label 'The bank account %1 has been duplicated in company %2';
        text094: label 'ERROR !\\Vendor %1 does not exists in company %2 !';
        text095: label 'ERROR !\\Vendor %1 does not exists in company %2';
        text097: label 'Utilisateur';
        text098: label 'ERROR !\\Vendor %1 already exists in company %2';
        text099: label 'ERROR !\\Vendor %1 does not exists in company %2 !';
        text100: label 'ERREUR !\\Le code utilisateur n''est pas saisi.';
        text103: label 'Attention !\Le champ "Service" est vide, souhaitez- vous continuer ?';
        text104: label 'Attention !\Le champ "Nom (signature)" est vide, souhaitez-vous continuer ?';
        text105: label 'Attention !\Le champ "ID Approbateur" est vide, souhaitez-vous continuer ?';
        text106: label 'ERREUR !\L''email utilisateur n''est pas saisi.';
        text107: label 'ERREUR !\L''utilisateur a des écritures approbations ouvertes dans la  société %1';
        text108: label 'sera supprimée dans la (ou les)  société(s) suivante(s) :';
        text109: label 'Can you confirm the duplication ?';
        text110: label 'L''utilisateur %1 a été supprimé de la  société %2';
        text111: label 'D''autre parté confirmez-vous la suppression de l''utilisateur %1 pour la  société actuelle: %2';
        text112: label 'Confirmez-vous la validation des périodes sur la société %1 ?';

    procedure Dupliquer(Lopt_TypeFiche: Option ,Vendor,"G/L Account",Item,VendorBankAccount,User,UserDelete,UserDeleteActualSociety; Lcode_Fiche: Code[50]; Lcode_Fiche2: Code[50]) Lint_DuplicationNumber: Integer
    var
        Lint_NbSte: Integer;
        Ltxt_TypeFiche: Text[30];
        Ltxt_Confirmation: Text[1024];
    begin
        // Créer un message afin de demander la confirmation de la duplication à l'utilisateur
        Lint_DuplicationNumber := 0;
        Lint_NbSte := 0;
        case Lopt_TypeFiche of
            Lopt_TypeFiche::Vendor:
                Ltxt_TypeFiche := text082;
            Lopt_TypeFiche::"G/L Account":
                Ltxt_TypeFiche := text083;
            Lopt_TypeFiche::Item:
                Ltxt_TypeFiche := text084;
            Lopt_TypeFiche::VendorBankAccount:
                Ltxt_TypeFiche := text091; //MODIF JX-XAD 15/06/2010
            Lopt_TypeFiche::User:
                Ltxt_TypeFiche := text097; //MODIF JX-AUD 07/04/14
            Lopt_TypeFiche::UserDelete:
                Ltxt_TypeFiche := text097; //MODIF JX-AUD 07/04/14
        end;

        if Lopt_TypeFiche = Lopt_TypeFiche::UserDelete then  //JX-AUD du 07/04/14
            Ltxt_Confirmation := text085 + ' ' + Ltxt_TypeFiche + ' ' + Lcode_Fiche + ' ' + text108 + '\' //JX-AUD du 07/04/14
        else
            if Lopt_TypeFiche <> Lopt_TypeFiche::UserDeleteActualSociety then
                Ltxt_Confirmation := text085 + ' ' + Ltxt_TypeFiche + ' ' + Lcode_Fiche + ' ' + text086 + '\';

        if Grec_DuplicatingList.FIND('-') then
            repeat
                if Grec_DuplicatingList.Duplication then begin
                    Lint_NbSte += 1;
                    Ltxt_Confirmation := Ltxt_Confirmation + '\' + Grec_DuplicatingList.Name;
                    //    IF Grec_DuplicatingList.Dimension THEN
                    //      Ltxt_Confirmation := Ltxt_Confirmation + ' '+text087;
                end;
            until Grec_DuplicatingList.NEXT() = 0;

        // Si au moins une soci‚t‚ a ‚t‚ coch‚e dans le form 50013 alors effectuer le traitement de duplication
        if Lint_NbSte > 0 then begin
            if Lopt_TypeFiche = Lopt_TypeFiche::UserDelete then  //JX-AUD du 07/04/14
                Ltxt_Confirmation := Ltxt_Confirmation + '\\' + text109//JX-AUD du 07/04/14
            else
                Ltxt_Confirmation := Ltxt_Confirmation + '\\' + text088;
            if CONFIRM(Ltxt_Confirmation) then
                case Lopt_TypeFiche of
                    Lopt_TypeFiche::Vendor:
                        Lint_DuplicationNumber := CreateVendor(Lcode_Fiche);
                    Lopt_TypeFiche::"G/L Account":
                        Lint_DuplicationNumber := CreateAccount(Lcode_Fiche);
                    Lopt_TypeFiche::Item:
                        Lint_DuplicationNumber := CreateItem(Lcode_Fiche);
                    //DEBUT MODIF JX-XAD 15/06/2010
                    Lopt_TypeFiche::VendorBankAccount:
                        Lint_DuplicationNumber := CreateBankAccount(Lcode_Fiche, Lcode_Fiche2);
                    //FIN MODIF JX-XAD 15/06/2010
                    //DEBUT MODIF JX-AUD 07/04/14
                    Lopt_TypeFiche::User:
                        Lint_DuplicationNumber := CreateUser(Lcode_Fiche);
                    Lopt_TypeFiche::UserDelete:
                        Lint_DuplicationNumber := DeleteUser(Lcode_Fiche);
                //FIN MODIF JX-AUD 07/04/14
                end;
        end else
            MESSAGE(text001);     // Aucune soci‚t‚ n'a ‚t‚ coch‚e !
    end;

    procedure Initialiser();
    begin
        Grec_DuplicatingList.DELETEALL();
        Grec_CompanyList.RESET();
        if Grec_CompanyList.FIND('-') then
            repeat
                if Grec_CompanyList.Name <> COMPANYNAME then begin
                    Grec_DuplicatingList.INIT();
                    Grec_DuplicatingList.Name := Grec_CompanyList.Name;
                    Grec_DuplicatingList.Duplication := true;
                    Grec_DuplicatingList.Dimension := true;
                    Grec_DuplicatingList.Echec := false;
                    Grec_DuplicatingList.INSERT();
                end;
            until Grec_CompanyList.NEXT() = 0;

        COMMIT();  //AJOUT JX-XAD 07/06/2011
    end;

    procedure CreateVendor(Lcode_Vendor: Code[20]) Lint_DuplicationNumber: Integer;
    var
        Lrec_DestBaseCalendar: Record "Base Calendar";
        Lrec_DestCurrency: Record Currency;
        Lrec_DestDimensionValue: Record "Dimension Value";
        Lrec_DestGenBusPostGroup: Record "Gen. Business Posting Group";
        Lrec_SourceGenLedgerSetup: Record "General Ledger Setup";
        Lrec_DestICPartner: Record "IC Partner";
        Lrec_DestLocation: Record Location;
        Lrec_DestPaymentMethod: Record "Payment Method";
        Lrec_DestPaymentTerms: Record "Payment Terms";
        Lrec_DestRespCenter: Record "Responsibility Center";
        Lrec_DestPurchaser: Record "Salesperson/Purchaser";
        Lrec_DestShipmentMethod: Record "Shipment Method";
        Lrec_DestVATBusPostGroup: Record "VAT Business Posting Group";
        Lrec_DestVendor: Record Vendor;
        Lrec_SourceVendor: Record Vendor;
        Lrec_DestVendorPostingGroup: Record "Vendor Posting Group"
;
    begin
        Lint_DuplicationNumber := 0;
        if Grec_DuplicatingList.FIND('-') then
            repeat
                if Grec_DuplicatingList.Duplication then begin
                    Grec_DuplicatingList.Echec := true;
                    Grec_DuplicatingList.MODIFY();
                    if Lrec_DestVendor.CHANGECOMPANY(Grec_DuplicatingList.Name) then begin
                        Lrec_DestVendorPostingGroup.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestPaymentTerms.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestPaymentMethod.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestGenBusPostGroup.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestVATBusPostGroup.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestPurchaser.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestRespCenter.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestICPartner.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestLocation.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestShipmentMethod.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestBaseCalendar.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestCurrency.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestDimensionValue.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        if Lrec_SourceVendor.GET(Lcode_Vendor) then begin
                            if not Lrec_DestVendor.GET(Lcode_Vendor) then begin
                                // Tests concernant les autres champs puis insertion de l'enregistrement si pas d'erreur
                                if (Lrec_SourceVendor."Vendor Posting Group" <> '') and
                                   (not Lrec_DestVendorPostingGroup.GET(Lrec_SourceVendor."Vendor Posting Group")) then
                                    MESSAGE(text005, Lrec_SourceVendor."Vendor Posting Group", Grec_DuplicatingList.Name)
                                else
                                    if (Lrec_SourceVendor."Payment Terms Code" <> '') and
                                       (not Lrec_DestPaymentTerms.GET(Lrec_SourceVendor."Payment Terms Code")) then
                                        MESSAGE(text012, Lrec_SourceVendor."Payment Terms Code", Grec_DuplicatingList.Name)
                                    else
                                        if (Lrec_SourceVendor."Invoice Disc. Code" <> '') and
                                           (Lrec_SourceVendor."Invoice Disc. Code" <> Lrec_SourceVendor."No.") and
                                           (not Lrec_DestVendor.GET(Lrec_SourceVendor."Invoice Disc. Code")) then
                                            MESSAGE(text013, Lrec_SourceVendor."Invoice Disc. Code", Grec_DuplicatingList.Name)
                                        else
                                            if (Lrec_SourceVendor."Pay-to Vendor No." <> '') and
                                               (not Lrec_DestVendor.GET(Lrec_SourceVendor."Pay-to Vendor No.")) then
                                                MESSAGE(text014, Lrec_SourceVendor."Pay-to Vendor No.", Grec_DuplicatingList.Name)
                                            else
                                                if (Lrec_SourceVendor."Payment Method Code" <> '') and
                                                   (not Lrec_DestPaymentMethod.GET(Lrec_SourceVendor."Payment Method Code")) then
                                                    MESSAGE(text015, Lrec_SourceVendor."Payment Method Code", Grec_DuplicatingList.Name)
                                                else
                                                    if (Lrec_SourceVendor."Gen. Bus. Posting Group" <> '') and
                                                       (not Lrec_DestGenBusPostGroup.GET(Lrec_SourceVendor."Gen. Bus. Posting Group")) then
                                                        MESSAGE(text016, Lrec_SourceVendor."Gen. Bus. Posting Group", Grec_DuplicatingList.Name)
                                                    else
                                                        if (Lrec_SourceVendor."VAT Bus. Posting Group" <> '') and
                                                           (not Lrec_DestVATBusPostGroup.GET(Lrec_SourceVendor."VAT Bus. Posting Group")) then
                                                            MESSAGE(text017, Lrec_SourceVendor."VAT Bus. Posting Group", Grec_DuplicatingList.Name)
                                                        else
                                                            if (Lrec_SourceVendor."Purchaser Code" <> '') and
                                                               (not Lrec_DestPurchaser.GET(Lrec_SourceVendor."Purchaser Code")) then
                                                                MESSAGE(text018, Lrec_SourceVendor."Purchaser Code", Grec_DuplicatingList.Name)
                                                            else
                                                                if (Lrec_SourceVendor."Responsibility Center" <> '') and
                                                                   (not Lrec_DestRespCenter.GET(Lrec_SourceVendor."Responsibility Center")) then
                                                                    MESSAGE(text019, Lrec_SourceVendor."Responsibility Center", Grec_DuplicatingList.Name)
                                                                else
                                                                    if (Lrec_SourceVendor."IC Partner Code" <> '') and
                                                                       (not Lrec_DestICPartner.GET(Lrec_SourceVendor."IC Partner Code")) then
                                                                        MESSAGE(text020, Lrec_SourceVendor."IC Partner Code", Grec_DuplicatingList.Name)
                                                                    else
                                                                        if (Lrec_SourceVendor."Location Code" <> '') and
                                                                           (not Lrec_DestLocation.GET(Lrec_SourceVendor."Location Code")) then
                                                                            MESSAGE(text021, Lrec_SourceVendor."Location Code", Grec_DuplicatingList.Name)
                                                                        else
                                                                            if (Lrec_SourceVendor."Shipment Method Code" <> '') and
                                                                               (not Lrec_DestShipmentMethod.GET(Lrec_SourceVendor."Shipment Method Code")) then
                                                                                MESSAGE(text022, Lrec_SourceVendor."Shipment Method Code", Grec_DuplicatingList.Name)
                                                                            else
                                                                                if (Lrec_SourceVendor."Base Calendar Code" <> '') and
                                                                                   (not Lrec_DestBaseCalendar.GET(Lrec_SourceVendor."Base Calendar Code")) then
                                                                                    MESSAGE(text023, Lrec_SourceVendor."Base Calendar Code", Grec_DuplicatingList.Name)
                                                                                else
                                                                                    if (Lrec_SourceVendor."Currency Code" <> '') and
                                                                                       (not Lrec_DestCurrency.GET(Lrec_SourceVendor."Currency Code")) then
                                                                                        MESSAGE(text024, Lrec_SourceVendor."Currency Code", Grec_DuplicatingList.Name)
                                                                                    else begin
                                                                                        //Test Code postal, ville, compte bancaire, contact principal, pays et langue (avec cr‚ation automatique)
                                                                                        TestPostCode(Lrec_SourceVendor."Post Code", Lrec_SourceVendor.City);
                                                                                        if not TestDefaultBankAccountCode(Lcode_Vendor, Lrec_SourceVendor."BC6_Default Bank Account Code") then
                                                                                            MESSAGE(text007, Grec_DuplicatingList.Name, Lrec_SourceVendor."BC6_Default Bank Account Code", Lcode_Vendor)
                                                                                        else
                                                                                            if not TestCountryRegion(Lrec_SourceVendor."Country/Region Code") then
                                                                                                MESSAGE(text010, Grec_DuplicatingList.Name, Lrec_SourceVendor."Country/Region Code")
                                                                                            else
                                                                                                if not TestLanguage(Lrec_SourceVendor."Language Code") then
                                                                                                    MESSAGE(text025, Grec_DuplicatingList.Name, Lrec_SourceVendor."Language Code")
                                                                                                else
                                                                                                    if not TestContactPrincipal(Lrec_SourceVendor."Primary Contact No.", Lcode_Vendor) then
                                                                                                        MESSAGE(text035, Grec_DuplicatingList.Name, Lrec_SourceVendor."Primary Contact No.")
                                                                                                    else begin
                                                                                                        // Insertion de l'enregistrement
                                                                                                        Lrec_DestVendor.INIT();
                                                                                                        Lrec_DestVendor.TRANSFERFIELDS(Lrec_SourceVendor);
                                                                                                        Lrec_DestVendor.INSERT();
                                                                                                        COMMIT();
                                                                                                        //***** D‚but Dupliquer analytique *****
                                                                                                        if Grec_DuplicatingList.Dimension then begin
                                                                                                            DupliquerAnalytique(23, Lcode_Vendor);
                                                                                                            if Lrec_SourceGenLedgerSetup.FIND('-') then begin
                                                                                                                if (Lrec_SourceVendor."Global Dimension 1 Code" <> '') then
                                                                                                                    if not Lrec_DestDimensionValue.GET(Lrec_SourceGenLedgerSetup."Global Dimension 1 Code",
                                                                                                                                                   Lrec_SourceVendor."Global Dimension 1 Code") then begin
                                                                                                                        if Lrec_DestVendor.GET(Lcode_Vendor) then begin
                                                                                                                            Lrec_DestVendor.VALIDATE(Lrec_DestVendor."Global Dimension 1 Code", '');
                                                                                                                            Lrec_DestVendor.MODIFY();
                                                                                                                        end;
                                                                                                                        MESSAGE(text089, Grec_DuplicatingList.Name, Lrec_SourceGenLedgerSetup."Global Dimension 1 Code",
                                                                                                                                        Lrec_SourceVendor."Global Dimension 1 Code");
                                                                                                                    end;
                                                                                                                if (Lrec_SourceVendor."Global Dimension 2 Code" <> '') then
                                                                                                                    if not Lrec_DestDimensionValue.GET(Lrec_SourceGenLedgerSetup."Global Dimension 2 Code",
                                                                                                                                                   Lrec_SourceVendor."Global Dimension 2 Code") then begin
                                                                                                                        if Lrec_DestVendor.GET(Lcode_Vendor) then begin
                                                                                                                            Lrec_DestVendor.VALIDATE(Lrec_DestVendor."Global Dimension 2 Code", '');
                                                                                                                            Lrec_DestVendor.MODIFY();
                                                                                                                        end;
                                                                                                                        MESSAGE(text090, Grec_DuplicatingList.Name, Lrec_SourceGenLedgerSetup."Global Dimension 2 Code",
                                                                                                                                        Lrec_SourceVendor."Global Dimension 2 Code");
                                                                                                                    end;
                                                                                                            end;
                                                                                                        end else
                                                                                                            if Lrec_DestVendor.GET(Lcode_Vendor) then begin
                                                                                                                Lrec_DestVendor.VALIDATE(Lrec_DestVendor."Global Dimension 1 Code", '');
                                                                                                                Lrec_DestVendor.VALIDATE(Lrec_DestVendor."Global Dimension 2 Code", '');
                                                                                                                Lrec_DestVendor.MODIFY();
                                                                                                            end;
                                                                                                        //***** Fin Dupliquer analytique *****
                                                                                                        Lint_DuplicationNumber += 1;
                                                                                                        Grec_DuplicatingList.Echec := false;
                                                                                                        Grec_DuplicatingList.MODIFY();
                                                                                                        //              MESSAGE(text004,Lcode_Vendor,Grec_DuplicatingList.Name);   // La fiche fournisseur a ‚t‚ dupliqu‚e
                                                                                                    end;
                                                                                    end;
                            end else
                                MESSAGE(text002, Lcode_Vendor, Grec_DuplicatingList.Name);   // La fiche fournisseur existe d‚j… dans la soci‚t‚ !
                        end else
                            MESSAGE(text003, Lcode_Vendor, COMPANYNAME);   // La fiche fournisseur n'existe pas dans la soci‚t‚
                    end;
                end;
            until Grec_DuplicatingList.NEXT() = 0;
    end;

    procedure CreateAccount(Lcode_Account: Code[20]) Lint_DuplicationNumber: Integer;
    var
        Lrec_DestDimensionValue: Record "Dimension Value";
        Lrec_DestAccount: Record "G/L Account";
        Lrec_SourceAccount: Record "G/L Account";
        Lrec_DestGenBusPostGroup: Record "Gen. Business Posting Group";
        Lrec_DestGenProdPostGroup: Record "Gen. Product Posting Group";
        Lrec_SourceGenLedgerSetup: Record "General Ledger Setup";
        Lrec_DestIC_GL_Account: Record "IC G/L Account";
        Lrec_DestTaxArea: Record "Tax Area";
        Lrec_DestTaxGroup: Record "Tax Group";
        Lrec_DestVATBusPostGroup: Record "VAT Business Posting Group";
        Lrec_DestVATProdPostGroup: Record "VAT Product Posting Group";
    begin
        Lint_DuplicationNumber := 0;
        if Grec_DuplicatingList.FIND('-') then
            repeat
                if Grec_DuplicatingList.Duplication then begin
                    Grec_DuplicatingList.Echec := true;
                    Grec_DuplicatingList.MODIFY();
                    if Lrec_DestAccount.CHANGECOMPANY(Grec_DuplicatingList.Name) then begin
                        Lrec_DestGenBusPostGroup.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestGenProdPostGroup.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestTaxArea.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestTaxGroup.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestVATBusPostGroup.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestVATProdPostGroup.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestIC_GL_Account.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestDimensionValue.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        if Lrec_SourceAccount.GET(Lcode_Account) then begin
                            if not Lrec_DestAccount.GET(Lcode_Account) then begin
                                // Tests concernant les autres champs puis insertion de l'enregistrement si pas d'erreur
                                if (Lrec_SourceAccount."Gen. Bus. Posting Group" <> '') and
                                   (not Lrec_DestGenBusPostGroup.GET(Lrec_SourceAccount."Gen. Bus. Posting Group")) then
                                    MESSAGE(text041, Lrec_SourceAccount."Gen. Bus. Posting Group", Grec_DuplicatingList.Name)
                                else
                                    if (Lrec_SourceAccount."Gen. Prod. Posting Group" <> '') and
                                  (not Lrec_DestGenProdPostGroup.GET(Lrec_SourceAccount."Gen. Prod. Posting Group")) then
                                        MESSAGE(text042, Lrec_SourceAccount."Gen. Prod. Posting Group", Grec_DuplicatingList.Name)
                                    else
                                        if (Lrec_SourceAccount."Tax Area Code" <> '') and
                                      (not Lrec_DestTaxArea.GET(Lrec_SourceAccount."Tax Area Code")) then
                                            MESSAGE(text043, Lrec_SourceAccount."Tax Area Code", Grec_DuplicatingList.Name)
                                        else
                                            if (Lrec_SourceAccount."Tax Group Code" <> '') and
                                          (not Lrec_DestTaxGroup.GET(Lrec_SourceAccount."Tax Group Code")) then
                                                MESSAGE(text044, Lrec_SourceAccount."Tax Group Code", Grec_DuplicatingList.Name)
                                            else
                                                if (Lrec_SourceAccount."VAT Bus. Posting Group" <> '') and
                                              (not Lrec_DestVATBusPostGroup.GET(Lrec_SourceAccount."VAT Bus. Posting Group")) then
                                                    MESSAGE(text045, Lrec_SourceAccount."VAT Bus. Posting Group", Grec_DuplicatingList.Name)
                                                else
                                                    if (Lrec_SourceAccount."VAT Prod. Posting Group" <> '') and
                                                  (not Lrec_DestVATProdPostGroup.GET(Lrec_SourceAccount."VAT Prod. Posting Group")) then
                                                        MESSAGE(text046, Lrec_SourceAccount."VAT Prod. Posting Group", Grec_DuplicatingList.Name)
                                                    else
                                                        if (Lrec_SourceAccount."Default IC Partner G/L Acc. No" <> '') and
                                                      (not Lrec_DestIC_GL_Account.GET(Lrec_SourceAccount."Default IC Partner G/L Acc. No")) then
                                                            MESSAGE(text047, Lrec_SourceAccount."Default IC Partner G/L Acc. No", Grec_DuplicatingList.Name)
                                                        else begin
                                                            // Insertion de l'enregistrement
                                                            Lrec_DestAccount.INIT();
                                                            Lrec_DestAccount.TRANSFERFIELDS(Lrec_SourceAccount);
                                                            Lrec_DestAccount.INSERT();
                                                            COMMIT();
                                                            //***** D‚but Dupliquer analytique *****
                                                            if Grec_DuplicatingList.Dimension then begin
                                                                DupliquerAnalytique(15, Lcode_Account);
                                                                if Lrec_SourceGenLedgerSetup.FIND('-') then begin
                                                                    if (Lrec_SourceAccount."Global Dimension 1 Code" <> '') then
                                                                        if not Lrec_DestDimensionValue.GET(Lrec_SourceGenLedgerSetup."Global Dimension 1 Code",
                                                                                                       Lrec_SourceAccount."Global Dimension 1 Code") then begin
                                                                            if Lrec_DestAccount.GET(Lcode_Account) then begin
                                                                                Lrec_DestAccount.VALIDATE(Lrec_DestAccount."Global Dimension 1 Code", '');
                                                                                Lrec_DestAccount.MODIFY();
                                                                            end;
                                                                            MESSAGE(text089, Grec_DuplicatingList.Name, Lrec_SourceGenLedgerSetup."Global Dimension 1 Code",
                                                                                            Lrec_SourceAccount."Global Dimension 1 Code");
                                                                        end;
                                                                    if (Lrec_SourceAccount."Global Dimension 2 Code" <> '') then
                                                                        if not Lrec_DestDimensionValue.GET(Lrec_SourceGenLedgerSetup."Global Dimension 2 Code",
                                                                                                       Lrec_SourceAccount."Global Dimension 2 Code") then begin
                                                                            if Lrec_DestAccount.GET(Lcode_Account) then begin
                                                                                Lrec_DestAccount.VALIDATE(Lrec_DestAccount."Global Dimension 2 Code", '');
                                                                                Lrec_DestAccount.MODIFY();
                                                                            end;
                                                                            MESSAGE(text090, Grec_DuplicatingList.Name, Lrec_SourceGenLedgerSetup."Global Dimension 2 Code",
                                                                                            Lrec_SourceAccount."Global Dimension 2 Code");
                                                                        end;
                                                                end;
                                                            end else
                                                                if Lrec_DestAccount.GET(Lcode_Account) then begin
                                                                    Lrec_DestAccount.VALIDATE(Lrec_DestAccount."Global Dimension 1 Code", '');
                                                                    Lrec_DestAccount.VALIDATE(Lrec_DestAccount."Global Dimension 2 Code", '');
                                                                    Lrec_DestAccount.MODIFY();
                                                                end;
                                                            //***** Fin Dupliquer analytique *****
                                                            Lint_DuplicationNumber += 1;
                                                            Grec_DuplicatingList.Echec := false;
                                                            Grec_DuplicatingList.MODIFY();
                                                            //            MESSAGE(text006,Lcode_Account,Grec_DuplicatingList.Name);   // La fiche compte g‚n‚ral a ‚t‚ dupliqu‚e
                                                        end;
                            end else
                                MESSAGE(text039, Lcode_Account, Grec_DuplicatingList.Name);   // La fiche compte g‚n‚ral existe d‚j… dans la soci‚t‚ !
                        end else
                            MESSAGE(text040, Lcode_Account, COMPANYNAME);   // La fiche compte g‚n‚ral n'existe pas dans la soci‚t‚
                    end;
                end;
            until Grec_DuplicatingList.NEXT() = 0;
    end;

    procedure CreateItem(Lcode_Item: Code[20]) Lint_DuplicationNumber: Integer;
    var
        Lrec_DestDimensionValue: Record "Dimension Value";
        Lrec_DestGenProdPostingGroup: Record "Gen. Product Posting Group";
        Lrec_SourceGenLedgerSetup: Record "General Ledger Setup";
        Lrec_DestInvPostGroup: Record "Inventory Posting Group";
        Lrec_DestAlternativeItem: Record Item;
        Lrec_DestItem: Record Item;
        Lrec_SourceItem: Record Item;
        Lrec_DestItemCategory: Record "Item Category";
        Lrec_DestItemDiscGroup: Record "Item Discount Group";
        Lrec_DestItemTracking: Record "Item Tracking Code";
        Lrec_DestManufacturer: Record Manufacturer;
        Lrec_DestNoSeries: Record "No. Series";
        Lrec_DestPhysInvtCountPeriod: Record "Phys. Invt. Counting Period";
        Lrec_DestProdBOM: Record "Production BOM Header";
        Lrec_DestPutawayTemplate: Record "Put-away Template Header";
        Lrec_DestRouting: Record "Routing Header";
        // Lrec_DestProductGroup: Record "Product Group";
        Lrec_DestServiceItemGroup: Record "Service Item Group";
        Lrec_DestSpecialEquipment: Record "Special Equipment";
        Lrec_DestTariffNumber: Record "Tariff Number";
        Lrec_DestTaxGroup: Record "Tax Group";
        Lrec_DestVATBusPostGroup: Record "VAT Business Posting Group";
        Lrec_DestVATProdPostGroup: Record "VAT Product Posting Group";
        Lrec_DestVendor: Record Vendor;
    begin
        Lint_DuplicationNumber := 0;
        if Grec_DuplicatingList.FIND('-') then
            repeat
                if Grec_DuplicatingList.Duplication then begin
                    Grec_DuplicatingList.Echec := true;
                    Grec_DuplicatingList.MODIFY();
                    if Lrec_DestItem.CHANGECOMPANY(Grec_DuplicatingList.Name) then begin
                        Lrec_DestGenProdPostingGroup.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestInvPostGroup.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestItemDiscGroup.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestVendor.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestAlternativeItem.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestTariffNumber.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestVATBusPostGroup.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestNoSeries.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestTaxGroup.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestVATProdPostGroup.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestManufacturer.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestItemCategory.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        // Lrec_DestProductGroup.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestServiceItemGroup.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestItemTracking.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestSpecialEquipment.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestPutawayTemplate.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestPhysInvtCountPeriod.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestProdBOM.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestRouting.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestDimensionValue.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        if Lrec_SourceItem.GET(Lcode_Item) then begin
                            if not Lrec_DestItem.GET(Lcode_Item) then begin
                                // Tests concernant les autres champs puis insertion de l'enregistrement si pas d'erreur
                                if (Lrec_SourceItem."Gen. Prod. Posting Group" <> '') and
                                   (not Lrec_DestGenProdPostingGroup.GET(Lrec_SourceItem."Gen. Prod. Posting Group")) then
                                    MESSAGE(text049, Lrec_SourceItem."Gen. Prod. Posting Group", Grec_DuplicatingList.Name)
                                else
                                    if (Lrec_SourceItem."Inventory Posting Group" <> '') and
                                  (not Lrec_DestInvPostGroup.GET(Lrec_SourceItem."Inventory Posting Group")) then
                                        MESSAGE(text058, Lrec_SourceItem."Inventory Posting Group", Grec_DuplicatingList.Name)
                                    else
                                        if (Lrec_SourceItem."Item Disc. Group" <> '') and
                                      (not Lrec_DestItemDiscGroup.GET(Lrec_SourceItem."Item Disc. Group")) then
                                            MESSAGE(text059, Lrec_SourceItem."Item Disc. Group", Grec_DuplicatingList.Name)
                                        else
                                            if (Lrec_SourceItem."Vendor No." <> '') and
                                          (not Lrec_DestVendor.GET(Lrec_SourceItem."Vendor No.")) then
                                                MESSAGE(text060, Lrec_SourceItem."Vendor No.", Grec_DuplicatingList.Name)
                                            else
                                                if (Lrec_SourceItem."Alternative Item No." <> '') and
                                              (not Lrec_DestAlternativeItem.GET(Lrec_SourceItem."Alternative Item No.")) then
                                                    MESSAGE(text061, Lrec_SourceItem."Alternative Item No.", Grec_DuplicatingList.Name)
                                                else
                                                    if (Lrec_SourceItem."Tariff No." <> '') and
                                                  (not Lrec_DestTariffNumber.GET(Lrec_SourceItem."Tariff No.")) then
                                                        MESSAGE(text062, Lrec_SourceItem."Tariff No.", Grec_DuplicatingList.Name)
                                                    else
                                                        if (Lrec_SourceItem."VAT Bus. Posting Gr. (Price)" <> '') and
                                                      (not Lrec_DestVATBusPostGroup.GET(Lrec_SourceItem."VAT Bus. Posting Gr. (Price)")) then
                                                            MESSAGE(text063, Lrec_SourceItem."VAT Bus. Posting Gr. (Price)", Grec_DuplicatingList.Name)
                                                        else
                                                            if (Lrec_SourceItem."No. Series" <> '') and
                                                          (not Lrec_DestNoSeries.GET(Lrec_SourceItem."No. Series")) then
                                                                MESSAGE(text064, Lrec_SourceItem."No. Series", Grec_DuplicatingList.Name)
                                                            else
                                                                if (Lrec_SourceItem."Tax Group Code" <> '') and
                                                              (not Lrec_DestTaxGroup.GET(Lrec_SourceItem."Tax Group Code")) then
                                                                    MESSAGE(text065, Lrec_SourceItem."Tax Group Code", Grec_DuplicatingList.Name)
                                                                else
                                                                    if (Lrec_SourceItem."VAT Prod. Posting Group" <> '') and
                                                                  (not Lrec_DestVATProdPostGroup.GET(Lrec_SourceItem."VAT Prod. Posting Group")) then
                                                                        MESSAGE(text066, Lrec_SourceItem."VAT Prod. Posting Group", Grec_DuplicatingList.Name)
                                                                    else
                                                                        if (Lrec_SourceItem."Serial Nos." <> '') and
                                                                      (not Lrec_DestNoSeries.GET(Lrec_SourceItem."Serial Nos.")) then
                                                                            MESSAGE(text067, Lrec_SourceItem."Serial Nos.", Grec_DuplicatingList.Name)
                                                                        else
                                                                            if (Lrec_SourceItem."Manufacturer Code" <> '') and
                                                                          (not Lrec_DestManufacturer.GET(Lrec_SourceItem."Manufacturer Code")) then
                                                                                MESSAGE(text068, Lrec_SourceItem."Manufacturer Code", Grec_DuplicatingList.Name)
                                                                            else
                                                                                if (Lrec_SourceItem."Item Category Code" <> '') and
                                                                              (not Lrec_DestItemCategory.GET(Lrec_SourceItem."Item Category Code")) then
                                                                                    MESSAGE(text069, Lrec_SourceItem."Item Category Code", Grec_DuplicatingList.Name)
                                                                                // ELSE TODO: Field 'Product Group Code' is removed
                                                                                //     IF (Lrec_SourceItem."Product Group Code" <> '') AND
                                                                                //   (NOT Lrec_DestProductGroup.GET(Lrec_SourceItem."Item Category Code", Lrec_SourceItem."Product Group Code")) THEN
                                                                                //         MESSAGE(text070, Lrec_SourceItem."Product Group Code", Grec_DuplicatingList.Name)
                                                                                else
                                                                                    if (Lrec_SourceItem."Service Item Group" <> '') and
                                                                                  (not Lrec_DestServiceItemGroup.GET(Lrec_SourceItem."Service Item Group")) then
                                                                                        MESSAGE(text071, Lrec_SourceItem."Service Item Group", Grec_DuplicatingList.Name)
                                                                                    else
                                                                                        if (Lrec_SourceItem."Item Tracking Code" <> '') and
                                                                                      (not Lrec_DestItemTracking.GET(Lrec_SourceItem."Item Tracking Code")) then
                                                                                            MESSAGE(text072, Lrec_SourceItem."Item Tracking Code", Grec_DuplicatingList.Name)
                                                                                        else
                                                                                            if (Lrec_SourceItem."Lot Nos." <> '') and
                                                                                          (not Lrec_DestNoSeries.GET(Lrec_SourceItem."Lot Nos.")) then
                                                                                                MESSAGE(text073, Lrec_SourceItem."Lot Nos.", Grec_DuplicatingList.Name)
                                                                                            else
                                                                                                if (Lrec_SourceItem."Special Equipment Code" <> '') and
                                                                                              (not Lrec_DestSpecialEquipment.GET(Lrec_SourceItem."Special Equipment Code")) then
                                                                                                    MESSAGE(text074, Lrec_SourceItem."Special Equipment Code", Grec_DuplicatingList.Name)
                                                                                                else
                                                                                                    if (Lrec_SourceItem."Put-away Template Code" <> '') and
                                                                                                  (not Lrec_DestPutawayTemplate.GET(Lrec_SourceItem."Put-away Template Code")) then
                                                                                                        MESSAGE(text075, Lrec_SourceItem."Put-away Template Code", Grec_DuplicatingList.Name)
                                                                                                    else
                                                                                                        if (Lrec_SourceItem."Phys Invt Counting Period Code" <> '') and
                                                                                                      (not Lrec_DestPhysInvtCountPeriod.GET(Lrec_SourceItem."Phys Invt Counting Period Code")) then
                                                                                                            MESSAGE(text076, Lrec_SourceItem."Phys Invt Counting Period Code", Grec_DuplicatingList.Name)
                                                                                                        else
                                                                                                            if (Lrec_SourceItem."Routing No." <> '') and
                                                                                                          (not Lrec_DestRouting.GET(Lrec_SourceItem."Routing No.")) then
                                                                                                                MESSAGE(text080, Lrec_SourceItem."Routing No.", Grec_DuplicatingList.Name)
                                                                                                            else
                                                                                                                if (Lrec_SourceItem."Production BOM No." <> '') and
                                                                                                              (not Lrec_DestProdBOM.GET(Lrec_SourceItem."Production BOM No.")) then
                                                                                                                    MESSAGE(text081, Lrec_SourceItem."Production BOM No.", Grec_DuplicatingList.Name)
                                                                                                                else begin
                                                                                                                    //Test code pays et code unit‚ (avec cr‚ation automatique)
                                                                                                                    if not TestCountryRegion(Lrec_SourceItem."Country/Region of Origin Code") then
                                                                                                                        MESSAGE(text050, Grec_DuplicatingList.Name, Lrec_SourceItem."Country/Region of Origin Code")
                                                                                                                    else
                                                                                                                        if not TestCountryRegion(Lrec_SourceItem."Country/Region Purchased Code") then
                                                                                                                            MESSAGE(text053, Grec_DuplicatingList.Name, Lrec_SourceItem."Country/Region Purchased Code")
                                                                                                                        else
                                                                                                                            if not TestUnitItem(Lcode_Item, Lrec_SourceItem."Base Unit of Measure") then
                                                                                                                                MESSAGE(text054, Grec_DuplicatingList.Name, Lrec_SourceItem."Base Unit of Measure")
                                                                                                                            else
                                                                                                                                if not TestUnitItem(Lcode_Item, Lrec_SourceItem."Sales Unit of Measure") then
                                                                                                                                    MESSAGE(text055, Grec_DuplicatingList.Name, Lrec_SourceItem."Sales Unit of Measure")
                                                                                                                                else
                                                                                                                                    if not TestUnitItem(Lcode_Item, Lrec_SourceItem."Purch. Unit of Measure") then
                                                                                                                                        MESSAGE(text056, Grec_DuplicatingList.Name, Lrec_SourceItem."Purch. Unit of Measure")
                                                                                                                                    else
                                                                                                                                        if not TestUnitItem(Lcode_Item, Lrec_SourceItem."Put-away Unit of Measure Code") then
                                                                                                                                            MESSAGE(text077, Grec_DuplicatingList.Name, Lrec_SourceItem."Put-away Unit of Measure Code")
                                                                                                                                        else begin
                                                                                                                                            // Insertion de l'enregistrement
                                                                                                                                            Lrec_DestItem.INIT();
                                                                                                                                            Lrec_DestItem.TRANSFERFIELDS(Lrec_SourceItem);
                                                                                                                                            Lrec_DestItem.INSERT();
                                                                                                                                            COMMIT();
                                                                                                                                            //***** D‚but Dupliquer analytique *****
                                                                                                                                            if Grec_DuplicatingList.Dimension then begin
                                                                                                                                                DupliquerAnalytique(27, Lcode_Item);
                                                                                                                                                if Lrec_SourceGenLedgerSetup.FIND('-') then begin
                                                                                                                                                    if (Lrec_SourceItem."Global Dimension 1 Code" <> '') then
                                                                                                                                                        if not Lrec_DestDimensionValue.GET(Lrec_SourceGenLedgerSetup."Global Dimension 1 Code",
                                                                                                                                                                                       Lrec_SourceItem."Global Dimension 1 Code") then begin
                                                                                                                                                            if Lrec_DestVendor.GET(Lcode_Item) then begin
                                                                                                                                                                Lrec_DestVendor.VALIDATE(Lrec_DestVendor."Global Dimension 1 Code", '');
                                                                                                                                                                Lrec_DestVendor.MODIFY();
                                                                                                                                                            end;
                                                                                                                                                            MESSAGE(text089, Grec_DuplicatingList.Name, Lrec_SourceGenLedgerSetup."Global Dimension 1 Code",
                                                                                                                                                                            Lrec_SourceItem."Global Dimension 1 Code");
                                                                                                                                                        end;
                                                                                                                                                    if (Lrec_SourceItem."Global Dimension 2 Code" <> '') then
                                                                                                                                                        if not Lrec_DestDimensionValue.GET(Lrec_SourceGenLedgerSetup."Global Dimension 2 Code",
                                                                                                                                                                                       Lrec_SourceItem."Global Dimension 2 Code") then begin
                                                                                                                                                            if Lrec_DestVendor.GET(Lcode_Item) then begin
                                                                                                                                                                Lrec_DestVendor.VALIDATE(Lrec_DestVendor."Global Dimension 2 Code", '');
                                                                                                                                                                Lrec_DestVendor.MODIFY();
                                                                                                                                                            end;
                                                                                                                                                            MESSAGE(text090, Grec_DuplicatingList.Name, Lrec_SourceGenLedgerSetup."Global Dimension 2 Code",
                                                                                                                                                                            Lrec_SourceItem."Global Dimension 2 Code");
                                                                                                                                                        end;
                                                                                                                                                end;
                                                                                                                                            end else
                                                                                                                                                if Lrec_DestItem.GET(Lcode_Item) then begin
                                                                                                                                                    Lrec_DestItem.VALIDATE(Lrec_DestItem."Global Dimension 1 Code", '');
                                                                                                                                                    Lrec_DestItem.VALIDATE(Lrec_DestItem."Global Dimension 2 Code", '');
                                                                                                                                                    Lrec_DestItem.MODIFY();
                                                                                                                                                end;
                                                                                                                                            //***** Fin Dupliquer analytique *****
                                                                                                                                            Lint_DuplicationNumber += 1;
                                                                                                                                            Grec_DuplicatingList.Echec := false;
                                                                                                                                            Grec_DuplicatingList.MODIFY();
                                                                                                                                        end;
                                                                                                                end;
                            end else
                                MESSAGE(text051, Lcode_Item, Grec_DuplicatingList.Name);   // La fiche article existe d‚j… dans la soci‚t‚ !
                        end else
                            MESSAGE(text052, Lcode_Item, COMPANYNAME);   // La fiche article n'existe pas dans la soci‚t‚
                    end;
                end;
            until Grec_DuplicatingList.NEXT() = 0;
    end;

    procedure CreateBankAccount(Lcode_Account1: Code[20]; Lcode_Account2: Code[10]) Lint_DuplicationNumber: Integer;
    var
        Lrec_DestCurrency: Record Currency;
        Lrec_DestVendor: Record Vendor;
        Lrec_DestVendorBankAccount: Record "Vendor Bank Account";
        Lrec_SourceVendorBankAccount: Record "Vendor Bank Account";
    begin
        Lint_DuplicationNumber := 0;
        if Grec_DuplicatingList.FIND('-') then
            repeat
                if Grec_DuplicatingList.Duplication then begin
                    Grec_DuplicatingList.Echec := true;
                    Grec_DuplicatingList.MODIFY();
                    if Lrec_DestVendorBankAccount.CHANGECOMPANY(Grec_DuplicatingList.Name) then begin
                        Lrec_DestCurrency.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        Lrec_DestVendor.CHANGECOMPANY(Grec_DuplicatingList.Name);
                        if Lrec_SourceVendorBankAccount.GET(Lcode_Account1, Lcode_Account2) then begin
                            if Lrec_DestVendorBankAccount.GET(Lcode_Account1, Lcode_Account2) then begin
                                //DEBUT MODIF JX-XAD 31/03/2011
                                if Lrec_SourceVendorBankAccount.Name <> Lrec_DestVendorBankAccount.Name then
                                    Lrec_DestVendorBankAccount.Name := Lrec_SourceVendorBankAccount.Name;
                                if Lrec_SourceVendorBankAccount."Name 2" <> Lrec_DestVendorBankAccount."Name 2" then
                                    Lrec_DestVendorBankAccount."Name 2" := Lrec_SourceVendorBankAccount."Name 2";
                                if Lrec_SourceVendorBankAccount.Address <> Lrec_DestVendorBankAccount.Address then
                                    Lrec_DestVendorBankAccount.Address := Lrec_SourceVendorBankAccount.Address;
                                TestPostCode(Lrec_SourceVendorBankAccount."Post Code", Lrec_SourceVendorBankAccount.City);
                                if Lrec_SourceVendorBankAccount.City <> Lrec_DestVendorBankAccount.City then
                                    Lrec_DestVendorBankAccount.City := Lrec_SourceVendorBankAccount.City;
                                if Lrec_SourceVendorBankAccount."Post Code" <> Lrec_DestVendorBankAccount."Post Code" then
                                    Lrec_DestVendorBankAccount."Post Code" := Lrec_SourceVendorBankAccount."Post Code";
                                if Lrec_SourceVendorBankAccount.Contact <> Lrec_DestVendorBankAccount.Contact then
                                    Lrec_DestVendorBankAccount.Contact := Lrec_SourceVendorBankAccount.Contact;
                                if Lrec_SourceVendorBankAccount."Phone No." <> Lrec_DestVendorBankAccount."Phone No." then
                                    Lrec_DestVendorBankAccount."Phone No." := Lrec_SourceVendorBankAccount."Phone No.";
                                if Lrec_SourceVendorBankAccount."Telex No." <> Lrec_DestVendorBankAccount."Telex No." then
                                    Lrec_DestVendorBankAccount."Telex No." := Lrec_SourceVendorBankAccount."Telex No.";
                                if Lrec_SourceVendorBankAccount."Bank Branch No." <> Lrec_DestVendorBankAccount."Bank Branch No." then begin
                                    Lrec_DestVendorBankAccount."Bank Branch No." := Lrec_SourceVendorBankAccount."Bank Branch No.";
                                    Lrec_DestVendorBankAccount."BC6_Change RIB/IBAN" := TODAY;
                                end;
                                if Lrec_SourceVendorBankAccount."Bank Account No." <> Lrec_DestVendorBankAccount."Bank Account No." then begin
                                    Lrec_DestVendorBankAccount."Bank Account No." := Lrec_SourceVendorBankAccount."Bank Account No.";
                                    Lrec_DestVendorBankAccount."BC6_Change RIB/IBAN" := TODAY;
                                end;
                                if Lrec_SourceVendorBankAccount."Transit No." <> Lrec_DestVendorBankAccount."Transit No." then
                                    Lrec_DestVendorBankAccount."Transit No." := Lrec_SourceVendorBankAccount."Transit No.";
                                if Lrec_SourceVendorBankAccount."Currency Code" <> Lrec_DestVendorBankAccount."Currency Code" then begin
                                    if (Lrec_SourceVendorBankAccount."Currency Code" <> '') and
                                       (not Lrec_DestCurrency.GET(Lrec_SourceVendorBankAccount."Currency Code")) then
                                        MESSAGE(text024, Lrec_SourceVendorBankAccount."Currency Code", Grec_DuplicatingList.Name)
                                    else
                                        Lrec_DestVendorBankAccount."Currency Code" := Lrec_SourceVendorBankAccount."Currency Code";
                                end;
                                if Lrec_SourceVendorBankAccount."Country/Region Code" <> Lrec_DestVendorBankAccount."Country/Region Code" then begin
                                    if not TestCountryRegion(Lrec_SourceVendorBankAccount."Country/Region Code") then
                                        MESSAGE(text010, Grec_DuplicatingList.Name, Lrec_SourceVendorBankAccount."Country/Region Code")
                                    else
                                        Lrec_DestVendorBankAccount."Country/Region Code" := Lrec_SourceVendorBankAccount."Country/Region Code";
                                end;
                                if Lrec_SourceVendorBankAccount.County <> Lrec_DestVendorBankAccount.County then
                                    Lrec_DestVendorBankAccount.County := Lrec_SourceVendorBankAccount.County;
                                if Lrec_SourceVendorBankAccount."Fax No." <> Lrec_DestVendorBankAccount."Fax No." then
                                    Lrec_DestVendorBankAccount."Fax No." := Lrec_SourceVendorBankAccount."Fax No.";
                                if Lrec_SourceVendorBankAccount."Telex Answer Back" <> Lrec_DestVendorBankAccount."Telex Answer Back" then
                                    Lrec_DestVendorBankAccount."Telex Answer Back" := Lrec_SourceVendorBankAccount."Telex Answer Back";
                                if Lrec_SourceVendorBankAccount."Language Code" <> Lrec_DestVendorBankAccount."Language Code" then begin
                                    if not TestLanguage(Lrec_SourceVendorBankAccount."Language Code") then
                                        MESSAGE(text025, Grec_DuplicatingList.Name, Lrec_SourceVendorBankAccount."Language Code")
                                    else
                                        Lrec_DestVendorBankAccount."Language Code" := Lrec_SourceVendorBankAccount."Language Code";
                                end;
                                if Lrec_SourceVendorBankAccount."E-Mail" <> Lrec_DestVendorBankAccount."E-Mail" then
                                    Lrec_DestVendorBankAccount."E-Mail" := Lrec_SourceVendorBankAccount."E-Mail";
                                if Lrec_SourceVendorBankAccount."Home Page" <> Lrec_DestVendorBankAccount."Home Page" then
                                    Lrec_DestVendorBankAccount."Home Page" := Lrec_SourceVendorBankAccount."Home Page";
                                if Lrec_SourceVendorBankAccount.IBAN <> Lrec_DestVendorBankAccount.IBAN then begin
                                    Lrec_DestVendorBankAccount.IBAN := Lrec_SourceVendorBankAccount.IBAN;
                                    Lrec_DestVendorBankAccount."BC6_Change RIB/IBAN" := TODAY;
                                end;
                                if Lrec_SourceVendorBankAccount."SWIFT Code" <> Lrec_DestVendorBankAccount."SWIFT Code" then begin
                                    Lrec_DestVendorBankAccount."SWIFT Code" := Lrec_SourceVendorBankAccount."SWIFT Code";
                                    Lrec_DestVendorBankAccount."BC6_Change RIB/IBAN" := TODAY;
                                end;
                                if Lrec_SourceVendorBankAccount."Agency Code" <> Lrec_DestVendorBankAccount."Agency Code" then begin
                                    Lrec_DestVendorBankAccount."Agency Code" := Lrec_SourceVendorBankAccount."Agency Code";
                                    Lrec_DestVendorBankAccount."BC6_Change RIB/IBAN" := TODAY;
                                end;
                                if Lrec_SourceVendorBankAccount."RIB Key" <> Lrec_DestVendorBankAccount."RIB Key" then begin
                                    Lrec_DestVendorBankAccount."RIB Key" := Lrec_SourceVendorBankAccount."RIB Key";
                                    Lrec_DestVendorBankAccount."BC6_Change RIB/IBAN" := TODAY;
                                end;
                                if Lrec_SourceVendorBankAccount."RIB Checked" <> Lrec_DestVendorBankAccount."RIB Checked" then
                                    Lrec_DestVendorBankAccount."RIB Checked" := Lrec_SourceVendorBankAccount."RIB Checked";
                                Lrec_DestVendorBankAccount.MODIFY();
                                COMMIT();
                                Lint_DuplicationNumber += 1;
                                Grec_DuplicatingList.Echec := false;
                                Grec_DuplicatingList.MODIFY();
                                //          MESSAGE(text096,Lcode_Account1,Lcode_Account2,Grec_DuplicatingList.Name); //La fiche compte bancaire a ‚t‚ mise … jour
                                //FIN MODIF JX-XAD 31/03/2011 : Modification du RIB si d‚j… existant
                            end else begin
                                // Tests concernant les autres champs puis insertion de l'enregistrement si pas d'erreur
                                if (Lrec_SourceVendorBankAccount."Currency Code" <> '') and
                                        (not Lrec_DestCurrency.GET(Lrec_SourceVendorBankAccount."Currency Code")) then
                                    MESSAGE(text024, Lrec_SourceVendorBankAccount."Currency Code", Grec_DuplicatingList.Name)
                                else
                                    if (Lcode_Account1 <> '') and
                                       (not Lrec_DestVendor.GET(Lcode_Account1)) then
                                        MESSAGE(text095, Lcode_Account1, Grec_DuplicatingList.Name)
                                    else begin
                                        //Test Code postal, ville, compte bancaire, contact principal, pays et langue (avec cr‚ation automatique)
                                        TestPostCode(Lrec_SourceVendorBankAccount."Post Code", Lrec_SourceVendorBankAccount.City);
                                        if not TestCountryRegion(Lrec_SourceVendorBankAccount."Country/Region Code") then
                                            MESSAGE(text010, Grec_DuplicatingList.Name, Lrec_SourceVendorBankAccount."Country/Region Code")
                                        else
                                            if not TestLanguage(Lrec_SourceVendorBankAccount."Language Code") then
                                                MESSAGE(text025, Grec_DuplicatingList.Name, Lrec_SourceVendorBankAccount."Language Code")
                                            else begin
                                                // Insertion de l'enregistrement
                                                Lrec_DestVendorBankAccount.INIT();
                                                Lrec_DestVendorBankAccount.TRANSFERFIELDS(Lrec_SourceVendorBankAccount);
                                                Lrec_DestVendorBankAccount.INSERT();
                                                COMMIT();
                                                Lint_DuplicationNumber += 1;
                                                Grec_DuplicatingList.Echec := false;
                                                Grec_DuplicatingList.MODIFY();
                                                MESSAGE(text092, Lcode_Account1, Lcode_Account2, Grec_DuplicatingList.Name); //La fiche compte bancaire a ‚t‚ dupliqu‚e
                                            end;
                                    end;
                            end;
                            //END; ELSE
                            //  MESSAGE(text093,Lcode_Account1,Lcode_Account2,Grec_DuplicatingList.Name); //Le compte bancaire existe d‚j… !
                        end else
                            MESSAGE(text094, Lcode_Account1, Lcode_Account2, COMPANYNAME);   // Le compte bancaire n'existe pas dans la soci‚t‚
                    end;
                end;
            until Grec_DuplicatingList.NEXT() = 0;
    end;

    procedure DupliquerAnalytique(Lint_Table: Integer; Lcode_Fiche: Code[20]);
    var
        Lrec_DefaultDimension: Record "Default Dimension";
        Lrec_DestDefaultDimension: Record "Default Dimension";
        Lrec_DestDimension: Record Dimension;
        Lrec_DestDimensionValue: Record "Dimension Value";
        Lcode_Axe: array[10] of Code[20];
        Lcode_Section: array[10] of Code[20];
        i: Integer;
        Lint_NbAxe: Integer;
        Lopt_ValuePosting: array[10] of Option ,"Code Mandatory","Same Code","No Code";
    begin
        Lrec_DestDefaultDimension.CHANGECOMPANY(Grec_DuplicatingList.Name);
        Lrec_DestDimension.CHANGECOMPANY(Grec_DuplicatingList.Name);
        Lrec_DestDimensionValue.CHANGECOMPANY(Grec_DuplicatingList.Name);
        Lint_NbAxe := 0;
        Lrec_DefaultDimension.RESET();
        Lrec_DefaultDimension.SETFILTER(Lrec_DefaultDimension."Table ID", '%1', Lint_Table);
        Lrec_DefaultDimension.SETFILTER(Lrec_DefaultDimension."No.", '%1', Lcode_Fiche);
        if Lrec_DefaultDimension.COUNT > 0 then begin
            if Lrec_DefaultDimension.FIND('-') then
                repeat
                    Lint_NbAxe += 1;
                    Lcode_Axe[Lint_NbAxe] := Lrec_DefaultDimension."Dimension Code";
                    Lcode_Section[Lint_NbAxe] := Lrec_DefaultDimension."Dimension Value Code";
                    Lopt_ValuePosting[Lint_NbAxe] := Lrec_DefaultDimension."Value Posting".AsInteger();
                until Lrec_DefaultDimension.NEXT() = 0;

            for i := 1 to Lint_NbAxe do begin
                if Lrec_DestDimension.GET(Lcode_Axe[i]) then begin
                    if Lrec_DestDimensionValue.GET(Lcode_Axe[i], Lcode_Section[i]) then begin
                        Lrec_DestDefaultDimension.INIT();
                        Lrec_DestDefaultDimension.VALIDATE(Lrec_DestDefaultDimension."Table ID", Lint_Table);
                        Lrec_DestDefaultDimension.VALIDATE(Lrec_DestDefaultDimension."No.", Lcode_Fiche);
                        Lrec_DestDefaultDimension.VALIDATE(Lrec_DestDefaultDimension."Dimension Code", Lcode_Axe[i]);
                        Lrec_DestDefaultDimension.VALIDATE(Lrec_DestDefaultDimension."Dimension Value Code", Lcode_Section[i]);
                        Lrec_DestDefaultDimension.VALIDATE(Lrec_DestDefaultDimension."Value Posting", Lopt_ValuePosting[i]);
                        Lrec_DestDefaultDimension.INSERT();
                    end else
                        if Lcode_Section[i] = '' then begin
                            Lrec_DestDefaultDimension.INIT();
                            Lrec_DestDefaultDimension.VALIDATE(Lrec_DestDefaultDimension."Table ID", Lint_Table);
                            Lrec_DestDefaultDimension.VALIDATE(Lrec_DestDefaultDimension."No.", Lcode_Fiche);
                            Lrec_DestDefaultDimension.VALIDATE(Lrec_DestDefaultDimension."Dimension Code", Lcode_Axe[i]);
                            Lrec_DestDefaultDimension.VALIDATE(Lrec_DestDefaultDimension."Dimension Value Code", '');
                            Lrec_DestDefaultDimension.VALIDATE(Lrec_DestDefaultDimension."Value Posting", Lopt_ValuePosting[i]);
                            Lrec_DestDefaultDimension.INSERT();
                        end else
                            MESSAGE(text038, Grec_DuplicatingList.Name, Lcode_Section[i], Lcode_Axe[i]);
                end else
                    MESSAGE(text037, Grec_DuplicatingList.Name, Lcode_Axe[i]);
            end;
            COMMIT();
        end;
    end;

    procedure TestPostCode(Lcode_PostCode: Code[20]; Ltxt_City: Text[30]) Lbool_OK: Boolean;
    var
        Lrec_DestPostCode: Record "Post Code";
        Lrec_SourcePostCode: Record "Post Code";
    begin
        if (Lcode_PostCode <> '') then begin // si pas de code postal, inutile de le dupliquer
            Lrec_DestPostCode.CHANGECOMPANY(Grec_DuplicatingList.Name);
            if not Lrec_DestPostCode.GET(Lcode_PostCode, Ltxt_City) then begin
                if Lrec_SourcePostCode.GET(Lcode_PostCode, Ltxt_City) then begin
                    Lrec_DestPostCode.INIT();
                    Lrec_DestPostCode.TRANSFERFIELDS(Lrec_SourcePostCode);
                    Lrec_DestPostCode.INSERT();
                    Lbool_OK := true;
                end else
                    Lbool_OK := false;
            end else
                Lbool_OK := true;
        end else
            Lbool_OK := true;
    end;

    procedure TestDefaultBankAccountCode(Lcode_Vendor: Code[20]; Lcode_Bank: Code[10]) Lbool_OK: Boolean;
    var
        Lrec_DestCurrency: Record Currency;
        Lrec_DestVendorBankAccount: Record "Vendor Bank Account";
        Lrec_SourceVendorBankAccount: Record "Vendor Bank Account";
    begin
        if Lcode_Bank <> '' then // si pas de code banque, inutile de le dupliquer
        begin
            Lrec_DestVendorBankAccount.CHANGECOMPANY(Grec_DuplicatingList.Name);
            Lrec_DestCurrency.CHANGECOMPANY(Grec_DuplicatingList.Name);
            if not Lrec_DestVendorBankAccount.GET(Lcode_Vendor, Lcode_Bank) then begin
                if Lrec_SourceVendorBankAccount.GET(Lcode_Vendor, Lcode_Bank) then begin
                    Lbool_OK := TestPostCode(Lrec_SourceVendorBankAccount."Post Code", Lrec_SourceVendorBankAccount.City);
                    if not Lbool_OK then
                        MESSAGE(text008, Grec_DuplicatingList.Name, Lrec_SourceVendorBankAccount."Post Code", Lrec_SourceVendorBankAccount.City)
                    else
                        if (Lrec_SourceVendorBankAccount."Currency Code" <> '') and
                           (not Lrec_DestCurrency.GET(Lrec_SourceVendorBankAccount."Currency Code")) then begin
                            MESSAGE(text009, Grec_DuplicatingList.Name, Lrec_SourceVendorBankAccount."Currency Code");
                            Lbool_OK := false;
                        end else
                            if not TestCountryRegion(Lrec_SourceVendorBankAccount."Country/Region Code") then begin
                                MESSAGE(text010, Grec_DuplicatingList.Name, Lrec_SourceVendorBankAccount."Country/Region Code");
                                Lbool_OK := false;
                            end else
                                if not TestLanguage(Lrec_SourceVendorBankAccount."Language Code") then begin
                                    MESSAGE(text011, Grec_DuplicatingList.Name, Lrec_SourceVendorBankAccount."Language Code");
                                    Lbool_OK := false;
                                end else begin
                                    Lrec_DestVendorBankAccount.INIT();
                                    Lrec_DestVendorBankAccount.TRANSFERFIELDS(Lrec_SourceVendorBankAccount);
                                    Lrec_DestVendorBankAccount.INSERT();
                                    Lbool_OK := true;
                                end;
                end else
                    Lbool_OK := false;
            end else
                Lbool_OK := true;
        end else
            Lbool_OK := true;
    end;

    procedure TestCountryRegion(Lcode_Country: Code[10]) Lbool_OK: Boolean;
    var
        Lrec_DestCountryRegion: Record "Country/Region";
        Lrec_SourceCountryRegion: Record "Country/Region";
    begin
        if (Lcode_Country <> '') then // si pas de code pays, inutile de le dupliquer
        begin
            Lrec_DestCountryRegion.CHANGECOMPANY(Grec_DuplicatingList.Name);
            if not Lrec_DestCountryRegion.GET(Lcode_Country) then begin
                if Lrec_SourceCountryRegion.GET(Lcode_Country) then begin
                    Lrec_DestCountryRegion.INIT();
                    Lrec_DestCountryRegion.TRANSFERFIELDS(Lrec_SourceCountryRegion);
                    Lrec_DestCountryRegion.INSERT();
                    Lbool_OK := true;
                end else
                    Lbool_OK := false;
            end else
                Lbool_OK := true;
        end else
            Lbool_OK := true;
    end;

    procedure TestLanguage(Lcode_Language: Code[10]) Lbool_OK: Boolean;
    var
        Lrec_DestLanguage: Record Language;
        Lrec_SourceLanguage: Record Language;
    begin
        if (Lcode_Language <> '') then // si pas de code langue, inutile de le dupliquer
        begin
            Lrec_DestLanguage.CHANGECOMPANY(Grec_DuplicatingList.Name);
            if not Lrec_DestLanguage.GET(Lcode_Language) then begin
                if Lrec_SourceLanguage.GET(Lcode_Language) then begin
                    Lrec_DestLanguage.INIT();
                    Lrec_DestLanguage.TRANSFERFIELDS(Lrec_SourceLanguage);
                    Lrec_DestLanguage.INSERT();
                    Lbool_OK := true;
                end else
                    Lbool_OK := false;
            end else
                Lbool_OK := true;
        end else
            Lbool_OK := true;
    end;

    procedure TestContactPrincipal(Lcode_Contact: Code[20]; Lcode_Vendor: Code[20]) Lbool_OK: Boolean;
    var
        Lrec_DestBuinesssRelation: Record "Business Relation";
        Lrec_DestContact: Record Contact;
        Lrec_SourceContact: Record Contact;
        Lrec_DestContBusRel: Record "Contact Business Relation";
        Lrec_SourceContBusRel: Record "Contact Business Relation";
        Lrec_DestCurrency: Record Currency;
        Lrec_DestNoSeries: Record "No. Series";
        Lrec_DestOrganizationalLevel: Record "Organizational Level";
        Lrec_DestSalesperson: Record "Salesperson/Purchaser";
        Lrec_DestSalutation: Record Salutation;
        Lrec_DestTerritory: Record Territory;
    begin
        if Lcode_Contact <> '' then // si pas de code contact, inutile de le dupliquer
        begin
            Lrec_DestContact.CHANGECOMPANY(Grec_DuplicatingList.Name);
            Lrec_DestCurrency.CHANGECOMPANY(Grec_DuplicatingList.Name);
            Lrec_DestTerritory.CHANGECOMPANY(Grec_DuplicatingList.Name);
            Lrec_DestSalesperson.CHANGECOMPANY(Grec_DuplicatingList.Name);
            Lrec_DestNoSeries.CHANGECOMPANY(Grec_DuplicatingList.Name);
            Lrec_DestSalutation.CHANGECOMPANY(Grec_DuplicatingList.Name);
            Lrec_DestOrganizationalLevel.CHANGECOMPANY(Grec_DuplicatingList.Name);
            Lrec_DestContBusRel.CHANGECOMPANY(Grec_DuplicatingList.Name);
            if not Lrec_DestContact.GET(Lcode_Contact) then begin
                if Lrec_SourceContact.GET(Lcode_Contact) then begin
                    Lbool_OK := TestPostCode(Lrec_SourceContact."Post Code", Lrec_SourceContact.City);
                    if not Lbool_OK then
                        MESSAGE(text026, Grec_DuplicatingList.Name, Lrec_SourceContact."Post Code", Lrec_SourceContact.City)
                    else
                        if (Lrec_SourceContact."Currency Code" <> '') and
                           (not Lrec_DestCurrency.GET(Lrec_SourceContact."Currency Code")) then begin
                            MESSAGE(text027, Grec_DuplicatingList.Name, Lrec_SourceContact."Currency Code");
                            Lbool_OK := false;
                        end else
                            if (Lrec_SourceContact."Territory Code" <> '') and
                           (not Lrec_DestTerritory.GET(Lrec_SourceContact."Territory Code")) then begin
                                MESSAGE(text030, Grec_DuplicatingList.Name, Lrec_SourceContact."Territory Code");
                                Lbool_OK := false;
                            end else
                                if (Lrec_SourceContact."Salesperson Code" <> '') and
                               (not Lrec_DestSalesperson.GET(Lrec_SourceContact."Salesperson Code")) then begin
                                    MESSAGE(text031, Grec_DuplicatingList.Name, Lrec_SourceContact."Salesperson Code");
                                    Lbool_OK := false;
                                end else
                                    if (Lrec_SourceContact."No. Series" <> '') and
                                   (not Lrec_DestNoSeries.GET(Lrec_SourceContact."No. Series")) then begin
                                        MESSAGE(text032, Grec_DuplicatingList.Name, Lrec_SourceContact."No. Series");
                                        Lbool_OK := false;
                                    end else
                                        if (Lrec_SourceContact."Organizational Level Code" <> '') and
                                       (not Lrec_DestOrganizationalLevel.GET(Lrec_SourceContact."Organizational Level Code")) then begin
                                            MESSAGE(text033, Grec_DuplicatingList.Name, Lrec_SourceContact."Organizational Level Code");
                                            Lbool_OK := false;
                                        end else
                                            if (Lrec_SourceContact."Salutation Code" <> '') and
                                           (not Lrec_DestSalutation.GET(Lrec_SourceContact."Salutation Code")) then begin
                                                MESSAGE(text034, Grec_DuplicatingList.Name, Lrec_SourceContact."Salutation Code");
                                                Lbool_OK := false;
                                            end else
                                                if not TestCountryRegion(Lrec_SourceContact."Country/Region Code") then begin
                                                    MESSAGE(text028, Grec_DuplicatingList.Name, Lrec_SourceContact."Country/Region Code");
                                                    Lbool_OK := false;
                                                end else
                                                    if not TestLanguage(Lrec_SourceContact."Language Code") then begin
                                                        MESSAGE(text029, Grec_DuplicatingList.Name, Lrec_SourceContact."Language Code");
                                                        Lbool_OK := false;
                                                    end else begin
                                                        Lrec_DestContact.INIT();
                                                        Lrec_DestContact.TRANSFERFIELDS(Lrec_SourceContact);
                                                        Lrec_DestContact.INSERT();
                                                        Lbool_OK := true;
                                                        //***** Duplication des relations d'affaire *****
                                                        Lrec_SourceContBusRel.RESET();
                                                        Lrec_SourceContBusRel.SETFILTER(Lrec_SourceContBusRel."Contact No.", '%1', Lrec_SourceContact."No.");
                                                        Lrec_SourceContBusRel.SETFILTER(Lrec_SourceContBusRel."Link to Table", '%1', Lrec_SourceContBusRel."Link to Table"::Vendor);
                                                        Lrec_SourceContBusRel.SETFILTER(Lrec_SourceContBusRel."No.", '%1', Lcode_Vendor);
                                                        if Lrec_SourceContBusRel.COUNT > 0 then
                                                            if Lrec_SourceContBusRel.FIND('-') then
                                                                repeat
                                                                    if Lrec_DestBuinesssRelation.GET(Lrec_SourceContBusRel."Business Relation Code") then begin
                                                                        Lrec_DestContBusRel.INIT();
                                                                        Lrec_DestContBusRel.TRANSFERFIELDS(Lrec_SourceContBusRel);
                                                                        Lrec_DestContBusRel.INSERT();
                                                                    end
                                                                    else
                                                                        MESSAGE(text036, Grec_DuplicatingList.Name, Lcode_Vendor, Lrec_SourceContact."No.");
                                                                until Lrec_SourceContBusRel.NEXT() = 0;
                                                    end;
                end else
                    Lbool_OK := false;
            end else
                Lbool_OK := true;
        end else
            Lbool_OK := true;
    end;

    procedure TestUnitItem(Lcode_Item: Code[20]; Lcode_Unit: Code[10]) Lbool_OK: Boolean;
    var
        Lrec_DestUnitItem: Record "Item Unit of Measure";
        Lrec_SourceUnitItem: Record "Item Unit of Measure";
    begin
        if (Lcode_Unit <> '') then // si pas de code unit‚, inutile de le dupliquer
        begin
            Lrec_DestUnitItem.CHANGECOMPANY(Grec_DuplicatingList.Name);
            if not Lrec_DestUnitItem.GET(Lcode_Item, Lcode_Unit) then begin
                if Lrec_SourceUnitItem.GET(Lcode_Item, Lcode_Unit) then begin
                    Lbool_OK := TestUnit(Lcode_Unit);
                    if not Lbool_OK then
                        MESSAGE(text057, Grec_DuplicatingList.Name, Lcode_Unit)
                    else begin
                        Lrec_DestUnitItem.INIT();
                        Lrec_DestUnitItem.TRANSFERFIELDS(Lrec_SourceUnitItem);
                        Lrec_DestUnitItem.INSERT();
                        Lbool_OK := true;
                    end
                end else
                    Lbool_OK := false;
            end else
                Lbool_OK := true;
        end else
            Lbool_OK := true;
    end;

    procedure TestUnit(Lcode_Unit: Code[10]) Lbool_OK: Boolean;
    var
        Lrec_DestUnit: Record "Unit of Measure";
        Lrec_SourceUnit: Record "Unit of Measure";
    begin
        if (Lcode_Unit <> '') then // si pas de code unit‚, inutile de le dupliquer
        begin
            Lrec_DestUnit.CHANGECOMPANY(Grec_DuplicatingList.Name);
            if not Lrec_DestUnit.GET(Lcode_Unit) then begin
                if Lrec_SourceUnit.GET(Lcode_Unit) then begin
                    Lrec_DestUnit.INIT();
                    Lrec_DestUnit.TRANSFERFIELDS(Lrec_SourceUnit);
                    Lrec_DestUnit.INSERT();
                    Lbool_OK := true;
                end else
                    Lbool_OK := false;
            end else
                Lbool_OK := true;
        end else
            Lbool_OK := true;
    end;

    procedure CopierPeriodesValidation(DateDebutPeriod: Date; DateFinPeriod: Date);
    var
        Grec_Society: Record Company;
        GLSetup: Record "General Ledger Setup";
        Text001: label 'Users have been updated on all companies';
        Text10800: label '%1 must be within the allowed posting range: %2..%3';
    begin
        //MODIF JX-AUD 28/03/14
        if Grec_Society.FIND('-') then
            repeat
                if CONFIRM(STRSUBSTNO(text112, Grec_Society.Name)) then begin
                    Grec_UserSetup.CHANGECOMPANY(Grec_Society.Name);
                    GLSetup.FIND('-');
                    GLSetup.CHANGECOMPANY(Grec_Society.Name);
                    GLSetup.CALCFIELDS("Posting Allowed From", "Posting Allowed To");

                    if ((DateDebutPeriod < GLSetup."Posting Allowed From") or (DateDebutPeriod >= GLSetup."Posting Allowed To")) then
                        ERROR(Text10800, GLSetup.FIELDCAPTION("Allow Posting From"),
                          GLSetup."Posting Allowed From", CALCDATE('<-1D>', GLSetup."Posting Allowed To"), Grec_Society.Name, DateDebutPeriod);

                    if ((DateFinPeriod < GLSetup."Posting Allowed From") or (DateFinPeriod >= GLSetup."Posting Allowed To")) then
                        ERROR(Text10800, GLSetup.FIELDCAPTION("Allow Posting To"),
                          GLSetup."Posting Allowed From", CALCDATE('<-1D>', GLSetup."Posting Allowed To"), Grec_Society.Name, DateFinPeriod);

                    if Grec_UserSetup.FIND('-') then
                        repeat
                            Grec_UserSetup.VALIDATE("Allow Posting From", DateDebutPeriod);
                            Grec_UserSetup.VALIDATE("Allow Posting To", DateFinPeriod);
                            Grec_UserSetup.MODIFY();
                        until Grec_UserSetup.NEXT() = 0;
                end;
            until Grec_Society.NEXT() = 0;

        MESSAGE(Text001);
        //Fin MODIF JX-AUD 28/03/14
    end;

    procedure CreateUser(Lcode_User: Code[50]) Lint_DuplicationNumber: Integer;
    var
        Lrec_DestUser: Record "User Setup";
        Lrec_SourceUser: Record "User Setup";
        Lbool_Ok: Boolean;
    begin
        Lbool_Ok := true;
        Lint_DuplicationNumber := 0;
        if Grec_DuplicatingList.FIND('-') then
            repeat
                if Grec_DuplicatingList.Duplication then begin
                    Grec_DuplicatingList.Echec := true;
                    Grec_DuplicatingList.MODIFY();
                    if Lrec_DestUser.CHANGECOMPANY(Grec_DuplicatingList.Name) then begin
                        if Lrec_SourceUser.GET(Lcode_User) then begin
                            if not Lrec_DestUser.GET(Lcode_User) then begin
                                // Tests concernant les autres champs puis insertion de l'enregistrement si pas d'erreur
                                if Lrec_SourceUser."User ID" = '' then begin
                                    MESSAGE(text100);
                                    Lbool_Ok := false;
                                end;
                                if Lrec_SourceUser."BC6_Service" = '' then
                                    if not CONFIRM(text103) then Lbool_Ok := false;
                                if Lrec_SourceUser."BC6_Nom" = '' then
                                    if not CONFIRM(text104) then Lbool_Ok := false;
                                if Lrec_SourceUser."Approver ID" = '' then
                                    if not CONFIRM(text105) then Lbool_Ok := false;
                                if Lrec_SourceUser."E-Mail" = '' then begin
                                    MESSAGE(text106);
                                    Lbool_Ok := false;
                                end;

                                if Lbool_Ok then begin
                                    // Insertion de l'enregistrement
                                    Lrec_DestUser.INIT();
                                    Lrec_DestUser.TRANSFERFIELDS(Lrec_SourceUser);
                                    Lrec_DestUser.INSERT();
                                    COMMIT();

                                    Lint_DuplicationNumber += 1;
                                    Grec_DuplicatingList.Echec := false;
                                    Grec_DuplicatingList.MODIFY();
                                end;

                            end else
                                MESSAGE(text098, Lcode_User, Grec_DuplicatingList.Name);   // L'utilisateur existe d‚j… dans la soci‚t‚ !
                        end else
                            MESSAGE(text099, Lcode_User, COMPANYNAME);   // L'utilisateur n'existe pas dans la soci‚t‚
                    end;
                end;
            until Grec_DuplicatingList.NEXT() = 0;
    end;

    procedure DeleteUser(Lcode_User: Code[50]) Lint_DuplicationNumber: Integer;
    var
        Lrec_ApprovalEntry: Record "Approval Entry";
        Lrec_DestUser: Record "User Setup";
        Lbool_Ok: Boolean;
    begin
        Lbool_Ok := true;
        Lint_DuplicationNumber := 0;
        if Grec_DuplicatingList.FIND('-') then
            repeat
                if Grec_DuplicatingList.Duplication then begin
                    Grec_DuplicatingList.Echec := true;
                    Grec_DuplicatingList.MODIFY();
                    if Lrec_DestUser.CHANGECOMPANY(Grec_DuplicatingList.Name) then begin
                        if Lrec_DestUser.GET(Lcode_User) then begin
                            //V‚rification des approbations en cours
                            Lrec_ApprovalEntry.CHANGECOMPANY(Grec_DuplicatingList.Name);
                            Lrec_ApprovalEntry.SETFILTER(Lrec_ApprovalEntry."Approver ID", Lcode_User);
                            Lrec_ApprovalEntry.SETFILTER(Lrec_ApprovalEntry.Status, FORMAT(Lrec_ApprovalEntry.Status::Open));
                            if Lrec_ApprovalEntry.FIND('-') then begin
                                MESSAGE(text107, Grec_DuplicatingList.Name);
                                Lbool_Ok := false;
                            end;

                            if Lbool_Ok then begin
                                //On supprime l'utilisateur
                                Lrec_DestUser.DELETE();
                                COMMIT();

                                Lint_DuplicationNumber += 1;
                                Grec_DuplicatingList.Echec := false;
                                Grec_DuplicatingList.MODIFY();
                            end;
                        end else
                            MESSAGE(text099, Lcode_User, Grec_DuplicatingList.Name);
                    end;
                end;
            until Grec_DuplicatingList.NEXT() = 0;
    end;

    procedure DeleteUserActualSociety(Lcode_User: Code[50]);
    var
        Lrec_ApprovalEntry: Record "Approval Entry";
        Lrec_DestUser: Record "User Setup";
        Lbool_Ok: Boolean;
    begin
        Lbool_Ok := true;
        if CONFIRM(STRSUBSTNO(text111, Lcode_User, COMPANYNAME)) then begin
            //V‚rification des approbations en cours
            Lrec_ApprovalEntry.SETFILTER(Lrec_ApprovalEntry."Approver ID", Lcode_User);
            Lrec_ApprovalEntry.SETFILTER(Lrec_ApprovalEntry.Status, FORMAT(Lrec_ApprovalEntry.Status::Open));
            if Lrec_ApprovalEntry.FIND('-') then begin
                MESSAGE(text107, COMPANYNAME);
                Lbool_Ok := false;
            end;

            if Lbool_Ok then begin
                //On supprime l'utilisateur
                if Lrec_DestUser.GET(Lcode_User) then begin
                    Lrec_DestUser.DELETE();
                    COMMIT();
                    MESSAGE(text110, Lcode_User, COMPANYNAME);
                end;
            end;
        end;
    end;

    // BEGIN
    // {
    //   CREATION JX-XAD LE 06/04/2009
    //   Permet la duplication de fiches fournisseur, compte g‚n‚ral et article d'une soci‚t‚ vers une autre.
    //   Objets li‚s modifi‚s ou cr‚‚s : Form 16, 26, 30, 50013 ; Table 50003
    //   MODIFICATION JX-XAD LE 08/06/2009 : traitement des axes analytiques principaux 1 et 2.

    //   MODIF JX-XAD 03/07/2009
    //   Correction bug sur code groupe produits dans la duplication d'un article

    //   ---------------------------- V1.2 ----------------------------

    //   MODIF JX-XAD 15/06/2010 (fait le 15/10/2010 dans Nav 2009)
    //   Ajout de la duplication de la fiche compte bancaire

    //   MODIF JX-XAD 31/03/2011
    //   Lors de la duplication de la fiche bancaire, modification de celle-ci si elle existe d‚j…

    //   MODIF JX-XAD 07/06/2011
    //   Ajout d'une instruction "COMMIT" lors de l'initialisation des coches pour le formuulaire de duplication
    //   et ceci dans le cadre de l'ajout des fonctions SelectAll et SelectAllWithDim dans la table de duplication

    //   //MODIF JX-AUD 28/03/14
    //   //Ajout de la fonction CopierPeriodesValidation: cette fonction s'applique … toutes les soci‚t‚s

    //   //MODIF JX-AUD 07/04/14
    //   //Ajout de la fonction CreateUser
    //   //Modification de la fonction Dupliquer
    // }
    // END.
    //}
}
