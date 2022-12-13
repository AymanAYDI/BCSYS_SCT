xmlport 50033 "BC6_Yooz Export Vendor"
{
    Caption = 'BC6 Yooz Export Vendor', Comment = 'FRA="Yooz Export fournisseurs"';
    Direction = Export;
    Format = VariableText;
    TextEncoding = WINDOWS;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    TableSeparator = '<NewLine>';
    UseRequestPage = false;
    FileName = '*.csv';

    schema
    {
        textelement(root)
        {
            tableelement("Header"; Integer)
            {
                textattribute(GTextHeader)
                {
                }

                trigger OnPreXMLItem()
                begin
                    Header.SETRANGE(Number, 1, 2);
                end;

                trigger OnAfterGetRecord()
                begin
                    if Header.Number = 1 then
                        GTextHeader := 'v20120430'
                    else
                        GTextHeader := 'SUPPLIER_TAB';
                end;
            }
            tableelement("Vendor"; "Vendor")
            {
                fieldattribute(No; Vendor."No.")
                {
                }
                fieldattribute(Name; Vendor.Name)
                {
                }
                fieldattribute(VAT; Vendor."VAT Registration No.")
                {
                }
                fieldattribute(Phone; Vendor."Phone No.")
                {
                }
                fieldattribute(FAX; Vendor."FAX No.")
                {
                }
                fieldattribute(Home; Vendor."Home Page")
                {
                }
                fieldattribute(Address; Vendor.Address)
                {
                }
                fieldattribute(Address2; Vendor."Address 2")
                {
                }
                fieldattribute(PostCode; Vendor."Post Code")
                {
                }
                fieldattribute(City; Vendor.City)
                {
                }
                fieldattribute(Country; Vendor."Country/Region Code")
                {
                }
                fieldattribute(Contact; Vendor.Contact)
                {
                }
                fieldattribute(Registration; Vendor."BC6_Registration No.")
                {
                }
                textelement(GTextBlank1)
                {
                }
                textelement(GTextBlank2)
                {
                }
                textelement(GTextBlank3)
                {
                }
                textelement(GTextBlank4)
                {
                }
                textelement(GTextBlank5)
                {
                }
                textelement(GTextBlank6)
                {
                }
                textelement(GTextBlank7)
                {
                }
                textelement(GTextBlank8)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    Vendor.Address := "Gcu_ANSI-ASCII".Ascii2Ansi(Vendor.Address);
                    Vendor.Name := "Gcu_ANSI-ASCII".Ascii2Ansi(Vendor.Name);
                end;
            }
        }
    }

    var
        Grec_YoozParameters: Record "BC6_Yooz Parameters";
        "Gcu_ANSI-ASCII": Codeunit "BC6_ANSI_ASCII converter";
        Text001: label 'Export vendor has been realized in folder %1', Comment = 'FRA="L''export des fournisseurs s''est bien effectué dans le dossier %1"';
        GTextBlank: Text[2];
        Gtext_PathFolder: Text[250];

    trigger OnPreXMLport()
    var
        Gtext_PathFolder: text[250];
    begin
        Grec_YoozParameters.GET();
        Gtext_PathFolder := Grec_YoozParameters."Yooz Export Path" + '\' +
        FORMAT(CURRENTDATETIME, 0, '<Year><Month,2><Day,2><Hours24><Minutes,2><Seconds,2>') + '_Yooz_Export_Vendors.csv';

        currXMLport.FILENAME := Gtext_PathFolder;

        GTextBlank := '';
    end;

    trigger OnPostXMLport()
    var

    begin
        MESSAGE(STRSUBSTNO(Text001, CONVERTSTR(Gtext_PathFolder, '\', '>')))
    end;
}
