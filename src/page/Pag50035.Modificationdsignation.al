page 50035 "BC6_Modification désignation"
{
    Caption = 'Modify description', Comment = 'FRA="Modification désignation"';
    PageType = List;
    Permissions = tabledata "Sales Invoice Line" = rm,
                  tabledata "Sales Cr.Memo Line" = rm;
    SourceTable = "Integer";

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                label(Control1000000002)
                {
                    CaptionClass = FORMAT(Gtext_TypeDocument + ' : ' + Gcode_DocumentNo + '          ' + Gtext_No + '  ' + Gcode_ItemNo);
                    ShowCaption = false;
                    Style = Standard;
                    StyleExpr = true;
                }
                field(Designation; Gtext_Designation)
                {
                    Caption = 'Description', Comment = 'FRA="Désignation"';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Ok)
            {
                Caption = 'Ok', Comment = 'FRA="Ok"';
                ApplicationArea = All;
                Image = Action;

                trigger OnAction()
                begin

                    //TEST sur le type de document Text001: Facture Text003 : Avoir
                    if Gtext_TypeDocument = Text001 then
                        if Grec_SalesInvLine.GET(Gcode_DocumentNo, Gcode_LineNo) then begin
                            Grec_SalesInvLine.Description := Gtext_Designation;
                            Grec_SalesInvLine.MODIFY();
                            CurrPage.CLOSE();
                        end;

                    if Gtext_TypeDocument = Text003 then
                        if Grec_SalesCrMemoLine.GET(Gcode_DocumentNo, Gcode_LineNo) then begin
                            Grec_SalesCrMemoLine.Description := Gtext_Designation;
                            Grec_SalesCrMemoLine.MODIFY();
                            CurrPage.CLOSE();
                        end;
                end;
            }
            action(Annuler)
            {
                Caption = 'Cancel', Comment = 'FRA="Annuler"';
                ApplicationArea = All;
                Image = Cancel;

                trigger OnAction()
                begin
                    CurrPage.CLOSE();
                end;
            }
        }
    }

    trigger OnClosePage()
    begin
        CurrPage.CLOSE();
    end;

    trigger OnOpenPage()
    begin
        if Rec.GET(Gcode_LineNo) then;
    end;

    var
        Grec_SalesCrMemoLine: Record "Sales Cr.Memo Line";
        Grec_SalesInvLine: Record "Sales Invoice Line";
        Gcode_DocumentNo: Code[20];
        Gcode_ItemNo: Code[20];
        Gcode_LineNo: Integer;
        Text001: label 'Invoice', Comment = 'FRA="Facture"';
        Text002: label 'No.', Comment = 'FRA="N° :"';
        Text003: label 'Credit Memo', Comment = 'FRA="Avoir"';
        Gtext_No: Text[10];
        Gtext_TypeDocument: Text[30];
        Gtext_Designation: Text[100];

    procedure SetPostedInvoice(Prec_SalesInvLine: Record "Sales Invoice Line")
    begin
        Gcode_DocumentNo := Prec_SalesInvLine."Document No.";
        Gcode_LineNo := Prec_SalesInvLine."Line No.";
        Gcode_ItemNo := Prec_SalesInvLine."No.";
        Gtext_Designation := Prec_SalesInvLine.Description;
        Gtext_TypeDocument := Text001;
        Gtext_No := Text002;
        if Gcode_ItemNo = '' then Gtext_No := '';
    end;

    procedure SetPostedCreditMemo(Prec_SalesCrMemoLine: Record "Sales Cr.Memo Line")
    begin
        Gcode_DocumentNo := Prec_SalesCrMemoLine."Document No.";
        Gcode_LineNo := Prec_SalesCrMemoLine."Line No.";
        Gcode_ItemNo := Prec_SalesCrMemoLine."No.";
        Gtext_Designation := Prec_SalesCrMemoLine.Description;
        Gtext_TypeDocument := Text003;
        Gtext_No := Text002;
        if Gcode_ItemNo = '' then Gtext_No := ''
    end;
}
