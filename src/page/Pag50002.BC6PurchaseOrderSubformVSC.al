page 50002 "BC6 Purchase Order Subform VSC"
{
    // Modif JX-LAB du 18/09/2008
    // Mise en visible des champs analytiques
    // 
    // Modif JX-LAB du 30/10/2008
    // Personalisation des colonnes visibles (uniquement pour les sociétés VSC et Agence)
    // 
    // //MODIF JX-XAD du 07/05/2009
    // //Autorisation de saisie du champ Quantité à condition que cette quantité soit inférieure à la quantité en cours
    // 
    // //MODIF JX-LAB du 25/08/2011
    // //rajout de la colonne quantité facturée
    // 
    // //Modif JX-VSC4.0-PBD du 26/01/15

    AutoSplitKey = true;
    Caption = 'Purchase Order Subform', Comment = 'FRA="Sous-form. commande achat"';
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableView = WHERE("Document Type" = FILTER(Order));

    layout
    {
        area(content)
        {
            repeater(Tableaulignes)
            {
                field(Type; "Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate();
                    end;
                }
                field("Cross-Reference No."; "Item Reference No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        GetPurchHeader();
                        ItemReferenceMgt.PurchaseReferenceNoLookUp(Rec, PurchHeader);
                        InsertExtendedText(FALSE);
                    end;

                    trigger OnValidate()
                    begin
                        CrossReferenceNoOnAfterValidat();
                    end;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
                    Editable = QuantityEditable;
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    BlankZero = true;
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    BlankZero = true;
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Line Discount Amount"; "Line Discount Amount")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Prepayment %"; "Prepayment %")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Prepmt. Line Amount"; "Prepmt. Line Amount")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Prepmt. Amt. Inv."; "Prepmt. Amt. Inv.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    Visible = true;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    Visible = true;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    Visible = true;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    Visible = true;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    Visible = true;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("ShortcutDimCode[9]"; ShortcutDimCode[9])
                {
                    CaptionClass = '1,2,9';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(9, ShortcutDimCode[9]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(9, ShortcutDimCode[9]);
                    end;
                }
                field("ShortcutDimCode[10]"; ShortcutDimCode[10])
                {
                    CaptionClass = '1,2,10';
                    Enabled = false;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(10, ShortcutDimCode[10]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(10, ShortcutDimCode[10]);
                    end;
                }
                field("Planned Receipt Date"; Rec."Planned Receipt Date")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Ligne")
            {
                Caption = '&Line', Comment = 'FRA="&Ligne"';
                Image = Line;
                group("Disponibilité article par")
                {
                    Caption = 'Item Availability by', Comment = 'FRA="Disponibilité article par"';
                    Image = ItemAvailability;
                    action("Événement")
                    {
                        Caption = 'Event', Comment = 'FRA="Événement"';
                        Image = "Event";
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByEvent())
                        end;
                    }
                    action("Période")
                    {
                        Caption = 'Period', Comment = 'FRA="Période"';
                        Image = Period;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByPeriod())
                        end;
                    }
                    action(Variante)
                    {
                        Caption = 'Variant', Comment = 'FRA="Variante"';
                        Image = ItemVariant;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByVariant())
                        end;
                    }
                    action(Magasin)
                    {
                        AccessByPermission = TableData Location = R;
                        Caption = 'Location', Comment = 'FRA="Magasin"';
                        Image = Warehouse;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByLocation())
                        end;
                    }
                    action("Niveau nomenclature")
                    {
                        Caption = 'BOM Level', Comment = 'FRA="Niveau nomenclature"';
                        Image = BOMLevel;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByBOM())
                        end;
                    }
                }
                action("Écritures réservation")
                {
                    AccessByPermission = TableData Item = R;
                    Caption = 'Reservation Entries', Comment = 'FRA="Écritures réservation"';
                    Image = ReservationLedger;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowReservationEntries(TRUE);
                    end;
                }
                action("Item Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines', Comment = 'FRA="Lignes &traçabilité"';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.OpenItemTrackingLines();
                    end;
                }
                action("Axes analytiques")
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions', Comment = 'FRA="Axes analytiques"';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions();
                    end;
                }
                action("Co&mmentaires")
                {
                    Caption = 'Co&mments', Comment = 'FRA="Co&mmentaires"';
                    Image = ViewComments;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowLineComments();
                    end;
                }
                action(ItemChargeAssignment)
                {
                    AccessByPermission = TableData "Item Charge" = R;
                    Caption = 'Item Charge &Assignment', Comment = 'FRA="&Affectation frais annexes"';
                    Image = Action;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowItemChargeAssgnt();
                    end;
                }
            }
            group("Fonction&s")
            {
                Caption = 'F&unctions', Comment = 'FRA="=Fonction&s"';
                Image = "Action";
                action("&Eclater nomenclature")
                {
                    AccessByPermission = TableData "BOM Component" = R;
                    Caption = 'E&xplode BOM', Comment = 'FRA="&Eclater nomenclature"';
                    Image = ExplodeBOM;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ExplodeBOM();
                    end;
                }
                action("Insert Ext. Texts")
                {
                    AccessByPermission = TableData "Extended Text Header" = R;
                    Caption = 'Insert &Ext. Texts', Comment = 'FRA="Insérer te&xtes étendus"';
                    Image = Text;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        InsertExtendedText(TRUE);
                    end;
                }
                action(Reserve)
                {
                    Caption = '&Reserve', Comment = 'FRA="&Réserver"';
                    Ellipsis = true;
                    Image = Reserve;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.FIND();
                        Rec.ShowReservation();
                    end;
                }
                action(OrderTracking)
                {
                    Caption = 'Order &Tracking', Comment = 'FRA="C&haînage"';
                    Image = OrderTracking;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ShowTracking();
                    end;
                }
            }
            group("&Commande")
            {
                Caption = 'O&rder', Comment = 'FRA="&Commande"';
                Image = "Order";
                group("Livraison &directe")
                {
                    Caption = 'Dr&op Shipment', Comment = 'FRA="Livraison &directe"';
                    Image = Delivery;
                    action("Commande &vente")
                    {
                        AccessByPermission = TableData "Sales Shipment Header" = R;
                        Caption = 'Sales &Order', Comment = 'FRA="Commande &vente"';
                        Image = Document;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            OpenSalesOrderForm();
                        end;
                    }
                }
                group("C&ommande spéciale")
                {
                    Caption = 'Speci&al Order', Comment = 'FRA="C&ommande spéciale"';
                    Image = SpecialOrder;
                    action(Action1000000001)
                    {
                        AccessByPermission = TableData "Sales Shipment Header" = R;
                        Caption = 'Sales &Order', Comment = 'FRA="Commande &vente"';
                        Image = Document;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            OpenSpecOrderSalesOrderForm();
                        end;
                    }
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
    begin
        IF (Rec.Quantity <> 0) AND Rec.ItemExists(Rec."No.") THEN BEGIN
            COMMIT();
            IF NOT ReservePurchLine.DeleteLineConfirm(Rec) THEN
                EXIT(FALSE);
            ReservePurchLine.DeleteLine(Rec);
        END;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //DEBUT MODIF JX-XAD 30/04/2009
        IF Rec.Quantity > xRec.Quantity THEN
            ERROR(Text001, Rec.Type, Rec."No.", Rec."Line No.", xRec.Quantity)
        ELSE
            IF Rec.Quantity < xRec.Quantity THEN
                IF NOT CONFIRM(Text002, FALSE, Rec.Type, Rec."No.", Rec."Line No.", Rec.Quantity) THEN
                    ERROR(Text003);
        //FIN MODIF JX-XAD 30/04/2009
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := xRec.Type;
        CLEAR(ShortcutDimCode);
    end;

    trigger OnOpenPage()
    begin
        //DEBUT MODIF JX-XAD 30/04/2009
        QuantityEditable := ((COMPANYNAME <> 'VSCT') AND (COMPANYNAME <> 'VSCT Test'));
        //FIN MODIF JX-XAD 30/04/2009
    end;

    var
        PurchHeader: Record "Purchase Header";
        DocumentTotals: Codeunit "Document Totals";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        ItemReferenceMgt: Codeunit "Item Reference Management";
        PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        [InDataSet]
        QuantityEditable: Boolean;
        ShortcutDimCode: array[10] of Code[20];
        Text001: Label 'Error on %1 %2 line %3 !\\The quantity must be less than or equal to % %4', Comment = 'FRA="Erreur sur %1 %2 ligne %3 !\\La quantité doit être inférieure ou égale à %4"';
        Text002: Label 'Warning! The quantity was modified on %1 %2 line %3\\ This operation is irreversible. The quantity can be changed with a value greater than %4.Do you confirm this new quantity ?', Comment = 'FRA="Attention ! La quantité a été modifiée sur %1 %2 ligne %3\\Cette opération est irréversible.\\La quantité ne pourra plus être modifiée avec une valeur supérieure à %4.\\Confirmez-vous cette nouvelle quantité ?"';
        Text003: Label 'Change in the quantity canceled!', Comment = 'FRA="Modification de la quantité annulée !"';

    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Disc. (Yes/No)", Rec);
    end;

    procedure CalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Calc.Discount", Rec);
    end;

    local procedure ExplodeBOM()
    begin
        if Rec."Prepmt. Amt. Inv." <> 0 then
            Error(Text001);
        CODEUNIT.Run(CODEUNIT::"Purch.-Explode BOM", Rec);
        DocumentTotals.PurchaseDocTotalsNotUpToDate();
    end;

    local procedure OpenSalesOrderForm()
    var
        SalesHeader: Record "Sales Header";
        SalesOrder: Page "Sales Order";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if IsHandled then
            exit;

        Rec.TestField("Sales Order No.");
        SalesHeader.SetRange("No.", Rec."Sales Order No.");
        SalesOrder.SetTableView(SalesHeader);
        SalesOrder.Editable := false;
        SalesOrder.Run();
    end;

    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        IF TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
            CurrPage.SAVERECORD();
            TransferExtendedText.InsertPurchExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate() THEN
            UpdateForm(TRUE);
    end;

    procedure ShowReservationEntries()
    begin
        Rec.ShowReservationEntries(TRUE);
    end;

    procedure ShowTracking()
    var
        TrackingForm: Page "Order Tracking";
    begin
        TrackingForm.SetPurchLine(Rec);
        TrackingForm.RUNMODAL();
    end;

    procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt();
    end;


    procedure OpenSpecOrderSalesOrderForm()
    var
        SalesHeader: Record "Sales Header";
        SalesOrder: Page "Sales Order";
    begin
        Rec.TESTFIELD("Special Order Sales No.");
        SalesHeader.SETRANGE("No.", Rec."Special Order Sales No.");
        SalesOrder.SETTABLEVIEW(SalesHeader);
        SalesOrder.EDITABLE := FALSE;
        SalesOrder.RUN();
    end;

    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;

    procedure ShowPrices()
    begin
        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLinePrice(PurchHeader, Rec);
    end;

    procedure ShowLineDisc()
    begin
        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLineLineDisc(PurchHeader, Rec);
    end;


    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(FALSE);
        IF (Rec.Type = Rec.Type::"Charge (Item)") AND (Rec."No." <> xRec."No.") AND
           (xRec."No." <> '')
        THEN
            CurrPage.SAVERECORD();
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    begin
        InsertExtendedText(FALSE);
    end;
}

