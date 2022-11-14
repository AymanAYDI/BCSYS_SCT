codeunit 50001 "BC6_PrintOrderVSC"
{
    var
        PurchLine: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
        ReportSelection: Record "Report Selections";
        PurchCalcDisc: Codeunit "Purch.-Calc.Discount";

    procedure PrintOrderVSC(PurchaseHeader: Record "Purchase Header");
    begin
        PurchaseHeader.SETRANGE("No.", PurchaseHeader."No.");
        PurchSetup.GET();
        if PurchSetup."Calc. Inv. Discount" then begin
            PurchLine.RESET();
            PurchLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchLine.SETRANGE("Document No.", PurchaseHeader."No.");
            PurchLine.FIND('-');
            PurchCalcDisc.RUN(PurchLine);
            PurchaseHeader.GET(PurchaseHeader."Document Type", PurchaseHeader."No.");
            COMMIT();
        end;

        case PurchaseHeader."Document Type" of
            PurchaseHeader."Document Type"::Order:
                if (COMPANYNAME = 'VSCT') or (COMPANYNAME = 'VSCT Test') or (COMPANYNAME = 'VFEC') or (COMPANYNAME = 'VFEC Test') then begin
                    //DEBUT MODIF JX-XAD le 20/04/2010
                    //TODO:Contract: n'est pas migré
                    // IF (NOT Gcu_ContractManagement.CheckOrderLines(PurchaseHeader."No.")) THEN BEGIN
                    //     //D‚but MODIF JX-XAD le 25/06/2010
                    //     //REPORT.RUNMODAL(ReportSelection."Report ID",TRUE,FALSE,PurchaseHeader)
                    //     Gbool_ManageContract := TRUE;
                    //     IF Grec_Contract.GET(PurchaseHeader."Quote No.") THEN BEGIN
                    //         IF Grec_Contract."BC6_Description1" = '' THEN
                    //             Gbool_ManageContract := FALSE;
                    //     END ELSE
                    //         Gbool_ManageContract := FALSE;

                    //     IF Gbool_ManageContract THEN
                    //         REPORT.RUNMODAL(Report::"Commande achat et contrat", TRUE, FALSE, PurchaseHeader)
                    //     ELSE BEGIN
                    //         ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"P.Order");
                    //         ReportSelection.SETFILTER("Report ID", '<>0');
                    //         ReportSelection.FIND('-');
                    //         REPEAT
                    //             REPORT.RUNMODAL(ReportSelection."Report ID", TRUE, FALSE, PurchaseHeader)
                    //         UNTIL ReportSelection.NEXT = 0;
                    //     END;
                    //     //Fin MODIF JX-XAD le 25/06/2010
                    // END ELSE BEGIN
                    //     //FIN MODIF JX-XAD le 20/04/2010
                    //     ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"P.Order");
                    //     ReportSelection.SETFILTER("Report ID", '<>0');
                    //     ReportSelection.FIND('-');
                    //     REPEAT
                    //         REPORT.RUNMODAL(ReportSelection."Report ID", TRUE, FALSE, PurchaseHeader)
                    //     UNTIL ReportSelection.NEXT = 0;
                    // END;
                end else begin

                    if (PurchaseHeader."Buy-from Country/Region Code" = '') or
                      (PurchaseHeader."Buy-from Country/Region Code" = 'FR') or
                      (PurchaseHeader."Buy-from Country/Region Code" = 'BE') or
                      (PurchaseHeader."Buy-from Country/Region Code" = 'LU') then begin
                        ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"P.Order");
                        ReportSelection.SETFILTER("Report ID", '<>0');
                        ReportSelection.FIND('-');
                        repeat
                            REPORT.RUNMODAL(ReportSelection."Report ID", true, false, PurchaseHeader)
                        until ReportSelection.NEXT() = 0;
                    end
                    // ELSE BEGIN

                    // IF (COMPANYNAME = 'Agence') OR (COMPANYNAME = 'Agence Test') THEN BEGIN
                    //     REPORT.RUNMODAL(Report::"PurchaseOrder aVSC EN", TRUE, FALSE, PurchaseHeader);
                    // END;

                    // IF (COMPANYNAME = 'VSC') OR (COMPANYNAME = 'VSC Test') THEN BEGIN
                    //     REPORT.RUNMODAL(Report::"PurchaseOrder VSC EN", TRUE, FALSE, PurchaseHeader);
                    // END;
                    // END;
                end;
            else
                exit;
        end;
    end;

    // BEGIN
    // {
    //   CREATION JX-AUD le 08.04.2009
    //   //fonction permettant d'afficher les CGA en fonction de la soci‚t‚ et du codePays du fournisseur

    //   MODIF JX-XAD le 20/04/2010
    //   Lancement du report 50041 (copmmande + contrat r‚gie) si soci‚t‚ VSCT et unit‚ = jours-hommes

    //   MODIF JX-XAD le 25/06/2010
    //   On imprime le contrat si le devis existe et contient une description. Ce code est en rapport avec le fait qu'on
    //   gŠre les contrats uniquement si le devis a ‚t‚ cr‚‚ aprŠs da date de mise en service de la gestion des contrats,
    //   soit le 16/06/2010.

    //   //MODIF JX-AUD le 16/12/2010
    //   //Ajout du code "OR (COMPANYNAME = 'VFE')" pour la soci‚t‚ VFE
    // }
    // END.
    //}
}
