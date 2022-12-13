tableextension 50002 "BC6_PaymentHeader" extends "Payment Header" //10865
{
    fields
    {
        field(50000; "BC6_User ID"; Code[50])
        {
            Caption = 'Code Utilisateur', Comment = 'FRA="Code Utilisateur"';
            DataClassification = CustomerContent;
        }
        field(50001; "BC6_Creation Date"; Date)
        {
            Caption = 'Date Création', Comment = 'FRA="Date Création"';
            DataClassification = CustomerContent;
        }
        field(50002; "BC6_Modifcation Date"; Date)
        {
            Caption = 'Date Modification', Comment = 'FRA="Date Modification"';
            DataClassification = CustomerContent;
        }
        field(50010; "BC6_Alone Payment"; Boolean)
        {
            Caption = 'Bordereau Manuel', Comment = 'FRA="Bordereau Manuel"';
            DataClassification = CustomerContent;
        }
        field(50020; "BC6_Yooz No."; Text[250])
        {
            Caption = 'N° Yooz', Comment = 'FRA="N° Yooz"';
            DataClassification = CustomerContent;
        }
        field(50021; "BC6_Yooz No. 2"; Text[250])
        {
            Caption = 'N° Yooz 2', Comment = 'FRA="N° Yooz 2"';
            DataClassification = CustomerContent;
        }
        field(50022; "BC6_Yooz No. 3"; Text[250])
        {
            Caption = 'N° Yooz 3', Comment = 'FRA="N° Yooz 3"';
            DataClassification = CustomerContent;
        }
        field(50023; "BC6_Yooz No. 4"; Text[250])
        {
            Caption = 'N° Yooz 4', Comment = 'FRA="N° Yooz 4"';
            DataClassification = CustomerContent;
        }
        field(50024; "BC6_Yooz No. 5"; Text[250])
        {
            Caption = 'N° Yooz 5', Comment = 'FRA="N° Yooz 5"';
            DataClassification = CustomerContent;
        }
        field(50025; "BC6_Yooz No. 6"; Text[250])
        {
            Caption = 'N° Yooz 6', Comment = 'FRA="N° Yooz 6"';
            DataClassification = CustomerContent;
        }
        field(50026; BC6_Motif; Text[30])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        // key(Key50000; "BC6_User ID", "Status No.")
        // {
        // } TODO
    }
    procedure FctYooz(ReCalc: Boolean)
    var
        YoozTable: Record "BC6_No. Yooz" TEMPORARY;
        SortTable: Record "Excel Buffer" temporary;
        PayLine: Record "Payment Line";
        IntYooz: Integer;
        LineNo: Integer;
        x: Integer;
        TextYooz: Text;
        YoozNo: Text;
    begin
        PayLine.Reset();
        PayLine.SetRange("No.", "No.");
        if PayLine.FindFirst() then
            repeat
                if ReCalc then
                    PayLine.FctYooz(false);
                if PayLine."BC6_Applied Yooz No." <> '' then begin
                    TextYooz := PayLine."BC6_Applied Yooz No.";
                    repeat
                        x := StrPos(TextYooz, ';');
                        if x <> 0 then
                            if Evaluate(IntYooz, CopyStr(TextYooz, 1, x - 1)) then begin
                                SortTable.Init();
                                SortTable."Row No." := IntYooz;
                                SortTable."Cell Value as Text" := CopyStr(TextYooz, 1, x - 1);
                                if SortTable.Insert() then;
                            end;
                        TextYooz := CopyStr(TextYooz, x + 1);
                    until x = 0;
                end;
            until PayLine.Next() = 0;

        Get("No.");
        YoozTable.Reset();
        YoozTable.SetRange("No.", "No.");
        YoozTable.DeleteAll();
        YoozTable.Reset();
        YoozNo := '';
        LineNo := 0;
        if SortTable.FindFirst() then
            repeat
                if StrLen(YoozNo + SortTable."Cell Value as Text" + ';') <= 250 then
                    YoozNo := YoozNo + SortTable."Cell Value as Text" + ';'
                else begin
                    FctInsertYoozNo(YoozNo, LineNo);
                    YoozNo := SortTable."Cell Value as Text" + ';';
                end;
            until SortTable.Next() = 0;
        FctInsertYoozNo(YoozNo, LineNo);
        Modify();
    end;

    local procedure FctInsertYoozNo(var YoozNo: Text; var LineNo: Integer)
    var
        YoozTable: Record "BC6_No. Yooz";
    begin
        LineNo += 10000;
        YoozTable.Init();
        YoozTable."No." := "No.";
        YoozTable."Line No." := LineNo;
        YoozTable."Applied Yooz No." := YoozNo;
        YoozTable.Insert();
    end;
}
