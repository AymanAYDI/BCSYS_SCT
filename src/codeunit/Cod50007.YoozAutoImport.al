codeunit 50007 "BC6_Yooz Auto. Import"
{
    VAR
        YoozImport: Record "BC6_Yooz Import File";
        YoozImport2: Record "BC6_Yooz Import File";
        ImportXmlFile: File;
        XmlINStream: InStream;

    trigger OnRun()
    begin
        YoozImport.RESET();
        YoozImport.SETCURRENTKEY("Yooz Import", "Yooz Import Date");
        YoozImport.SETRANGE("Yooz Import", FALSE);
        YoozImport.SETFILTER("Yooz Import Date", '%1', 0D);
        IF YoozImport.FINDFIRST() THEN
            REPEAT
                ImportXmlFile.Open(YoozImport."File Name" + YoozImport."File Name 2");
                ImportXmlFile.CREATEINSTREAM(XmlINStream);
                XMLPORT.IMPORT(XmlPort::"BC6_Yz Pch. Inv.&CrM. Imp. Aut", XmlINStream);
                ImportXmlFile.CLOSE();
                YoozImport2.GET(YoozImport."Entry No.");
                YoozImport2."Yooz Import Date" := TODAY;
                YoozImport2.MODIFY();
            UNTIL YoozImport.NEXT() = 0;
    end;
}
