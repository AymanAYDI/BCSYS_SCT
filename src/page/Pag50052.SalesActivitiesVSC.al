
page 50052 "BC6_Sales Activities VSC"
{
    Caption = 'Sales Activities', Comment = 'FRA="Activités ventes"';
    PageType = CardPart;
    SourceTable = "Sales Cue";

    layout
    {
        area(content)
        {
            cuegroup("Commandes ventes")
            {
                Caption = 'Sales orders', Comment = 'FRA="Commandes ventes"';
                field("Sales Orders"; Rec."BC6_Sales Orders")
                {
                    DrillDownPageID = "Sales Order List";
                    ApplicationArea = All;
                }

                actions
                {
                    action("Nouveau devis")
                    {
                        Caption = 'New Sales Quote', Comment = 'FRA="Nouveau devis"';
                        Image = TileBrickNew;
                        RunObject = Page "Sales Quote";
                        RunPageMode = Create;
                        ApplicationArea = All;
                    }
                    action("Nouvelle commande vente")
                    {
                        Caption = 'New Sales Order', Comment = 'FRA="Nouvelle commande vente"';
                        RunObject = Page "Sales Order";
                        Image = TileBrickNew;
                        RunPageMode = Create;
                        ApplicationArea = All;
                    }
                }
            }
            cuegroup("Commandes ventes-Ouvertes..")
            {
                Caption = 'Commandes ventes-Ouvertes..', Comment = 'FRA="Commandes ventes-Ouvertes.."';
                Visible = false;
                field("Sales Orders - Open"; Rec."Sales Orders - Open")
                {
                    DrillDownPageID = "Sales Order List";
                    Visible = false;
                    ApplicationArea = All;
                }
                field(ReadyToShip; Rec."Ready to Ship")
                {
                    Caption = 'Ready To Ship', Comment = 'FRA="Prêt pour expédition"';
                    DrillDownPageID = "Sales Order List";
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        Rec.ShowOrders(Rec.FIELDNO("Ready to Ship"));
                    end;
                }
                field(PartiallyShipped; Rec."Partially Shipped")
                {
                    Caption = 'Partially Shipped', Comment = 'FRA="Partiellement livré"';
                    DrillDownPageID = "Sales Order List";
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        Rec.ShowOrders(Rec.FIELDNO("Partially Shipped"));
                    end;
                }
                field(DelayedOrders; Rec.Delayed)
                {
                    Caption = 'Delayed', Comment = 'FRA="En retard"';
                    DrillDownPageID = "Sales Order List";
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        Rec.ShowOrders(Rec.FIELDNO(Delayed));
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Set Up Cues")
            {
                Caption = 'Set Up Cues', Comment = 'FRA="Paramétrer piles"';
                Image = Setup;
                ApplicationArea = All;

                trigger OnAction()
                var
                    CueRecordRef: RecordRef;
                begin
                    CueRecordRef.GETTABLE(Rec);
                    CuesAndKpis.OpenCustomizePageForCurrentUser(CueRecordRef.NUMBER);
                end;
            }
        }
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
        Rec.SETRANGE("Date Filter", 0D, WORKDATE() - 1);
        Rec.SETFILTER("Date Filter2", '>=%1', WORKDATE());
    end;

    var
        CuesAndKpis: Codeunit "Cues And KPIs";

    local procedure CalculateCueFieldValues()
    begin
        IF Rec.FIELDACTIVE("Average Days Delayed") THEN
            Rec."Average Days Delayed" := Rec.CalculateAverageDaysDelayed();

        IF Rec.FIELDACTIVE("Ready to Ship") THEN
            Rec."Ready to Ship" := Rec.CountOrders(Rec.FIELDNO("Ready to Ship"));

        IF Rec.FIELDACTIVE("Partially Shipped") THEN
            Rec."Partially Shipped" := Rec.CountOrders(Rec.FIELDNO("Partially Shipped"));

        IF Rec.FIELDACTIVE(Delayed) THEN
            Rec.Delayed := Rec.CountOrders(Rec.FIELDNO(Delayed));
    end;
}

