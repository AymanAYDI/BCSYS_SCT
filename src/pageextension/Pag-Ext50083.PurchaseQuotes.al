pageextension 50083 "BC6_PurchaseQuotes" extends "Purchase Quotes"
{
    Caption = 'Purchase Quotes';

    layout
    {
        modify("Vendor Authorization No.")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        addafter(Status)
        {
            field("BC6_Status Code"; Rec."BC6_Status Code")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
        addafter("Campaign No.")
        {
            field("BC6_Document Prepaid"; Rec."BC6_Document Prepaid")
            {
                Editable = false;
                Importance = Additional;
                ApplicationArea = All;
            }
            field("BC6_Amount Prepaid"; Rec."BC6_Amount Prepaid")
            {
                Editable = false;
                Importance = Additional;
                ApplicationArea = All;
            }
        }

        addafter("Vendor Authorization No.")
        {
            field("BC6_Your Reference"; Rec."Your Reference")
            {
            }
            field("BC6_Lines Amount"; Rec."BC6_Lines Amount")
            {
            }
            field("BC6_Assigned User ID"; Rec."Assigned User ID")
            {
            }
            field("BC6_Matricule No."; Rec."BC6_Matricule No.")
            {
            }
            field(BC6_Status; Rec.Status)
            {
            }
            field("BC6_Creation date"; Rec."BC6_Creation date")
            {
            }
        }
    }
    actions
    {
        modify(Statistics)
        {
            Promoted = true;
            PromotedCategory = Process;
        }
        modify(MakeOrder)
        {
            Visible = false;
            Caption = 'Make &Order';
        }
        addbefore(Action12)
        {
            action(BC6_MakeOrder)
            {
                ApplicationArea = Suite;
                Caption = 'Make &Order';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Convert the purchase quote to a purchase order.';

                trigger OnAction()
                begin
                    //TODO: a virifé: date 20100616 ou bien 20160610
                    //Début Modif JX-XAD du 24/06/2010
                    // IF Rec."BC6_Creation date" >= 20100616D THEN BEGIN
                    //     // Début Modif JX-XAD du 22/02/2010
                    //     // Test si le devis nécessite un contrat et si les champs obligatoires sont remplis
                    //     //IF (COMPANYNAME = 'VSCT') OR (COMPANYNAME = 'VSCT - RECETTE') THEN
                    //     //  IF (COMPANYNAME = 'VSC') OR (COMPANYNAME = 'VSC - RECETTE') THEN
                    //     BEGIN
                    //         IF NOT Gcu_ManageContract.CheckQuoteLines(Rec."No.") THEN
                    //             IF NOT Gcu_ManageContract.CheckContractInQuote(Rec."No.") THEN
                    //                 ERROR(Text001);
                    //     END;
                    //     // Fin Modif JX-XAD du 22/02/2010
                    // END;
                    //Fin Modif JX-XAD du 24/06/2010

                    //Modif JX-AUD du 29/01/2013
                    VerifSaisieAxesAnalytiques();
                    //Fin modif JX-AUD du 29/01/2013

                    // if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
                    //     CODEUNIT.Run(CODEUNIT::"Purch.-Quote to Order (Yes/No)", Rec);
                end;
            }
        }
        modify(SendApprovalRequest)
        {
            Visible = false;
        }
        addfirst("Request Approval")
        {
            action("Envoyer demande d'approbation")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Enabled = not OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Request approval of the document.';

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin
                    //TODO: a virifé: date 20100616 ou bien 20160610
                    //Début Modif JX-XAD du 24/06/2010
                    // IF Rec."BC6_Creation date" >= 20100616D THEN BEGIN
                    //     // Début Modif JX-XAD du 22/02/2010
                    //     // Test si le devis nécessite un contrat et si les champs obligatoires sont remplis
                    //     //IF (COMPANYNAME = 'VSCT') OR (COMPANYNAME = 'VSCT - RECETTE') THEN
                    //     //  IF (COMPANYNAME = 'VSC') OR (COMPANYNAME = 'VSC - RECETTE') THEN
                    //     BEGIN
                    //         IF NOT Gcu_ManageContract.CheckQuoteLines(Rec."No.") THEN
                    //             IF NOT Gcu_ManageContract.CheckContractInQuote(Rec."No.") THEN
                    //                 ERROR(Text001);
                    //     END;
                    //     // Fin Modif JX-XAD du 22/02/2010
                    // END;
                    //Fin Modif JX-XAD du 24/06/2010

                    //Modif JX-AUD du 29/01/2013
                    VerifSaisieAxesAnalytiques();
                    //Fin modif JX-AUD du 29/01/2013
                    if ApprovalMgt.CheckPurchaseApprovalPossible(Rec) then
                        ApprovalMgt.OnSendPurchaseDocForApproval(Rec);
                end;
            }
            action("BC6_Cancel Approval Re&quest")
            {
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                begin
                    ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                    WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                end;
            }
            action("BC6_Payer ce document")
            {
                Caption = 'Payer ce document';
                Image = VendorPayment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    lPaymentMgt: Codeunit "BC6_Vendor Payments";
                begin
                    lPaymentMgt.CreatePaymentDoc(Rec);
                end;
            }
        }
    }

    var
        Grec_Dimension: Record Dimension;
        Grec_DimSetEntry: Record "Dimension Set Entry";
        Grecord_GeneralLedgerSetup: Record "General Ledger Setup";
        Grec_PurchaseLine: Record "Purchase Line";
        FunctionsMgt: Codeunit "BC6_FunctionsMgt";
        OpenApprovalEntriesExist: Boolean;
        Gcode_Axe1: Code[20];
        Gcode_Axe2: Code[20];
        Gcode_Axe3: Code[20];
        Gcode_Axe4: Code[20];
        Gtext_Axe1: Text[50];
        Gtext_Axe2: Text[50];
        Gtext_Axe3: Text[50];
        Gtext_Axe4: Text[50];

    trigger OnOpenPage()
    begin

        Rec.SetSecurityFilterOnRespCenter();

        //Début Modif JX-XAD du 11/06/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Assigned User ID", FunctionsMgt.jx_GetPurchasesFilter());
        Rec.FILTERGROUP(0);
        //Fin Modif JX-XAD du 11/06/2008
    end;

    procedure VerifSaisieAxesAnalytiques()
    begin
        if Grecord_GeneralLedgerSetup.FIND('-') then begin
            Gcode_Axe1 := Grecord_GeneralLedgerSetup."Shortcut Dimension 3 Code";//Axe 0
            if Grec_Dimension.GET(Gcode_Axe1) then Gtext_Axe1 := Grec_Dimension.Name;
            Gcode_Axe2 := Grecord_GeneralLedgerSetup."Shortcut Dimension 4 Code";// Axe 1
            if Grec_Dimension.GET(Gcode_Axe2) then Gtext_Axe2 := Grec_Dimension.Name;
            Gcode_Axe3 := Grecord_GeneralLedgerSetup."Shortcut Dimension 5 Code";// Axe 2
            if Grec_Dimension.GET(Gcode_Axe3) then Gtext_Axe3 := Grec_Dimension.Name;
            Gcode_Axe4 := Grecord_GeneralLedgerSetup."Shortcut Dimension 6 Code";// Axe 3
            if Grec_Dimension.GET(Gcode_Axe4) then Gtext_Axe4 := Grec_Dimension.Name;
        end;

        if Rec."Document Type" = Rec."Document Type"::Quote then//DA
        begin
            Grec_PurchaseLine.SETFILTER("Document No.", Rec."No.");
            if Grec_PurchaseLine.FIND('-') then
                repeat
                    if Grec_PurchaseLine.Type <> Grec_PurchaseLine.Type::" " then begin
                        if Gcode_Axe1 <> '' then
                            if not Grec_DimSetEntry.GET(Grec_PurchaseLine."Dimension Set ID", Gcode_Axe1) then
                                ERROR('Vous devez saisir l''axe analytique ' + FORMAT(Gtext_Axe1) + ' sur la ligne ' + FORMAT(Grec_PurchaseLine."Line No."));
                        if Gcode_Axe2 <> '' then
                            if not Grec_DimSetEntry.GET(Grec_PurchaseLine."Dimension Set ID", Gcode_Axe2) then
                                ERROR('Vous devez saisir l''axe analytique ' + FORMAT(Gtext_Axe2) + ' sur la ligne ' + FORMAT(Grec_PurchaseLine."Line No."));
                        if Gcode_Axe3 <> '' then
                            if not Grec_DimSetEntry.GET(Grec_PurchaseLine."Dimension Set ID", Gcode_Axe3) then
                                ERROR('Vous devez saisir l''axe analytique ' + FORMAT(Gtext_Axe3) + ' sur la ligne ' + FORMAT(Grec_PurchaseLine."Line No."));
                        if Gcode_Axe4 <> '' then
                            if not Grec_DimSetEntry.GET(Grec_PurchaseLine."Dimension Set ID", Gcode_Axe4) then
                                ERROR('Vous devez saisir l''axe analytique ' + FORMAT(Gtext_Axe4) + ' sur la ligne ' + FORMAT(Grec_PurchaseLine."Line No."));
                    end;
                until Grec_PurchaseLine.NEXT() = 0;
        end;

        if Rec."Document Type" = Rec."Document Type"::Order then//Commande
        begin
            Grec_PurchaseLine.SETFILTER("Document No.", Rec."No.");
            if Grec_PurchaseLine.FIND('-') then
                repeat
                    if Grec_PurchaseLine.Type <> Grec_PurchaseLine.Type::" " then begin
                        if Gcode_Axe1 <> '' then
                            if not Grec_DimSetEntry.GET(Grec_PurchaseLine."Dimension Set ID", Gcode_Axe1) then
                                ERROR('Vous devez saisir l''axe analytique ' + FORMAT(Gtext_Axe1) + ' sur la ligne ' + FORMAT(Grec_PurchaseLine."Line No."));
                        if Gcode_Axe2 <> '' then
                            if not Grec_DimSetEntry.GET(Grec_PurchaseLine."Dimension Set ID", Gcode_Axe2) then
                                ERROR('Vous devez saisir l''axe analytique ' + FORMAT(Gtext_Axe2) + ' sur la ligne ' + FORMAT(Grec_PurchaseLine."Line No."));
                        if Gcode_Axe3 <> '' then
                            if not Grec_DimSetEntry.GET(Grec_PurchaseLine."Dimension Set ID", Gcode_Axe3) then
                                ERROR('Vous devez saisir l''axe analytique ' + FORMAT(Gtext_Axe3) + ' sur la ligne ' + FORMAT(Grec_PurchaseLine."Line No."));
                        if Gcode_Axe4 <> '' then
                            if not Grec_DimSetEntry.GET(Grec_PurchaseLine."Dimension Set ID", Gcode_Axe4) then
                                ERROR('Vous devez saisir l''axe analytique ' + FORMAT(Gtext_Axe4) + ' sur la ligne ' + FORMAT(Grec_PurchaseLine."Line No."));
                    end;
                until Grec_PurchaseLine.NEXT() = 0;
        end;
    end;
}
