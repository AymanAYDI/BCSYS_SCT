xmlport 50035 "BC6_Sales_CR.Memo_Export"
{
    Caption = 'Sales_CR.Memo_Export', Comment = 'FRA="Export_Avoirs_ventes"';
    Direction = Export;
    Encoding = UTF8;
    schema
    {
        textelement(root)
        {
            tableelement("Salescr.MemoHeader"; "Sales Cr.Memo Header")
            {
                RequestFilterFields = "No.", "Posting Date", "Bill-to Customer No.", "Sell-to Customer No.";
                SourceTableView = SORTING("No.") ORDER(Ascending);
                fieldelement("DocumentNo."; "Salescr.MemoHeader"."No.")
                {

                }
                textelement(TypeDoc)
                {

                }
                fieldelement(CustNo; "Salescr.MemoHeader"."Bill-to Customer No.")
                {

                }
                fieldelement(CustName; "Salescr.MemoHeader"."Bill-to Name")
                {

                }
                fieldelement(CustAddress1; "Salescr.MemoHeader"."Bill-to Address")
                {

                }
                fieldelement(CustAddress2; "Salescr.MemoHeader"."Bill-to Address 2")
                {

                }
                fieldelement(CustCity; "Salescr.MemoHeader"."Bill-to City")
                {

                }
                fieldelement(CustPostCode; "Salescr.MemoHeader"."Bill-to Post Code")
                {

                }
                fieldelement(CustCountry; "Salescr.MemoHeader"."Bill-to Country/Region Code")
                {

                }
                fieldelement(YourRef; "Salescr.MemoHeader"."Your Reference")
                {

                }
                textelement(UserMail)
                {
                    trigger OnBeforePassVariable()
                    begin
                        IF UserSetup.GET("Salescr.MemoHeader"."User ID") THEN
                            UserMail := UserSetup."E-Mail";

                        IF UserSetup.GET("Salescr.MemoHeader"."User ID") THEN BEGIN
                            // Gtext_UserName := UserSetup."User ID";
                            UserMail := UserSetup."E-Mail";
                        END ELSE BEGIN
                            //  Gtext_UserName := '';
                            UserMail := '';
                        END;
                    end;
                }
                fieldelement(Date; "Salescr.MemoHeader"."Posting Date")
                {

                }
                fieldelement(PostingDescription; "Salescr.MemoHeader"."Posting Description")
                {

                }
                fieldelement(Currency; "Salescr.MemoHeader"."Currency Code")
                {

                }
                fieldelement(HeaderAmount; "Salescr.MemoHeader".Amount)
                {

                }
                fieldelement(HeaderAmountWithVAT; "Salescr.MemoHeader"."Amount Including VAT")
                {

                }
                textelement(VATAMOUNTheader)
                {
                    trigger OnBeforePassVariable()
                    begin
                        VATAMOUNTheader := FORMAT("Salescr.MemoHeader"."Amount Including VAT" - "Salescr.MemoHeader".Amount);
                    end;
                }
                fieldelement(CustVATRegistration; "Salescr.MemoHeader"."VAT Registration No.")
                {

                }
                fieldelement("ExternalNo."; "Salescr.MemoHeader"."External Document No.")
                {

                }
                trigger OnAfterGetRecord()
                begin
                    GLEntry_G.RESET();
                    GLEntry_G.SETRANGE(GLEntry_G."Document No.", "Salescr.MemoHeader"."No.");
                    IF GLEntry_G.FINDSET() THEN
                        TypeDoc := FORMAT(GLEntry_G."Document Type");
                end;
            }
            tableelement("SalesCr.MemoLine"; "Sales Cr.Memo Line")
            {

                SourceTableView = SORTING("Document No.", "Line No.") ORDER(Ascending);
                LinkFields = "Document No." = FIELD("No.");
                LinkTable = "Salescr.MemoHeader";
                fieldelement("LineDocumentNo."; "SalesCr.MemoLine"."Document No.")
                {

                }
                fieldelement("LineLineNo."; "SalesCr.MemoLine"."Line No.")
                {

                }
                fieldelement(LineType; "SalesCr.MemoLine".Type)
                {

                }
                fieldelement("LineNo."; "SalesCr.MemoLine"."No.")
                {

                }
                fieldelement(LineDescription; "SalesCr.MemoLine".Description)
                {

                }
                fieldelement(LineQuantity; "SalesCr.MemoLine".Quantity)
                {

                }
                fieldelement(LineUnit; "SalesCr.MemoLine"."Unit of Measure")
                {

                }
                fieldelement(LineUnitPrice; "SalesCr.MemoLine"."Unit Price")
                {

                }
                fieldelement(LineVAT; "SalesCr.MemoLine"."VAT %")
                {

                }
                fieldelement(LineDiscountPercent; "SalesCr.MemoLine"."Line Discount %")
                {

                }
                fieldelement(LineDiscountAmount; "SalesCr.MemoLine"."Line Discount Amount")
                {

                }
                fieldelement(LineAmount; "SalesCr.MemoLine".Amount)
                {

                }
                fieldelement(LineAmountWithVAT; "SalesCr.MemoLine"."Amount Including VAT")
                {

                }
                textelement(VATAMOUNTline)
                {
                    trigger OnBeforePassVariable()
                    begin
                        VATAMOUNTline := FORMAT("SalesCr.MemoLine"."Amount Including VAT" - "SalesCr.MemoLine".Amount);
                    end;
                }
                fieldelement(LineCustomerVAT; "SalesCr.MemoLine"."VAT Bus. Posting Group")
                {

                }
                fieldelement(LineProductVAT; "SalesCr.MemoLine"."VAT Prod. Posting Group")
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
        GLEntry_G: Record "G/L Entry";
        UserSetup: Record "User Setup";
}
