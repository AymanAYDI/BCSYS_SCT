report 50072 "BC6_Archive Purch. Orders"
{
    // //JX-AUD du 13/05/14 CREATION COPIE DU REPORT 499

    Caption = 'Archive Purch. Orders', Comment = 'FRA="Archivage commandes achat"';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "Pay-to Vendor No.";
            RequestFilterHeading = 'Purchase Order';

            trigger OnAfterGetRecord()
            var
                ReservePurchLine: Codeunit "Purch. Line-Reserve";
            begin
                Window.UPDATE(1, "No.");

                AllLinesDeleted := TRUE;
                ItemChargeAssgntPurch.RESET();
                ItemChargeAssgntPurch.SETRANGE("Document Type", "Document Type");
                ItemChargeAssgntPurch.SETRANGE("Document No.", "No.");
                PurchLine.RESET();
                PurchLine.SETRANGE("Document Type", "Document Type");
                PurchLine.SETRANGE("Document No.", "No.");
                PurchLine.SETFILTER("Quantity Invoiced", '<>0');
                IF PurchLine.FIND('-') THEN BEGIN
                    PurchLine.SETRANGE("Quantity Invoiced");
                    PurchLine.SETFILTER("Outstanding Quantity", '<>0');
                    IF NOT PurchLine.FIND('-') THEN BEGIN
                        PurchLine.SETRANGE("Outstanding Quantity");
                        PurchLine.SETFILTER("Qty. Rcd. Not Invoiced", '<>0');
                        IF NOT PurchLine.FIND('-') THEN BEGIN
                            PurchLine.LOCKTABLE();
                            IF NOT PurchLine.FIND('-') THEN BEGIN
                                //MODIF JX-AUD du 13/05/2014
                                //On fait une archive de la commande
                                ArchiveManagement.ArchivePurchDocument("Purchase Header");
                                //FIN MODIF JX-AUD du 13/05/2014
                                PurchLine.SETRANGE("Qty. Rcd. Not Invoiced");
                                IF PurchLine.FIND('-') THEN
                                    REPEAT
                                        PurchLine.CALCFIELDS("Qty. Assigned");
                                        IF ((PurchLine."Qty. Assigned" = PurchLine."Quantity Invoiced") AND
                                          (PurchLine."Qty. Assigned" <> 0)) OR
                                          (PurchLine.Type <> PurchLine.Type::"Charge (Item)")
                                        THEN BEGIN
                                            IF PurchLine.Type = PurchLine.Type::"Charge (Item)" THEN BEGIN
                                                ItemChargeAssgntPurch.SETRANGE("Document Line No.", PurchLine."Line No.");
                                                ItemChargeAssgntPurch.DELETEALL();
                                            END;
                                            IF PurchLine.HASLINKS THEN
                                                PurchLine.DELETELINKS();

                                            PurchLine.DELETE();
                                        END ELSE
                                            AllLinesDeleted := FALSE;
                                    UNTIL PurchLine.NEXT() = 0;

                                IF AllLinesDeleted THEN BEGIN
                                    PostPurchDelete.DeleteHeader("Purchase Header", PurchRcptHeader, PurchInvHeader, PurchCrMemoHeader, ReturnShptHeader, PrepmtPurchInvHeader, PrepmtPurchCrMemoHeader);

                                    ReservePurchLine.DeleteInvoiceSpecFromHeader("Purchase Header");

                                    PurchCommentLine.SETRANGE("Document Type", "Document Type");
                                    PurchCommentLine.SETRANGE("No.", "No.");
                                    PurchCommentLine.DELETEALL();

                                    WhseRequest.SETRANGE("Source Type", DATABASE::"Purchase Line");
                                    WhseRequest.SETRANGE("Source Subtype", "Document Type");
                                    WhseRequest.SETRANGE("Source No.", "No.");
                                    WhseRequest.DELETEALL(TRUE);

                                    IF HASLINKS THEN
                                        DELETELINKS();

                                    DELETE();
                                END;
                                COMMIT();
                            END;
                        END;
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN(Text000);
            end;
        }
    }
    trigger OnPostReport()
    begin
        MESSAGE('Traitement terminé.\\Les commandes d''achats ont été archivées puis supprimées');
    end;

    var
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
        PurchCommentLine: Record "Purch. Comment Line";
        PrepmtPurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        PrepmtPurchInvHeader: Record "Purch. Inv. Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchLine: Record "Purchase Line";
        ReturnShptHeader: Record "Return Shipment Header";
        WhseRequest: Record "Warehouse Request";
        ArchiveManagement: Codeunit ArchiveManagement;
        PostPurchDelete: Codeunit "PostPurch-Delete";
        AllLinesDeleted: Boolean;
        Window: Dialog;
        Text000: Label 'Processing purch. orders #1##########', Comment = 'FRA="Traitement des commandes achat #1##########"';
}

