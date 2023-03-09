pageextension 50060 "BC6_ApprovalUserSetup" extends "Approval User Setup" //663
{
    layout
    {
        addafter("Approver ID")
        {
            field("BC6_Sign Name"; Rec."BC6_Sign Name")
            {
                ApplicationArea = All;
            }
            field(BC6_Sign; Rec."BC6_Sign")
            {
                ApplicationArea = All;
            }
        }
    }

}
