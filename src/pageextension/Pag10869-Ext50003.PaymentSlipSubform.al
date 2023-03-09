pageextension 50003 "BC6_PaymentSlipSubform" extends "Payment Slip Subform" //10869
{
    layout
    {
        addafter("Account No.")
        {
            field("BC6_Account Name"; Rec."BC6_Account Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("External Document No.")
        {
            field("BC6_E-Mail"; RecGVendor."E-Mail")
            {
                ApplicationArea = all;
                Caption = 'E-Mail', Comment = 'FRA="E-mail"';
                Visible = BooGEmailVisibility;
                Editable = false;
            }
        }

        addafter("Direct Debit Mandate ID")
        {
            field("BC6_Pay Document Type"; Rec."BC6_Pay Document Type")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Pay Document No."; Rec."BC6_Pay Document No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_E-mail Sent To Vendor"; Rec."BC6_E-mail Sent To Vendor")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }
    var
        RecGVendor: Record Vendor;
        "Bank Account NameVisible": Boolean;
        BooGEmailVisibility: Boolean;

    trigger OnAfterGetRecord()
    begin
        BooGEmailVisibility := Rec."Account Type" = Rec."Account Type"::Vendor;

        IF (Rec."Account Type" = Rec."Account Type"::Vendor) THEN
            IF RecGVendor.GET(Rec."Account No.") THEN;
    end;

    trigger OnOpenPage()
    begin
        "Bank Account NameVisible" := TRUE;
    end;
}

