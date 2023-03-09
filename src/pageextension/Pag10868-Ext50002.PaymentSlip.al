pageextension 50002 "BC6_PaymentSlip" extends "Payment Slip" //10868
{
    layout
    {
        addafter("Account No.")
        {
            field("N° Yooz Bordereau"; YoozNo_G)
            {
                Caption = 'N° Yooz Bordereau';
                Editable = false;
                ApplicationArea = All;
            }
        }
        modify("No.")
        {
            Editable = true;
        }
    }
    actions
    {
        addafter("Header RIB")
        {
            action("BC6_Export Nos. Yooz")
            {
                Caption = 'Export Numéros Yooz du bordereau';
                Image = Export1099;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                var
                    lPaymHeader: Record "Payment Header";
                begin
                    lPaymHeader.RESET();
                    lPaymHeader.SETRANGE("No.", Rec."No.");
                    XMLPORT.RUN(XmlPort::"BC6_Yooz Export Payment Nos.", TRUE, FALSE, lPaymHeader);
                end;
            }
        }
        addafter(Archive)
        {
            action("Mettre à jour numéros Yooz")
            {
                Caption = 'Mettre à jour numéros Yooz';
                Image = UpdateXML;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec.FctYooz(TRUE);
                end;
            }
            action(BC6_SendEmail)
            {
                ApplicationArea = All;
                Promoted = true;
                Image = Email;
                PromotedCategory = Process;
                Caption = 'Send vendor payments', Comment = 'FRA="Envoyer paiements fournisseurs"';
                trigger OnAction()
                var
                    CduLVendorPayments: Codeunit "BC6_Vendor Payments";
                begin
                    CLEAR(CduLVendorPayments);
                    CduLVendorPayments.FctSendPaymentMail(Rec, TRUE);
                end;
            }
        }
        addafter(SuggestVendorPayments)
        {
            action("BC6_BC6 SuggestVendorPayments")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Suggest &Vendor Payments', Comment = 'FRA="Proposer paiements &fournisseur"';
                Image = SuggestVendorPayments;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    PaymentClass: Record "Payment Class";
                    CreateVendorPmtSuggestion: Report "Suggest Vendor Payments FR";
                begin
                    if Rec."Status No." <> 0 then
                        Message(Text003)
                    else
                        if PaymentClass.Get(Rec."Payment Class") then
                            if PaymentClass.Suggestions = PaymentClass.Suggestions::Vendor then begin
                                CreateVendorPmtSuggestion.SetGenPayLine(Rec);
                                CreateVendorPmtSuggestion.RunModal();
                                Clear(CreateVendorPmtSuggestion);
                            end else
                                Message(Text001);
                    // PBE 29/07/16
                    Rec.FctYooz(TRUE);
                    //
                end;
            }
        }
        modify(SuggestVendorPayments)
        {
            Visible = false;
        }
    }
    var
        Text001: Label 'This payment class does not authorize vendor suggestions.', Comment = 'FRA="Ce type de règlement n''autorise pas les propositions fournisseur."';
        Text003: Label 'You cannot suggest payments on a posted header.', Comment = 'FRA="Vous n''êtes pas autorisé à faire des propositions de paiement sur un bordereau validé."';
        YoozNo_G: Text;

    procedure FctYoozNo()
    var
        YoozTable: Record "BC6_No. Yooz";
    begin
        YoozNo_G := '';
        YoozTable.RESET();
        YoozTable.SETRANGE("No.", Rec."No.");
        IF YoozTable.FindSet() THEN
            REPEAT
                YoozNo_G := YoozNo_G + YoozTable."Applied Yooz No.";
            UNTIL YoozTable.NEXT() = 0;
    end;
}

