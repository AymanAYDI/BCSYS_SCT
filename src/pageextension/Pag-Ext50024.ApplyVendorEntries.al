pageextension 50024 "BC6_ApplyVendorEntries" extends "Apply Vendor Entries"
{
    layout
    {
        addafter("Posting Date")
        {
            field("BC6_Document Date"; Rec."Document Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("BC6_Yooz No."; Rec."BC6_Yooz No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Yooz Token link"; Rec."BC6_Yooz Token link")
            {
                Editable = false;
                ExtendedDatatype = URL;
                ApplicationArea = All;
            }
        }
    }
}
