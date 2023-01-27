xmlport 50080 "BC6_Mail Setup"
{
    Caption = 'Mail Setup';
    schema
    {
        textelement(Root)
        {
            tableelement(Table; "BC6_Mail Setup")
            {
                AutoSave = true;
                AutoUpdate = true;
                fieldelement(Type; Table."Mail Type")
                {
                }
                fieldelement(Subject; Table."Subject")
                {
                }
            }
        }
    }
}
