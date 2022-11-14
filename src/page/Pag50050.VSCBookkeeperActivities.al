page 50050 "BC6_VSC Bookkeeper Activities"
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "Finance Cue";

    layout
    {
        area(content)
        {
            cuegroup(Fournisseurs)
            {
                Caption = 'Payables';
                field("Purchase Invoices Due Today"; Rec."Purchase Documents Due Today")
                {
                    DrillDownPageID = "Vendor Ledger Entries";
                    ApplicationArea = All;
                }
            }
            cuegroup(Clients)
            {
                Caption = 'Receivables';
                field("Overdue Sales Documents"; Rec."Overdue Sales Documents")
                {
                    DrillDownPageID = "Customer Ledger Entries";
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
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
