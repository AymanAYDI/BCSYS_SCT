table 50004 "BC6_VSC historic"
{
    Caption = 'Historique VSC';
    DataClassification = CustomerContent;
    LookupPageId = "BC6_Purch. Invoice Subform VSC";

    fields
    {
        field(1; Type; enum "BC6_VSC Historic Type")
        {
            Caption = 'Type';
            Description = 'Type de document';
            DataClassification = CustomerContent;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            Description = 'N° de document';
            DataClassification = CustomerContent;
        }
        field(3; "Date time"; DateTime)
        {
            Caption = 'Date time';
            DataClassification = CustomerContent;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(5; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        field(6; Comments; Text[100])
        {
            Caption = 'Comments';
            Description = 'Commentaires éditables par la compta';
            DataClassification = CustomerContent;
        }
        field(7; "Assigned User ID"; Code[50])
        {
            Caption = 'Assigned User ID';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key50000; Type, "No.", "Date time")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    /// <summary>
    /// ShowHistoric.
    /// </summary>
    procedure ShowHistoric()
    begin
        //TESTFIELD("Document No.");
        //TESTFIELD("Line No.");
        //DocDim.SETRANGE("Table ID",DATABASE::"Purchase Line");
        //DocDim.SETRANGE("Document Type","Document Type");
        //DocDim.SETRANGE("Document No.","Document No.");
        //DocDim.SETRANGE("Line No.","Line No.");
        //DocDimensions.SETTABLEVIEW(DocDim);
        //DocDimensions.RUNMODAL;
    end;
}
