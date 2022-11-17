pageextension 50034 "BC6_VendorBankAccountList" extends "Vendor Bank Account List" //426
{
    layout
    {
        modify("Country/Region Code")
        {
            Visible = true;
        }
        modify("Phone No.")
        {
            Visible = false;
        }
        modify(Contact)
        {
            Visible = false;
        }
        modify("Bank Account No.")
        {
            Visible = true;
        }
        modify("SWIFT Code")
        {
            Visible = true;
        }
        modify(IBAN)
        {
            Visible = true;
        }
        addafter("Contact")
        {
            field(BC6_City; Rec."City")
            {
                ApplicationArea = All;
            }
            field("BC6_Change RIB/IBAN"; Rec."BC6_Change RIB/IBAN")
            {
                ApplicationArea = All;
            }
        }

        addfirst(Control1)
        {
            field("BC6_Vendor No."; Rec."Vendor No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addfirst(navigation)
        {
            group("BC6_&Bank Acc.")
            {
                Caption = '&Bank Acc.';
            }
            action(BC6_Card)
            {
                Caption = 'Card';
                Image = EditLines;
                RunObject = page "Vendor Bank Account List";
                RunPageLink = "Vendor No." = field("Vendor No."), Code = field(Code);
                ShortCutKey = 'Shift+F5';
                ApplicationArea = All;
            }
        }
    }
}
