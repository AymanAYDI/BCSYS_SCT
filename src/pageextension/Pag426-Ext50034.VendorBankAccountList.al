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
                Caption = '&Bank Acc.', Comment = 'FRA="&Banque"';

                action(BC6_Card)
                {
                    Caption = 'Card', Comment = 'FRA="Fiche"';
                    Image = EditLines;
                    RunObject = page "Vendor Bank Account List";
                    RunPageLink = "Vendor No." = field("Vendor No."), Code = field(Code);
                    ShortCutKey = 'Shift+F5';
                    ApplicationArea = All;
                }
            }
        }
    }
}
