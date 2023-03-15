page 50044 "BC6 Purchase Activities VSC"
{
    // // Modif JX-ABE-20/10/2015
    // // Renommer la Pile BC à receptionner en BC non receptionnés.
    // // Fin Modif
    // 
    // // Modif JX-ABE-01/02/2016
    // // Renommer le caption de la Pile tous mes BC par Historique BC.
    // // Fin Modif

    Caption = 'Activities', Comment = 'FRA="Activités"';
    PageType = CardPart;
    SourceTable = "Purchase Cue";

    layout
    {
        area(content)
        {
            cuegroup(Devis)
            {
                Caption = 'Quote', Comment = 'FRA="Devis"';
                field("Quote Open"; Rec."BC6_Quote Open")
                {
                    DrillDownPageID = "Purchase Quotes";
                    ApplicationArea = All;
                }
                field("Quote to Release"; Rec."BC6_Quote to Release")
                {
                    DrillDownPageID = "Purchase Quotes";
                    ApplicationArea = All;
                }
                field("Quote to tranform"; Rec."BC6_Quote to tranform")
                {
                    DrillDownPageID = "Purchase Quotes";
                    ApplicationArea = All;
                }

                actions
                {
                    action(Naviguer)
                    {
                        Caption = 'Navigate', Comment = 'FRA="Naviguer"';
                        Image = Navigate;
                        RunObject = Page Navigate;
                        ApplicationArea = All;
                    }
                    action("Nouveau devis")
                    {
                        Caption = 'New Purchase Quote', Comment = 'FRA="Nouveau devis"';
                        RunObject = Page "Purchase Quote";
                        Image = TileBrickNew;
                        RunPageMode = Create;
                        ApplicationArea = All;
                    }
                }
            }
            cuegroup(Commandes)
            {
                Caption = 'Orders & Invoices', Comment = 'FRA="Commandes"';
                field("<Historique BC>"; Rec."BC6_All Orders")
                {
                    Caption = 'Historique BC', Comment = 'FRA="Historique BC"';
                    DrillDownPageID = "BC6_Purchase Order List VSC";
                    ApplicationArea = All;
                }
                field("<Bc not Receive>"; Rec."BC6_Order To Receipt")
                {
                    Caption = 'BC not receive', Comment = 'FRA="BC non receptionnés"';
                    DrillDownPageID = "BC6_Purchase Order List VSC";
                    ApplicationArea = All;
                }

                actions
                {
                    action(Action16)
                    {
                        Caption = 'Navigate', Comment = 'FRA="Naviguer"';
                        Image = Navigate;
                        RunObject = Page Navigate;
                        ApplicationArea = All;
                    }
                }
            }
            cuegroup("Factures & Avoirs")
            {
                Caption = 'Orders & Invoices', Comment = 'FRA="Factures & Avoirs"';
                field("Invoice To Approve"; Rec."BC6_Invoice To Approve")
                {
                    DrillDownPageID = "BC6 Purchase Invoices List VSC";
                    ApplicationArea = All;
                }
                field("Credit Memo To Approve"; Rec."BC6_Credit Memo To Approve")
                {
                    DrillDownPageID = "Purchase Credit Memos";
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        CalculateCueFieldValues();
    end;

    trigger OnOpenPage()
    begin
        Rec.RESET();
        IF NOT Rec.GET() THEN BEGIN
            Rec.INIT();
            Rec.INSERT();
        END;

        Rec.SetRespCenterFilter();
        Rec.SETFILTER("Date Filter", '>=%1', WORKDATE());

        // Migration 2015
        IF FunctionsMgt.jx_GetPurchasesFilter() <> '' THEN
            Rec.SETFILTER(Rec."BC6_User Filter", FunctionsMgt.jx_GetPurchasesFilter());
        //
    end;

    var
        FunctionsMgt: Codeunit "BC6_FunctionsMgt";
    //UserMgt: Codeunit "User Setup Management";

    local procedure CalculateCueFieldValues()
    begin
        IF Rec.FIELDACTIVE("Outstanding Purchase Orders") THEN
            Rec."Outstanding Purchase Orders" := Rec.CountOrders(Rec.FIELDNO("Outstanding Purchase Orders"));

        IF Rec.FIELDACTIVE("BC6_Order To Receipt") THEN
            Rec."Outstanding Purchase Orders" := Rec.CountOrders(Rec.FIELDNO("BC6_Order To Receipt"));

        IF Rec.FIELDACTIVE("Not Invoiced") THEN
            Rec."Not Invoiced" := Rec.CountOrders(Rec.FIELDNO("Not Invoiced"));

        IF Rec.FIELDACTIVE("Partially Invoiced") THEN
            Rec."Partially Invoiced" := Rec.CountOrders(Rec.FIELDNO("Partially Invoiced"));
    end;
}

