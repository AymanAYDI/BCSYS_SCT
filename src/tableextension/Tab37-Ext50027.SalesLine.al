tableextension 50027 "BC6_SalesLine" extends "Sales Line" //37
{
    //TODO: Field " Dimension Set ID " devient editable, dans la procedure ShowShortcutDimCode: length de l'un de paramétre a modifié  

    fields
    {
    }

    procedure SetCompany(NameSociety: Text[30])
    begin
        CurrExchRate.ChangeCompany(NameSociety);
        SalesHeader.ChangeCompany(NameSociety);
        SalesLine2.ChangeCompany(NameSociety);
        TempSalesLine.CHANGECOMPANY(NameSociety);
        GLAcc.ChangeCompany(NameSociety);
        Item.CHANGECOMPANY(NameSociety);
        Resource.ChangeCompany(NameSociety);
        Currency.ChangeCompany(NameSociety);
        ItemTranslation.CHANGECOMPANY(NameSociety);
        Res.ChangeCompany(NameSociety);
        ResCost.CHANGECOMPANY(NameSociety);
        WorkType.CHANGECOMPANY(NameSociety);
        VATPostingSetup.ChangeCompany(NameSociety);
        StdTxt.CHANGECOMPANY(NameSociety);
        GenBusPostingGrp.ChangeCompany(NameSociety);
        GenProdPostingGrp.ChangeCompany(NameSociety);
        ReservEntry.CHANGECOMPANY(NameSociety);
        UnitOfMeasure.ChangeCompany(NameSociety);
        FA.CHANGECOMPANY(NameSociety);
        ShippingAgentServices.CHANGECOMPANY(NameSociety);
        NonstockItem.ChangeCompany(NameSociety);
        PurchasingCode.CHANGECOMPANY(NameSociety);
        SKU.ChangeCompany(NameSociety);
        ItemCharge.ChangeCompany(NameSociety);
        ItemChargeAssgntSales.CHANGECOMPANY(NameSociety);
        InvtSetup.ChangeCompany(NameSociety);
        Location.ChangeCompany(NameSociety);
        ReturnReason.CHANGECOMPANY(NameSociety);
        //TempKitSalesLine.CHANGECOMPANY(NameSociety);
        ItemCategory.CHANGECOMPANY(NameSociety);
        CalChange.ChangeCompany(NameSociety);
        Gbool_ImportGroupInvoice := true;
    end;

    procedure BC6_ShowShortcutDimCode(var ShortcutDimCode: array[10] of Code[20])
    var
        GetShortcutDimVal: Codeunit "BC6_Get Shortcut Dimension Val";
    begin
        GetShortcutDimVal.BC6_GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    var
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        CalChange: Record "Customized Calendar Change";
        FA: Record "Fixed Asset";
        GLAcc: Record "G/L Account";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        GenProdPostingGrp: Record "Gen. Product Posting Group";
        InvtSetup: Record "Inventory Setup";
        Item: Record Item;

        ItemCategory: Record "Item Category";
        ItemCharge: Record "Item Charge";
        ItemChargeAssgntSales: Record "Item Charge Assignment (Sales)";
        ItemTranslation: Record "Item Translation";
        Location: Record Location;
        NonstockItem: Record "Nonstock Item";
        PurchasingCode: Record Purchasing;
        ReservEntry: Record "Reservation Entry";
        Res: Record Resource;
        Resource: Record Resource;
        ResCost: Record "Resource Cost";
        ReturnReason: Record "Return Reason";
        SalesHeader: Record "Sales Header";
        SalesLine2: Record "Sales Line";
        TempSalesLine: Record "Sales Line" temporary;
        ShippingAgentServices: Record "Shipping Agent Services";
        StdTxt: Record "Standard Text";
        SKU: Record "Stockkeeping Unit";
        UnitOfMeasure: Record "Unit of Measure";
        VATPostingSetup: Record "VAT Posting Setup";
        WorkType: Record "Work Type";
        Gbool_ImportGroupInvoice: Boolean;
}

