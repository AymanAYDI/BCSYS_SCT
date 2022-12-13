page 50050 "BC6_VSC Bookkeeper Activities"
{
    Caption = 'Activities', Comment = 'FRA="Activités"';
    PageType = CardPart;
    SourceTable = "Finance Cue";

    layout
    {
        area(content)
        {
            cuegroup(Fournisseurs)
            {
                Caption = 'Payables', Comment = 'FRA="Fournisseurs"';
                field("Purchase Invoices Due Today"; Rec."Purchase Documents Due Today")
                {
                    DrillDownPageID = "Vendor Ledger Entries";
                    ApplicationArea = All;
                }
            }
            cuegroup(Clients)
            {
                Caption = 'Receivables', Comment = 'FRA="Clients"';
                field("Overdue Sales Documents"; Rec."Overdue Sales Documents")
                {
                    DrillDownPageID = "Customer Ledger Entries";
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.RESET();
        if not Rec.GET() then begin
            Rec.INIT();
            Rec.INSERT();
        end;

        Rec.SETFILTER("Due Date Filter", '<=%1', WORKDATE());
        Rec.SETFILTER("Overdue Date Filter", '<%1', WORKDATE());
    end;
}
