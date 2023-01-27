report 50035 "BC6_F.A. tracking release date"
{
    // CREATION JX-XAD 29/01/2009
    // Listing de suivi des affectations immo
    // N'affiche les immos que jusque la date J+3 (paramétrable dans l'onglet Options)
    // 
    // //MODIF LAB DU 12/02/2010
    // //ajout du champ service
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/FAtrackingreleasedate.rdl';
    Caption = 'F.A. tracking release date', Comment = 'FRA="Suivi des dates de sortie immos"';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("BC6 F.A. Tracking"; "BC6_F.A. Tracking")
        {
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(Text001; Text001)
            {
            }
            column("USERID"; USERID)
            {
            }
            column(FORMAT_TODAY_; FORMAT(TODAY))
            {
            }
            column(Text003_____FORMAT_TIME_; Text003 + ' ' + FORMAT(TIME))
            {
            }
            column(F_A__Tracking__Fixed_Asset_No__; "Fixed Asset No.")
            {
            }
            column(F_A__Tracking_Description; "Description")
            {
            }
            column(F_A__Tracking__Serial_No__; "Serial No.")
            {
            }
            column(F_A__Tracking__type_of_equipment_; "Type of equipment")
            {
            }
            column(F_A__Tracking__Order_No__; "Order No.")
            {
            }
            column(F_A__Tracking__Vendor_No__; "Vendor No.")
            {
            }
            column(F_A__Tracking__User_name_; "User name")
            {
            }
            column(F_A__Tracking__User_status_; "User status")
            {
            }
            column(F_A__Tracking_Manager; "Manager")
            {
            }
            column(F_A__Tracking__release_date_; "Release date")
            {
            }
            column(F_A__Tracking__Location_1_; "Location 1")
            {
            }
            column(F_A__Tracking__Location_2_; "Location 2")
            {
            }
            column(F_A__Tracking__Fixed_asst_linked_; "Fixed asst linked")
            {
            }
            column(F_A__Tracking_Comments; "Comments")
            {
            }
            column(F_A__Tracking_Service; "Service")
            {
            }
            column(User__Caption; User__CaptionLbl)
            {
            }
            column(Date__Caption; Date__CaptionLbl)
            {
            }
            column(Fixed_asset_No_Caption; Fixed_asset_No_CaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(Serial_No_Caption; Serial_No_CaptionLbl)
            {
            }
            column(type_of_equipmentCaption; type_of_equipmentCaptionLbl)
            {
            }
            column(Order_No_Caption; Order_No_CaptionLbl)
            {
            }
            column(Vendor_No_Caption; Vendor_No_CaptionLbl)
            {
            }
            column(User_nameCaption; User_nameCaptionLbl)
            {
            }
            column(User_statusCaption; User_statusCaptionLbl)
            {
            }
            column(F_A__Tracking_ManagerCaption; FIELDCAPTION("Manager"))
            {
            }
            column(Release_dateCaption; Release_dateCaptionLbl)
            {
            }
            column(Loc__1Caption; Loc__1CaptionLbl)
            {
            }
            column(Loc__2Caption; Loc__2CaptionLbl)
            {
            }
            column(Fixed_asst_linkedCaption; Fixed_asst_linkedCaptionLbl)
            {
            }
            column(CommentsCaption; CommentsCaptionLbl)
            {
            }
            column(F_A__Tracking_ServiceCaption; FIELDCAPTION("Service"))
            {
            }

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET();
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);

                Gdate_Sortie := TODAY + Gint_NbJours;

                SETFILTER("BC6 F.A. Tracking"."Release date", '<=%1', Gdate_Sortie);
                IF COUNT = 0 THEN
                    MESSAGE(STRSUBSTNO(Text004, Gdate_Sortie));
            end;
        }
    }

    trigger OnInitReport()
    begin
        Gint_NbJours := 3;
        Gbool_AfficherEnTete := TRUE;
    end;

    var
        CompanyInfo: Record "Company Information";
        Gbool_AfficherEnTete: Boolean;
        Gdate_Sortie: Date;
        Gint_NbJours: Integer;
        CommentsCaptionLbl: Label 'Comments', Comment = 'FRA="Commentaires"';
        Date__CaptionLbl: Label 'Date :';
        DescriptionCaptionLbl: Label 'Description', Comment = 'FRA="Désignation"';
        Fixed_asset_No_CaptionLbl: Label 'Fixed asset No.', Comment = 'FRA="N° immo"';
        Fixed_asst_linkedCaptionLbl: Label 'Fixed asst linked', Comment = 'FRA="immobilisation raccrochée"';
        Loc__1CaptionLbl: Label 'Loc. 1', Comment = 'FRA="Empl. 1"';
        Loc__2CaptionLbl: Label 'Loc. 2', Comment = 'FRA="Empl. 2"';
        Order_No_CaptionLbl: Label 'Order No.', Comment = 'FRA="N° de BC"';
        Release_dateCaptionLbl: Label 'Release date', Comment = 'FRA="Date de sortie"';
        Serial_No_CaptionLbl: Label 'Serial No.', Comment = 'FRA="N° de  série"';
        Text001: Label 'Track Release Date of fixed asset', Comment = 'FRA="Suivi des dates de sortie immos"';
        Text002: Label 'Page %1';
        Text003: Label 'to', Comment = 'FRA="à"';
        Text004: Label 'There is no record on the date of %1', Comment = 'FRA="Il n''y a aucune écriture à la date du %1"';
        type_of_equipmentCaptionLbl: Label 'type of equipment', Comment = 'FRA="Type de matériel"';
        User__CaptionLbl: Label 'User :', Comment = 'FRA="Utilisateur :"';
        User_nameCaptionLbl: Label 'User name', Comment = 'FRA="Nom du fournisseur"';
        User_statusCaptionLbl: Label 'User status', Comment = 'FRA="Statut utilisateur"';
        Vendor_No_CaptionLbl: Label 'Vendor No.', Comment = 'FRA="Nom du fournisseur"';
}

