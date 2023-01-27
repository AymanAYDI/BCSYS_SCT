codeunit 50003 "BC6_VSC_Mail"
{
    var
        Grec_UserSetup: Record "User Setup";
        Mail: codeunit Email;
        EmailMessage: codeunit "Email Message";
        TempBlob: codeunit "Temp Blob";
        Text002: label 'Hello,', Comment = 'FRA="Bonjour,"';
        Text010: label 'the credit memo', Comment = 'FRA="l''avoir"';
        Text013: label 'Accounting Service.', Comment = 'FRA="Service comptabilité."';
        Text016: label ' with user account "', Comment = 'FRA=" avec le compte utilisateur ""';
        Text017: label 'This operation is to be carried out only if you agree with the amount of the credit note issued, otherwise please notify the supplier by putting a copy to us.', Comment = 'FRA="Cette opération est à effectuer uniquement si vous être d''accord avec le montant de l''avoir émis, dans le cas contraire veuillez svp en avertir le fournisseur en nous mettant en copie."';
        Text018: label 'Email has been sent', Comment = 'FRA="Le mail a été envoyé"';
        Gtext_MailUser: List of [Text];
        Gtext_alias: Text;
        Gtext_Mail: Text[100];

    procedure NewMessageAvoir(ToName: Text[80]; CCName: Text[80]; Subject: Text[260]; Body: Text[260]; AttachFileName: Text[260]; OpenDialog: Boolean; LRecPurchaseHeader: Record "Purchase Header"; Ptxt_DocNumber: Text[30]; LtxtUser: Text[30]) MailSent: Boolean;
    var
        LtxtAmount: Text[30];
        LtxtCurrency: Text[30];
        LtxtVendorname: Text[100];
        Ltxt_body: Text[1024];
    begin
        LRecPurchaseHeader.CALCFIELDS(LRecPurchaseHeader."BC6_Lines Amount");
        if LRecPurchaseHeader."Currency Code" <> '' then
            LtxtCurrency := LRecPurchaseHeader."Currency Code"
        else
            LtxtCurrency := 'EUR';

        LtxtVendorname := LRecPurchaseHeader."Buy-from Vendor Name";
        LtxtAmount := FORMAT(LRecPurchaseHeader."BC6_Lines Amount");
        Ltxt_body += Text002 + '<br><br>';
        Ltxt_body += 'Merci de contrôler puis envoyer en approbation <b>' + Text010 + ' ' + Ptxt_DocNumber + '</b>';
        Ltxt_body += ' du fournisseur' + ' <b>' + LtxtVendorname + '</b>';
        Ltxt_body += ' pour un montant de <b>' + LtxtAmount + ' ' + LtxtCurrency + ' HT</b>';
        Ltxt_body += ' sur la société <b>' + COMPANYNAME + '</b>';
        Ltxt_body += Text016 + '<b>' + LtxtUser + '</b>". <br><br>';

        Ltxt_body += 'Cliquez sur le ';
        Ltxt_body += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 50005, LRecPurchaseHeader) + '">';
        //Ltxt_body +='&position=Field1=0(3),Field3=0(' + Ptxt_DocNumber + ')">';
        Ltxt_body += '<u>lien</u></a> puis appuyez sur le bouton <font color="blue">"Approbation d''avoir"</font><br><br>';

        Ltxt_body += '<font color="red">' + Text017 + '</font>';
        Ltxt_body += '<br><br>' + Text013;
        //recherche du mail de l'utilisateur
        if Grec_UserSetup.GET(USERID) then
            Gtext_Mail := Grec_UserSetup."E-Mail";

        Gtext_MailUser.Add(ToName);
        Gtext_alias := '';
        if (COMPANYNAME = 'VFEC') or (COMPANYNAME = 'VFEC - RECETTE') then
            Gtext_alias := 'VSC GROUPE'
        else
            Gtext_alias := COMPANYNAME();

        //creation du mail
        //[Syntax for the Createmessage function -
        // Createmessage([sender's name] ,[sender's id],[recipient's id or ids],[subject] ,[body line],[html formatted or not]]
        //NB:Les paramétres [sender's name] ,[sender's id] n'existe pas
        EmailMessage.Create(Gtext_MailUser, Subject, '', true);
        EmailMessage.AppendToBody(Ltxt_body);
        InsertAvoir(Ptxt_DocNumber, EmailMessage, TempBlob);
        // //Envoi du mail
        if CONFIRM('Confirmez-vous l''envoi de cet email ?') then begin
            Mail.Send(EmailMessage);
            MESSAGE(Text018);
            // END;
        end;
    end;

    local procedure TrimCode(Code: Code[20]) TrimString: Text;
    begin
        TrimString := COPYSTR(Code, 1, 1) + LOWERCASE(COPYSTR(Code, 2, STRLEN(Code) - 1))
    end;

    procedure GetMailGUIDFieldName(): Text[30];
    begin
        exit('Mail GUID');
    end;

    local procedure CollectContactAddresses(var ContactThrough: Record "Communication Method"; ContactNo: Code[20]);
    var
        Contact: Record Contact;
        ContAltAddrDateRange: Record "Contact Alt. Addr. Date Range";
        ContAltAddr: Record "Contact Alt. Address";
        KeyNo: Integer;
    begin
        if not Contact.GET(ContactNo) then
            exit;
        if ContactThrough.FINDLAST() then
            KeyNo := ContactThrough.Key + 1
        else
            KeyNo := 1;

        if Contact."E-Mail" <> '' then begin
            ContactThrough.Key := KeyNo;
            ContactThrough."Contact No." := ContactNo;
            ContactThrough.Name := Contact.Name;
            ContactThrough.Description := Contact.FIELDCAPTION("E-Mail");
            ContactThrough."E-Mail" := Contact."E-Mail";
            ContactThrough.Type := Contact.Type;
            ContactThrough.INSERT();
            KeyNo := KeyNo + 1;
        end;

        // Alternative address
        ContAltAddrDateRange.SETCURRENTKEY("Contact No.", "Starting Date");
        ContAltAddrDateRange.SETRANGE("Contact No.", ContactNo);
        ContAltAddrDateRange.SETRANGE("Starting Date", 0D, TODAY);
        ContAltAddrDateRange.SETFILTER("Ending Date", '>=%1|%2', TODAY, 0D);
        if ContAltAddrDateRange.FINDSET() then
            repeat
                if ContAltAddr.GET(Contact."No.", ContAltAddrDateRange."Contact Alt. Address Code") then
                    if ContAltAddr."E-Mail" <> '' then begin
                        ContactThrough.Key := KeyNo;
                        ContactThrough.Description := TrimCode(ContAltAddr.Code) + ' - ' + ContAltAddr.FIELDCAPTION("E-Mail");
                        ContactThrough."E-Mail" := ContAltAddr."E-Mail";
                        ContactThrough.Type := Contact.Type;
                        ContactThrough.INSERT();
                        KeyNo := KeyNo + 1;
                    end;
            until ContAltAddrDateRange.NEXT() = 0;
    end;

    procedure InsertAvoir(pNumAvoir: Code[20]; var EmailMessageV: Codeunit "Email Message"; var TempBlobV: codeunit "Temp Blob") AttachFileName: Text[250];
    var
        InStream: InStream;
        FileNameLbl: label 'Avoir_%1%2';
        AttachmentFileName: Text[250];
    begin
        AttachmentFileName := STRSUBSTNO(FileNameLbl, pNumAvoir, '.pdf');

        if not TempBlobV.HasValue() then
            exit;

        TempBlobV.CreateInStream(InStream);
        EmailMessageV.AddAttachment(AttachmentFileName, 'SendMail', InStream);
    end;
}
