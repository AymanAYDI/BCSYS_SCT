xmlport 50081 "BC6_Mail Setup Line"
{
    Caption = 'BC6 Mail Setup Line';
    schema
    {
        textelement(Root)
        {
            tableelement(Table; "BC6_Mail Body Setup")
            {
                AutoUpdate = true;
                fieldelement(Type; Table."Mail Type")
                {

                }
                fieldelement(Line; Table."Line No.")
                {

                }
                fieldelement(TextLine; Table."Textline")
                {

                }
                fieldelement(Sep; Table."Seperator")
                {

                }
            }
        }
    }
}
