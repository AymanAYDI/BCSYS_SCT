report 50049 "BC6_Export ETAFI"
{
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Tasks;

    dataset
    {
        dataitem(DataItem5444; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = const(1));

            trigger OnAfterGetRecord()
            begin
                DataportETAFI.SetParameters(Gdate_StartDate, Gdate_EndDate, Gdate_DateIsolation);
                DataportETAFI.RUN();
                CLEAR(DataportETAFI);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(Gdate_StartDate; Gdate_StartDate)
                {
                    Caption = 'Date début';
                    ApplicationArea = All;
                }
                field(Gdate_EndDate; Gdate_EndDate)
                {
                    Caption = 'Date fin';
                    ApplicationArea = All;
                }
                field(Gdate_DateIsolation; Gdate_DateIsolation)
                {
                    Caption = 'Date à isoler';
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        DataportETAFI: XMLport "BC6_ETAFI";
        Gdate_DateIsolation: Date;
        Gdate_EndDate: Date;
        Gdate_StartDate: Date;
}