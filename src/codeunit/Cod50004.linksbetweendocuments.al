codeunit 50004 "BC6_Links Between Documents"
{
    var
        gRec_ItemLedgerEntry: Record "Item Ledger Entry";
        gRec_PurchInvHeader: Record "Purch. Inv. Header";
        gRec_PurchInvLine: Record "Purch. Inv. Line";
        gRec_PurchRcptHeader: Record "Purch. Rcpt. Header";
        gRec_PurchaseHeader: Record "Purchase Header";
        gRec_PurchaseLine: Record "Purchase Line";
        Grec_PurchaseLine2: Record "Purchase Line";
        gRec_ValueEntry: Record "Value Entry";
        grec_VendorLedgerEntry: Record "Vendor Ledger Entry";
        gBool_InvoiceExist: Boolean;
        gBool_OrderExist: Boolean;
        Gdec_TotalHTDocument: Decimal;
        gInt_Count: Integer;
        i: Integer;

    procedure SearchInvoices(pCode_Commande: Code[20]; var pCode_Invoice: array[5, 1000] of Text) rInt_NbInvoices: Integer;
    var
        Lrec_PurchInvLine: Record "Purch. Inv. Header";
    begin
        //Fonction qui permet de retrouver pour une commande donn‚e
        //toutes les factures … la fois en cours et enregistr‚es.
        //Entr‚es :  nø commande
        //Sorties :  pCode_Invoice (Tableau … deux dimensions de 2x100 chaines de 20 caractŠres contenant les factures:
        //                            pCode_Invoice[1,x] = Nø facture et pCode_Invoice[2,x] = montant HT)
        //           rInt_NbInvoices (Nombre de factures trouv‚es)

        gInt_Count := 0;    //Compteur de factures

        //***** On recherche d'abord les r‚ceptions li‚es … la commande *****
        gRec_PurchRcptHeader.RESET();
        gRec_PurchRcptHeader.SETFILTER(gRec_PurchRcptHeader."Order No.", '%1', pCode_Commande);
        if gRec_PurchRcptHeader.COUNT > 0 then

            //***** Pour chaque r‚ception, on recherche les factures en cours correspondantes *****
            if gRec_PurchRcptHeader.FIND('-') then
                repeat
                    gRec_PurchaseLine.RESET();
                    gRec_PurchaseLine.SETFILTER(gRec_PurchaseLine."Document Type", '%1', gRec_PurchaseLine."Document Type"::Invoice);
                    gRec_PurchaseLine.SETFILTER(gRec_PurchaseLine."Receipt No.", '%1', gRec_PurchRcptHeader."No.");
                    if gRec_PurchaseLine.COUNT > 0 then
                        if gRec_PurchaseLine.FIND('-') then
                            repeat
                                //***** On v‚rifie si la facture est d‚j… dans la liste *****
                                gBool_InvoiceExist := false;
                                for i := 1 to gInt_Count do begin
                                    if gRec_PurchaseLine."Document No." = pCode_Invoice[1, i] then
                                        gBool_InvoiceExist := true;
                                end;
                                //***** Si la facture n'est pas dans la liste, on l'y ajoute *****
                                if not gBool_InvoiceExist then begin
                                    gInt_Count += 1;
                                    if gInt_Count > 1000 then
                                        exit;
                                    pCode_Invoice[1, gInt_Count] := gRec_PurchaseLine."Document No.";
                                    // D‚but Calcul du montant HT total de la facture
                                    Gdec_TotalHTDocument := 0;
                                    Grec_PurchaseLine2.RESET();
                                    Grec_PurchaseLine2.SETFILTER(Grec_PurchaseLine2."Document Type", '%1', Grec_PurchaseLine2."Document Type"::Invoice);
                                    Grec_PurchaseLine2.SETFILTER(Grec_PurchaseLine2."Document No.", '%1', pCode_Invoice[1, gInt_Count]);
                                    if Grec_PurchaseLine2.FIND('-') then
                                        repeat
                                            Gdec_TotalHTDocument += Grec_PurchaseLine2."Line Amount";
                                        until Grec_PurchaseLine2.NEXT() = 0;
                                    if Gdec_TotalHTDocument <> 0 then
                                        pCode_Invoice[2, gInt_Count] := FORMAT(Gdec_TotalHTDocument)
                                    else
                                        pCode_Invoice[2, gInt_Count] := '';
                                    // Fin Calcul du montant HT total de la facture

                                    //Modif JX-AUD du 30/10/2012
                                    //recherche si la facture est ouverte
                                    pCode_Invoice[3, gInt_Count] := 'true'; //FAPXXX a toujours un montant ouvert
                                    if not gRec_PurchaseHeader.GET(gRec_PurchaseLine."Document Type", gRec_PurchaseLine."Document No.") then
                                        gRec_PurchaseHeader.INIT();
                                    pCode_Invoice[4, gInt_Count] := gRec_PurchaseHeader."BC6_Yooz No.";
                                    pCode_Invoice[5, gInt_Count] := gRec_PurchaseHeader."BC6_Yooz Token link";
                                    pCode_Invoice[6, gInt_Count] := gRec_PurchaseHeader."BC6_BC No.";
                                    //Fin Modif JX-AUD du 30/10/2012
                                end;
                            until gRec_PurchaseLine.NEXT() = 0;
                until gRec_PurchRcptHeader.NEXT() = 0;

        //***** Pour chaque r‚ception, rechercher les ‚critures article correspondantes *****
        if gRec_PurchRcptHeader.FIND('-') then
            repeat
                //***** Pour chaque ‚criture article li‚e … la r‚ception, rechercher les ‚critures valeur *****
                gRec_ItemLedgerEntry.RESET();
                gRec_ItemLedgerEntry.SETFILTER(gRec_ItemLedgerEntry."Document No.", '%1', gRec_PurchRcptHeader."No.");
                if gRec_ItemLedgerEntry.COUNT > 0 then
                    if gRec_ItemLedgerEntry.FIND('-') then
                        repeat
                            //***** Pour chaque ‚criture valeur li‚e … l'‚criture article, rechercher les factures enregistr‚es *****
                            gRec_ValueEntry.RESET();
                            gRec_ValueEntry.SETFILTER(gRec_ValueEntry."Item Ledger Entry No.", '%1', gRec_ItemLedgerEntry."Entry No.");
                            gRec_ValueEntry.SETFILTER(gRec_ValueEntry."Document Type", '%1', gRec_ValueEntry."Document Type"::"Purchase Invoice");
                            if gRec_ValueEntry.COUNT > 0 then
                                if gRec_ValueEntry.FIND('-') then
                                    repeat
                                        //***** On v‚rifie si la facture est d‚j… dans la liste *****
                                        gBool_InvoiceExist := false;
                                        for i := 1 to gInt_Count do
                                            if gRec_ValueEntry."Document No." = pCode_Invoice[1, i] then
                                                gBool_InvoiceExist := true;
                                        //***** Si la facture n'est pas dans la liste, on l'y ajoute *****
                                        if not gBool_InvoiceExist then begin
                                            gInt_Count += 1;
                                            if gInt_Count > 1000 then
                                                exit;
                                            pCode_Invoice[1, gInt_Count] := gRec_ValueEntry."Document No.";
                                            if not gRec_PurchInvHeader.GET(gRec_ValueEntry."Document No.") then
                                                gRec_PurchInvHeader.INIT();
                                            pCode_Invoice[4, gInt_Count] := gRec_PurchInvHeader."BC6_Yooz No.";
                                            pCode_Invoice[5, gInt_Count] := gRec_PurchInvHeader."BC6_Yooz Token link";
                                            pCode_Invoice[6, gInt_Count] := gRec_PurchInvHeader."BC6_BC No.";
                                            // D‚but Calcul du montant HT total de la facture
                                            if Lrec_PurchInvLine.GET(pCode_Invoice[1, gInt_Count]) then begin
                                                Lrec_PurchInvLine.CALCFIELDS(Lrec_PurchInvLine.Amount);
                                                pCode_Invoice[2, gInt_Count] := FORMAT(Lrec_PurchInvLine.Amount);
                                            end else
                                                pCode_Invoice[2, gInt_Count] := '';
                                            // Fin Calcul du montant HT total de la facture

                                            //Modif JX-AUD du 30/10/2012
                                            //recherche si la facture est ouverte
                                            grec_VendorLedgerEntry.SETFILTER(grec_VendorLedgerEntry."Document No.", gRec_ValueEntry."Document No.");
                                            if grec_VendorLedgerEntry.FIND('-') then
                                                if grec_VendorLedgerEntry.Open then
                                                    pCode_Invoice[3, gInt_Count] := 'true'
                                                else
                                                    pCode_Invoice[3, gInt_Count] := 'false'
                                            //Fin Modif JX-AUD du 30/10/2012
                                        end;
                                    until gRec_ValueEntry.NEXT() = 0;
                        until gRec_ItemLedgerEntry.NEXT() = 0;
            until gRec_PurchRcptHeader.NEXT() = 0;

        rInt_NbInvoices := gInt_Count;
    end;

    procedure SearchOrdersFAP(pCode_Invoice: Code[20]; var pCode_Order: array[1000] of Code[20]) rInt_NbOrders: Integer;
    begin
        //Fonction qui permet de retrouver pour une facture donn‚e (en cours) toutes les commandes.
        //Entr‚es :  pCode_Invoice (nø facture en cours)
        //Sorties :  pCode_Order (Tableau de 100 chaines de 20 caractŠres contenant les commandes)
        //           rInt_NbOrders (Nombre de commandes trouv‚es)

        gInt_Count := 0;    //Compteur de commandes

        //***** On recherche les r‚ceptions li‚es … la facture *****
        gRec_PurchaseLine.RESET();
        gRec_PurchaseLine.SETFILTER(gRec_PurchaseLine."Document Type", '%1', gRec_PurchaseLine."Document Type"::Invoice);
        gRec_PurchaseLine.SETFILTER(gRec_PurchaseLine."Document No.", '%1', pCode_Invoice);
        if gRec_PurchaseLine.COUNT > 0 then
            //***** Pour chaque r‚ception, on r‚cupŠre le nø commande *****
            if gRec_PurchaseLine.FIND('-') then
                repeat
                    if gRec_PurchaseLine."Receipt No." <> '' then
                        if gRec_PurchRcptHeader.GET(gRec_PurchaseLine."Receipt No.") then
                            if gRec_PurchRcptHeader."Order No." <> '' then begin
                                //***** On v‚rifie si la commande est d‚j… dans la liste *****
                                gBool_OrderExist := false;
                                for i := 1 to gInt_Count do begin
                                    if gRec_PurchRcptHeader."Order No." = pCode_Order[i] then
                                        gBool_OrderExist := true;
                                end;
                                //***** Si la commande n'est pas dans la liste, on l'y ajoute *****
                                if not gBool_OrderExist then begin
                                    gInt_Count += 1;
                                    pCode_Order[gInt_Count] := gRec_PurchRcptHeader."Order No.";
                                end;
                            end;
                until gRec_PurchaseLine.NEXT() = 0;

        rInt_NbOrders := gInt_Count;
    end;

    procedure SearchOrdersFA(pCode_Invoice: Code[20]; var pCode_Order: array[1000] of Code[20]) rInt_NbOrders: Integer;
    begin
        //Fonction qui permet de retrouver pour une facture donn‚e (enregistr‚e) toutes les commandes.
        //Entr‚es :  pCode_Invoice (nø facture en cours)
        //Sorties :  pCode_Order (Tableau de 100 chaines de 20 caractŠres contenant les commandes)
        //           rInt_NbOrders (Nombre de commandes trouv‚es)

        gInt_Count := 0;    //Compteur de commandes

        //***** Pour chaque ligne de la facture, rechercher les ‚critures valeur correspondantes *****
        gRec_PurchInvLine.RESET();
        gRec_PurchInvLine.SETFILTER(gRec_PurchInvLine."Document No.", '%1', pCode_Invoice);
        if gRec_PurchInvLine.FIND('-') then
            repeat
                gRec_ValueEntry.RESET();
                gRec_ValueEntry.SETFILTER(gRec_ValueEntry."Document No.", '%1', gRec_PurchInvLine."Document No.");
                gRec_ValueEntry.SETFILTER(gRec_ValueEntry."Document Line No.", '%1', gRec_PurchInvLine."Line No.");
                if gRec_ValueEntry.COUNT > 0 then
                    if gRec_ValueEntry.FIND('-') then
                        repeat
                            if gRec_ItemLedgerEntry.GET(gRec_ValueEntry."Item Ledger Entry No.") then
                                if gRec_PurchRcptHeader.GET(gRec_ItemLedgerEntry."Document No.") then
                                    if gRec_PurchRcptHeader."Order No." <> '' then begin
                                        //***** On v‚rifie si la commande est d‚j… dans la liste *****
                                        gBool_OrderExist := false;
                                        for i := 1 to gInt_Count do begin
                                            if gRec_PurchRcptHeader."Order No." = pCode_Order[i] then
                                                gBool_OrderExist := true;
                                        end;
                                        //***** Si la commande n'est pas dans la liste, on l'y ajoute *****
                                        if not gBool_OrderExist then begin
                                            gInt_Count += 1;
                                            pCode_Order[gInt_Count] := gRec_PurchRcptHeader."Order No.";
                                        end;
                                    end;
                        until gRec_ValueEntry.NEXT() = 0;
            until gRec_PurchInvLine.NEXT() = 0;

        rInt_NbOrders := gInt_Count;
    end;
}
