tableextension 50033 "BC6_ApprovalEntry" extends "Approval Entry" //545
{
    // 
    // //Modif LAB du 04/11/08
    // //mise en place forms non editables
    fields
    {
        field(50000; "BC6_Vendor Name"; Text[100])
        {
            CalcFormula = lookup("Purchase Header"."Pay-to Name" where("No." = field("Document No.")));
            Caption = 'Nom fournisseur';
            FieldClass = FlowField;
        }
    }

    procedure "BC6 ShowDocument"()
    var
        SalesHeader: Record "Sales Header";
        PurchHeader: Record "Purchase Header";
    begin
        case "Table ID" OF
            DATABASE::"Sales Header":
                begin
                    IF NOT SalesHeader.GET("Document Type", "Document No.") THEN
                        exit;
                    case "Document Type" OF
                        "Document Type"::Quote:
                            PAGE.RUN(PAGE::"Sales Quote", SalesHeader);
                        "Document Type"::Order:
                            PAGE.RUN(PAGE::"Sales Order", SalesHeader);
                        "Document Type"::Invoice:
                            PAGE.RUN(PAGE::"Sales Invoice", SalesHeader);
                        "Document Type"::"Credit Memo":
                            PAGE.RUN(PAGE::"Sales Credit Memo", SalesHeader);
                        "Document Type"::"Blanket Order":
                            PAGE.RUN(PAGE::"Blanket Sales Order", SalesHeader);
                        "Document Type"::"Return Order":
                            PAGE.RUN(PAGE::"Sales Return Order", SalesHeader);
                    end;
                end;
            DATABASE::"Purchase Header":
                begin
                    IF NOT PurchHeader.GET("Document Type", "Document No.") THEN
                        exit;
                    case "Document Type" OF
                        "Document Type"::Quote:
                            PAGE.RUN(PAGE::"Purchase Quote", PurchHeader);
                        "Document Type"::Order:
                            PAGE.RUN(PAGE::"Purchase Order", PurchHeader);
                        //Modif LAB du 04/11/08
                        //mise en place forms non editables
                        "Document Type"::Invoice:
                            PAGE.RUN(PAGE::"BC6_Purchase Invoice VSC", PurchHeader);
                        "Document Type"::"Credit Memo":
                            PAGE.RUN(PAGE::"BC6_Purchase Credit Memo VSC", PurchHeader);

                        //Fin Modif LAB du 04/11/08
                        "Document Type"::"Blanket Order":
                            PAGE.RUN(PAGE::"Blanket Purchase Order", PurchHeader);
                        "Document Type"::"Return Order":
                            PAGE.RUN(PAGE::"Purchase Return Order", PurchHeader);
                    end;
                end;
            else
                exit;
        end;
    end;

}

