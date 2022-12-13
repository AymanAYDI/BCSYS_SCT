pageextension 50081 "BC6_VendorHistBuyfromFactBox" extends "Vendor Hist. Buy-from FactBox" //9095
{
    //TODO: A vérifier a garder ou non
    trigger OnOpenPage()
    begin
        CalcNoOfBuyRecords();
    end;

    trigger OnAfterGetRecord()
    begin
        CalcNoOfBuyRecords();

    end;

    var
        FunctionsMgt: Codeunit "BC6_FunctionsMgt";

    procedure CalcNoOfBuyRecords()
    var
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchReceiptHeader: Record "Purch. Rcpt. Header";
        PurchHeader: Record "Purchase Header";
        PurchReturnShptHeader: Record "Return Shipment Header";
        NoOfBlanketOrders, NoOfCreditMemos, NoOfInvoices, NoOfOrders, NoOfPostedCreditMemos, NoOfPostedInvoices, NoOfPostedReceipts, NoOfPostedReturnShipments, NoOfQuotes, NoOfReturnOrders : Integer;
    begin
        PurchHeader.RESET();
        PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::Quote);
        PurchHeader.SETRANGE("Buy-from Vendor No.", Rec."No.");
        //Début Modif JX-XAD du 11/06/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        PurchHeader.FILTERGROUP(2);
        PurchHeader.SETFILTER("Assigned User ID", FunctionsMgt.jx_GetPurchasesFilter());
        PurchHeader.FILTERGROUP(0);
        //Fin Modif JX-XAD du 11/06/2008

        NoOfQuotes := PurchHeader.COUNT;

        PurchHeader.RESET();
        PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::"Blanket Order");
        PurchHeader.SETRANGE("Buy-from Vendor No.", Rec."No.");
        //Début Modif JX-XAD du 11/06/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        PurchHeader.FILTERGROUP(2);
        PurchHeader.SETFILTER("Assigned User ID", FunctionsMgt.jx_GetPurchasesFilter());
        PurchHeader.FILTERGROUP(0);
        //Fin Modif JX-XAD du 11/06/2008
        NoOfBlanketOrders := PurchHeader.COUNT;

        PurchHeader.RESET();
        PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::Order);
        PurchHeader.SETRANGE("Buy-from Vendor No.", Rec."No.");
        //Début Modif JX-XAD du 11/06/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        PurchHeader.FILTERGROUP(2);
        PurchHeader.SETFILTER("Assigned User ID", FunctionsMgt.jx_GetPurchasesFilter());
        PurchHeader.FILTERGROUP(0);
        //Fin Modif JX-XAD du 11/06/2008
        NoOfOrders := PurchHeader.COUNT;

        PurchHeader.RESET();
        PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::"Return Order");
        PurchHeader.SETRANGE("Buy-from Vendor No.", Rec."No.");
        //Début Modif JX-XAD du 11/06/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        PurchHeader.FILTERGROUP(2);
        PurchHeader.SETFILTER("Assigned User ID", FunctionsMgt.jx_GetPurchasesFilter());
        PurchHeader.FILTERGROUP(0);
        //Fin Modif JX-XAD du 11/06/2008
        NoOfReturnOrders := PurchHeader.COUNT;

        PurchHeader.RESET();
        PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::Invoice);
        PurchHeader.SETRANGE("Buy-from Vendor No.", Rec."No.");
        //Début Modif JX-XAD du 11/06/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        PurchHeader.FILTERGROUP(2);
        PurchHeader.SETFILTER("Assigned User ID", FunctionsMgt.jx_GetPurchasesFilter());
        PurchHeader.FILTERGROUP(0);
        //Fin Modif JX-XAD du 11/06/2008
        NoOfInvoices := PurchHeader.COUNT;

        PurchHeader.RESET();
        PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::"Credit Memo");
        PurchHeader.SETRANGE("Buy-from Vendor No.", Rec."No.");
        //Début Modif JX-XAD du 11/06/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        PurchHeader.FILTERGROUP(2);
        PurchHeader.SETFILTER("Assigned User ID", FunctionsMgt.jx_GetPurchasesFilter());
        PurchHeader.FILTERGROUP(0);
        //Fin Modif JX-XAD du 11/06/2008
        NoOfCreditMemos := PurchHeader.COUNT;

        PurchReturnShptHeader.RESET();
        PurchReturnShptHeader.SETRANGE("Buy-from Vendor No.", Rec."No.");
        //Début Modif JX-XAD du 05/08/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        PurchReturnShptHeader.FILTERGROUP(2);
        PurchReturnShptHeader.SETFILTER("User ID", FunctionsMgt.jx_GetPurchasesFilter());
        PurchReturnShptHeader.FILTERGROUP(0);
        //Fin Modif JX-XAD du 05/08/2008
        NoOfPostedReturnShipments := PurchReturnShptHeader.COUNT;

        PurchInvHeader.RESET();
        PurchInvHeader.SETRANGE("Buy-from Vendor No.", Rec."No.");
        //Début Modif JX-XAD du 05/08/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        PurchInvHeader.FILTERGROUP(2);
        PurchInvHeader.SETFILTER("User ID", FunctionsMgt.jx_GetPurchasesFilter());
        PurchInvHeader.FILTERGROUP(0);
        //Fin Modif JX-XAD du 05/08/2008
        NoOfPostedInvoices := PurchInvHeader.COUNT;

        PurchCrMemoHeader.RESET();
        PurchCrMemoHeader.SETRANGE("Buy-from Vendor No.", Rec."No.");
        //Début Modif JX-XAD du 05/08/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        PurchCrMemoHeader.FILTERGROUP(2);
        PurchCrMemoHeader.SETFILTER("User ID", FunctionsMgt.jx_GetPurchasesFilter());
        PurchCrMemoHeader.FILTERGROUP(0);
        //Fin Modif JX-XAD du 05/08/2008
        NoOfPostedCreditMemos := PurchCrMemoHeader.COUNT;

        PurchReceiptHeader.RESET();
        PurchReceiptHeader.SETRANGE("Buy-from Vendor No.", Rec."No.");
        //Début Modif JX-XAD du 05/08/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        PurchReceiptHeader.FILTERGROUP(2);
        PurchReceiptHeader.SETFILTER("User ID", FunctionsMgt.jx_GetPurchasesFilter());
        PurchReceiptHeader.FILTERGROUP(0);
        //Fin Modif JX-XAD du 05/08/2008
        NoOfPostedReceipts := PurchReceiptHeader.COUNT;
    end;
}
