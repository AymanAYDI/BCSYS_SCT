report 50039 "BC6_Modifier axes réception"
{
    // JX-XAD 24/03/2010
    // Modification des axes analyutiques pour les factures enregistrées
    // 
    // JX-AUD 25/05/2011
    // Modification sur la visibilité des axes analytiques s'ils existent

    Caption = 'Modify invoice dimensions', Comment = 'FRA="Modifier axes facture"';
    Permissions = TableData "Item Ledger Entry" = rm,
                  TableData "Purch. Rcpt. Line" = rm,
                  TableData "Value Entry" = rm;
    ProcessingOnly = true;
    UseRequestPage = false;
    UseSystemPrinter = false;

    dataset
    {
        dataitem(DataItem5707; "Purch. Rcpt. Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.");
            dataitem(DataItem7069; "Item Ledger Entry")
            {
                DataItemLink = "Document No." = FIELD("Document No.");
                DataItemTableView = SORTING("Entry No.");

                trigger OnAfterGetRecord()
                begin
                    "Dimension Set ID" := Gnew_DimSetID;
                    MODIFY();
                end;

                trigger OnPreDataItem()
                begin
                    Window.UPDATE(1, 'Phase 1/2 Item Ledger Entry');
                end;
            }
            dataitem(DataItem8894; "Value Entry")
            {
                DataItemLink = "Document No." = FIELD("Document No."), "Document Line No." = FIELD("Line No.");
                DataItemTableView = SORTING("Entry No.");

                trigger OnAfterGetRecord()
                begin
                    "Dimension Set ID" := Gnew_DimSetID;
                    MODIFY();
                end;

                trigger OnPreDataItem()
                begin
                    Window.UPDATE(1, 'Phase 2/2 Value Entry');
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
            end;

            trigger OnPostDataItem()
            begin
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
        Lint_CompteurSection: Integer;
        Lrec_DimensionValue: Record "Dimension Value";
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
        Text001: Label 'All accounting will be updated to the invoice %1', Comment = 'FRA="Toute la comptabilité analytique sera mise à jour pour la facture %1"';
        Text002: Label 'Operation canceled !', Comment = 'FRA="Opération annulée !"';
        Text003: Label 'Posted invoice No. : ', Comment = 'FRA="Facture enregistrée n° : "';
        Gcode_DocumentNo: Code[20];
        Gcode_LineNo: Integer;
        Gcode_ItemNo: Code[20];
        Text004: Label 'Error ! line is empty', Comment = 'FRA="Erreur ! cette ligne est vide"';
        Text005: Label 'To use the change function of analytics, you must create an analytical axis named ''RESERVE''', Comment = 'FRA="Pour utiliser la fonction de modification de l''analytique,\\vous devez créer un axe analytique nommé ''RESERVE''"';
        Text006: Label 'This document was created before the introduction of the modified analytical functionality.\\The accounting entries will not be updated.\\Would you still continue?', Comment = 'FRA="Ce document a été créé avant la mise en place de la fonctionnalité de modification analytique.\\Les écritures comptables ne pourront pas être mises à jour.\\Souhaitez-vous tout de même poursuivre ?"';
        Text007: Label 'Invoice', Comment = 'FRA="Facture"';
        Text008: Label 'No.', Comment = 'FRA="N°"';
        Gcode_AxeReserve: Code[20];
        Gcode_AxeReserveLigneFacture: Code[20];
        Gnew_DimSetID: Integer;
        Window: Dialog;

    procedure SetPostedInvoice(Prec_PurchRcptLine: Record "Purch. Rcpt. Line"; pi_NewDimSetID: Integer)
    begin
        Gcode_DocumentNo := Prec_PurchRcptLine."Document No.";
        Gcode_LineNo := Prec_PurchRcptLine."Line No.";
        Gcode_ItemNo := Prec_PurchRcptLine."No.";
        Gnew_DimSetID := pi_NewDimSetID;
    end;
}

