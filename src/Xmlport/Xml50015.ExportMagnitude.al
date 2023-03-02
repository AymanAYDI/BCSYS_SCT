xmlport 50015 "BC6_Export Magnitude"
{
    Caption = 'Export Magnitude', Comment = 'FRA="Export Magnitude"';
    Direction = Export;
    TextEncoding = WINDOWS;
    Format = VariableText;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    TableSeparator = '<NewLine>';
    UseRequestPage = false;
    schema
    {
        textelement(Root)
        {
            tableelement(Header; Integer)
            {
                SourceTableView = SORTING(Number) WHERE(Number = CONST(1));
                textelement(Gtext_NomChamp)
                {
                }
                trigger OnPreXMLItem()
                begin
                    Grec_Societe.GET();
                    Gtext_NomChamp := 'd_ca;d_dp;d_ru;d_tftr;d_metier;d_libre1;d_libre2;d_libre3;d_echeances;d_dossiers;d_geoactivite;d_pe;d_oru;d_ac;';
                    Gtext_NomChamp += 'd_fl;d_au;d_t1;d_t2;d_cu;d_to;d_go;d_le;d_nu;d_libre5;d_dest;d_area;d_geosite;d_geocontrat;P_COMMENT;P_AMOUNT';
                end;
            }
            tableelement(GlobalTempTable; "BC6_Global temporary table")
            {
                SourceTableView = SORTING("Document No.", "Line No.");
                textelement(d_ca)
                {
                }
                textelement(d_dp)
                {
                }
                textelement(d_ru)
                {
                }
                textelement(d_tftr)
                {
                }
                textelement(d_metier)
                {
                }
                textelement(d_libre1)
                {
                }
                textelement(d_libre2)
                {
                }
                textelement(d_libre3)
                {
                }
                textelement(d_echeances)
                {
                }
                textelement(d_dossiers)
                {
                }
                textelement(d_geoactivite)
                {
                }
                textelement(d_pe)
                {
                }
                textelement(d_oru)
                {
                }
                textelement(d_ac)
                {
                }
                textelement(d_fl)
                {
                }
                textelement(d_au)
                {
                }
                textelement(d_t1)
                {
                }
                textelement(d_t2)
                {
                }
                textelement(d_cu)
                {
                }
                textelement(d_to)
                {
                }
                textelement(d_go)
                {
                }
                textelement(d_le)
                {
                }
                textelement(d_nu)
                {
                }
                textelement(d_libre5)
                {
                }
                textelement(d_dest)
                {
                }
                textelement(d_area)
                {
                }
                textelement(d_geosite)
                {
                }
                textelement(d_geocontrat)
                {
                }
                textelement(P_COMMENT)
                {
                }
                textelement(P_AMOUNT)
                {
                }
                trigger OnPreXMLItem()
                var

                    Grec_MagnitudeCorrespondence: Record "BC6_Magnitude correspondence";
                    Grec_MagnitudeCorrespondence1: Record "BC6_Magnitude correspondence";
                    Grec_MagnitudeCorrespondence2: Record "BC6_Magnitude correspondence";
                    TempGrec_Temporary: Record "BC6_Table temporaire" TEMPORARY;
                    TempGrec_Temporary1: Record "BC6_Table temporaire" TEMPORARY;
                    //Grec_Societe: Record "Company Information";
                    Grec_GL_Account: Record "G/L Account";
                    Gbool_exit: Boolean;
                    Gdate_Comptabilisation: Date;
                    i: Integer;
                // Text001: label 'No company code found', Comment = 'FRA="Aucun code société trouvé"';
                // Text002: label 'Error on the company code', Comment = 'FRA="Erreur sur le code société"';
                begin
                    //mettre tous les montants … 0 de la table MagnitudeCorrespondence
                    if Grec_MagnitudeCorrespondence1.FindSet() then
                        repeat
                            Grec_MagnitudeCorrespondence1.Amount := 0;
                            Grec_MagnitudeCorrespondence1.MODIFY();
                        until Grec_MagnitudeCorrespondence1.NEXT() = 0;
                    Gbool_exit := true;
                    i := 0;

                    //MODIFICATION DU 26/10/10 JX-AUD
                    if Grec_MagnitudeCorrespondence2.FindSet() then
                        repeat
                            Grec_GL_Account.RESET();
                            Grec_GL_Account.SETFILTER(Grec_GL_Account."No.", Grec_MagnitudeCorrespondence2."Account No.");
                            Grec_GL_Account.SETFILTER(Grec_GL_Account."Account Type", '%1', Grec_GL_Account."Account Type"::Posting);
                            Grec_GL_Account.SETFILTER(Grec_GL_Account."Date Filter", '..%1', Gdate_Comptabilisation);
                            // Grec_GL_Account.SETFILTER(Grec_GL_Account."G/L Entry Type Filter", '%1', Grec_GL_Account."G/L Entry Type Filter"::Definitive);

                            TempGrec_Temporary.RESET();
                            TempGrec_Temporary.DELETEALL();
                            //INITIALISATION DE LA TABLE TEMPORAIRE AVEC LE PREMIER FILTRE
                            if Grec_GL_Account.FindSet() then
                                repeat
                                    i += 1;
                                    TempGrec_Temporary.INIT();
                                    TempGrec_Temporary.Piece := i;
                                    TempGrec_Temporary.Compte := Grec_GL_Account."No.";
                                    TempGrec_Temporary.INSERT();
                                until Grec_GL_Account.NEXT() = 0;

                            //FILTRE SUR LES COMPTES DE NIVEAU S'IL Y EN A
                            if Grec_MagnitudeCorrespondence.GET(Grec_MagnitudeCorrespondence2."Line No.") then
                                if Grec_MagnitudeCorrespondence.FIND('>') then
                                    while (Grec_MagnitudeCorrespondence.Level > Grec_MagnitudeCorrespondence2.Level) and (Gbool_exit) do begin
                                        TempGrec_Temporary.SETFILTER(TempGrec_Temporary.Compte, Grec_MagnitudeCorrespondence."Account No.");
                                        TempGrec_Temporary1.DELETEALL();

                                        if TempGrec_Temporary.FindSet() then
                                            repeat
                                                TempGrec_Temporary1.INIT();
                                                TempGrec_Temporary1.Piece := TempGrec_Temporary.Piece;
                                                TempGrec_Temporary1.Compte := TempGrec_Temporary.Compte;
                                                TempGrec_Temporary1.INSERT();
                                            until TempGrec_Temporary.NEXT() = 0;

                                        TempGrec_Temporary.RESET();

                                        if TempGrec_Temporary1.FindSet() then
                                            repeat
                                                if TempGrec_Temporary.GET(TempGrec_Temporary1.Piece) then
                                                    TempGrec_Temporary.DELETE();
                                            until TempGrec_Temporary1.NEXT() = 0;

                                        if not Grec_MagnitudeCorrespondence.FIND('>') then Gbool_exit := false;
                                    end;

                            //CALCUL MONTANT
                            if TempGrec_Temporary.FindSet() then
                                repeat
                                    if Grec_GL_Account.GET(TempGrec_Temporary.Compte) then begin
                                        Grec_GL_Account.CALCFIELDS(Grec_GL_Account."Net Change");

                                        case Grec_MagnitudeCorrespondence2.Sign of
                                            '<=0', '<0':

                                                if Grec_GL_Account."Net Change" > 0 then
                                                    Grec_GL_Account."Net Change" := 0;
                                            '>=0', '>0':

                                                if Grec_GL_Account."Net Change" <= 0 then
                                                    Grec_GL_Account."Net Change" := 0;
                                            else
                                                ;
                                        end;

                                        if COPYSTR(Grec_MagnitudeCorrespondence2.Rubric, 1, 1) = 'A' then
                                            Grec_MagnitudeCorrespondence2.Amount += (Grec_GL_Account."Net Change" / (1000))
                                        else
                                            Grec_MagnitudeCorrespondence2.Amount += (Grec_GL_Account."Net Change" / (-1000));
                                    end;
                                until TempGrec_Temporary.NEXT() = 0;
                            Grec_MagnitudeCorrespondence2.MODIFY();
                        until Grec_MagnitudeCorrespondence2.NEXT() = 0;

                    //********DEUXIEME TRAITEMENT***************************************************************************//

                    Grec_MagnitudeCorrespondence.RESET();

                    GlobalTempTable.DELETEALL();
                    if Grec_MagnitudeCorrespondence.FindSet() then
                        repeat
                            if GlobalTempTable.GET(Grec_MagnitudeCorrespondence.Rubric, 1) then begin
                                GlobalTempTable."Credit amount" += Grec_MagnitudeCorrespondence.Amount;
                                GlobalTempTable.MODIFY();
                            end
                            else begin
                                GlobalTempTable.INIT();
                                GlobalTempTable."Line No." := 1;
                                GlobalTempTable."Document No." := Grec_MagnitudeCorrespondence.Rubric;
                                GlobalTempTable."Credit amount" := Grec_MagnitudeCorrespondence.Amount;
                                GlobalTempTable.INSERT();
                            end;
                        until Grec_MagnitudeCorrespondence.NEXT() = 0;

                    d_ru := '';
                    // case Grec_Societe."IC Partner Code" of //TODO: Field 'IC Partner Code' is marked for removal.
                    //     'TEC':
                    //         d_ru := 'GLI85';
                    //     'COM':
                    //         d_ru := 'GLI80';
                    //     'GLI':
                    //         d_ru := 'GLI81';
                    //     'EXP', 'AGE':
                    //         d_ru := 'GLI82';
                    //     'HEX':
                    //         d_ru := 'GLI99';
                    //     'C25':
                    //         d_ru := 'GLI112';
                    //     '':
                    //         ERROR(Text001);
                    //     else
                    //         ERROR(Text002);
                    // end;
                end;

                trigger OnAfterGetRecord()
                var
                    VSCSettings: Record "BC6_VSC Settings";
                begin
                    d_ca := 'C';
                    d_dp := Gtxt_Annee + '.' + Gtxt_Mois;

                    d_ru := '';
                    VSCSettings.Get();
                    VSCSettings.TestField("Company Name Import/Export");
                    d_ru := VSCSettings."Company Name Import/Export";
                    //         'VSCT', 'VSCT TEST':
                    //             d_ru := 'GLI85';
                    //         'VSC', 'VSC TEST':
                    //             d_ru := 'GLI80';
                    //         'VFEC', 'VFEC TEST':
                    //             d_ru := 'GLI81';
                    //         'Agence', 'Agence TEST':
                    //             d_ru := 'GLI82';
                    // end;

                    d_tftr := '';
                    d_metier := '';
                    d_libre1 := '';
                    d_libre2 := '';
                    d_libre3 := '';
                    d_echeances := '';
                    d_dossiers := '';
                    d_geoactivite := '';
                    d_pe := Gtxt_Annee + '.' + Gtxt_Mois;
                    d_oru := '';
                    d_ac := GlobalTempTable."Document No.";
                    d_fl := 'F99';
                    d_au := '0LIA01';
                    d_t1 := '';
                    d_t2 := '';
                    d_cu := 'EUR';
                    d_to := '';
                    d_go := '';
                    d_le := '';
                    d_nu := '';
                    d_libre5 := '';
                    d_dest := '';
                    d_area := '';
                    d_geosite := '';
                    d_geocontrat := '';
                    P_COMMENT := '';
                    P_AMOUNT := DELCHR(FORMAT(GlobalTempTable."Credit amount", 30, '<Sign,1><Integer><Decimals>'), '=', ' ');
                    P_AMOUNT := CONVERTSTR(P_AMOUNT, ',', '.');
                    //FIN MODIFICATION DU 26/10/10 JX-AUD
                end;
            }
        }
    }

    var
        Grec_Societe: Record "Company Information";
        Gdate_Comptabilisation: Date;
        Gtxt_Mois: Text[2];
        Gtxt_Annee: Text[4];

    procedure SetParameters(Pdate_Comptabilisation: Date);
    begin
        Gdate_Comptabilisation := Pdate_Comptabilisation;
        Gtxt_Annee := FORMAT(DATE2DMY(Gdate_Comptabilisation, 3));
        Gtxt_Mois := FORMAT(DATE2DMY(Gdate_Comptabilisation, 2));
        if STRLEN(Gtxt_Mois) < 2 then
            Gtxt_Mois := '0' + Gtxt_Mois;
    end;
}
