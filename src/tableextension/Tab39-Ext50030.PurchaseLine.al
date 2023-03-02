tableextension 50030 "BC6_PurchaseLine" extends "Purchase Line" //39
{
    fields
    {
        modify("No.")
        {
            TableRelation = if (Type = const(" ")) "Standard Text" else
            if (Type = const("G/L Account"), "System-Created Entry" = const(false)) "G/L Account" where("Direct Posting" = const(true), "Account Type" = const(Posting), Blocked = const(false))
            else
            if (Type = const("G/L Account"), "System-Created Entry" = const(true)) "G/L Account"
            else
            if (Type = const(Item)) Item
            else
            if (Type = const("Fixed Asset")) "Fixed Asset" where("Serial No." = filter('LIBRE | Cde*'))
            else
            if (Type = const("Charge (Item)")) "Item Charge";
        }
        field(50005; "BC6_Matricule No."; Code[20])
        {
            Caption = 'Code matricule', Comment = 'FRA="Code matricule"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50020; "BC6_VTIME New Line"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'VTIME New Line', Comment = 'FRA="VTIME New Line"';
        }
    }
    keys
    {
        key(Key1; "BC6_Matricule No.")
        {
        }
    }
    procedure ShowShortcutDimCodeV(var ShortcutDimCode: array[10] of Code[20])
    var
        FunctionsMgt: Codeunit BC6_FunctionsMgt;
    begin
        FunctionsMgt.Cdu408_GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    procedure SetCompany(NameSociety: Text[30])
    begin
        PurchHeader.CHANGECOMPANY(NameSociety);
        PurchLine2.CHANGECOMPANY(NameSociety);
        TempPurchLine.CHANGECOMPANY(NameSociety);
        GLAcc.CHANGECOMPANY(NameSociety);
        Item.CHANGECOMPANY(NameSociety);
        Currency.CHANGECOMPANY(NameSociety);
        CurrExchRate.CHANGECOMPANY(NameSociety);
        ItemTranslation.CHANGECOMPANY(NameSociety);
        SalesOrderLine.CHANGECOMPANY(NameSociety);
        VATPostingSetup.CHANGECOMPANY(NameSociety);
        StdTxt.CHANGECOMPANY(NameSociety);
        FA.CHANGECOMPANY(NameSociety);
        FADeprBook.CHANGECOMPANY(NameSociety);
        FASetup.CHANGECOMPANY(NameSociety);
        GenBusPostingGrp.CHANGECOMPANY(NameSociety);
        GenProdPostingGrp.CHANGECOMPANY(NameSociety);
        ReservEntry.CHANGECOMPANY(NameSociety);
        UnitOfMeasure.CHANGECOMPANY(NameSociety);
        ItemCharge.CHANGECOMPANY(NameSociety);
        ItemChargeAssgntPurch.CHANGECOMPANY(NameSociety);
        SKU.CHANGECOMPANY(NameSociety);
        WorkCenter.CHANGECOMPANY(NameSociety);
        PurchasingCode.CHANGECOMPANY(NameSociety);
        InvtSetup.CHANGECOMPANY(NameSociety);
        Location.CHANGECOMPANY(NameSociety);
        GLSetup.CHANGECOMPANY(NameSociety);
        ReturnReason.CHANGECOMPANY(NameSociety);
        ItemVend.CHANGECOMPANY(NameSociety);
        CalChange.CHANGECOMPANY(NameSociety);
        Gbool_ImportGroupInvoice := true;
    end;

    var
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        CalChange: Record "Customized Calendar Change";
        FADeprBook: Record "FA Depreciation Book";
        FASetup: Record "FA Setup";
        FA: Record "Fixed Asset";
        GLAcc: Record "G/L Account";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        GenProdPostingGrp: Record "Gen. Product Posting Group";
        GLSetup: Record "General Ledger Setup";
        InvtSetup: Record "Inventory Setup";
        Item: Record Item;
        ItemCharge: Record "Item Charge";
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
        ItemTranslation: Record "Item Translation";
        ItemVend: Record "Item Vendor";
        Location: Record Location;
        PurchHeader: Record "Purchase Header";
        PurchLine2: Record "Purchase Line";
        TempPurchLine: Record "Purchase Line";
        PurchasingCode: Record Purchasing;
        ReservEntry: Record "Reservation Entry";
        ReturnReason: Record "Return Reason";
        SalesOrderLine: Record "Sales Line";
        StdTxt: Record "Standard Text";
        SKU: Record "Stockkeeping Unit";
        UnitOfMeasure: Record "Unit of Measure";
        VATPostingSetup: Record "VAT Posting Setup";
        WorkCenter: Record "Work Center";
        Gbool_ImportGroupInvoice: Boolean;
}
