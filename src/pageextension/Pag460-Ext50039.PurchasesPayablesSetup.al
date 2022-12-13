pageextension 50039 "BC6_PurchasesPayablesSetup" extends "Purchases & Payables Setup" //460
{
    // //Modif JX-AUD du 25/10/11
    // //Ajout de l'onglet Approbation et du champ Montant max. autorisé
    layout
    {
        addafter("Default Qty. to Receive")
        {
            field("BC6_Excel File Vendor Not Created"; Rec."BC6_ExcelFile Vend Not Created")
            {
                ApplicationArea = All;
            }
            field("BC6_Mail Invoice Path"; Rec."BC6_Mail Invoice Path")
            {
                ApplicationArea = All;
            }
        }
        addafter("Posted Prepmt. Cr. Memo Nos.")
        {
            group(BC6_Approval)
            {
                Caption = 'Approval', Comment = 'FRA="Approbation"';
                field("BC6_Max. Amount allowed"; Rec."BC6_Max. Amount allowed")
                {
                    Caption = 'Max. amount allowed', Comment = 'FRA="Montant max. autorisé"';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.MODIFY();
                    end;
                }
            }
        }
        addafter("Notify On Success")
        {
            group(BC6_Imports)
            {
                Caption = 'Imports';
                field("BC6_Entity Code"; Rec."BC6_Entity Code")
                {
                    ApplicationArea = All;
                }
                field("BC6_Timing Dimension 0"; Rec."BC6_Timing Dimension 0")
                {
                    ApplicationArea = All;
                }
                field("BC6_Verify Dim 0 on Purch. Line"; Rec."BC6_Verif Dim 0 on Purch. Line")
                {
                    ApplicationArea = All;
                }
                field("BC6_Timing Dimension 1"; Rec."BC6_Timing Dimension 1")
                {
                    ApplicationArea = All;
                }
                field("BC6_Verify Dim 1 on Purch. Line"; Rec."BC6_Verif Dim 1 on Purch. Line")
                {
                    ApplicationArea = All;
                }
                field("BC6_Timing Dimension 2"; Rec."BC6_Timing Dimension 2")
                {
                    ApplicationArea = All;
                }
                field("BC6_Verify Dim 2 on Purch. Line"; Rec."BC6_Verif Dim 2 on Purch. Line")
                {
                    ApplicationArea = All;
                }
                field("BC6_Timing Dimension 3"; Rec."BC6_Timing Dimension 3")
                {
                    ApplicationArea = All;
                }
                field("BC6_BC6 Verify Dim 3 on Purch. Line"; Rec."BC6_Verif Dim 3 on Purch. Line")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

