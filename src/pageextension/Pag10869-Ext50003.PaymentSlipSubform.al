pageextension 50003 "BC6_PaymentSlipSubform" extends "Payment Slip Subform" //10869
{
    // //Jx-AUD du 10/09/2013
    // //Mise en non éditable les champs Code établissement, Agence, Compte bancaire
    layout
    {
        addafter("Account No.")
        {
            field("BC6_Account Name"; Rec."BC6_Account Name")
            {
                ApplicationArea = All;
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
        }
    }
    var
        "Bank Account NameVisible": Boolean;

    trigger OnOpenPage()
    begin
        "Bank Account NameVisible" := TRUE;
    end;
}

