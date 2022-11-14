pageextension 50027 "BC6_VendorLedgerEntries" extends "Vendor Ledger Entries"
{
    layout
    {
        addafter("Document No.")
        {
            field("BC6_Transaction No."; Rec."Transaction No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Due Date")
        {
            field("BC6_Document Type Prepaid"; Rec."BC6_Document Type Prepaid")
            {
                ApplicationArea = All;
            }
            field("BC6_Document Prepaid"; Rec."BC6_Document Prepaid")
            {
                ApplicationArea = All;
            }
        }
        addafter("Reversed Entry No.")
        {
            field("BC6_Closed by Entry No."; Rec."Closed by Entry No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Entry No.")
        {
            field("BC6_Yooz No."; Rec."BC6_Yooz No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Yooz Token link"; Rec."BC6_Yooz Token link")
            {
                ApplicationArea = All;
            }
        }
    }
    var
        UserMgt: Codeunit "BC6_FunctionsMgt";

    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("User ID", UserMgt.jx_GetPurchasesFilter());
        Rec.FILTERGROUP(0);
    end;
}
