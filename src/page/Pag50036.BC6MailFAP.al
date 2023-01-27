
page 50036 "BC6_BC6 Mail FAP"
{
    PageType = NavigatePage;
    SourceTable = "Purchase Header";
    Caption = 'BC6 Mail FAP', Comment = 'FRA="Mail FAP"';

    layout
    {
        area(content)
        {
            group("Information à saisir")
            {
                field("Paramètre 1"; Gtext_Param1)
                {
                    ApplicationArea = All;
                    Caption = 'Paramètre 1', Comment = 'FRA="Paramètre 1"';
                }
                field("Paramètre 2"; Gtext_Param2)
                {
                    ApplicationArea = All;
                    Caption = 'Paramètre 2', Comment = 'FRA="Paramètre 2"';
                }
                field("Paramètre 3"; Gtext_Param3)
                {
                    ApplicationArea = All;
                    Caption = 'Paramètre 3', Comment = 'FRA="Paramètre 3"';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Mail)
            {
                action("Prévisualisation et Envoi Mail")
                {
                    Image = SendApprovalRequest;
                    InFooterBar = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        MailManagement: Codeunit "Mail Management";
                        TempBlob: codeunit "Temp Blob";
                        InStream: InStream;
                        SendToList: List of [Text];
                    begin
                        CLEAR(EmailMessage);

                        //recherche du mail de l'utilisateur
                        IF Grec_UserSetup.GET(USERID) THEN
                            Gtext_Mail := Grec_UserSetup."E-Mail";

                        IF Grec_UserSetup.GET(Rec."Assigned User ID") THEN
                            Gtext_MailUser.Add(Grec_UserSetup."E-Mail");

                        //creation du mail
                        //[Syntax for the Createmessage function -
                        // Createmessage([sender's name] ,[sender's id],[recipient's id or ids],[subject] ,[body line],[html formatted or not]]
                        Gtext_alias := '';
                        IF (COMPANYNAME = 'VFEC') OR (COMPANYNAME = 'VFEC - RECETTE') THEN
                            Gtext_alias := 'VSC GROUPE'
                        ELSE
                            Gtext_alias := COMPANYNAME;

                        //recherche du nom du fournisseur
                        Gtext_VendorName := '';
                        IF Grec_Vendor.GET(Rec."Buy-from Vendor No.") THEN BEGIN
                            Gtext_VendorName := Grec_Vendor.Name;
                            Gtext_ObjetMail := Gtext_alias + ' - ' + Gtext_ObjetMail + ' - ' + Gtext_VendorName;
                        END ELSE
                            Gtext_ObjetMail := Gtext_alias + ' - ' + Gtext_ObjetMail;

                        IF VSCSettings."BC Test Mode" THEN
                            Gtext_MailUser.Add(VSCSettings."BC E-Mail Test");
                        BCCRecipients.Add('');
                        Gtext_MailCCList.Add(Gtext_MailCC);
                        EmailMessage.Create(SendToList, Gtext_ObjetMail, '', TRUE, Gtext_MailCCList, BCCRecipients);

                        //Ajout des lignes au mail
                        CASE Gint_Param4 OF
                            1:
                                BEGIN
                                    EmailMessage.AppendToBody(CorpsMail1());
                                    EmailMessage.AppendToBody(CorpsMail1BIS());
                                    //Ajout de la pièce jointe au mail suivant les sociétés
                                    IF NOT VSCSettings."BC Test Mode" THEN BEGIN
                                        TempBlob.CreateInStream(InStream);
                                        IF (COMPANYNAME = 'VSC') OR (COMPANYNAME = 'VSC - RECETTE') THEN
                                            EmailMessage.AddAttachment('\\10.16.34.109\Pdf\Fournisseurs\Fiche_fournisseur_VSC.xls'
                                             , '\\10.16.34.109\Pdf\Fournisseurs\Fiche_fournisseur_VSC.xls', InStream);
                                        IF (COMPANYNAME = 'VSCT') OR (COMPANYNAME = 'VSCT - RECETTE') THEN
                                            EmailMessage.AddAttachment('\\10.16.34.109\Pdf\Fournisseurs\Fiche_fournisseur_VSCT.xls'
                                             , '\\10.16.34.109\Pdf\Fournisseurs\Fiche_fournisseur_VSCT.xls', InStream);
                                        IF (COMPANYNAME = 'Agence') OR (COMPANYNAME = 'Agence - RECETTE') THEN
                                            EmailMessage.AddAttachment('\\10.16.34.109\Pdf\Fournisseurs\Fiche_fournisseur_AGVSC.xls'
                                             , '\\10.16.34.109\Pdf\Fournisseurs\Fiche_fournisseur_AGVSC.xls', InStream);
                                        IF (COMPANYNAME = 'VFEC') OR (COMPANYNAME = 'VFEC - RECETTE') THEN
                                            EmailMessage.AddAttachment('\\10.16.34.109\Pdf\Fournisseurs\Fiche_fournisseur_VSCGroupe.xls'
                                             , '\\10.16.34.109\Pdf\Fournisseurs\Fiche_fournisseur_VSCGroupe.xls', InStream);
                                        IF (COMPANYNAME = 'HEXATOURISME') OR (COMPANYNAME = 'HEXATOURISME - RECETTE') THEN
                                            EmailMessage.AddAttachment('\\10.16.34.109\Pdf\Fournisseurs\Fiche_fournisseur_HEXATOURISME.xls'
                                             , '\\10.16.34.109\Pdf\Fournisseurs\Fiche_fournisseur_HEXATOURISME.xls', InStream);
                                        InsertFacture(EmailMessage, Rec."No.", TempBlob);
                                    END;
                                    IF CONFIRM(STRSUBSTNO(VariableDebutMail1, Rec."No.") + STRSUBSTNO(VariableMilieuMail, Gtext_Param1, Gtext_Param2, Gtext_Param3)
                                     + STRSUBSTNO(VariableMilieuMailbis, Gtext_Param2, Rec."Document Date", Rec."Vendor Invoice No.", Rec."BC6_Register amount")
                                     + VariableFinMail1 + VariableSignature) THEN BEGIN
                                        //Envoi du mail
                                        MailV.Send(EmailMessage);
                                        MESSAGE(Text002);
                                        CurrPage.CLOSE();
                                        InsertHistorique();
                                    END;
                                END;
                            3:
                                BEGIN
                                    //Vérification du numéro de document saisi s'il existe
                                    CLEAR(Grec_PurchaseHeader);
                                    IF NOT Grec_PurchaseHeader.GET(Grec_PurchaseHeader."Document Type"::Quote, Gtext_Param2) THEN
                                        ERROR(Text001);

                                    EmailMessage.AppendToBody(CorpsMail3());
                                    IF NOT VSCSettings."BC Test Mode" THEN
                                        InsertFacture(EmailMessage, Rec."No.", TempBlob);
                                    IF CONFIRM(STRSUBSTNO(VariableDebutMail3, Rec."No.") + STRSUBSTNO(VariableMilieuMail, Gtext_Param1, Gtext_Param2, Gtext_Param3)
                                     + VariableFinMail3 + VariableSignature) THEN BEGIN
                                        //Envoi du mail
                                        MailV.Send(EmailMessage);
                                        MESSAGE(Text002);
                                        CurrPage.CLOSE();
                                        InsertHistorique();
                                    END;
                                END;
                            4:
                                BEGIN
                                    //Vérification du numéro de document saisi s'il existe
                                    CLEAR(Grec_PurchaseHeader);
                                    IF NOT Grec_PurchaseHeader.GET(Grec_PurchaseHeader."Document Type"::Quote, Gtext_Param2) THEN
                                        ERROR(Text001);

                                    EmailMessage.AppendToBody(CorpsMail4());
                                    InsertFacture(EmailMessage, Rec."No.", TempBlob);
                                    IF CONFIRM(STRSUBSTNO(VariableDebutMail4, Rec."No.") + STRSUBSTNO(VariableMilieuMail, Gtext_Param1, Gtext_Param2, Gtext_Param3)
                                     + VariableFinMail4 + VariableSignature) THEN BEGIN
                                        //Envoi du mail
                                        MailV.Send(EmailMessage);
                                        MESSAGE(Text002);
                                        CurrPage.CLOSE();
                                        InsertHistorique();
                                    END;
                                END;
                            5:
                                BEGIN
                                    //Vérification du numéro de document saisi s'il existe
                                    CLEAR(Grec_PurchaseHeader);
                                    IF NOT Grec_PurchaseHeader.GET(Grec_PurchaseHeader."Document Type"::Quote, Gtext_Param2) THEN
                                        ERROR(Text001);

                                    EmailMessage.AppendToBody(CorpsMail5());
                                    InsertFacture(EmailMessage, Rec."No.", TempBlob);
                                    IF CONFIRM(STRSUBSTNO(VariableDebutMail5, Rec."No.") + STRSUBSTNO(VariableMilieuMail, '- ' + Gtext_Param1, Gtext_Param2, Gtext_Param3)
                                     + VariableFinMail5 + VariableSignature) THEN BEGIN
                                        //Envoi du mail
                                        MailV.Send(EmailMessage);
                                        MESSAGE(Text002);
                                        CurrPage.CLOSE();
                                        InsertHistorique();
                                    END;
                                END;
                            6:
                                BEGIN
                                    //Vérification du numéro de document saisi s'il existe
                                    CLEAR(Grec_PurchaseHeader);
                                    IF NOT Grec_PurchaseHeader.GET(Grec_PurchaseHeader."Document Type"::Order, Gtext_Param2) THEN
                                        ERROR(Text001);

                                    //recherche du nom du fournisseur
                                    Gtext_VendorName := '';
                                    IF Grec_Vendor.GET(Rec."Buy-from Vendor No.") THEN
                                        Gtext_VendorName := Grec_Vendor.Name;

                                    EmailMessage.AppendToBody(CorpsMail6());
                                    EmailMessage.AppendToBody(CorpsMail6BIS());
                                    InsertFacture(EmailMessage, Rec."No.", TempBlob);
                                    IF CONFIRM(STRSUBSTNO(VariableDebutMail6, Rec."No.") + STRSUBSTNO(VariableMilieuMail, Gtext_Param1, Gtext_Param2, Gtext_Param3)
                                     + STRSUBSTNO(VariableMilieuMail6, Gtext_VendorName, Rec."Document Date", Rec."Vendor Invoice No.", Rec."BC6_Register amount")
                                     + VariableFinMail6 + VariableSignature) THEN BEGIN
                                        //Envoi du mail
                                        MailV.Send(EmailMessage);
                                        MESSAGE(Text002);
                                        CurrPage.CLOSE();
                                        InsertHistorique();
                                    END;
                                END;
                            7:
                                BEGIN
                                    //Vérification du numéro de document saisi s'il existe
                                    CLEAR(Grec_PurchaseHeader);
                                    IF NOT Grec_PurchaseHeader.GET(Grec_PurchaseHeader."Document Type"::Order, Gtext_Param2) THEN
                                        ERROR(Text001);

                                    EmailMessage.AppendToBody(CorpsMail7());
                                    InsertFacture(EmailMessage, Rec."No.", TempBlob);
                                    IF CONFIRM(STRSUBSTNO(VariableDebutMail7, Rec."No.") + STRSUBSTNO(VariableMilieuMail, Gtext_Param1, Gtext_Param2, Gtext_Param3)
                                     + VariableFinMail7 + VariableSignature) THEN BEGIN
                                        //Envoi du mail
                                        MailV.Send(EmailMessage);
                                        MESSAGE(Text002);
                                        CurrPage.CLOSE();
                                        InsertHistorique();
                                    END;
                                END;

                        END;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        VSCSettings.GET();
    end;

    var
        VSCSettings: Record "BC6_VSC Settings";
        Grec_PurchaseHeader: Record "Purchase Header";
        //SMAIL: Codeunit "SMTP Mail";
        Grec_UserSetup: Record "User Setup";
        Grec_Vendor: Record Vendor;
        MailV: codeunit Email;
        EmailMessage: codeunit "Email Message";
        Gint_Param4: Integer;
        Gtext_MailCC: Label 'VSCComptaFour@voyages-sncf.com', Comment = 'FRA="VSCComptaFour@voyages-sncf.com"';
        GtextMail1: Label 'These operations are to be carried out if and only if you agree with the service invoiced, otherwise we thank you for informing us by email.', Comment = 'FRA="Ces opérations sont à effectuer si et seulement si vous êtes d''accord avec la prestation facturée, dans le cas contraire nous vous remercions de nous en informer par mail."';
        Text001: Label 'The document number is incorrect, please change it', Comment = 'FRA="Le numéro du document est incorrect, veuillez le modifier"';
        Text002: Label 'The email has been sent', Comment = 'FRA="Le mail a bien été envoyé"';
        VariableDebutMail1: Label 'Do you validate the following message?: \\ Hello, \\ We cannot enter invoice %1, for the following reason:', Comment = 'FRA="Validez-vous le message suivant ?:\\Bonjour,\\Nous ne pouvons pas saisir la facture %1, pour la raison suivante:"';
        VariableDebutMail2: Label 'Do you validate the following message?: \\ Hello, \\ We cannot enter invoice %1, for the following reason: \\ The corresponding quote was not created. \', Comment = 'FRA="Validez-vous le message suivant ?:\\Bonjour,\\Nous ne pouvons pas saisir la facture %1, pour la raison suivante:\\Le devis correspondant n’a pas été créé.\"';
        VariableDebutMail3: Label 'Do you validate the following message?: \\ Hello, \\ We cannot enter invoice %1, for the following reason:', Comment = 'FRA="Validez-vous le message suivant ?:\\Bonjour,\\Nous ne pouvons pas saisir la facture %1, pour la raison suivante:"';
        VariableDebutMail4: Label 'Do you validate the following message?: \\ Hello, \\ We cannot enter invoice %1, for the following reason:', Comment = 'FRA="Validez-vous le message suivant ?:\\Bonjour,\\Nous ne pouvons pas saisir la facture %1, pour la raison suivante:"';
        VariableDebutMail5: Label 'Do you validate the following message?: \\ Hello, \\ We cannot enter invoice %1, for the following reason: \', Comment = 'FRA="Validez-vous le message suivant ?:\\Bonjour,\\Nous ne pouvons pas saisir la facture %1, pour la raison suivante:\"';
        VariableDebutMail6: Label 'Do you validate the following message?: \\ Hello, \\ We cannot enter invoice% 1 because its amount is greater than that of your purchase order: \ ', Comment = 'FRA="Validez-vous le message suivant ?:\\Bonjour,\\Nous ne pouvons pas saisir la facture %1 car son montant est supérieur à celui de votre bon de commande:\"';
        VariableDebutMail7: Label 'Do you validate the following message?: \\ Hello, \\ We cannot enter invoice %1, for the following reason: \', Comment = 'FRA="Validez-vous le message suivant ?:\\Bonjour,\\Nous ne pouvons pas saisir la facture %1, pour la raison suivante:\"';
        VariableDebutMail8: Label 'Do you validate the following message?: \\ Hello, \\ We have received an invoice %1.', Comment = 'FRA="Validez-vous le message suivant ?:\\Bonjour,\\Nous avons reçu une facture %1."';
        VariableFinMail1: Label '\ The actions you need to take are: \\ 1. You must send the attached referral form to the supplier and then return it once completed to the alias "ERP support" \ 2. Once the Supplier is listed in our databases, you can create the Quote in NAVISION \ Please do the necessary as quickly as possible. These operations are to be carried out if and only if you agree with the service invoiced, otherwise we thank you for informing us by email.', Comment = 'FRA="\Les actions que vous devez effectuer sont les suivantes:\\1. Vous devez envoyer la fiche de référencement ci-jointe au fournisseur puis la retourner une fois complétée à l''alias "support ERP" \2. Une fois le Fournisseur référencé dans nos bases, vous pourrez créer le Devis dans NAVISION\Merci de faire le nécessaire le plus rapidement possible. Ces opérations sont à effectuer si et seulement si vous êtes d''accord avec la prestation facturée, dans le cas contraire nous vous remercions de  nous en informer par mail."';
        VariableFinMail2: Label '\ Please do what is necessary as soon as possible. These operations are to be carried out if and only if you agree with the billed service, otherwise we thank you for informing us by email. \\ To create a DA, follow the following link: link + press F3 ', Comment = 'FRA="\Merci de faire le nécessaire le plus rapidement possible. Ces opérations sont à effectuer si et seulement si vous êtes d''accord avec la prestation facturée,  dans le cas contraire nous vous remercions de  nous en informer par mail.\\Pour créer une DA, suivre le lien suivant: lien + appuyer sur F3"';
        VariableFinMail3: Label '\ Please do what is necessary as soon as possible. These operations are to be carried out if and only if you agree with the billed service, otherwise we thank you for informing us by email. \\ To access the DA, click on this link: link + click on "request for approval" ', Comment = 'FRA="\Merci de faire le nécessaire le plus rapidement possible. Ces opérations sont à effectuer si et seulement si vous êtes d''accord avec la prestation facturée,  dans le cas contraire nous vous remercions de  nous en informer par mail.\\Pour accéder à la  DA, cliquez sur ce lien :  lien + cliquer sur "demande d''approb.""';
        VariableFinMail4: Label '\ Please do the necessary as soon as possible. These operations are to be carried out if and only if you agree with the billed service, otherwise we thank you for informing us by email. \\ To access the DA, click on this link: link + click on "request for approval" ', Comment = 'FRA="\Merci de faire le nécessaire le plus rapidement possible. Ces opérations sont à effectuer si et seulement si vous êtes d''accord avec la prestation facturée,  dans le cas contraire nous vous remercions de  nous en informer par mail.\\Pour accéder à la  DA, cliquez sur ce lien :  lien + cliquer sur "demande d''approb.""';
        VariableFinMail5: Label '\ - Once the estimate has been transformed into PO, it must be received. Without these actions, the invoice cannot be paid. These operations are to be carried out if and only IF THE SERVICE IS COMPLIANT WITH THE ORDER, otherwise we thank you for informing us by email. \\ To access the DA, click on this link: link + click on "Transform in BC "', Comment = 'FRA="\- Une fois le devis transformé en BC, celui-ci est à réceptionner SVP Sans ces actions la facture ne pourra être payée. Ces opérations sont à effectuer si et seulement SI LA PRESTATION EST CONFORME A LA COMMANDE,  dans le cas contraire nous vous remercions de  nous en informer par mail.\\Pour accéder à la  DA, cliquez sur ce lien :  lien + cliquer sur "Transformer en BC""';
        VariableFinMail6: Label '\ Please tell us if you agree with the amount invoiced. \\ If yes -> Please create an additional quote cf. procedure Quote to be created \\ If not -> Please formalize your refusal by email to the supplier without forgetting to copy to us. \\ To create a DA, follow the following link: link + press F3 ', Comment = 'FRA="\Merci de nous dire si vous êtes d’accord avec le montant facturé.\\Si oui --> Veuillez  svp créer un devis complémentaire cf. procédure Devis à créer\\Si non --> Veuillez  svp formaliser votre refus par mail au fournisseur sans oublier de nous mettre en copie.\\Pour créer une  DA, suivre le lien suivant:  lien + appuyer sur F3"';
        VariableFinMail7: Label '\ The reception is to be carried out if and only IF THE SERVICE IS COMPLIANT WITH THE ORDER, otherwise we thank you for informing us by email. \\ To access the PO to receive, follow the following link: link + button "Receive" ', Comment = 'FRA="\La réception est à effectuer si et seulement SI LA PRESTATION EST CONFORME A LA COMMANDE,  dans le cas contraire nous vous remercions de  nous en informer par mail.\\Pour accéder au BC à réceptionner, suivre le lien suivant: lien  + bouton "Réceptionner""';
        VariableFinMail8: Label '\\ We need your control and your validation to pay it. \\ To access the invoice follow the following link: link + click on "Invoice approval" \\ This operation is to be carried out if and only IF THE SERVICE IS COMPLIANT, otherwise we thank you for informing us by email. ', Comment = 'FRA="\\Nous avons besoin de votre contrôle et de votre validation pour la payer.\\Pour accéder à la facture suivre le lien suivant: lien +  cliquez sur  "Approbation de facture"\\Cette opération est à effectuer si et seulement SI LA PRESTATION EST CONFORME,  dans le cas contraire nous vous remercions de  nous en informer par mail."';
        VariableMilieuMail: Label '\%1 %2 %3\', Comment = 'FRA="\%1 %2 %3\"';
        VariableMilieuMail2: Label '\ Information on the invoice for which you must create an estimate: \\ Supplier: %1 \ Invoice date: %2 \ Invoice number: %3 \ Amount: %4 \', Comment = 'FRA="\Informations sur la facture pour laquelle vous devez créer un devis :\\Fournisseur : %1 \Date de facture : %2\N° facture : %3\Montant : %4\"';
        VariableMilieuMail6: Label '\ Information on the invoice awaiting posting: \\ Supplier: %1 \ Invoice date: %2 \ Invoice number: %3 \ Amount: %4 \', Comment = 'FRA="\Informations sur la facture en attente de comptabilisation :\\Fournisseur : %1 \Date de facture : %2\N° facture : %3\Montant : %4\"';
        VariableMilieuMailbis: Label '\ Information on the invoice for which you must create the supplier: \\ Supplier: %1 \ Invoice date: %2 \ Invoice number: %3 \ Amount: %4 \ ', Comment = 'FRA="\Informations sur la facture pour laquelle vous devez créer le fournisseur:\\Fournisseur : %1 \Date de facture : %2\N° facture : %3\Montant : %4\"';
        VariableSignature: Label '\\ Thank you for your cooperation, \\ The Accounting Department.', Comment = 'FRA="\\Merci de votre coopération,\\Le Service comptabilité."';
        BCCRecipients: List of [Text];
        Gtext_MailCCList: list of [Text];
        Gtext_MailUser: list of [Text];
        Gtext_alias: Text[30];
        Gtext_Mail: Text[50];
        Gtext_VendorName: Text[50];
        Gtext_Corps: Text[1024];
        Gtext_Corps1: Text[1024];
        Gtext_ObjetMail: Text[1024];
        Gtext_Param1: Text[1024];
        Gtext_Param2: Text[1024];
        Gtext_Param3: Text[1024];

    procedure SetParam(Param1: Text[1024]; Param2: Text[1024]; Param3: Text[1024]; Param4: Integer; Param5: Text[1024])
    begin
        Gtext_Param1 := Param1;
        Gtext_Param2 := Param2;
        Gtext_Param3 := Param3;
        Gint_Param4 := Param4;
        Gtext_ObjetMail := Param5;
    end;

    procedure SetPurchaseHeader(p_PurchaseHeader: Record "Purchase Header")
    begin
        Grec_PurchaseHeader := p_PurchaseHeader;
    end;

    procedure CorpsMail1() pCorps: Text[1024]
    begin
        //corps du mail1
        Gtext_Corps := '';

        Gtext_Corps += 'Bonjour,<br><br>';

        Gtext_Corps += 'Nous ne pouvons pas saisir la facture <b>' + Rec."No." + '</b>, pour la raison suivante: ';
        Gtext_Corps += Gtext_Param1 + ' <b>' + Gtext_Param2 + '</b> ' + Gtext_Param3 + '<br><br>';

        Gtext_Corps += '<u>Informations sur la facture pour laquelle vous devez créer le fournisseur :</u><br><br>';
        Gtext_Corps += 'Fournisseur : ' + Gtext_Param2 + '<br>';
        Gtext_Corps += 'Date de facture : ' + FORMAT(Rec."Document Date") + ' <br>';
        Gtext_Corps += 'N° facture : ' + Rec."Vendor Invoice No." + ' <br>';
        Gtext_Corps += 'Montant : ' + FORMAT(Rec."BC6_Register amount") + '<br><br>';

        Gtext_Corps += 'Les actions que vous devez effectuer sont les suivantes:<br><br>';
        Gtext_Corps += '<b><font color="red">1.</font></b> Vous devez envoyer la fiche de référencement ';
        Gtext_Corps += 'ci-jointe au fournisseur puis la retourner une fois complétée à l''alias "support ERP"<br><br>';


        pCorps := Gtext_Corps;
    end;

    procedure CorpsMail1BIS() pCorps1: Text[1024]
    begin
        //corps du mail1BIS
        Gtext_Corps1 := '';

        Gtext_Corps1 += '<b><font color="red">2.</font></b> Une fois le Fournisseur référencé dans nos bases, ';
        Gtext_Corps1 += 'vous pourrez créer le Devis dans NAVISION <br><br>';

        Gtext_Corps += '<b>Merci de faire le nécessaire le plus rapidement possible.</b><br><br>';

        //Gtext_Corps1 += '<b><font color="red">Ces opérations sont à effectuer si et seulement si vous êtes d''accord avec </font></b>';
        //Gtext_Corps1 += '<b><font color="red">la prestation facturée, dans le cas contraire nous vous remercions de </font></b>';
        //Gtext_Corps1 += '<b><font color="red">nous en informer par mail.</font></b><br><br>';
        Gtext_Corps1 += '<b><font color="red">' + GtextMail1 + '</font></b><br><br>';

        Gtext_Corps1 += 'Merci de votre coopération,<br><br>';
        Gtext_Corps1 += 'Le Service comptabilité.';

        pCorps1 := Gtext_Corps1;
    end;

    procedure CorpsMail3() pCorps: Text[1024]
    var
        lPurchHeader: Record "Purchase Header";
    begin
        //corps du mail3
        Gtext_Corps := '';

        Gtext_Corps += 'Bonjour,<br> <br>';

        Gtext_Corps += 'Nous ne pouvons pas saisir la facture <b>' + Rec."No." + '</b>, pour la raison suivante: ';
        Gtext_Corps += '<b>' + Gtext_Param1 + ' ' + Gtext_Param2 + ' ' + Gtext_Param3 + '</b><br><br>';


        Gtext_Corps += '<b>Merci de faire le nécessaire le plus rapidement possible.</b><br><br>';

        Gtext_Corps += '<b><font color="red">Ces opérations sont à effectuer </font></b>';
        Gtext_Corps += '<b><font color="red"><u>si et seulement si vous êtes d''accord avec </u></font></b>';
        Gtext_Corps += '<b><font color="red"><u>la prestation facturée</u>, dans le cas contraire nous vous remercions de </font></b>';
        Gtext_Corps += '<b><font color="red">nous en informer par mail.</font></b><br><br>';

        //lien Navision
        Gtext_Corps += 'Pour accéder à la  DA, cliquez sur ce lien: ';
        IF lPurchHeader.GET(lPurchHeader."Document Type", Gtext_Param2) THEN
            Gtext_Corps += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 49, lPurchHeader)
        ELSE
            Gtext_Corps += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 49);
        Gtext_Corps += '">Demande d''approbation</a><br><br>';
        //Gtext_Corps +='lien</a> + cliquer sur <font color="blue">"demande d''approb."</font><br><br>';

        Gtext_Corps += 'Merci de votre coopération,<br><br>';
        Gtext_Corps += 'Le Service comptabilité.';

        pCorps := Gtext_Corps;
    end;

    procedure CorpsMail4() pCorps: Text[1024]
    var
        lPurchHeader: Record "Purchase Header";
    begin
        //corps du mail4
        Gtext_Corps := '';

        Gtext_Corps += 'Bonjour,<br> <br>';

        Gtext_Corps += 'Nous ne pouvons pas saisir la facture <b>' + Rec."No." + '</b>, pour la raison suivante: ';
        Gtext_Corps += '<b>' + Gtext_Param1 + ' ' + Gtext_Param2 + ' ' + Gtext_Param3 + '</b><br><br>';


        Gtext_Corps += '<b>Merci de faire le nécessaire le plus rapidement possible.</b><br><br>';

        Gtext_Corps += '<b><font color="red">Ces opérations sont à effectuer </font></b>';
        Gtext_Corps += '<b><font color="red"><u>si et seulement si vous êtes d''accord avec </u></font></b>';
        Gtext_Corps += '<b><font color="red"><u>la prestation facturée</u>, dans le cas contraire nous vous remercions de </font></b>';
        Gtext_Corps += '<b><font color="red">nous en informer par mail.</font></b><br><br>';

        //lien Navision
        Gtext_Corps += 'Pour accéder à la  DA, cliquez sur ce lien: ';
        IF lPurchHeader.GET(lPurchHeader."Document Type", Gtext_Param2) THEN
            Gtext_Corps += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 49, lPurchHeader)
        ELSE
            Gtext_Corps += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 49);
        Gtext_Corps += '">Demande d''approbation</a><br><br>';
        //Gtext_Corps +='lien</a> + cliquer sur <font color="blue">"demande d''approb."</font><br><br>';


        Gtext_Corps += 'Merci de votre coopération,<br><br>';
        Gtext_Corps += 'Le Service comptabilité.';

        pCorps := Gtext_Corps;
    end;

    procedure CorpsMail5() pCorps: Text[1024]
    var
        lPurchHeader: Record "Purchase Header";
    begin
        //corps du mail5
        Gtext_Corps := '';

        Gtext_Corps += 'Bonjour,<br> <br>';

        Gtext_Corps += 'Nous ne pouvons pas saisir la facture <b>' + Rec."No." + '</b>, pour la raison suivante:<br><br>';
        Gtext_Corps += '<b>- ' + Gtext_Param1 + ' ' + Gtext_Param2 + ' ' + Gtext_Param3 + '</b><br><br>';
        Gtext_Corps += '<b>- Une fois le devis transformé en BC, celui-ci est à réceptionner SVP</b><br>';
        Gtext_Corps += '<b>Sans ces actions la facture ne pourra être payée.</b><br><br>';


        Gtext_Corps += '<b><font color="red">Ces opérations sont à effectuer </font></b>';
        Gtext_Corps += '<b><font color="red"><u>si et seulement SI LA PRESTATION EST CONFORME A LA COMMANDE, </u></font></b>';
        Gtext_Corps += '<b><font color="red">dans le cas contraire nous vous remercions de </font></b>';
        Gtext_Corps += '<b><font color="red">nous en informer par mail.</font></b><br><br>';

        //lien Navision
        Gtext_Corps += 'Pour accéder à la  DA, cliquez sur ce lien: ';
        IF lPurchHeader.GET(lPurchHeader."Document Type", Gtext_Param2) THEN
            Gtext_Corps += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 49, lPurchHeader)
        ELSE
            Gtext_Corps += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 49);
        Gtext_Corps += '">Transformer en BC</a><br><br>';
        //Gtext_Corps +='lien</a> + cliquer sur <font color="blue">"Transformer en BC"</font><br><br>';

        Gtext_Corps += 'Merci de votre coopération,<br><br>';
        Gtext_Corps += 'Le Service comptabilité.';
        pCorps := Gtext_Corps;
    end;

    procedure CorpsMail6() pCorps: Text[1024]
    var
        lPurchHeader: Record "Purchase Header";
    begin
        //corps du mail6
        Gtext_Corps := '';

        Gtext_Corps += 'Bonjour,<br> <br>';

        Gtext_Corps += 'Nous ne pouvons pas saisir la facture <b>' + Rec."No." + '</b> ';
        Gtext_Corps += 'car son montant est supérieur à celui de votre bon de commande:<br><br>';
        Gtext_Corps += '<b>' + Gtext_Param1 + ' ' + Gtext_Param2 + ' ' + Gtext_Param3 + '</b><br><br>';

        Gtext_Corps += '<u>Informations sur la facture en attente de comptabilisation :</u><br><br>';
        Gtext_Corps += 'Fournisseur : ' + Gtext_VendorName + '<br>';
        Gtext_Corps += 'Date de facture : ' + FORMAT(Rec."Document Date") + ' <br>';
        Gtext_Corps += 'N° facture : ' + Rec."Vendor Invoice No." + ' <br>';
        Gtext_Corps += 'Montant : ' + FORMAT(Rec."BC6_Register amount") + '<br><br>';

        pCorps := Gtext_Corps;
    end;

    procedure CorpsMail6BIS() pCorps1: Text[1024]
    var
        lPurchHeader: Record "Purchase Header";
    begin
        //corps du mail6
        Gtext_Corps1 := '';

        Gtext_Corps1 += 'Merci de nous dire si vous êtes d’accord avec le montant facturé.<br><br>';

        Gtext_Corps1 += '<font color="green">Si oui --> Veuillez svp créer un devis complémentaire cf. procédure Devis à créer</font><br>';
        Gtext_Corps1 += '<font color="red">Si non -->Veuillez svp formaliser votre refus par mail au fournisseur </font>';
        Gtext_Corps1 += '<font color="red">sans oublier de nous mettre en copie.</font><br><br>';

        lPurchHeader.INIT();
        lPurchHeader."Document Type" := lPurchHeader."Document Type"::Quote;
        lPurchHeader."No." := '';
        lPurchHeader.INSERT(TRUE);

        //lien Navision
        Gtext_Corps1 += 'Pour créer une DA, suivre le lien suivant: ';
        Gtext_Corps1 += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 49, lPurchHeader) + '"> Création DA</a><br><br>';
        //Gtext_Corps1 +='lien</a> + <font color="blue">appuyer sur F3</font><br><br>';

        Gtext_Corps1 += 'Merci de votre coopération,<br><br>';
        Gtext_Corps1 += 'Le Service comptabilité.';

        pCorps1 := Gtext_Corps1;
    end;

    procedure CorpsMail7() pCorps: Text[1024]
    var
        lPurchHeader: Record "Purchase Header";
    begin
        //corps du mail7
        Gtext_Corps := '';

        Gtext_Corps += 'Bonjour,<br> <br>';

        Gtext_Corps += 'Nous ne pouvons pas saisir la facture <b>' + Rec."No." + '</b>, pour la raison suivante:<br><br>';
        Gtext_Corps += '<b>' + Gtext_Param1 + ' ' + Gtext_Param2 + ' ' + Gtext_Param3 + '</b><br><br>';

        Gtext_Corps += '<b><font color="red">La réception est à effectuer </font></b>';
        Gtext_Corps += '<b><font color="red">si et seulement SI LA PRESTATION EST CONFORME A LA COMMANDE, </font></b>';
        Gtext_Corps += '<b><font color="red">dans le cas contraire nous vous remercions de </font></b>';
        Gtext_Corps += '<b><font color="red">nous en informer par mail.</font></b><br><br>';

        //lien Navision
        Gtext_Corps += 'Pour accéder au BC à réceptionner, suivre le lien suivant: ';
        IF lPurchHeader.GET(lPurchHeader."Document Type"::Order, Gtext_Param2) THEN
            Gtext_Corps += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 50, lPurchHeader)
        ELSE
            Gtext_Corps += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 50);

        Gtext_Corps += '">Réceptionner</a><br><br>';
        //Gtext_Corps +='lien</a> + bouton <font color="blue">"Réceptionner"</font><br><br>';


        Gtext_Corps += 'Merci de votre coopération,<br><br>';
        Gtext_Corps += 'Le Service comptabilité.';

        pCorps := Gtext_Corps;
    end;

    procedure SendMail8() pCorps: Text[1024]
    var
        TempBlob: codeunit "Temp Blob";
    begin
        CLEAR(EmailMessage);

        //recherche du mail de l'utilisateur
        IF Grec_UserSetup.GET(USERID) THEN
            Gtext_Mail := Grec_UserSetup."E-Mail";

        IF Grec_UserSetup.GET(Rec."Assigned User ID") THEN
            Gtext_MailUser.Add(Grec_UserSetup."E-Mail");

        Gtext_alias := '';
        IF (COMPANYNAME = 'VFEC') OR (COMPANYNAME = 'VFEC - RECETTE') THEN
            Gtext_alias := 'VSC GROUPE'
        ELSE
            Gtext_alias := COMPANYNAME;

        //recherche du nom du fournisseur
        Gtext_VendorName := '';
        IF Grec_Vendor.GET(Rec."Buy-from Vendor No.") THEN BEGIN
            Gtext_VendorName := Grec_Vendor.Name;
            Gtext_ObjetMail := Gtext_alias + ' - ' + Gtext_ObjetMail + ' - ' + Gtext_VendorName;
        END ELSE
            Gtext_ObjetMail := Gtext_alias + ' - ' + Gtext_ObjetMail;

        //creation du mail
        //[Syntax for the Createmessage function -
        // Createmessage([sender's name] ,[sender's id],[recipient's id or ids],[subject] ,[body line],[html formatted or not]]

        VSCSettings.GET();
        IF VSCSettings."BC Test Mode" THEN
            Gtext_MailUser.Add(VSCSettings."BC E-Mail Test");
        BCCRecipients.Add('');
        Gtext_MailCCList.Add(Gtext_MailCC);
        EmailMessage.Create(Gtext_MailUser, Gtext_ObjetMail, '', TRUE, Gtext_MailCCList, BCCRecipients);

        //corps du mail8
        Gtext_Corps := '';

        Gtext_Corps += 'Bonjour,<br> <br>';

        Gtext_Corps += 'Nous avons reçu une facture <b>' + Rec."No." + '</b>.<br><br>';

        Gtext_Corps += 'Nous avons besoin de votre contrôle et de votre validation pour la payer.';

        //lien Navision
        Gtext_Corps += '<br><br>Pour accéder à la facture suivre le lien suivant: ';
        Gtext_Corps += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 50003, Rec);
        Gtext_Corps += '">Approbation de facture</a><br><br>';
        //Gtext_Corps +='lien</a> + cliquez sur <font color="blue">"Approbation de facture"</font><br><br>';

        Gtext_Corps += '<b><font color="red">Cette opération est à effectuer </font></b>';
        Gtext_Corps += '<b><font color="red">si et seulement SI LA PRESTATION EST CONFORME, </font></b>';
        Gtext_Corps += '<b><font color="red">dans le cas contraire nous vous remercions de </font></b>';
        Gtext_Corps += '<b><font color="red">nous en informer par mail.</font></b><br><br>';

        Gtext_Corps += 'Merci de votre coopération,<br><br>';
        Gtext_Corps += 'Le Service comptabilité.';

        EmailMessage.AppendToBody(Gtext_Corps);
        InsertFacture(EmailMessage, Rec."No.", TempBlob);
        IF CONFIRM(STRSUBSTNO(VariableDebutMail8, Rec."No.") + VariableFinMail8 + VariableSignature) THEN BEGIN
            //Envoi du mail
            MailV.Send(EmailMessage);
            MESSAGE(Text002);
            InsertHistorique();
        END;
    end;

    procedure SendMail2() pCorps: Text[1024]
    var
        lPurchHeader: Record "Purchase Header";
        TempBlob: codeunit "Temp Blob";
    begin
        CLEAR(EmailMessage);

        //recherche du mail de l'utilisateur
        IF Grec_UserSetup.GET(USERID) THEN
            Gtext_Mail := Grec_UserSetup."E-Mail";

        IF Grec_UserSetup.GET(Rec."Assigned User ID") THEN
            Gtext_MailUser.Add(Grec_UserSetup."E-Mail");

        //recherche du nom du fournisseur
        Gtext_VendorName := '';
        IF Grec_Vendor.GET(Rec."Buy-from Vendor No.") THEN
            Gtext_VendorName := Grec_Vendor.Name;
        Gtext_alias := '';
        IF (COMPANYNAME = 'VFEC') OR (COMPANYNAME = 'VFEC - RECETTE') THEN
            Gtext_alias := 'VSC GROUPE'
        ELSE
            Gtext_alias := COMPANYNAME;

        //recherche du nom du fournisseur
        Gtext_VendorName := '';
        IF Grec_Vendor.GET(Rec."Buy-from Vendor No.") THEN BEGIN
            Gtext_VendorName := Grec_Vendor.Name;
            Gtext_ObjetMail := Gtext_alias + ' - ' + Gtext_ObjetMail + ' - ' + Gtext_VendorName;
        END ELSE
            Gtext_ObjetMail := Gtext_alias + ' - ' + Gtext_ObjetMail;

        //creation du mail
        //[Syntax for the Createmessage function -
        // Createmessage([sender's name] ,[sender's id],[recipient's id or ids],[subject] ,[body line],[html formatted or not]]

        VSCSettings.GET();
        IF VSCSettings."BC Test Mode" THEN
            Gtext_MailUser.Add(VSCSettings."BC E-Mail Test");
        BCCRecipients.Add('');
        Gtext_MailCCList.Add(Gtext_MailCC);
        EmailMessage.Create(Gtext_MailUser, Gtext_ObjetMail, '', TRUE, Gtext_MailCCList, BCCRecipients);

        //Corps du mail 2
        Gtext_Corps := '';
        Gtext_Corps1 := '';

        Gtext_Corps += '<b>Bonjour,</b><br><br>';

        Gtext_Corps += '<b>Nous ne pouvons pas saisir la facture ' + Rec."No." + ', pour la raison suivante:</b><br><br>';
        Gtext_Corps += '<b>Le devis correspondant n’a pas été créé.</b><br><br>';

        Gtext_Corps += '<u>Informations sur la facture pour laquelle vous devez créer un devis :</u><br><br>';
        Gtext_Corps += '<b>Fournisseur : ' + Gtext_VendorName + '</b><br>';
        Gtext_Corps += '<b>Date de facture : ' + FORMAT(Rec."Document Date") + ' </b><br>';
        Gtext_Corps += '<b>N° facture : ' + Rec."Vendor Invoice No." + ' </b><br>';
        Gtext_Corps += '<b>Montant : ' + FORMAT(Rec."BC6_Register amount") + '</b><br>';


        Gtext_Corps += '<br>Merci de faire le nécessaire le plus rapidement possible.<br><br>';

        Gtext_Corps1 += '<br><font color="red">Ces opérations sont à effectuer <u>si et seulement si vous êtes d''accord avec ';
        Gtext_Corps1 += 'la prestation facturée, dans le cas contraire nous vous remercions de ';
        Gtext_Corps1 += 'nous en informer par mail.</font><br><br>';

        lPurchHeader.INIT();
        lPurchHeader."Document Type" := lPurchHeader."Document Type"::Quote;
        lPurchHeader."No." := '';
        lPurchHeader.INSERT(TRUE);

        //lien Navision
        Gtext_Corps1 += '<br>Pour créer une DA, suivre le lien suivant: ';
        Gtext_Corps1 += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 49, lPurchHeader);
        Gtext_Corps1 += '">Créer une DA</a>';
        Gtext_Corps1 += '<br><font color="blue"> + Puis cliquer sur Nouveau </font><br><br>';

        Gtext_Corps1 += '<b>Merci de votre coopération,</b><br><br>';
        Gtext_Corps1 += '<b>Le Service comptabilité.</b>';


        EmailMessage.AppendToBody(Gtext_Corps);
        EmailMessage.AppendToBody(Gtext_Corps1);
        InsertFacture(EmailMessage, Rec."No.", TempBlob);
        IF CONFIRM(STRSUBSTNO(VariableDebutMail2, Rec."No.")
        + STRSUBSTNO(VariableMilieuMail2, Gtext_VendorName, Rec."Document Date", Rec."Vendor Invoice No.", Rec."BC6_Register amount")
        + VariableFinMail2 + VariableSignature) THEN BEGIN
            //Envoi du mail
            MailV.Send(EmailMessage);
            MESSAGE(Text002);
            InsertHistorique();
        END;
    end;

    procedure InsertHistorique()
    var
        Lrec_Historic: Record "BC6_VSC historic";
        Lrec_PurchLines: Record "Purchase Line";
    begin
        //Début Ajout JX-XAD le 20/11/2009
        Lrec_Historic.INIT();
        Lrec_Historic."Type" := Lrec_Historic."Type"::Invoice;
        Lrec_Historic."No." := Rec."No.";
        Lrec_Historic."Date time" := CURRENTDATETIME;

        Lrec_PurchLines.SETFILTER(Lrec_PurchLines."Document Type", FORMAT(Lrec_PurchLines."Document Type"::Invoice));
        Lrec_PurchLines.SETFILTER(Lrec_PurchLines."Document No.", Rec."No.");
        Lrec_Historic."Description" := Rec."BC6_Status description";

        Lrec_Historic."User ID" := USERID;

        // modif LAB du 16/12/2009
        // ajout de la gestion du code utilisateur affecté sur l'historique envoi email

        Lrec_Historic."Assigned User ID" := Rec."Assigned User ID";

        //fin modif LAB du 16/12/2009

        Lrec_Historic.INSERT();
    end;

    procedure InsertFacture(var SMAIL: codeunit "Email Message"; pNumFacture: Code[20]; var TempBlob: codeunit "Temp Blob"): Text[250]
    var
        InStream: InStream;
    begin
        TempBlob.CreateInStream(InStream);
        IF (COMPANYNAME = 'VSC') OR (COMPANYNAME = 'VSC - RECETTE') THEN
            IF EXISTS('\\10.16.34.109\Pdf\Factures\VSC\' + pNumFacture + '.pdf') THEN
                SMAIL.AddAttachment('\\10.16.34.109\Pdf\Factures\VSC\' + pNumFacture + '.pdf', '\\10.16.34.109\Pdf\Factures\VSC\' + pNumFacture + '.pdf', InStream);

        IF (COMPANYNAME = 'VSCT') OR (COMPANYNAME = 'VSCT - RECETTE') THEN
            IF EXISTS('\\10.16.34.109\Pdf\Factures\VSCT\' + pNumFacture + '.pdf') THEN
                SMAIL.AddAttachment('\\10.16.34.109\Pdf\Factures\VSCT\' + pNumFacture + '.pdf', '\\10.16.34.109\Pdf\Factures\VSCT\' + pNumFacture + '.pdf', InStream);

        IF (COMPANYNAME = 'Agence') OR (COMPANYNAME = 'Agence - RECETTE') THEN
            IF EXISTS('\\10.16.34.109\Pdf\Factures\Agvsc\' + pNumFacture + '.pdf') THEN
                SMAIL.AddAttachment('\\10.16.34.109\Pdf\Factures\Agvsc\' + pNumFacture + '.pdf', '\\10.16.34.109\Pdf\Factures\Agvsc\' + pNumFacture + '.pdf', InStream);

        IF (COMPANYNAME = 'VFEC') OR (COMPANYNAME = 'VFEC - RECETTE') THEN
            IF EXISTS('\\10.16.34.109\Pdf\Factures\VSCG\' + pNumFacture + '.pdf') THEN
                SMAIL.AddAttachment('\\10.16.34.109\Pdf\Factures\VSCG\' + pNumFacture + '.pdf', '\\10.16.34.109\Pdf\Factures\VSCG\' + pNumFacture + '.pdf', InStream);

        IF (COMPANYNAME = 'HEXATOURISME') OR (COMPANYNAME = 'HEXATOURISME - RECETTE') THEN
            IF EXISTS('\\10.16.34.109\Pdf\Factures\HEXATOURISME\' + pNumFacture + '.pdf') THEN
                SMAIL.AddAttachment('\\10.16.34.109\Pdf\Factures\HEXATOURISME\' + pNumFacture + '.pdf', '\\10.16.34.109\Pdf\Factures\HEXATOURISME\' + pNumFacture + '.pdf', InStream);
        EXIT;
    end;
}

