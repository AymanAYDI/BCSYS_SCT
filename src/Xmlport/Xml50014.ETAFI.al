xmlport 50014 "BC6_ETAFI"
{
    Caption = 'ETAFI', Comment = 'FRA="ETAFI"';
    Direction = Export;
    TextEncoding = WINDOWS;
    Format = FixedText;
    TableSeparator = '<<NewLine><NewLine>>';
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement(GLAccountList; "G/L Account")
            {
                SourceTableView = sorting("No.");
                textelement(Gtext_Compte)
                {
                    Width = 12;
                }
                textelement(Gtext_Description)
                {
                    Width = 35;
                }
                textelement(Gtext_A_Nouveau)
                {
                    Width = 16;
                }
                textelement(Gtext_Debit)
                {
                    Width = 16;
                }
                textelement(Gtext_Credit)
                {
                    Width = 12;
                }
                textelement(Gtext_SoldeAnnee0)
                {
                    Width = 16;
                }
                textelement(Gtext_SoldeAnnee1)
                {
                    Width = 16;
                }
                textelement(Gtext_SoldeAnnee2)
                {
                    Width = 12;
                }
                textelement(Gtext_SoldeAnnee3)
                {
                    Width = 12;
                }
                trigger OnPreXMLItem()
                begin
                    //Initialisation des dates pour le Filtre date
                    GLAccountList.SETFILTER(GLAccountList."Account Type", '%1', GLAccountList."Account Type"::Posting);
                    Gint_Annee0 := DATE2DMY(Gdate_EndDate, 3);
                    Gdate_SoldeAnnee0 := DMY2DATE(31, 12, Gint_Annee0);
                    Gdate_SoldeAnnee1 := CALCDATE('<-1Y>', Gdate_SoldeAnnee0);
                    Gdate_SoldeAnnee2 := CALCDATE('<-2Y>', Gdate_SoldeAnnee0);
                    Gdate_SoldeAnnee3 := CALCDATE('<-3Y>', Gdate_SoldeAnnee0);
                end;

                trigger OnAfterGetRecord()
                begin
                    Gtext_Compte := PADSTR(GLAccountList."No.", 12);
                    Gtext_Description := PADSTR(GLAccountList.Name, 35);

                    //Calcul A Nouveau 2010
                    Gdec_MontantANouveau := 0;
                    Grec_GL_Entry.RESET();
                    Grec_GL_Entry.SETFILTER(Grec_GL_Entry."G/L Account No.", '%1', GLAccountList."No.");
                    Grec_GL_Entry.SETFILTER(Grec_GL_Entry."Journal Batch Name", '%1', 'ANOUV');
                    Grec_GL_Entry.SETFILTER(Grec_GL_Entry."Posting Date", '..%1', Gdate_EndDate);
                    if Grec_GL_Entry.FIND('-') then
                        repeat
                            Gdec_MontantANouveau += Grec_GL_Entry.Amount;
                        until Grec_GL_Entry.NEXT() = 0;

                    //Début Ajout ecritures isolées
                    Grec_GL_Entry.RESET();
                    Grec_GL_Entry.SETFILTER(Grec_GL_Entry."G/L Account No.", '%1', GLAccountList."No.");
                    Grec_GL_Entry.SETFILTER(Grec_GL_Entry."Journal Batch Name", '<>%1', 'ANOUV');
                    Grec_GL_Entry.SETFILTER(Grec_GL_Entry."Posting Date", '%1', Gdate_DateIsolation);
                    if Grec_GL_Entry.FIND('-') then
                        repeat
                            Gdec_MontantANouveau += Grec_GL_Entry.Amount;
                        until Grec_GL_Entry.NEXT() = 0;
                    //Fin Ajout ecritures isolées
                    Gtext_A_Nouveau := FORMAT(Gdec_MontantANouveau, 16, '<Sign,1><Integer><Decimals,3>');

                    //TODO Field removed :
                    //GLAccountList.SETFILTER("G/L Entry Type Filter", '%1', GLAccountList."G/L Entry Type Filter"::Definitive);
                    //SETRANGE("Date Filter",Gdate_StartDate,Gdate_EndDate);
                    GLAccountList.SETFILTER("Date Filter", '%1..%2&<>%3', Gdate_StartDate, Gdate_EndDate, Gdate_DateIsolation);  //Filtre sur ecritures isolées

                    //Calcul DEBIT
                    GLAccountList.CALCFIELDS("Debit Amount");
                    Gtext_Debit := FORMAT(GLAccountList."Debit Amount", 16, '<Sign,1><Integer><Decimals,3>');

                    //Calcul CREDIT
                    GLAccountList.CALCFIELDS(GLAccountList."Credit Amount");
                    Gtext_Credit := FORMAT(GLAccountList."Credit Amount", 16, '<Sign,1><Integer><Decimals,3>');

                    //Calcul Solde 2010
                    GLAccountList.SETRANGE("Date Filter", 0D, Gdate_EndDate);
                    GLAccountList.CALCFIELDS(GLAccountList."Net Change");
                    Gtext_SoldeAnnee0 := FORMAT(GLAccountList."Net Change", 16, '<Sign,1><Integer><Decimals,3>');

                    //Calcul Solde 2009
                    GLAccountList.SETRANGE("Date Filter", 0D, Gdate_SoldeAnnee1);
                    GLAccountList.CALCFIELDS(GLAccountList."Net Change");
                    Gtext_SoldeAnnee1 := FORMAT(GLAccountList."Net Change", 16, '<Sign,1><Integer><Decimals,3>');

                    //Calcul Solde 2008
                    GLAccountList.SETRANGE("Date Filter", 0D, Gdate_SoldeAnnee2);
                    GLAccountList.CALCFIELDS(GLAccountList."Net Change");
                    Gtext_SoldeAnnee2 := FORMAT(GLAccountList."Net Change", 16, '<Sign,1><Integer><Decimals,3>');

                    //Calcul Solde 2007
                    GLAccountList.SETRANGE("Date Filter", 0D, Gdate_SoldeAnnee3);
                    GLAccountList.CALCFIELDS(GLAccountList."Net Change");
                    Gtext_SoldeAnnee3 := FORMAT(GLAccountList."Net Change", 16, '<Sign,1><Integer><Decimals,3>');
                end;
            }
        }
    }
    var
        Grec_GL_Entry: Record "G/L Entry";
        Gdate_DateIsolation: Date;
        Gdate_EndDate: Date;
        Gdate_SoldeAnnee0: Date;
        Gdate_SoldeAnnee1: Date;
        Gdate_SoldeAnnee2: Date;
        Gdate_SoldeAnnee3: Date;
        Gdate_StartDate: Date;
        Gdec_MontantANouveau: Decimal;
        Gint_Annee0: Integer;

    procedure SetParameters(Pdate_StartDate: Date; Pdate_EndDate: Date; Pdate_DateIsolation: Date);
    begin
        Gdate_StartDate := Pdate_StartDate;
        Gdate_EndDate := Pdate_EndDate;
        Gdate_DateIsolation := Pdate_DateIsolation;
    end;
}
