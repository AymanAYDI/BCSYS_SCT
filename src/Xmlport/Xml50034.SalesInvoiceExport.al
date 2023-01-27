xmlport 50034 "BC6_Sales_Invoice_Export"
{
    Caption = 'Sales_Invoice_Export', Comment = 'FRA="Export_factures_ventes"';
    Direction = Export;
    Encoding = UTF8;
    schema
    {
        textelement(root)
        {
            tableelement(SalesInvoiceHeader; "Sales Invoice Header")
            {
                RequestFilterFields = "No.", "Posting Date";
                SourceTableView = SORTING("No.") ORDER(Ascending);
                fieldelement("DocumentNo."; SalesInvoiceHeader."No.")
                {
                }
                textelement(TypeDoc)
                {
                }
                fieldelement(CustNo; SalesInvoiceHeader."Bill-to Customer No.")
                {
                }
                fieldelement(CustName; SalesInvoiceHeader."Bill-to Name")
                {
                }
                fieldelement(CustAddress1; SalesInvoiceHeader."Bill-to Address")
                {
                }
                fieldelement(CustAddress2; SalesInvoiceHeader."Bill-to Address 2")
                {
                }
                fieldelement(CustCity; SalesInvoiceHeader."Bill-to City")
                {
                }
                fieldelement(CustPostCode; SalesInvoiceHeader."Bill-to Post Code")
                {
                }
                fieldelement(CustCountry; SalesInvoiceHeader."Bill-to Country/Region Code")
                {
                }
                fieldelement(YourRef; SalesInvoiceHeader."Your Reference")
                {
                }
                textelement(UserMail)
                {
                    trigger OnBeforePassVariable()
                    begin
                        IF UserSetup.GET(SalesInvoiceHeader."User ID") THEN
                            UserMail := UserSetup."E-Mail";
                        // IF UserSetup.GET(SalesInvoiceHeader."User ID") THEN
                        //     UserMail := UserSetup."E-Mail"
                        // // Gtext_UserName := UserSetup."User ID";
                        // ELSE
                        //     // Gtext_UserName := '';
                        //     UserMail := '';
                    end;
                }
                fieldelement(Date; SalesInvoiceHeader."Document Date")
                {

                }
                fieldelement(PostingDescription; SalesInvoiceHeader."Posting Description")
                {

                }
                fieldelement(Currency; SalesInvoiceHeader."Currency Code")
                {

                }
                fieldelement("OrderNo."; SalesInvoiceHeader."Order No.")
                {

                }
                fieldelement(HeaderAmount; SalesInvoiceHeader.Amount)
                {

                }
                fieldelement(HeaderAmountWithVAT; SalesInvoiceHeader."Amount Including VAT")
                {

                }
                textelement(VATAMOUNTheader)
                {
                    trigger OnBeforePassVariable()
                    begin
                        VATAMOUNTheader := FORMAT(SalesInvoiceHeader."Amount Including VAT" - SalesInvoiceHeader.Amount);
                    end;
                }
                fieldelement(CustVATRegistration; SalesInvoiceHeader."VAT Registration No.")
                {

                }
                fieldelement("ExternalNo."; SalesInvoiceHeader."External Document No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    GLEntry_G.RESET();
                    GLEntry_G.SETRANGE(GLEntry_G."Document No.", SalesInvoiceHeader."No.");
                    IF GLEntry_G.FINDSET() THEN
                        TypeDoc := FORMAT(GLEntry_G."Document Type");
                end;
            }
            tableelement(SalesInvoiceLines; "Sales Invoice Line")
            {
                SourceTableView = SORTING("Document No.", "Line No.") ORDER(Ascending) WHERE(Type = FILTER(<> ' '), Quantity = FILTER(<> 0));
                LinkFields = "Document No." = field("No.");
                LinkTable = SalesInvoiceHeader;
                fieldelement("LineDocumentNo."; SalesInvoiceLines."Document No.")
                {

                }
                fieldelement("LineLineNo."; SalesInvoiceLines."Line No.")
                {

                }
                fieldelement(LineType; SalesInvoiceLines.Type)
                {

                }
                fieldelement("LineNo."; SalesInvoiceLines."No.")
                {

                }
                fieldelement(LineDescription; SalesInvoiceLines.Description)
                {

                }
                fieldelement(LineQuantity; SalesInvoiceLines.Quantity)
                {

                }
                fieldelement(LineUnit; SalesInvoiceLines."Unit of Measure")
                {

                }
                fieldelement(LineUnitPrice; SalesInvoiceLines."Unit Price")
                {

                }
                fieldelement(LineVAT; SalesInvoiceLines."VAT %")
                {

                }
                fieldelement(LineDiscountPercent; SalesInvoiceLines."Line Discount %")
                {

                }
                fieldelement(LineDicountAmount; SalesInvoiceLines."Line Discount Amount")
                {

                }
                fieldelement(LineAmount; SalesInvoiceLines.Amount)
                {

                }

                fieldelement(LineAmountWithVAT; SalesInvoiceLines."Amount Including VAT")
                {

                }
                textelement(VATAMOUNTline)
                {
                    trigger OnBeforePassVariable()
                    begin
                        VATAMOUNTline := FORMAT(SalesInvoiceLines."Amount Including VAT" - SalesInvoiceLines.Amount);
                    end;
                }
                fieldelement(LineCustomerVAT; SalesInvoiceLines."VAT Bus. Posting Group")
                {

                }
                fieldelement(LineProductVAT; SalesInvoiceLines."VAT Prod. Posting Group")
                {

                }
            }
            tableelement(CompanyInformation; "Company Information")
            {
                fieldelement(Name; CompanyInformation.Name)
                {

                }
                fieldelement(Adress; CompanyInformation.Address)
                {

                }
                fieldelement(Adress2; CompanyInformation."Address 2")
                {

                }
                fieldelement(PostCode; CompanyInformation."Post Code")
                {

                }
                fieldelement(City; CompanyInformation.City)
                {

                }
                fieldelement(CountryPays_Region; CompanyInformation."Country/Region Code")
                {

                }
                fieldelement(VATRegistaration; CompanyInformation."VAT Registration No.")
                {

                }
                fieldelement(IBAN; CompanyInformation.IBAN)
                {

                }
                fieldelement("RegistrationNo."; CompanyInformation."Registration No.")
                {

                }
            }
        }
    }
    VAR
        Grec_CompanyInfo: Record "Company Information";
        GLEntry_G: Record "G/L Entry";
        UserSetup: Record "User Setup";

    trigger OnInitXMLport()
    var
    begin
        Grec_CompanyInfo.GET();
    end;

}
