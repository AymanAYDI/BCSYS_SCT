report 50061 "Modifier axes facture ventes"
{
    // JX-AUD 24/05/2011
    // Modification des axes analytiques pour les factures enregistrées
    // 
    // JX-AUD 25/05/2011
    // Modification sur la visibilité des axes analytiques s'ils existent

    Caption = 'Modify invoice dimensions', Comment = 'FRA="Modifier axes facture ventes"';
    Permissions = TableData "G/L Entry" = rm,
                  TableData "Sales Invoice Line" = rm,
                  TableData "FA Ledger Entry" = rm,
                  TableData "Value Entry" = rm;
    ProcessingOnly = true;
    UseRequestPage = false;
    UseSystemPrinter = false;

    dataset
    {
        dataitem(DataItem1570; "Sales Invoice Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.");
            dataitem(DataItem7069; "G/L Entry")
            {
                DataItemLink = "Document No." = FIELD("Document No.");
                DataItemTableView = SORTING("Document No.", "Posting Date");

                trigger OnAfterGetRecord()
                begin
                    IF Grec_GLEntry.GET("Entry No.") THEN BEGIN
                        Grec_GLEntry."Dimension Set ID" := Gnew_DimSetID;
                        Grec_GLEntry.MODIFY();
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    Window.UPDATE(1, 'Phase 1/3 G/L Entry');
                    SETRANGE("Dimension Set ID", Gold_DimSetID);
                end;
            }
            dataitem(DataItem8894; "Value Entry")
            {
                DataItemLink = "Document No." = FIELD("Document No."), "Document Line No." = FIELD("Line No.");
                DataItemTableView = SORTING("Document No.");

                trigger OnAfterGetRecord()
                begin
                    IF Grec_ValueEntry.GET("Entry No.") THEN BEGIN
                        Grec_ValueEntry."Dimension Set ID" := Gnew_DimSetID;
                        Grec_ValueEntry.MODIFY();
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    Window.UPDATE(1, 'Phase 2/3 Value Entry');
                end;
            }
            dataitem(DataItem9888; "FA Ledger Entry")
            {
                DataItemLink = "Document No." = FIELD("Document No."), "FA No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Posting Date");

                trigger OnAfterGetRecord()
                begin
                    IF Grec_FALedgerEntry.GET("Entry No.") THEN BEGIN
                        Grec_FALedgerEntry."Dimension Set ID" := Gnew_DimSetID;
                        Grec_FALedgerEntry.MODIFY();
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    Window.UPDATE(1, 'Phase 3/3 FA Ledger Entry');
                    SETRANGE("Dimension Set ID", Gold_DimSetID);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Gcode_AxeReserveLigneFacture := '';
                IF Grec_DimSetEntry.GET("Dimension Set ID", Gcode_AxeReserve) THEN
                    Gcode_AxeReserveLigneFacture := Grec_DimSetEntry."Dimension Value Code";

                IF Gcode_AxeReserveLigneFacture = '' THEN
                    IF NOT CONFIRM(Text006) THEN
                        ERROR(Text002);

                "Dimension Set ID" := Gnew_DimSetID;
                MODIFY();
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Document No.", '%1', Gcode_DocumentNo);
                SETFILTER("Line No.", '%1', Gcode_LineNo);
            end;
        }
    }

    trigger OnInitReport()
    var
        Lrec_Dimension: Record Dimension;
    // Lrec_DimensionValue: Record "Dimension Value";
    // Lint_CompteurSection: Integer;
    begin
        //Test existence axe analytique
        Gcode_AxeReserve := 'RESERVE';
        IF NOT Lrec_Dimension.GET(Gcode_AxeReserve) THEN
            ERROR(Text005);
    end;

    trigger OnPostReport()
    begin
        Window.CLOSE();
    end;

    trigger OnPreReport()
    begin
        Window.OPEN('#1########################');
    end;

    var
        Grec_DimSetEntry: Record "Dimension Set Entry";
        Grec_FALedgerEntry: Record "FA Ledger Entry";
        Grec_GLEntry: Record "G/L Entry";
        Grec_ValueEntry: Record "Value Entry";
        Gcode_AxeReserve: Code[20];
        Gcode_AxeReserveLigneFacture: Code[20];
        Gcode_DocumentNo: Code[20];
        Gcode_ItemNo: Code[20];
        Window: Dialog;
        Gcode_LineNo: Integer;
        Gnew_DimSetID: Integer;
        Gold_DimSetID: Integer;
        Text002: Label 'Operation canceled !', Comment = 'FRA="Opération annulée !"';
        Text005: Label 'To use the change function of analytics, you must create an analytical axis named ''RESERVE''', Comment = 'FRA="Pour utiliser la fonction de modification de l''analytique,\\vous devez créer un axe analytique nommé ''RESERVE''"';
        Text006: Label 'This document was created before the introduction of the modified analytical functionality.\\The accounting entries will not be updated.\\Would you still continue?', Comment = 'FRA="Ce document a été créé avant la mise en place de la fonctionnalité de modification analytique.\\Les écritures comptables ne pourront pas être mises à jour.\\Souhaitez-vous tout de même poursuivre ?"';

    procedure SetPostedInvoice(Prec_SalesInvLine: Record "Sales Invoice Line"; pi_NewDimSetID: Integer)
    begin
        Gcode_DocumentNo := Prec_SalesInvLine."Document No.";
        Gcode_LineNo := Prec_SalesInvLine."Line No.";
        Gcode_ItemNo := Prec_SalesInvLine."No.";
        Gnew_DimSetID := pi_NewDimSetID;
        Gold_DimSetID := Prec_SalesInvLine."Dimension Set ID";
    end;
}

