tableextension 50040 "BC6_CompanyInformation" extends "Company Information" //79
{
    //TODO: procédure IsPaymentInfoAvailble 
    fields
    {
        field(50000; BC6_Leader; Code[50])
        {
            Caption = 'Leader';
            TableRelation = "User Setup";
            DataClassification = CustomerContent;
        }
        field(50001; BC6_CGV; Blob)
        {
            Subtype = Bitmap;
            DataClassification = CustomerContent;
        }
    }
}

