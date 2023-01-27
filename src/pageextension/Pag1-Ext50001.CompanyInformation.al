
pageextension 50001 "BC6_CompanyInformation" extends "Company Information" //1
{
    layout
    {
        addafter("Country/Region Code")
        {
            field(BC6_Leader; Rec."BC6_Leader")
            {
                ApplicationArea = All;
            }
        }
        addafter(CISD)
        {
            field(BC6_CGV; Rec."BC6_CGV")
            {
                ApplicationArea = All;
            }

        }
    }




}

