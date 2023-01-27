tableextension 50021 "BC6_ReminderLine" extends "Reminder Line" //296
{
    fields
    {
        field(50000; BC6_Agent; Code[20])
        {
            Caption = 'Agent', Comment = 'FRA="Mandataire"';
            DataClassification = CustomerContent;
        }
        field(50001; "BC6_Paying agent"; Boolean)
        {
            Caption = 'Paying agent', Comment = 'FRA="Mandataire payeur"';
            DataClassification = CustomerContent;
        }
    }
}

