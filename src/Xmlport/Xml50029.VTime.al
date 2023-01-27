xmlport 50029 "BC6_VTime"
{
    Caption = 'VTime';
    Direction = Import;
    Format = VariableText;
    FieldSeparator = ';';
    UseRequestPage = false;
    FileName = '*.csv';
    schema
    {
        textelement(Root)
        {
            tableelement(VTime; Integer)
            {
                AutoSave = false;
                AutoUpdate = false;
                AutoReplace = false;
                textelement(Champ1)
                {
                }
                textelement(Champ2)
                {
                }
                textelement(Champ3)
                {
                }
                textelement(Champ4)
                {
                }
                textelement(Champ5)
                {
                }
                textelement(Champ6)
                {
                }
                trigger OnBeforeInsertRecord()
                BEGIN
                    IF Champ1 = 'P' THEN
                        IF Grec_Matricule.GET(Champ2) THEN BEGIN
                            Grec_Matricule."Provider name" := "Gcu_ANSI-ASCII".Ansi2Ascii(Champ4);
                            Grec_Matricule."Provider first name" := "Gcu_ANSI-ASCII".Ansi2Ascii(Champ5);
                            Grec_Matricule."Society code" := Champ3;
                            Grec_Matricule.MODIFY();
                        END ELSE BEGIN
                            Grec_Matricule.INIT();
                            Grec_Matricule."Matricule No." := Champ2;
                            Grec_Matricule."Provider name" := "Gcu_ANSI-ASCII".Ansi2Ascii(Champ4);
                            Grec_Matricule."Provider first name" := "Gcu_ANSI-ASCII".Ansi2Ascii(Champ5);
                            Grec_Matricule."Society code" := Champ3;
                            Grec_Matricule.INSERT();
                        END;
                END;

            }
        }
    }
    VAR
        Grec_Matricule: Record "BC6_Matricule";
        "Gcu_ANSI-ASCII": Codeunit "BC6_ANSI_ASCII converter";


}
