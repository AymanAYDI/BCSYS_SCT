page 50008 "BC6_G/L Account List VSC"
{
    // //CREATION LAB du 07/11/08
    // //Nouveau formulaire pour ligne achat
    // 
    // //MODIF JX-XAD du 08/11/10
    // Suppression filtre (annulé)

    Caption = 'G/L Account List', Comment = 'FRA="Liste des comptes généraux"';
    DataCaptionFields = "Search Name";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "G/L Account";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                IndentationColumn = NameIndent;
                IndentationControls = Name;
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Direct Posting"; Rec."Direct Posting")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Reconciliation Account"; Rec."Reconciliation Account")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        NameIndent := 0;
        NoOnFormat();
        NameOnFormat();
    end;

    trigger OnOpenPage()
    begin
    end;

    var
        [InDataSet]
        NameEmphasize: Boolean;
        [InDataSet]
        "No.Emphasize": Boolean;
        [InDataSet]
        NameIndent: Integer;

    procedure SetSelection(var GLAcc: Record "G/L Account")
    begin
        CurrPage.SETSELECTIONFILTER(GLAcc);
    end;

    procedure GetSelectionFilter(): Code[80]
    var
        GLAcc: Record "G/L Account";
        More: Boolean;
        SelectionFilter: Code[80];
        GLAccCount: Integer;
        FirstAcc: Text[20];
        LastAcc: Text[20];
    begin
        CurrPage.SETSELECTIONFILTER(GLAcc);
        GLAcc.SETCURRENTKEY("No.");
        GLAccCount := GLAcc.COUNT;
        IF GLAccCount > 0 THEN BEGIN
            GLAcc.FIND('-');
            WHILE GLAccCount > 0 DO BEGIN
                GLAccCount := GLAccCount - 1;
                GLAcc.MARKEDONLY(FALSE);
                FirstAcc := GLAcc."No.";
                LastAcc := FirstAcc;
                More := (GLAccCount > 0);
                WHILE More DO
                    IF GLAcc.NEXT() = 0 THEN
                        More := FALSE
                    ELSE
                        IF NOT GLAcc.MARK() THEN
                            More := FALSE
                        ELSE BEGIN
                            LastAcc := GLAcc."No.";
                            GLAccCount := GLAccCount - 1;
                            IF GLAccCount = 0 THEN
                                More := FALSE;
                        END;
                if SelectionFilter <> '' THEN
                    SelectionFilter := SelectionFilter + '|';
                IF FirstAcc = LastAcc THEN
                    SelectionFilter := SelectionFilter + FirstAcc
                ELSE
                    SelectionFilter := SelectionFilter + FirstAcc + '..' + LastAcc;
                IF GLAccCount > 0 THEN BEGIN
                    GLAcc.MARKEDONLY(TRUE);
                    GLAcc.NEXT();
                END;
            END;
        END;
        EXIT(SelectionFilter);
    end;

    local procedure NoOnFormat()
    begin
        "No.Emphasize" := Rec."Account Type" <> Rec."Account Type"::Posting;
    end;

    local procedure NameOnFormat()
    begin
        NameIndent := Rec.Indentation;
        NameEmphasize := Rec."Account Type" <> Rec."Account Type"::Posting;
    end;
}

