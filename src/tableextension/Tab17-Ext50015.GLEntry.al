tableextension 50015 "BC6_GLEntry" extends "G/L Entry" //17
{
    fields
    {
        field(50000; "BC6_Vendor No."; Code[20])
        {
            Caption = 'N° Fournisseur';
            DataClassification = CustomerContent;
        }
        field(50002; "BC6_Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
        }
        field(50003; "BC6_Temp Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50004; "BC6_Temp Rcpt No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50005; "BC6_Temp Rcpt Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50006; "BC6_Temp Dim. Set ID"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50010; "BC6_Document Type Prepaid"; enum "BC6_Document Type Prepaid")
        {
            Caption = 'Type Document Prépayé';
            DataClassification = CustomerContent;
        }
        field(50011; "BC6_Document Prepaid"; Code[20])
        {
            Caption = 'N° Document Prépayé';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key50000; "BC6_Vendor No.")
        {
        }
        key(Key50001; "BC6_Customer No.")
        {
        }
    }
    procedure "BC6_ModifyDimensions"()
    var
        lUpdateDim: Report "Modifier axes écritures compta";
        DimMgt: Codeunit DimensionManagement;
        lNewDimSet: Integer;
    begin
        if ("Document Type" = "Document Type"::Invoice) or ("Document Type" = "Document Type"::"Credit Memo") then begin
            MESSAGE(Text50000);
            DimMgt.ShowDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2', TABLECAPTION, "Entry No."));
        end else begin
            lNewDimSet := DimMgt.EditDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2', TABLECAPTION, "Entry No."));
            if "Dimension Set ID" <> lNewDimSet then begin
                CLEAR(lUpdateDim);
                lUpdateDim.SetGLEntry(Rec, lNewDimSet);
                lUpdateDim.RUN();
            end;
        end;
    end;

    var
        Text50000: label 'To modify the analytical axes of an invoice or of a credit note, you must modify them from the invoice page or have saved.';
}
