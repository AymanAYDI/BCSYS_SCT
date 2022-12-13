pageextension 50057 "BC6_ApprovalRequestEntries" extends "Approval Request Entries" //662
{
    layout
    {
        addafter("Document No.")
        {
            field("BC6_Vendor Name"; Rec."BC6_Vendor Name")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("Record")
        {
            visible = false;
        }
        addafter("Record")
        {
            action(BC6_Record2)
            {
                ApplicationArea = All;
                Caption = 'Record', Comment = 'FRA="Document"';
                Enabled = ShowRecCommentsEnabled;
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    Rec."BC6 ShowDocument"();
                end;

            }
        }
    }
    trigger OnAfterGetCurrRecord()
    var
        RecRef: RecordRef;
    begin
        ShowRecCommentsEnabled := RecRef.Get(Rec."Record ID to Approve");
    end;

    var
        ShowRecCommentsEnabled: Boolean;
}


