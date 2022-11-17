page 50040 "BC6_User Setup Card"
{
    SourceTable = "User Setup";
    Caption = 'User Setup Card';

    layout
    {
        area(content)
        {
            group(Signature)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field(Nom; Rec."BC6_Nom")
                {
                    ApplicationArea = All;
                }
                field(Picture; Rec."BC6_Picture")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
