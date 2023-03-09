report 50097 "BC6_Send Vendor Payments"
{
    Caption = 'Send Vendor Payments', Comment = 'FRA="Envoi virements aux fournisseurs"';
    Permissions = TableData "Payment Header" = rimd;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;
    dataset
    {
        dataitem(DataItem1000000000; "Payment Header")
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            var
                RecGPaymentHeader: Record "Payment Header";
                CduLVendorPayments: Codeunit "BC6_Vendor Payments";
            begin
                IntGCounter += 1;
                Window.UPDATE(1, ROUND(IntGCounter / IntGTotal * 10000, 1));

                RecGPaymentHeader.GET("No.");

                CLEAR(CduLVendorPayments);
                CduLVendorPayments.FctSendPaymentMail(RecGPaymentHeader, FALSE);
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE();
            end;

            trigger OnPreDataItem()
            begin
                IntGTotal := COUNT;
                Window.OPEN(SendingEmail);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        IntGCounter := 0;
        IntGTotal := 0;
    end;

    var
        Window: Dialog;
        IntGCounter: Integer;
        IntGTotal: Integer;
        SendingEmail: Label 'Sending E-mails: @1@@@@@@@@@@@@@@@', Comment = 'FRA="Envoi des mails: @1@@@@@@@@@@@@@@@"';
}

