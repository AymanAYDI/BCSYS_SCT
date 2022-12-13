report 50051 "BC6_Export Magnitude"
{
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Tasks;
    Caption = 'Export Magnitude', Comment = 'FRA="Export Magnitude"';

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
                field(Gdate_ComptabilisationV; Gdate_Comptabilisation)
                {
                    Caption = 'Date comptabilisation', Comment = 'FRA="Date comptabilisation"';
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        XmlPortMagnitude: XMLport "BC6_Export Magnitude";
        Gdate_Comptabilisation: Date;
}
