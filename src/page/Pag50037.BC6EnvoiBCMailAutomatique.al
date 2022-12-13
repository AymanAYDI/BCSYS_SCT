page 50037 "BC6 Envoi BC Mail Automatique"
{
    // JX-ABE 09/12/2016 : Modification de la signature du corps
    // JX-ABE 21/12/2017 : Changer la signature du corps.
    // JX-ABE 21/12/2017 : Ajout le text demandé.

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTable = Date;
    ApplicationArea = All;
    UsageCategory = Tasks;
    Caption = 'Envoi BC Mail Automatique', Comment = 'FRA="Envoi BC Mail Automatique"';

    layout
    {
        area(content)
        {
            field(Gdate_DateCompta; Gdate_DateCompta)
            {
                Caption = 'Saisir la date de comptabilisation', Comment = 'FRA="Saisir la date de comptabilisation"';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Lancement des envois")
            {
                Image = SendEmailPDF;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    InStream: InStream;
                    TempBlob: codeunit "Temp Blob";
                begin
                    //mail expéditeur
                    IF Grec_UserSetup.GET(USERID) THEN
                        Gtext_Mail := Grec_UserSetup."E-Mail";

                    //Window.OPEN('processing');
                    //WindowisOpen := FALSE;
                    //IF FileName = '' THEN
                    //ERROR('Please specify what the file should be saved as');
                    Object.GET(Object.Type::Report, '', ReportID);

                    Grec_PurchaseHeader.SETFILTER(Grec_PurchaseHeader."Document Type", FORMAT(Grec_PurchaseHeader."Document Type"::Order));
                    Grec_PurchaseHeader.SETFILTER(Grec_PurchaseHeader."Posting Date", FORMAT(Gdate_DateCompta));
                    //Grec_PurchaseHeader.SETFILTER(Grec_PurchaseHeader."Posting Date", FORMAT(TODAY));
                    Grec_PurchaseHeader.SETFILTER(Grec_PurchaseHeader."BC6_Import", 'Oui');

                    IF Grec_PurchaseHeader.FIND('-') THEN BEGIN
                        REPEAT
                            Grec_PurchaseHeader2.SETFILTER(Grec_PurchaseHeader2."No.", Grec_PurchaseHeader."No.");

                            IF Grec_PurchaseHeader2.FIND('-') THEN BEGIN
                                Gtext_NomPresta := '';
                                Gtext_PrenomPresta := '';
                                Gtext_DebutContrat := '';
                                Gtext_FinContrat := '';

                                Gtext_Fournisseur := Grec_PurchaseHeader2."BC6_Import Vendor Email";
                                IF Gtext_Fournisseur = '' THEN
                                    ERROR('L''email du fournisseur pour la commande ' + Grec_PurchaseHeader2."No." + ' n''est pas renseigné');

                                //recherche des information sur le contrat
                                // Grec_Contract.SETFILTER(Grec_Contract."BC6 Order No.", Grec_PurchaseHeader2."No.");
                                // IF Grec_Contract.FIND('-') THEN BEGIN

                                //     Gtext_NomPresta := DELCHR(Grec_Contract."BC6 Nom prestataire", '=', '');
                                //     Gtext_PrenomPresta := DELCHR(Grec_Contract."BC6 Prénom prestataire", '=', '');
                                //     Gtext_DebutContrat := FORMAT(Grec_Contract."BC6 Date of entry", 0, '<Day,2><Month,2><Year>');
                                //     Gtext_FinContrat := FORMAT(Grec_Contract."BC6_End date", 0, '<Day,2><Month,2><Year>');
                                //     // FORMAT(DATE2DMY(Gdate_DebutContrat,1)) + '' +
                                //     //FORMAT(DATE2DMY(Gdate_DebutContrat,2)) + '' + FORMAT(DATE2DMY(Gdate_DebutContrat,3)) ;

                                //     Name := STRSUBSTNO('%1- Prestation ' + Gtext_NomPresta + ' ' + Gtext_PrenomPresta
                                //     + ' du ' + Gtext_DebutContrat + ' au ' + Gtext_FinContrat + '', Grec_PurchaseHeader2."No.");

                                //     FileName := STRSUBSTNO('%1-Prestation_' + Gtext_NomPresta + '_' + Gtext_PrenomPresta
                                //     + '_du_' + Gtext_DebutContrat + '_au_' + Gtext_FinContrat + '.pdf', Grec_PurchaseHeader2."No.");

                                // END ELSE BEGIN
                                FileName := STRSUBSTNO('%1.pdf', Grec_PurchaseHeader2."No.");
                                Name := STRSUBSTNO('%1', Grec_PurchaseHeader2."No.");
                                // END;

                                ObjetMail := Name;
                                Corps := 'Madame, Monsieur,<br><br>';
                                Corps += 'Vous trouverez en pièce jointe le bon de commande concernant la prestation de ';
                                Corps += Gtext_NomPresta + ' ' + Gtext_PrenomPresta + ' ';
                                Corps += 'pour la période du ' + Gtext_DebutContrat + ' au ' + Gtext_FinContrat + '.<br><br>';
                                Corps += '<u>Nous vous remercions de rappeler la référence des bons de commande sur vos factures.</u><br><br>';
                                //JX-ABE Ajout du 21/12/2017
                                Corps += 'Les factures sont à transmettre à cette adresse mail : Facturesonly@oui.sncf,<br><br>';
                                //JX-ABE Fin d'ajout du 21/12/2017
                                Corps += 'Nous vous en souhaitons bonne réception et restons à votre disposition pour toutes questions complémentaires.';
                                Corps += '<br><br>';
                                Corps += 'Cordialement,<br><br>';

                                //JX-ABE Modif du 21/12/2017 : Changer la signature du corps

                                // //JX-ABE Modif du 09/12/2016
                                // //Corps += 'Le Service Contrôle de Gestion VSC-Technologies';
                                // Corps += 'Le Service Contrôle de Gestion Voyages-Sncf.com';
                                // //JX-ABE Fin Modif du 09/12/2016

                                Corps += 'Le Service Contrôle de Gestion de OUI.Sncf';

                                //JX-ABE Fin Modif du 21/12/2017


                                /* // Suppression du code PDFCreator suite migration Nav2015
                                      PDFCreatorOption :=  PDFCreator.cOptions;

                                      PDFCreatorOption.UseAutosave := 1;
                                      PDFCreatorOption.UseAutosaveDirectory := 1;
                                      PDFCreatorOption.AutosaveDirectory := FileDirectory;
                                      PDFCreatorOption.AutosaveFormat := 0;                       //PDF file, you can also save in other formats
                                      PDFCreatorOption.AutosaveFilename := FileName;

                                      PDFCreator.cOptions := PDFCreatorOption;
                                      PDFCreator.cClearCache();
                                      DefaultPrinter := PDFCreator.cDefaultPrinter;
                                      PDFCreator.cDefaultPrinter := 'PDFCreator';
                                      PDFCreator.cPrinterStop := FALSE;
                                */

                                REPORT.SaveAsPdf(ReportID, FileDirectory + FileName, Grec_PurchaseHeader2);
                                //      SLEEP(8000); 

                                // JX-VSC3.0-PBD Nav2015
                                EMailTest.Add(VSCSettings."BC E-Mail Test");
                                Gtext_FournisseurList.Add(Gtext_Fournisseur);
                                IF VSCSettings."BC Test Mode" THEN
                                    EmailMessage.Create(EMailTest, ObjetMail, '', TRUE)
                                ELSE
                                    EmailMessage.Create(Gtext_FournisseurList, ObjetMail, '', TRUE);
                                EmailMessage.AppendToBody(Corps);
                                TempBlob.CreateInStream(InStream);
                                EmailMessage.AddAttachment(FileDirectory + FileName, FileName, InStream);
                                Mail.Send(EmailMessage);
                                //On modifie la commande pour décocher le champ "Import"
                                // JX-VSC3.0-PBD Nav2015
                                IF NOT VSCSettings."BC Test Mode" THEN
                                    IF Grec_PurchaseHeader3.GET(Grec_PurchaseHeader3."Document Type"::Order, Grec_PurchaseHeader2."No.") THEN BEGIN
                                        Grec_PurchaseHeader3."BC6_Import" := FALSE;
                                        Grec_PurchaseHeader3.MODIFY();
                                        COMMIT();
                                    END;

                                FILE.Erase(FileDirectory + FileName);//on supprime le fichier après envoi

                            END;
                        UNTIL Grec_PurchaseHeader.NEXT() = 0;
                        MESSAGE('Les envois sont terminés');
                    END ELSE
                        ERROR('Aucune commande à la date indiquée');

                end;
            }
        }
    }


    trigger OnOpenPage()
    begin
        Rec.SETRANGE("Period Type", Rec."Period Type"::Date);
        Rec.SETRANGE("Period Start", WORKDATE());

        VSCSettings.GET();
        /*
        IF ISCLEAR(PDFCreator) THEN
          CREATE(PDFCreator,VSCSettings."New Server",VSCSettings."On Client");
        IF ISCLEAR(PDFCreatorError) THEN
          CREATE(PDFCreatorError,VSCSettings."New Server",VSCSettings."On Client");
        */

        ReportID := 50041;
        IF Object.GET(Object.Type::Report, '', ReportID) THEN;

        Gdate_DateCompta := TODAY;
        IF NOT VSCSettings."BCUse Temporary Path" THEN
            FileDirectory := VSCSettings."BC Path"
        ELSE
            FileDirectory := TEMPORARYPATH;

        /*
        PDFCreatorError := PDFCreator.cError;
        
        IF PDFCreator.cStart('/NoProcessingAtStartup',TRUE) = FALSE THEN
             ERROR('Status: Error[' + FORMAT(PDFCreatorError.Number) + ']: ' + PDFCreatorError.Description);
        */

    end;

    var
        FileDirectory: Text;
        FileName: Text;
        ReportID: Integer;
        VSCSettings: Record "BC6_VSC Settings";
        "Object": Record "Object";
        EMailTest, Gtext_FournisseurList : list of [Text];
        // [WithEvents]
        // PDFCreator: Automation;
        // PDFCreatorOption: Automation;
        // PDFCreatorError: Automation;
        DefaultPrinter: Text[200];
        Window: Dialog;
        WindowisOpen: Boolean;
        //FileDialog: Codeunit "SMTP Test Mail";
        Grec_PurchaseHeader: Record "Purchase Header";
        Tofile: Text;
        Grec_PurchaseHeader2: Record "Purchase Header";
        //SMAIL: Codeunit "SMTP Mail";
        Mail: codeunit Email;
        EmailMessage: codeunit "Email Message";
        Gtext_Mail: Text[50];
        Grec_UserSetup: Record "User Setup";
        Gtext_Fournisseur: Text[250];
        Gtext_text: Text;
        Name: Text;
        ObjetMail: Text;
        Corps: Text;
        Gdate_DateCompta: Date;
        Grec_PurchaseHeader3: Record "Purchase Header";
        //Grec_Contract: Record "BC6 Contract";
        Gtext_NomPresta: Text[100];
        Gtext_DebutContrat: Text[10];
        Gtext_FinContrat: Text[10];
        Gtext_PrenomPresta: Text[100];
        Gtext_CheminDossierBC: Label '\\10.16.34.109\Pdf\Suppliers \', Comment = 'FRA="\\10.16.34.109\Pdf\Suppliers \"';
        Gtext_CheminDossierBC1: Label 'C:\Users\aurelie\Desktop\temp\', Comment = 'FRA="C:\Users\aurelie\Desktop\temp\"';
}

