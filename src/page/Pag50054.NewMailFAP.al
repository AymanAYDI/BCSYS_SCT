page 50054 "BC6_New Mail FAP"
{
    PageType = NavigatePage;
    SourceTable = "Purchase Header";
    Caption = 'New Mail FAP', Comment = 'FRA="New Mail FAP"';

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
                field("Montant 1"; Amount1)
                {
                    Visible = bvisible;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CalcAmount();
                    end;
                }
                field("Montant 2"; Amount2)
                {
                    Visible = bvisible;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CalcAmount();
                    end;
                }
                field("Différence"; Amount3)
                {
                    Editable = false;
                    Visible = bvisible;
                    ApplicationArea = All;
                }
                field(Nombre1; Nombre1)
                {
                    Visible = bvisibleint;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CalcAmount();
                    end;
                }
                field(Nombre2; Nombre2)
                {
                    Visible = bvisibleint;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CalcAmount();
                    end;
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
                    Caption = 'Mail', Comment = 'FRA="Mail"';
                    Image = SendApprovalRequest;
                    InFooterBar = true;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        SendMail();
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        VSCSettings.GET();
        PurchSetup.GET();
        case Gint_Param4 of
            1:
                CorpsMail1();
            2:
                begin
                    CorpsMail2();
                    SendMail();
                    CurrPage.CLOSE();
                end;
            3:
                CorpsMail3();
            4:
                CorpsMail4();
            5:
                CorpsMail5();
            6:
                CorpsMail6();
            7:
                CorpsMail7();
            8:
                begin
                    CorpsMail8();
                    SendMail();
                    CurrPage.CLOSE();
                end;
            9:
                CorpsMail9();
        end;
    end;

    var
        MailText: Record "BC6_Mail Body Setup";
        MailSetup: Record "BC6_Mail Setup";
        VSCSettings: Record "BC6_VSC Settings";
        Grec_PurchaseHeader: Record "Purchase Header";
        PurchSetup: Record "Purchases & Payables Setup";
        Grec_UserSetup: Record "User Setup";
        Grec_Vendor: Record Vendor;
        [InDataSet]
        bVisible: Boolean;
        [InDataSet]
        bVisibleInt: Boolean;
        Amount1: Decimal;
        Amount2: Decimal;
        Amount3: Decimal;
        Gint_Param4: Integer;
        NbAtt: Integer;
        Nombre1: Integer;
        Nombre2: Integer;

        Gtext_MailCC: label 'VSCComptaFour@voyages-sncf.com', Comment = 'FRA="VSCComptaFour@voyages-sncf.com"';
        Text001: label 'The document number is incorrect, please change it', Comment = 'FRA="Le numéro du document est incorrect, veuillez le modifier"';
        Text002: label 'The email has been sent', Comment = 'FRA="Le mail a bien été envoyé"';
        BCCRecipients: List of [Text];
        Gtext_MailCCList: List of [Text];
        Gtext_MailUser: list of [Text];
        AddAtt: array[10] of Text;
        Aff_Corps: Text;
        Gtext_Corps: Text;
        Gtext_ObjetMail: Text;
        Gtext_Param1: Text;
        Gtext_Param2: Text;
        Gtext_Param3: Text;
        URLNavBC: Text;
        URLNavDA: Text;
        URLNavFAC: Text;
        Gtext_alias: Text[30];
        Gtext_Mail: Text[50];
        Gtext_VendorName: Text[50];

    local procedure CalcAmount()
    var
        x: Integer;
    begin
        Amount3 := Amount2 - Amount1;
        case Gint_Param4 of
            1:
                Gtext_Param3 := '= <MONTANT1> euros pour une FACTURE= <MONTANT2> euros d''où un écart de <MONTANT3> euros';
            9:
                Gtext_Param3 := '<NOMBRE1> jours pour une facture = <NOMBRE2> jours';
        end;
        x := STRPOS(UPPERCASE(Gtext_Param3), '<MONTANT1>');
        if (x <> 0) and (Amount1 <> 0) then
            Gtext_Param3 := COPYSTR(Gtext_Param3, 1, x - 1) + FORMAT(Amount1) + COPYSTR(Gtext_Param3, x + 10);

        x := STRPOS(UPPERCASE(Gtext_Param3), '<MONTANT2>');
        if (x <> 0) and (Amount2 <> 0) then
            Gtext_Param3 := COPYSTR(Gtext_Param3, 1, x - 1) + FORMAT(Amount2) + COPYSTR(Gtext_Param3, x + 10);

        x := STRPOS(UPPERCASE(Gtext_Param3), '<MONTANT3>');
        if (x <> 0) and (Amount1 <> 0) and (Amount2 <> 0) then
            Gtext_Param3 := COPYSTR(Gtext_Param3, 1, x - 1) + FORMAT(Amount3) + COPYSTR(Gtext_Param3, x + 10);

        x := STRPOS(UPPERCASE(Gtext_Param3), '<NOMBRE1>');
        if (x <> 0) and (Nombre1 <> 0) then
            Gtext_Param3 := COPYSTR(Gtext_Param3, 1, x - 1) + FORMAT(Nombre1) + COPYSTR(Gtext_Param3, x + 9);

        x := STRPOS(UPPERCASE(Gtext_Param3), '<NOMBRE2>');
        if (x <> 0) and (Nombre2 <> 0) then
            Gtext_Param3 := COPYSTR(Gtext_Param3, 1, x - 1) + FORMAT(Nombre2) + COPYSTR(Gtext_Param3, x + 9);
    end;

    procedure SetParam(Param1: Text; Param2: Text; Param3: Text; Param4: Integer; Param5: Text)
    begin
        Gtext_Param1 := Param1;
        Gtext_Param2 := Param2;
        Gtext_Param3 := Param3;
        Gint_Param4 := Param4;
        Gtext_ObjetMail := Param5;
        bVisible := false;
        bVisibleInt := false;
        if Gint_Param4 = 6 then
            bVisible := true;
        if Gint_Param4 = 9 then
            bVisibleInt := true;
    end;

    procedure SetPurchaseHeader(p_PurchaseHeader: Record "Purchase Header")
    begin
        Grec_PurchaseHeader := p_PurchaseHeader;
    end;

    local procedure ReplaceText(pText: Text): Text
    var
        x: Integer;
        y: Integer;
    begin
        CLEAR(AddAtt);
        NbAtt := 0;
        x := STRPOS(pText, '<NOFOUR>');
        if x <> 0 then
            pText := COPYSTR(pText, 1, x - 1) + Rec."Buy-from Vendor No." + COPYSTR(pText, x + 8);
        x := STRPOS(pText, '<NOMFOUR>');
        if x <> 0 then
            pText := COPYSTR(pText, 1, x - 1) + Rec."Buy-from Vendor Name" + COPYSTR(pText, x + 9);
        x := STRPOS(pText, '<DATEDOC>');
        if x <> 0 then
            pText := COPYSTR(pText, 1, x - 1) + FORMAT(Rec."Document Date") + COPYSTR(pText, x + 9);
        x := STRPOS(pText, '<NOFAC>');
        if x <> 0 then
            pText := COPYSTR(pText, 1, x - 1) + Rec."No." + COPYSTR(pText, x + 7);
        x := STRPOS(pText, '<MTFAC>');
        if x <> 0 then
            pText := COPYSTR(pText, 1, x - 1) + FORMAT(Rec."BC6_Register amount") + COPYSTR(pText, x + 7);
        x := STRPOS(UPPERCASE(pText), '<B>');
        if x <> 0 then
            pText := COPYSTR(pText, 1, x - 1) + '<b>' + COPYSTR(pText, x + 3);
        x := STRPOS(UPPERCASE(pText), '</B>');
        if x <> 0 then
            pText := COPYSTR(pText, 1, x - 1) + '</b>' + COPYSTR(pText, x + 4);

        x := STRPOS(UPPERCASE(pText), '<COUL:');
        if x <> 0 then begin
            y := STRPOS(UPPERCASE(COPYSTR(pText, x + 6, 6)), 'ROUGE>');
            if y <> 0 then
                pText := COPYSTR(pText, 1, x - 1) + '<font color="red">' + COPYSTR(pText, x + 12)
            else begin
                y := STRPOS(UPPERCASE(COPYSTR(pText, x + 6, 5)), 'VERT>');
                if y <> 0 then
                    pText := COPYSTR(pText, 1, x - 1) + '<font color="green">' + COPYSTR(pText, x + 11)
                else begin
                    y := STRPOS(UPPERCASE(COPYSTR(pText, x + 6, 5)), 'BLEU>');
                    if y <> 0 then
                        pText := COPYSTR(pText, 1, x - 1) + '<font color="blue">' + COPYSTR(pText, x + 11)
                    else begin
                        y := STRPOS(UPPERCASE(COPYSTR(pText, x + 6, 1)), '>');
                        pText := COPYSTR(pText, 1, x - 1) + COPYSTR(pText, x + 7);
                    end;
                end;
            end;
        end;

        x := STRPOS(UPPERCASE(pText), '</COUL>');
        if x <> 0 then
            pText := COPYSTR(pText, 1, x - 1) + '</font>' + COPYSTR(pText, x + 7);

        x := STRPOS(UPPERCASE(pText), '<FJ:FOUR>');
        if x <> 0 then begin
            if EXISTS(PurchSetup."BC6_ExcelFile Vend Not Created") then begin
                NbAtt += 1;
                AddAtt[NbAtt] := PurchSetup."BC6_ExcelFile Vend Not Created";
            end;
            pText := '';
        end;

        x := STRPOS(UPPERCASE(pText), '<FJ:FAC>');
        if x <> 0 then begin
            if EXISTS(PurchSetup."BC6_Mail Invoice Path" + Rec."No." + '.pdf') then begin
                NbAtt += 1;
                AddAtt[NbAtt] := PurchSetup."BC6_Mail Invoice Path" + Rec."No." + '.pdf';
            end;
            pText := '';
        end;

        x := STRPOS(UPPERCASE(pText), '<LIENDOCDA>');
        if x <> 0 then
            pText := COPYSTR(pText, 1, x - 1) + URLNavDA + '">' + COPYSTR(pText, x + 11);

        x := STRPOS(UPPERCASE(pText), '</LIENDOCDA>');
        if x <> 0 then
            pText := COPYSTR(pText, 1, x - 1) + '</a>' + COPYSTR(pText, x + 12);

        x := STRPOS(UPPERCASE(pText), '<LIENDOCBC>');
        if x <> 0 then
            pText := COPYSTR(pText, 1, x - 1) + URLNavBC + '">' + COPYSTR(pText, x + 11);

        x := STRPOS(UPPERCASE(pText), '</LIENDOCBC>');
        if x <> 0 then
            pText := COPYSTR(pText, 1, x - 1) + '</a>' + COPYSTR(pText, x + 12);

        x := STRPOS(UPPERCASE(pText), '<LIENDOCFAC>');
        if x <> 0 then
            pText := COPYSTR(pText, 1, x - 1) + URLNavFAC + '">' + COPYSTR(pText, x + 12);

        x := STRPOS(UPPERCASE(pText), '</LIENDOCFAC>');
        if x <> 0 then
            pText := COPYSTR(pText, 1, x - 1) + '</a>' + COPYSTR(pText, x + 13);

        x := STRPOS(UPPERCASE(pText), '<LIENYOOZ>');
        if x <> 0 then
            pText := COPYSTR(pText, 1, x - 1) + '<a href="' + Rec."BC6_Yooz Token link" + '">Lien Yooz</a>' + COPYSTR(pText, x + 10);

        x := STRPOS(UPPERCASE(pText), '<PARAM1>');
        if x <> 0 then
            pText := COPYSTR(pText, 1, x - 1) + Gtext_Param1 + COPYSTR(pText, x + 8);

        x := STRPOS(UPPERCASE(pText), '<PARAM2>');
        if x <> 0 then
            pText := COPYSTR(pText, 1, x - 1) + Gtext_Param2 + COPYSTR(pText, x + 8);

        x := STRPOS(UPPERCASE(pText), '<PARAM3>');
        if x <> 0 then
            pText := COPYSTR(pText, 1, x - 1) + Gtext_Param3 + COPYSTR(pText, x + 8);

        x := STRPOS(UPPERCASE(pText), '<MONTANT1>');
        if x <> 0 then
            pText := COPYSTR(pText, 1, x - 1) + FORMAT(Amount1) + COPYSTR(pText, x + 10);

        x := STRPOS(UPPERCASE(pText), '<MONTANT2>');
        if x <> 0 then
            pText := COPYSTR(pText, 1, x - 1) + FORMAT(Amount2) + COPYSTR(pText, x + 10);

        x := STRPOS(UPPERCASE(pText), '<MONTANT3>');
        if x <> 0 then
            pText := COPYSTR(pText, 1, x - 1) + FORMAT(Amount3) + COPYSTR(pText, x + 10);

        exit(pText);
    end;

    procedure CorpsMail1() pCorps: Text
    var
        lPurchHeader: Record "Purchase Header";
    begin
        //corps du mail1
        URLNavBC := '';
        URLNavDA := '';
        if lPurchHeader.GET(lPurchHeader."Document Type", Gtext_Param2) then
            URLNavDA := '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 49, lPurchHeader)
        else
            URLNavDA += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 49);
        URLNavFAC := '';
        if lPurchHeader.GET(Rec."Document Type", Rec."No.") then
            URLNavFAC := '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 51, lPurchHeader)
        else
            URLNavFAC += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 51);

        CLEAR(Gtext_Corps);
        CLEAR(Aff_Corps);
        MailSetup.GET(MailSetup."Mail Type"::"Fourn. non créé");
        MailText.SETRANGE("Mail Type", MailText."Mail Type"::"Fourn. non créé");
        if MailText.FINDFIRST() then
            repeat
                if MailText.Seperator = MailText.Seperator::"Carriage Return" then begin
                    Gtext_Corps := Gtext_Corps + ReplaceText(MailText.Textline) + '<br>';
                    Aff_Corps := Aff_Corps + ReplaceText(MailText.Textline) + '\';
                end else begin
                    Gtext_Corps := Gtext_Corps + ReplaceText(MailText.Textline) + ' ';
                    Aff_Corps := Aff_Corps + ReplaceText(MailText.Textline) + ' ';
                end;
            until MailText.NEXT() = 0;

        pCorps := Gtext_Corps;
    end;

    procedure CorpsMail2() pCorps: Text
    var
        lPurchHeader: Record "Purchase Header";
    begin
        //corps du mail2
        URLNavBC := '';
        URLNavDA := '';
        URLNavDA += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 49);
        URLNavFAC := '';
        if lPurchHeader.GET(Rec."Document Type", Rec."No.") then
            URLNavFAC := '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 51, lPurchHeader)
        else
            URLNavFAC += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 51);

        CLEAR(Gtext_Corps);
        CLEAR(Aff_Corps);
        MailSetup.GET(MailSetup."Mail Type"::"DA à créer");
        MailText.SETRANGE("Mail Type", MailText."Mail Type"::"DA à créer");
        if MailText.FINDFIRST() then
            repeat
                if MailText.Seperator = MailText.Seperator::"Carriage Return" then begin
                    Gtext_Corps := Gtext_Corps + ReplaceText(MailText.Textline) + '<br>';
                    Aff_Corps := Aff_Corps + ReplaceText(MailText.Textline) + '\';
                end else begin
                    Gtext_Corps := Gtext_Corps + ReplaceText(MailText.Textline) + ' ';
                    Aff_Corps := Aff_Corps + ReplaceText(MailText.Textline) + ' ';
                end;
            until MailText.NEXT() = 0;

        pCorps := Gtext_Corps;
    end;

    procedure CorpsMail3() pCorps: Text
    var
        lPurchHeader: Record "Purchase Header";
    begin
        //corps du mail3
        URLNavBC := '';
        URLNavDA := '';
        if lPurchHeader.GET(lPurchHeader."Document Type", Gtext_Param2) then
            URLNavDA := '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 49, lPurchHeader)
        else
            URLNavDA += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 49);
        URLNavFAC := '';
        if lPurchHeader.GET(Rec."Document Type", Rec."No.") then
            URLNavFAC := '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 51, lPurchHeader)
        else
            URLNavFAC += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 51);

        CLEAR(Gtext_Corps);
        CLEAR(Aff_Corps);
        MailSetup.GET(MailSetup."Mail Type"::"DA non envoyé en appro.");
        MailText.SETRANGE("Mail Type", MailText."Mail Type"::"DA non envoyé en appro.");
        if MailText.FINDFIRST() then
            repeat
                if MailText.Seperator = MailText.Seperator::"Carriage Return" then begin
                    Gtext_Corps := Gtext_Corps + ReplaceText(MailText.Textline) + '<br>';
                    Aff_Corps := Aff_Corps + ReplaceText(MailText.Textline) + '\';
                end else begin
                    Gtext_Corps := Gtext_Corps + ReplaceText(MailText.Textline) + ' ';
                    Aff_Corps := Aff_Corps + ReplaceText(MailText.Textline) + ' ';
                end;
            until MailText.NEXT() = 0;
    end;

    procedure CorpsMail4() pCorps: Text
    var
        lPurchHeader: Record "Purchase Header";
    begin
        //corps du mail4
        URLNavDA := '';
        if lPurchHeader.GET(lPurchHeader."Document Type", Gtext_Param2) then
            URLNavDA := '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 49, lPurchHeader)
        else
            URLNavDA += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 49);
        URLNavFAC := '';
        if lPurchHeader.GET(Rec."Document Type", Rec."No.") then
            URLNavFAC := '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 51, lPurchHeader)
        else
            URLNavFAC += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 51);

        CLEAR(Gtext_Corps);
        CLEAR(Aff_Corps);
        MailSetup.GET(MailSetup."Mail Type"::"DA non approuvée");
        MailText.SETRANGE("Mail Type", MailText."Mail Type"::"DA non approuvée");
        if MailText.FINDFIRST() then
            repeat
                if MailText.Seperator = MailText.Seperator::"Carriage Return" then begin
                    Gtext_Corps := Gtext_Corps + ReplaceText(MailText.Textline) + '<br>';
                    Aff_Corps := Aff_Corps + ReplaceText(MailText.Textline) + '\';
                end else begin
                    Gtext_Corps := Gtext_Corps + ReplaceText(MailText.Textline) + ' ';
                    Aff_Corps := Aff_Corps + ReplaceText(MailText.Textline) + ' ';
                end;
            until MailText.NEXT() = 0;
    end;

    procedure CorpsMail5() pCorps: Text
    var
        lPurchHeader: Record "Purchase Header";
    begin
        //corps du mail5
        URLNavBC := '';
        URLNavDA := '';
        if lPurchHeader.GET(lPurchHeader."Document Type", Gtext_Param2) then
            URLNavDA := '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 49, lPurchHeader)
        else
            URLNavDA += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 49);
        URLNavFAC := '';
        if lPurchHeader.GET(Rec."Document Type", Rec."No.") then
            URLNavFAC := '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 51, lPurchHeader)
        else
            URLNavFAC += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 51);

        CLEAR(Gtext_Corps);
        CLEAR(Aff_Corps);
        MailSetup.GET(MailSetup."Mail Type"::"DA non transormée");
        MailText.SETRANGE("Mail Type", MailText."Mail Type"::"DA non transormée");
        if MailText.FINDFIRST() then
            repeat
                if MailText.Seperator = MailText.Seperator::"Carriage Return" then begin
                    Gtext_Corps := Gtext_Corps + ReplaceText(MailText.Textline) + '<br>';
                    Aff_Corps := Aff_Corps + ReplaceText(MailText.Textline) + '\';
                end else begin
                    Gtext_Corps := Gtext_Corps + ReplaceText(MailText.Textline) + ' ';
                    Aff_Corps := Aff_Corps + ReplaceText(MailText.Textline) + ' ';
                end;
            until MailText.NEXT() = 0;
    end;

    procedure CorpsMail6() pCorps: Text
    var
        lPurchHeader: Record "Purchase Header";
    begin
        //corps du mail6
        URLNavDA := '';
        URLNavDA := '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 49);
        URLNavBC := '';
        URLNavFAC := '';
        if lPurchHeader.GET(Rec."Document Type", Rec."No.") then
            URLNavFAC := '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 51, lPurchHeader)
        else
            URLNavFAC += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 51);

        CLEAR(Gtext_Corps);
        CLEAR(Aff_Corps);
        MailSetup.GET(MailSetup."Mail Type"::"DA Cplmt");
        MailText.SETRANGE("Mail Type", MailText."Mail Type"::"DA Cplmt");
        if MailText.FINDFIRST() then
            repeat
                if MailText.Seperator = MailText.Seperator::"Carriage Return" then begin
                    Gtext_Corps := Gtext_Corps + ReplaceText(MailText.Textline) + '<br>';
                    Aff_Corps := Aff_Corps + ReplaceText(MailText.Textline) + '\';
                end else begin
                    Gtext_Corps := Gtext_Corps + ReplaceText(MailText.Textline) + ' ';
                    Aff_Corps := Aff_Corps + ReplaceText(MailText.Textline) + ' ';
                end;
            until MailText.NEXT() = 0;
    end;

    procedure CorpsMail7() pCorps: Text
    var
        lPurchHeader: Record "Purchase Header";
    begin
        //corps du mail7
        URLNavDA := '';
        URLNavBC := '';
        if lPurchHeader.GET(Rec."Document Type"::Order, Gtext_Param2) then
            URLNavBC := '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 50, lPurchHeader)
        else
            URLNavBC += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 50);
        URLNavFAC := '';
        if lPurchHeader.GET(Rec."Document Type", Rec."No.") then
            URLNavFAC := '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 51, lPurchHeader)
        else
            URLNavFAC += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 51);

        CLEAR(Gtext_Corps);
        CLEAR(Aff_Corps);
        MailSetup.GET(MailSetup."Mail Type"::"BC à réceptionner");
        MailText.SETRANGE("Mail Type", MailText."Mail Type"::"BC à réceptionner");
        if MailText.FINDFIRST() then
            repeat
                if MailText.Seperator = MailText.Seperator::"Carriage Return" then begin
                    Gtext_Corps := Gtext_Corps + ReplaceText(MailText.Textline) + '<br>';
                    Aff_Corps := Aff_Corps + ReplaceText(MailText.Textline) + '\';
                end else begin
                    Gtext_Corps := Gtext_Corps + ReplaceText(MailText.Textline) + ' ';
                    Aff_Corps := Aff_Corps + ReplaceText(MailText.Textline) + ' ';
                end;
            until MailText.NEXT() = 0;
    end;

    procedure CorpsMail8() pCorps: Text
    var
        lPurchHeader: Record "Purchase Header";
    begin
        URLNavDA := '';
        URLNavBC := '';
        URLNavFAC := '';
        if lPurchHeader.GET(Rec."Document Type", Rec."No.") then
            URLNavFAC := '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 50003, lPurchHeader)
        else
            URLNavFAC += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 50003);

        CLEAR(Gtext_Corps);
        CLEAR(Aff_Corps);
        MailSetup.GET(MailSetup."Mail Type"::"Fact. à approuver");
        MailText.SETRANGE("Mail Type", MailText."Mail Type"::"Fact. à approuver");
        if MailText.FINDFIRST() then
            repeat
                if MailText.Seperator = MailText.Seperator::"Carriage Return" then begin
                    Gtext_Corps := Gtext_Corps + ReplaceText(MailText.Textline) + '<br>';
                    Aff_Corps := Aff_Corps + ReplaceText(MailText.Textline) + '\';
                end else begin
                    Gtext_Corps := Gtext_Corps + ReplaceText(MailText.Textline) + ' ';
                    Aff_Corps := Aff_Corps + ReplaceText(MailText.Textline) + ' ';
                end;
            until MailText.NEXT() = 0;
    end;

    procedure CorpsMail9() pCorps: Text
    var
        lPurchHeader: Record "Purchase Header";
    begin
        //corps du mail7
        URLNavDA := '';
        URLNavBC := '';
        if lPurchHeader.GET(Rec."Document Type"::Order, Gtext_Param2) then
            URLNavBC := '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 50, lPurchHeader)
        else
            URLNavBC += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 50);
        URLNavFAC := '';
        if lPurchHeader.GET(Rec."Document Type", Rec."No.") then
            URLNavFAC := '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 51, lPurchHeader)
        else
            URLNavFAC += '<a href="' + GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Page, 51);

        CLEAR(Gtext_Corps);
        CLEAR(Aff_Corps);
        MailSetup.GET(MailSetup."Mail Type"::"Factures Presta Timé");
        MailText.SETRANGE("Mail Type", MailText."Mail Type"::"Factures Presta Timé");
        if MailText.FINDFIRST() then
            repeat
                if MailText.Seperator = MailText.Seperator::"Carriage Return" then begin
                    Gtext_Corps := Gtext_Corps + ReplaceText(MailText.Textline) + '<br>';
                    Aff_Corps := Aff_Corps + ReplaceText(MailText.Textline) + '\';
                end else begin
                    Gtext_Corps := Gtext_Corps + ReplaceText(MailText.Textline) + ' ';
                    Aff_Corps := Aff_Corps + ReplaceText(MailText.Textline) + ' ';
                end;
            until MailText.NEXT() = 0;
    end;

    procedure InsertHistorique()
    var
        Lrec_Historic: Record "BC6_VSC historic";
        Lrec_PurchLines: Record "Purchase Line";
    begin
        //Début Ajout JX-XAD le 20/11/2009
        Lrec_Historic.INIT();
        Lrec_Historic.Type := Lrec_Historic.Type::Invoice;
        Lrec_Historic."No." := Rec."No.";
        Lrec_Historic."Date time" := CURRENTDATETIME;

        Lrec_PurchLines.SETFILTER(Lrec_PurchLines."Document Type", FORMAT(Lrec_PurchLines."Document Type"::Invoice));
        Lrec_PurchLines.SETFILTER(Lrec_PurchLines."Document No.", Rec."No.");
        Lrec_Historic.Description := Rec."BC6_Status description";

        Lrec_Historic."User ID" := USERID;

        // modif LAB du 16/12/2009
        // ajout de la gestion du code utilisateur affecté sur l'historique envoi email

        Lrec_Historic."Assigned User ID" := Rec."Assigned User ID";

        //fin modif LAB du 16/12/2009

        Lrec_Historic.INSERT();
    end;

    // procedure InsertFacture(var pSMAIL: Codeunit "SMTP Mail"; pNumFacture: Code[20]): Text[250]
    // begin
    //     IF (COMPANYNAME = 'VSC') OR (COMPANYNAME = 'VSC - RECETTE') THEN
    //         IF EXISTS(PurchSetup."BC6_Mail Invoice Path" + pNumFacture + '.pdf') THEN
    //             SMAIL.AddAttachment(PurchSetup."BC6_Mail Invoice Path" + pNumFacture + '.pdf', PurchSetup."BC6_Mail Invoice Path" + pNumFacture + '.pdf');

    //     IF (COMPANYNAME = 'VSCT') OR (COMPANYNAME = 'VSCT - RECETTE') THEN
    //         IF EXISTS(PurchSetup."BC6_Mail Invoice Path" + pNumFacture + '.pdf') THEN
    //             SMAIL.AddAttachment(PurchSetup."BC6_Mail Invoice Path" + pNumFacture + '.pdf', PurchSetup."BC6_Mail Invoice Path" + pNumFacture + '.pdf');

    //     IF (COMPANYNAME = 'Agence') OR (COMPANYNAME = 'Agence - RECETTE') THEN
    //         IF EXISTS(PurchSetup."BC6_Mail Invoice Path" + pNumFacture + '.pdf') THEN
    //             SMAIL.AddAttachment(PurchSetup."BC6_Mail Invoice Path" + pNumFacture + '.pdf', PurchSetup."BC6_Mail Invoice Path" + pNumFacture + '.pdf');

    //     IF (COMPANYNAME = 'VFEC') OR (COMPANYNAME = 'VFEC - RECETTE') THEN
    //         IF EXISTS(PurchSetup."BC6_Mail Invoice Path" + pNumFacture + '.pdf') THEN
    //             SMAIL.AddAttachment(PurchSetup."BC6_Mail Invoice Path" + pNumFacture + '.pdf', PurchSetup."BC6_Mail Invoice Path" + pNumFacture + '.pdf');

    //     IF (COMPANYNAME = 'HEXATOURISME') OR (COMPANYNAME = 'HEXATOURISME - RECETTE') THEN
    //         IF EXISTS(PurchSetup."BC6_Mail Invoice Path" + pNumFacture + '.pdf') THEN
    //             SMAIL.AddAttachment(PurchSetup."BC6_Mail Invoice Path" + pNumFacture + '.pdf', PurchSetup."BC6_Mail Invoice Path" + pNumFacture + '.pdf');

    //     EXIT;
    // end;

    local procedure SendMail()
    var
        MAIL: codeunit Email;
        EmailMessage: codeunit "Email Message";
        TempBlob: codeunit "Temp Blob";
        InStream: InStream;
        i: Integer;
    begin
        CLEAR(MAIL);

        //recherche du mail de l'utilisateur
        if Grec_UserSetup.GET(USERID) then
            Gtext_Mail := Grec_UserSetup."E-Mail";

        if Grec_UserSetup.GET(Rec."Assigned User ID") then
            Gtext_MailUser.Add(Grec_UserSetup."E-Mail");

        //creation du mail
        //[Syntax for the Createmessage function -
        // Createmessage([sender's name] ,[sender's id],[recipient's id or ids],[subject] ,[body line],[html formatted or not]]
        Gtext_alias := '';
        if (COMPANYNAME = 'VFEC') or (COMPANYNAME = 'VFEC - RECETTE') then
            Gtext_alias := 'VSC GROUPE'
        else
            Gtext_alias := COMPANYNAME;

        //recherche du nom du fournisseur
        Gtext_VendorName := '';
        if Grec_Vendor.GET(Rec."Buy-from Vendor No.") then begin
            Gtext_VendorName := Grec_Vendor.Name;
            Gtext_ObjetMail := Gtext_alias + ' - ' + MailSetup.Subject + ' - ' + Gtext_VendorName;
        end else
            Gtext_ObjetMail := Gtext_alias + ' - ' + MailSetup.Subject;

        if VSCSettings."BC Test Mode" then
            Gtext_MailUser.Add(VSCSettings."BC E-Mail Test");
        BCCRecipients.Add('');
        Gtext_MailCCList.Add(Gtext_MailCC);
        //EmailMessage.Create(Gtext_alias, Gtext_Mail, Gtext_MailUser, Gtext_ObjetMail, '', TRUE);
        EmailMessage.Create(Gtext_MailUser, Gtext_ObjetMail, '', true, Gtext_MailCCList, BCCRecipients);

        //Ajout des lignes au mail
        case Gint_Param4 of
            1:
                begin
                    EmailMessage.AppendToBody(Gtext_Corps);
                    if NbAtt <> 0 then
                        for i := 1 to NbAtt do begin
                            if not TempBlob.HasValue() then
                                exit;
                            TempBlob.CreateInStream(InStream);

                            //Ajout de la pièce jointe au mail suivant les sociétés
                            EmailMessage.AddAttachment(AddAtt[i], AddAtt[i], InStream);
                        end;

                    if CONFIRM('Validez-vous le message suivant ?\' + Aff_Corps) then begin
                        //Envoi du mail
                        MAIL.Send(EmailMessage);
                        MESSAGE(Text002);
                        CurrPage.CLOSE();
                        InsertHistorique();
                    end;
                end;
            2:
                begin
                    CorpsMail2();
                    EmailMessage.AppendToBody(Gtext_Corps);
                    if NbAtt <> 0 then
                        for i := 1 to NbAtt do begin
                            if not TempBlob.HasValue() then
                                exit;
                            TempBlob.CreateInStream(InStream);
                            //Ajout de la pièce jointe au mail suivant les sociétés
                            EmailMessage.AddAttachment(AddAtt[i], AddAtt[i], InStream);
                        end;

                    if CONFIRM('Validez-vous le message suivant ?\' + Aff_Corps) then begin
                        //Envoi du mail
                        MAIL.Send(EmailMessage);
                        MESSAGE(Text002);
                        CurrPage.CLOSE();
                        InsertHistorique();
                    end;
                    CurrPage.CLOSE();
                end;
            3:
                begin
                    //Vérification du numéro de document saisi s'il existe
                    CorpsMail3();
                    CLEAR(Grec_PurchaseHeader);
                    if not Grec_PurchaseHeader.GET(Grec_PurchaseHeader."Document Type"::Quote, Gtext_Param2) then
                        ERROR(Text001);

                    EmailMessage.AppendToBody(Gtext_Corps);
                    if NbAtt <> 0 then
                        for i := 1 to NbAtt do begin
                            if not TempBlob.HasValue() then
                                exit;
                            TempBlob.CreateInStream(InStream);
                            //Ajout de la pièce jointe au mail suivant les sociétés
                            EmailMessage.AddAttachment(AddAtt[i], AddAtt[i], InStream);
                        end;

                    if CONFIRM('Validez-vous le message suivant ?\' + Aff_Corps) then begin
                        //Envoi du mail
                        MAIL.Send(EmailMessage);
                        MESSAGE(Text002);
                        CurrPage.CLOSE();
                        InsertHistorique();
                    end;
                end;
            4:
                begin
                    //Vérification du numéro de document saisi s'il existe
                    CorpsMail4();
                    CLEAR(Grec_PurchaseHeader);
                    if not Grec_PurchaseHeader.GET(Grec_PurchaseHeader."Document Type"::Quote, Gtext_Param2) then
                        ERROR(Text001);

                    EmailMessage.AppendToBody(Gtext_Corps);
                    if NbAtt <> 0 then
                        for i := 1 to NbAtt do begin
                            if not TempBlob.HasValue() then
                                exit;
                            TempBlob.CreateInStream(InStream);
                            //Ajout de la pièce jointe au mail suivant les sociétés
                            EmailMessage.AddAttachment(AddAtt[i], AddAtt[i], InStream);
                        end;

                    if CONFIRM('Validez-vous le message suivant ?\' + Aff_Corps) then begin
                        //Envoi du mail
                        MAIL.Send(EmailMessage);
                        MESSAGE(Text002);
                        CurrPage.CLOSE();
                        InsertHistorique();
                    end;
                end;
            5:
                begin
                    //Vérification du numéro de document saisi s'il existe
                    CorpsMail5();
                    CLEAR(Grec_PurchaseHeader);
                    if not Grec_PurchaseHeader.GET(Grec_PurchaseHeader."Document Type"::Quote, Gtext_Param2) then
                        ERROR(Text001);

                    EmailMessage.AppendToBody(Gtext_Corps);
                    if NbAtt <> 0 then
                        for i := 1 to NbAtt do begin
                            if not TempBlob.HasValue() then
                                exit;
                            TempBlob.CreateInStream(InStream);
                            //Ajout de la pièce jointe au mail suivant les sociétés
                            EmailMessage.AddAttachment(AddAtt[i], AddAtt[i], InStream);
                        end;

                    if CONFIRM('Validez-vous le message suivant ?\' + Aff_Corps) then begin
                        //Envoi du mail
                        MAIL.Send(EmailMessage);
                        MESSAGE(Text002);
                        CurrPage.CLOSE();
                        InsertHistorique();
                    end;
                end;
            6:
                begin
                    CorpsMail6();
                    //Vérification du numéro de document saisi s'il existe
                    CLEAR(Grec_PurchaseHeader);
                    if not Grec_PurchaseHeader.GET(Grec_PurchaseHeader."Document Type"::Order, Gtext_Param2) then
                        ERROR(Text001);

                    //recherche du nom du fournisseur
                    Gtext_VendorName := '';
                    if Grec_Vendor.GET(Rec."Buy-from Vendor No.") then
                        Gtext_VendorName := Grec_Vendor.Name;

                    EmailMessage.AppendToBody(Gtext_Corps);
                    if NbAtt <> 0 then
                        for i := 1 to NbAtt do begin
                            if not TempBlob.HasValue() then
                                exit;
                            TempBlob.CreateInStream(InStream);
                            //Ajout de la pièce jointe au mail suivant les sociétés
                            EmailMessage.AddAttachment(AddAtt[i], AddAtt[i], InStream);
                        end;

                    if CONFIRM('Validez-vous le message suivant ?\' + Aff_Corps) then begin
                        //Envoi du mail
                        MAIL.Send(EmailMessage);
                        MESSAGE(Text002);
                        CurrPage.CLOSE();
                        InsertHistorique();
                    end;
                end;
            7:
                begin
                    //Vérification du numéro de document saisi s'il existe
                    CorpsMail7();
                    CLEAR(Grec_PurchaseHeader);
                    if not Grec_PurchaseHeader.GET(Grec_PurchaseHeader."Document Type"::Order, Gtext_Param2) then
                        ERROR(Text001);

                    EmailMessage.AppendToBody(Gtext_Corps);
                    if NbAtt <> 0 then
                        for i := 1 to NbAtt do begin
                            if not TempBlob.HasValue() then
                                exit;
                            TempBlob.CreateInStream(InStream);
                            //Ajout de la pièce jointe au mail suivant les sociétés
                            EmailMessage.AddAttachment(AddAtt[i], AddAtt[i], InStream);
                        end;

                    if CONFIRM('Validez-vous le message suivant ?\' + Aff_Corps) then begin
                        //Envoi du mail
                        MAIL.Send(EmailMessage);
                        MESSAGE(Text002);
                        CurrPage.CLOSE();
                        InsertHistorique();
                    end;
                end;
            8:
                begin
                    CorpsMail8();
                    EmailMessage.AppendToBody(Gtext_Corps);
                    if NbAtt <> 0 then
                        for i := 1 to NbAtt do begin
                            if not TempBlob.HasValue() then
                                exit;
                            TempBlob.CreateInStream(InStream);
                            //Ajout de la pièce jointe au mail suivant les sociétés
                            EmailMessage.AddAttachment(AddAtt[i], AddAtt[i], InStream);
                        end;

                    if CONFIRM('Validez-vous le message suivant ?\' + Aff_Corps) then begin
                        //Envoi du mail
                        MAIL.Send(EmailMessage);
                        MESSAGE(Text002);
                        CurrPage.CLOSE();
                        InsertHistorique();
                    end;
                    CurrPage.CLOSE();
                end;
            9:
                begin
                    //Vérification du numéro de document saisi s'il existe
                    CorpsMail9();
                    CLEAR(Grec_PurchaseHeader);
                    if not Grec_PurchaseHeader.GET(Grec_PurchaseHeader."Document Type"::Order, Gtext_Param2) then
                        ERROR(Text001);

                    EmailMessage.AppendToBody(Gtext_Corps);
                    if NbAtt <> 0 then
                        for i := 1 to NbAtt do begin
                            if not TempBlob.HasValue() then
                                exit;
                            TempBlob.CreateInStream(InStream);
                            //Ajout de la pièce jointe au mail suivant les sociétés
                            EmailMessage.AddAttachment(AddAtt[i], AddAtt[i], InStream);
                        end;

                    if CONFIRM('Validez-vous le message suivant ?\' + Aff_Corps) then begin
                        //Envoi du mail
                        MAIL.Send(EmailMessage);
                        MESSAGE(Text002);
                        CurrPage.CLOSE();
                        InsertHistorique();
                    end;
                end;
        end;
    end;
}
