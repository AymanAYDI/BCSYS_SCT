report 50049 "BC6_Export ETAFI"
{
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Tasks;
    Caption = 'Export ETAFI';

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
                field(Gdate_StartDateV; Gdate_StartDate)
                {
                    Caption = 'Date début';
                    ApplicationArea = All;
                }
                field(Gdate_EndDateV; Gdate_EndDate)
                {
                    Caption = 'Date fin';
                    ApplicationArea = All;
                }
                field(Gdate_DateIsolationV; Gdate_DateIsolation)
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
