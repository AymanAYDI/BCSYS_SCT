xmlport 50030 "BC6_Import Purchase Receipt"
{
    Caption = 'Import Purchase Receipt';
    Direction = Import;
    Format = VariableText;
    FieldSeparator = ';';
    UseRequestPage = false;
    FileName = '*.csv';
    schema
    {
        textelement(Root)
        {
            tableelement(ImportRecept; Integer)
            {
                AutoSave = false;
                AutoUpdate = false;
                AutoReplace = false;
                textelement(Gcode_OrderNo)
                {
                }
                textelement(Gtext_LineNo)
                {
                }
                textelement(Gdec_Quantity)
                {
                }

                trigger OnBeforeInsertRecord()
                BEGIN
                    Gint_CompteurLigne += 1;
                    IF Gint_CompteurLigne > 1 THEN
                        //recherche de la commande
                        IF Grec_PurchHeader.GET(Grec_PurchHeader."Document Type"::Order, Gcode_OrderNo) THEN BEGIN
                            EVALUATE(Gint_LineNo, Gtext_LineNo);
                            //recherche si la ligne de la commande existe
                            IF Grec_PurchLine.GET(Grec_PurchHeader."Document Type"::Order, Gcode_OrderNo, Gint_LineNo) THEN
                                IF NOT (Grec_PurchLine."Quantity Received" <> 0) THEN BEGIN
                                    IF Grec_PurchLine.Type <> Grec_PurchLine.Type::Item THEN
                                        ERROR(STRSUBSTNO(Text004, Gcode_OrderNo, Gint_LineNo));

                                    //si le statut est lanc‚, il faut rouvrir la commande
                                    IF Grec_PurchHeader.Status = Grec_PurchHeader.Status::Released THEN
                                        ReleasePurchDoc.PerformManualReopen(Grec_PurchHeader);

                                    //mettre toutes les quantit‚s … recevoir … 0 si la commande a plusieurs lignes
                                    Grec_PurchLine2.SETFILTER(Grec_PurchLine2."Document Type", FORMAT(Grec_PurchLine2."Document Type"::Order));
                                    IF Grec_PurchLine2.FIND('-') THEN
                                        REPEAT
                                            IF NOT (Grec_PurchLine2."Quantity Received" <> 0) THEN BEGIN
                                                Grec_PurchLine2.VALIDATE("Qty. to Receive", 0);
                                                Grec_PurchLine2.MODIFY();
                                            END;
                                        UNTIL Grec_PurchLine2.NEXT() = 0;

                                    //modification de la quantit‚ de la ligne
                                    Grec_PurchLine.GET(Grec_PurchHeader."Document Type"::Order, Gcode_OrderNo, Gint_LineNo);
                                    EVALUATE(Grec_PurchLine.Quantity, FORMAT(Gdec_Quantity));
                                    Grec_PurchLine.VALIDATE(Quantity, Grec_PurchLine.Quantity);
                                    Grec_PurchLine.MODIFY();

                                    //changement de la date de comptabilisation afin de permettre la r‚ception automatique
                                    Grec_PurchHeader."Posting Date" := TODAY;
                                    Grec_PurchHeader.VALIDATE(Grec_PurchHeader.Receive, TRUE);
                                    Grec_PurchHeader.MODIFY();

                                    //r‚ception automatique
                                    CODEUNIT.RUN(CODEUNIT::"Purch.-Post", Grec_PurchHeader);

                                END ELSE
                                    //ERROR(STRSUBSTNO(Text003,Gcode_OrderNo,Gint_LineNo));
                                    //ou mettre ici un message non bloquant disant que cette ligne ne sera
                                    //pas prise en compte, et le fichier en cas d'erreur sur une des ligne pourra ˆtre repasser.
                                    MESSAGE(STRSUBSTNO(Text003, Gcode_OrderNo, Gint_LineNo))
                            ELSE
                                ERROR(STRSUBSTNO(Text002, Gcode_OrderNo, Gint_LineNo));
                        END ELSE
                            ERROR(STRSUBSTNO(Text001, Gcode_OrderNo));
                END;
            }
        }
    }
    trigger OnPostXMLport()
    BEGIN
        MESSAGE('L''import est terminé');
    END;

    VAR
        Grec_PurchHeader: Record "Purchase Header";
        Grec_PurchLine: Record "Purchase Line";
        Grec_PurchLine2: Record "Purchase Line";
        ReleasePurchDoc: Codeunit "Release Purchase Document";
        Gint_LineNo: Decimal;
        Gint_CompteurLigne: Integer;
        Text001: Label 'Import error: Could not find the command %1', Comment = 'FRA="Erreur import: Impossible de trouver la commande %1"';
        Text002: Label 'Import error: Could not find line %2 of command %1', Comment = 'FRA="Erreur import: Impossible de trouver la ligne %2 de la commande %1"';
        Text003: Label '"Warning: Line %2 of command %1 has already been received, it will not be taken into account"', Comment = 'FRA="Attention : La ligne %2 de la commande %1 a déjà été reçue, elle ne sera pas prise en compte"';
        Text004: Label 'Import error: Line %2 of command %1 is not a line of type Article', Comment = 'FRA="Erreur import: La ligne %2 de la commande %1 n''est pas une ligne de type Article"';



}
