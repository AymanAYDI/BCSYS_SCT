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
                    ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"P.Order");
                    ReportSelection.SETFILTER("Report ID", '<>0');
                    ReportSelection.FIND('-');
                    REPEAT
                        REPORT.RUNMODAL(ReportSelection."Report ID", TRUE, FALSE, PurchaseHeader)
                    UNTIL ReportSelection.NEXT() = 0;
                    // END;
                end
                else

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
                    end;
            // ELSE BEGIN
            // IF (COMPANYNAME = 'Agence') OR (COMPANYNAME = 'Agence Test') THEN BEGIN
            //     REPORT.RUNMODAL(Report::"PurchaseOrder aVSC EN", TRUE, FALSE, PurchaseHeader);
            // END;
            // IF (COMPANYNAME = 'VSC') OR (COMPANYNAME = 'VSC Test') THEN BEGIN
            //     REPORT.RUNMODAL(Report::"PurchaseOrder VSC EN", TRUE, FALSE, PurchaseHeader);
            // END;
            // END;
            else
                exit;
        end;
    end;
}
