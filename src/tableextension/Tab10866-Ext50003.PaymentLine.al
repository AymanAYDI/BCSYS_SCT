tableextension 50003 "BC6_PaymentLine" extends "Payment Line" //10866
{
    fields
    {
        field(50000; "BC6_Account Name"; Text[50])
        {
            Caption = 'Nom du compte', Comment = 'FRA="Nom du compte"';
            Description = 'JX-YOOZ2';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50010; "BC6_Applied Yooz No."; Text[250])
        {
            Caption = 'N° Yooz lettrés', Comment = 'FRA="N° Yooz lettrés"';
            Description = 'JX-YOOZ2';
            DataClassification = CustomerContent;
        }
        field(50020; "BC6_Pay Document Type"; enum "BC6_Pay Document Type")
        {
            Caption = 'Type Document payé', Comment = 'FRA="Type Document payé"';
            DataClassification = CustomerContent;
        }
        field(50021; "BC6_Pay Document No."; Code[20])
        {
            Caption = 'N° Document payé', Comment = 'FRA="N° Document payé"';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key2; "BC6_Pay Document Type", "BC6_Pay Document No.")
        {
        }
    }
    procedure FctYooz(piHeader: Boolean)
    var
        PayHeader: Record "Payment Header";
        CrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        InvoiceHeader: Record "Purch. Inv. Header";
        VendLedgerEntry: Record "Vendor Ledger Entry";
    begin
        //Vendor No.=FIELD(Account No.),Applies-to ID=FIELD(Applies-to ID)
        "BC6_Applied Yooz No." := '';
        if "Applies-to ID" <> '' then begin
            VendLedgerEntry.Reset();
            VendLedgerEntry.SetCurrentKey("Vendor No.", "Applies-to ID");
            VendLedgerEntry.SetRange("Vendor No.", "Account No.");
            VendLedgerEntry.SetRange("Applies-to ID", "Applies-to ID");
            if VendLedgerEntry.FindSet() then
                repeat
                    if VendLedgerEntry."BC6_Yooz No." = '' then
                        if VendLedgerEntry."Document Type" = VendLedgerEntry."Document Type"::Invoice then begin
                            if InvoiceHeader.Get(VendLedgerEntry."Document No.") then
                                VendLedgerEntry."BC6_Yooz No." := InvoiceHeader."BC6_Yooz No.";
                        end else
                            if CrMemoHeader.Get(VendLedgerEntry."Document No.") then
                                VendLedgerEntry."BC6_Yooz No." := CrMemoHeader."BC6_Yooz No.";

                    if VendLedgerEntry."BC6_Yooz No." <> '' then
                        "BC6_Applied Yooz No." := "BC6_Applied Yooz No." + VendLedgerEntry."BC6_Yooz No." + ';';
                until VendLedgerEntry.Next() = 0;
            Modify();

            if piHeader then
                if PayHeader.Get("No.") then
                    PayHeader.FctYooz(false);
        end;
    end;
}
