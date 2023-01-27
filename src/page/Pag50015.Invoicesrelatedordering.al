page 50015 "BC6_Invoices related  ordering"
{
    Caption = 'Invoices related to ordering', Comment = 'FRA="Factures liées à la commande"';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Integer";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                Editable = false;
                ShowCaption = false;
                field("gCode_Invoice[1,Number]"; gCode_Invoice[1, Rec.Number])
                {
                    Caption = 'Invoices', Comment = 'FRA="Factures"';
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Lrec_PurchInvHeader: Record "Purch. Inv. Header";
                        Lrec_PurchaseHeader: Record "Purchase Header";
                    begin
                        if Lrec_PurchInvHeader.GET(gCode_Invoice[1, Rec.Number]) then
                            PAGE.RUNMODAL(Page::"Posted Purchase Invoice", Lrec_PurchInvHeader)
                        else
                            if Lrec_PurchaseHeader.GET(Lrec_PurchaseHeader."Document Type"::Invoice, gCode_Invoice[1, Rec.Number]) then
                                PAGE.RUNMODAL(Page::"BC6_Purchase Invoice VSC", Lrec_PurchaseHeader);
                        CurrPage.UPDATE(false);
                    end;
                }
                field("gCode_Invoice[2,Number]"; gCode_Invoice[2, Rec.Number])
                {
                    Caption = 'Amount', Comment = 'FRA="Montant HT"';
                    ApplicationArea = All;
                }
                field(Ouvert; gbool_Ouvert)
                {
                    Caption = 'Open', Comment = 'FRA="Ouvert"';
                    ApplicationArea = All;
                }
                field("gCode_Invoice[4,Number]"; gCode_Invoice[4, Rec.Number])
                {
                    Caption = 'Invoices', Comment = 'FRA="N° Yooz"';
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Lrec_PurchInvHeader: Record "Purch. Inv. Header";
                        Lrec_PurchaseHeader: Record "Purchase Header";
                    begin
                        if Lrec_PurchInvHeader.GET(gCode_Invoice[1, Rec.Number]) then
                            PAGE.RUNMODAL(Page::"Posted Purchase Invoice", Lrec_PurchInvHeader)
                        else
                            if Lrec_PurchaseHeader.GET(Lrec_PurchaseHeader."Document Type"::Invoice, gCode_Invoice[1, Rec.Number]) then
                                PAGE.RUNMODAL(Page::"BC6_Purchase Invoice VSC", Lrec_PurchaseHeader);
                        CurrPage.UPDATE(false);
                    end;
                }
                field("gCode_Invoice[5,Number]"; gCode_Invoice[5, Rec.Number])
                {
                    Caption = 'Amount', Comment = 'FRA="Lien Yooz"';
                    ExtendedDatatype = URL;
                    ApplicationArea = All;
                }
                field("gCode_Invoice[6,Number]"; gCode_Invoice[6, Rec.Number])
                {
                    Caption = 'Invoices', Comment = 'FRA="N° BC"';
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Lrec_PurchInvHeader: Record "Purch. Inv. Header";
                        Lrec_PurchaseHeader: Record "Purchase Header";
                    begin
                        if Lrec_PurchInvHeader.GET(gCode_Invoice[1, Rec.Number]) then
                            PAGE.RUNMODAL(Page::"Posted Purchase Invoice", Lrec_PurchInvHeader)
                        else
                            if Lrec_PurchaseHeader.GET(Lrec_PurchaseHeader."Document Type"::Invoice, gCode_Invoice[1, Rec.Number]) then
                                PAGE.RUNMODAL(Page::"BC6_Purchase Invoice VSC", Lrec_PurchaseHeader);
                        CurrPage.UPDATE(false);
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecordV();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecordV();
    end;

    trigger OnOpenPage()
    begin
        //***** Appel de la fonction de recherche des factures liées à une commande *****
        gInt_Count := gCU_linksBetweenDocuments.SearchInvoices(gCode_Commande, gCode_Invoice);
        if gInt_Count <> 0 then
            Rec.SETFILTER(Number, '%1..%2', 1, gInt_Count)
        else
            Rec.SETFILTER(Number, '%1..%2', 1, 1);
    end;

    var
        gCU_linksBetweenDocuments: Codeunit "BC6_Links Between Documents";
        gbool_Ouvert: Boolean;
        gCode_Commande: Code[20];
        gInt_Count: Integer;
        gCode_Invoice: array[6, 1000] of Text;

    procedure jx_InitForm(pCode_Commande: Code[20])
    begin
        gCode_Commande := pCode_Commande;
    end;

    local procedure OnAfterGetCurrRecordV()
    begin
        xRec := Rec;
        if Rec.Number <> 0 then
            if gCode_Invoice[3, Rec.Number] = 'TRUE' then
                gbool_Ouvert := true
            else
                gbool_Ouvert := false
    end;
}
