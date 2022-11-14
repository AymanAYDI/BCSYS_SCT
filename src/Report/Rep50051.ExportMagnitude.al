report 50051 "BC6_Export Magnitude"
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
                XmlPortMagnitude.SetParameters(Gdate_Comptabilisation);
                XmlPortMagnitude.RUN();
                CLEAR(XmlPortMagnitude);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(Gdate_Comptabilisation; Gdate_Comptabilisation)
                {
                    Caption = 'Date comptabilisation';
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        XmlPortMagnitude: XMLport "BC6_Export Magnitude";
        Gdate_Comptabilisation: Date;
}
