reportextension 50001 "BC6_BatchPostSalesCreditMemos" extends "Batch Post Sales Credit Memos"
{
    dataset
    {
        modify("Sales Header")
        {
            trigger OnAfterAfterGetRecord()
            var
                Lrec_SalesLine: Record "Sales Line";
                Lrec_Dimension: Record Dimension;
                Lrec_DimensionValue: Record "Dimension Value";
                Lcu_Dimension: Codeunit BC6_FunctionsMgt;
                LCode_DimCode: ARRAY[50] OF Code[20];
                LCode_DimValueCode: ARRAY[50] OF Code[20];
                Lint_Compteur: Integer;
                Lcode_AxeReserve: Code[10];
            begin
                //DEBUT MODIF JX XAD 16/03/2011 (traitement modification analytique manuelle post validation)
                Lcode_AxeReserve := 'RESERVE';
                IF Lrec_Dimension.GET(Lcode_AxeReserve) THEN
                    // On initialise, si n‚cessaire, les sections de l'axe analytique 'RESERVE'
                    IF NOT Lrec_DimensionValue.GET(Lcode_AxeReserve, '100') THEN
                        FOR Lint_Compteur := 1 TO 100 DO
                            IF NOT Lrec_DimensionValue.GET(Lcode_AxeReserve, FORMAT(Lint_Compteur)) THEN BEGIN
                                Lrec_DimensionValue.INIT();
                                Lrec_DimensionValue.VALIDATE(Lrec_DimensionValue."Dimension Code", Lcode_AxeReserve);
                                Lrec_DimensionValue.VALIDATE(Lrec_DimensionValue.Code, FORMAT(Lint_Compteur));
                                Lrec_DimensionValue.INSERT();
                            END;
                // Traitement de l'axe analytique 'RESERVE' pour chaque ligne du document
                IF ("Document Type" IN ["Document Type"::Invoice, "Document Type"::"Credit Memo", "Document Type"::Order]) THEN BEGIN
                    Lrec_SalesLine.RESET();
                    Lrec_SalesLine.SETFILTER(Lrec_SalesLine."Document Type", '%1', "Document Type");
                    Lrec_SalesLine.SETFILTER(Lrec_SalesLine."Document No.", '%1', "No.");
                    Lrec_SalesLine.SETFILTER(Lrec_SalesLine.Type, '<>%1', Lrec_SalesLine.Type::" ");
                    Lrec_SalesLine.SETFILTER(Lrec_SalesLine."No.", '<>%1', '');
                    Lint_Compteur := 0;
                    IF Lrec_SalesLine.FIND('-') THEN
                        REPEAT
                            Lint_Compteur += 1;
                            LCode_DimCode[1] := Lcode_AxeReserve;
                            LCode_DimValueCode[1] := FORMAT(Lint_Compteur);
                            Lrec_SalesLine."Dimension Set ID" := Lcu_Dimension.SetNewDimIDSpec(Lrec_SalesLine."Dimension Set ID", Lrec_SalesLine."Shortcut Dimension 1 Code",
                                                          Lrec_SalesLine."Shortcut Dimension 2 Code", LCode_DimCode, LCode_DimValueCode);
                            Lrec_SalesLine.MODIFY();
                        UNTIL Lrec_SalesLine.NEXT() = 0;
                    COMMIT();
                END;
                //FIN MODIF JX XAD 16/03/2011 (traitement modification analytique manuelle post validation)
            end;
        }
    }
}
