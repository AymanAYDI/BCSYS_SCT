report 50092 "BC6_Draft Notice VSC TEST"
{
    // // JX-VSC3.0-PBD Migration Nav2015

    Caption = 'Draft Notice 1', Comment = 'FRA="Avis de virement 1"';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Payment Line"; "Payment Line")
        {
            DataItemTableView = SORTING("No.", "Account No.", "Bank Branch No.", "Agency Code", "Bank Account No.", "Payment Address Code") WHERE("Copied To No." = FILTER(''));
            RequestFilterFields = "No.", "Account Type", "Account No.";

            trigger OnAfterGetRecord()
            begin
                IF Gprec_Vendor <> "Payment Line"."Account No." THEN BEGIN
                    Grec_PayLine.SETRANGE("No.", "Payment Line"."No.");
                    Grec_PayLine.SETRANGE("Copied To No.", '');
                    Grec_PayLine.SETRANGE("Account No.", "Payment Line"."Account No.");
                    Grec_PayLine.FINDFIRST();
                    //REPORT.RUN(50071,FALSE,FALSE,Grec_PayLine);
                    REPORT.RUN(Report::"BC6_Draft notice VSC 2", TRUE, TRUE, Grec_PayLine);
                    Gprec_Vendor := "Payment Line"."Account No.";
                END;
            end;
        }
    }
    var
        Grec_PayLine: Record "Payment Line";
        Gprec_Vendor: Code[20];
}

