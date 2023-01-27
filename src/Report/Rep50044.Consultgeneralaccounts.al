report 50044 "BC6_Consult general accounts"
{
    // CREATION JX-AUD du 23/08/2010
    // CONSULTATION DES COMPTES GENERAUX 401* ou 411*
    // 
    // //JX-AUD du 13/05/2013
    // //Agrandissement logo
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/Consultgeneralaccounts.rdl';

    Caption = 'Consult general accounts', Comment = 'FRA="Consultation des comptes généraux"';

    dataset
    {
        dataitem(DataItem1000000003; Integer)
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            MaxIteration = 1;
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CONSULTATION_OF_GENERAL_ACCOUNTSCaption; CONSULTATION_OF_GENERAL_ACCOUNTSCaptionLbl)
            {
            }
            column(Reminder_of_the_selectionCaption; Reminder_of_the_selectionCaptionLbl)
            {
            }
            column(Date__Caption; Date__CaptionLbl)
            {
            }
            column(User__Caption; User__CaptionLbl)
            {
            }
            column(AccountCaption; AccountCaptionLbl)
            {
            }
            column(Debit_AmountCaption; Debit_AmountCaptionLbl)
            {
            }
            column(Credit_AmountCaption; Credit_AmountCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column("USERID"; USERID)
            {
            }
            column(FORMAT_TODAY_; FORMAT(TODAY))
            {
            }

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET();
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
            end;
        }
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING("G/L Account No.", "Source Type", "Source No.");
            RequestFilterFields = "G/L Account No.";
            column(Text001_____Gtxt_AccountNoFilter; Text001 + ' ' + Gtxt_AccountNoFilter)
            {
            }
            column(Text003_____FORMAT_TIME_; Text003 + ' ' + FORMAT(TIME))
            {
            }
            column(G_L_Entry__G_L_Entry___Source_No__; "G/L Entry"."Source No.")
            {
            }
            column(G_L_Entry__G_L_Entry__Amount; "G/L Entry".Amount)
            {
            }
            column(G_L_Entry__G_L_Entry___Debit_Amount_; "G/L Entry"."Debit Amount")
            {
            }
            column(G_L_Entry__G_L_Entry___Credit_Amount_; "G/L Entry"."Credit Amount")
            {
            }
            column(G_L_Entry__G_L_Entry__Amount_Control1000000014; "G/L Entry".Amount)
            {
            }
            column(G_L_Entry__G_L_Entry___Credit_Amount__Control1000000000; "G/L Entry"."Credit Amount")
            {
            }
            column(G_L_Entry__G_L_Entry___Debit_Amount__Control1000000005; "G/L Entry"."Debit Amount")
            {
            }
            column(G_L_Entry_Entry_No_; "Entry No.")
            {
            }

            trigger OnPreDataItem()
            begin
                Gtxt_AccountNoFilter := "G/L Entry".GETFILTER("G/L Entry"."G/L Account No.");
                Gtxt_SourceNoFilter := "G/L Entry".GETFILTER("G/L Entry"."Source Type");
            end;
        }
    }
    trigger OnInitReport()
    begin
        Gbool_AfficherEnTete := TRUE;
    end;

    var
        CompanyInfo: Record "Company Information";
        Gbool_AfficherEnTete: Boolean;
        AccountCaptionLbl: Label 'Account', Comment = 'FRA="Compte"';
        AmountCaptionLbl: Label 'Amount', Comment = 'FRA="Solde"';
        CONSULTATION_OF_GENERAL_ACCOUNTSCaptionLbl: Label 'CONSULTATION OF GENERAL ACCOUNTS', Comment = 'FRA="CONSULTATION DES COMPTES GENERAUX"';
        Credit_AmountCaptionLbl: Label 'Credit Amount', Comment = 'FRA="Crédit"';
        Date__CaptionLbl: Label 'Date :';
        Debit_AmountCaptionLbl: Label 'Debit Amount', Comment = 'FRA="Débit"';
        Reminder_of_the_selectionCaptionLbl: Label 'Reminder of the selection', Comment = 'FRA="Rappel de la sélection"';
        Text001: Label 'Account No. :', Comment = 'FRA="N° compte général :"';
        Text003: Label 'at', Comment = 'FRA="à"';
        //Text004: Label 'Page %1', Comment = 'FRA="Page %1"';
        TotalCaptionLbl: Label 'Total';
        User__CaptionLbl: Label 'User :', Comment = 'FRA="Utilisateur"';
        Gtxt_AccountNoFilter: Text[30];
        Gtxt_SourceNoFilter: Text[30];
}

