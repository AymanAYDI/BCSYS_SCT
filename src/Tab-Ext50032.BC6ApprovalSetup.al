//TODO:The taarget table "Approval Setup" for the extension object is not found 
//tableextension 50032 "BC6 Approval Setup" extends "Approval Setup"
//{
//     // 
//     // // Modif JX-LAB du 21/04/09
//     // // ajout des champs 50000 et 50001 pour la gestions des mails descendants
//     fields
//     {
//         field(50000; "BC6 Approved"; Boolean)
//         {
//             Caption = 'Approved';
//             DataClassification = CustomerContent;
//         }
//         field(50001; "BC6 Approved Template"; Blob)
//         {
//             Caption = 'Approved Template';
//             Subtype = UserDefined;
//             DataClassification = CustomerContent;
//         }
//         field(50002; "BC6 Sales Quote"; Integer)
//         {
//             Caption = 'Sales Quote';
//             TableRelation = Object.ID where(Type = const(Page));
//             DataClassification = CustomerContent;
//         }
//         field(50003; "BC6 Sales Order"; Integer)
//         {
//             Caption = 'Sales Order';
//             TableRelation = Object.ID where(Type = const(Page));
//             DataClassification = CustomerContent;
//         }
//         field(50004; "BC6 Sales Invoice"; Integer)
//         {
//             Caption = 'Sales Invoice';
//             TableRelation = Object.ID where(Type = const(Page));
//             DataClassification = CustomerContent;
//         }
//         field(50005; "BC6 Sales Credit Memo"; Integer)
//         {
//             Caption = 'Sales Credit Memo';
//             TableRelation = Object.ID where(Type = const(Page));
//             DataClassification = CustomerContent;
//         }
//         field(50006; "BC6 Sales Blanket Order"; Integer)
//         {
//             Caption = 'Sales Blanket Order';
//             TableRelation = Object.ID where(Type = const(Page));
//             DataClassification = CustomerContent;
//         }
//         field(50007; "BC6 Sales Return Order"; Integer)
//         {
//             Caption = 'Sales Return Order';
//             TableRelation = Object.ID where(Type = const(Page));
//             DataClassification = CustomerContent;
//         }
//         field(50008; "BC6 Purchases Quote"; Integer)
//         {
//             Caption = 'Purchases Quote';
//             TableRelation = Object.ID where(Type = const(Page));
//             DataClassification = CustomerContent;
//         }
//         field(50009; "BC6 Purchases Order"; Integer)
//         {
//             Caption = 'Purchases Order';
//             TableRelation = Object.ID where(Type = const(Page));
//             DataClassification = CustomerContent;
//         }
//         field(50010; "BC6 Purchases Invoice"; Integer)
//         {
//             Caption = 'Purchases Invoice';
//             TableRelation = Object.ID where(Type = const(Page));
//             DataClassification = CustomerContent;
//         }
//         field(50011; "BC6 Purchases Credit Memo"; Integer)
//         {
//             Caption = 'Purchases Credit Memo';
//             TableRelation = Object.ID where(Type = const(Page));
//             DataClassification = CustomerContent;
//         }
//         field(50012; "BC6 Purchases Blanket Order"; Integer)
//         {
//             Caption = 'Purchases Blanket Order';
//             TableRelation = Object.ID where(Type = const(Page));
//             DataClassification = CustomerContent;
//         }
//         field(50013; "BC6 Purchases Return Order"; Integer)
//         {
//             Caption = 'Purchases Return Order';
//             TableRelation = Object.ID where(Type = const(Page));
//             DataClassification = CustomerContent;
//         }
//         field(50014; "BC6 Sales Quote Yes/No"; Boolean)
//         {
//             Caption = 'Sales Quote Y/N';
//             DataClassification = CustomerContent;
//         }
//         field(50015; "BC6 Sales Order Yes/No"; Boolean)
//         {
//             Caption = 'Sales Order Y/N';
//             DataClassification = CustomerContent;
//         }
//         field(50016; "BC6 Sales Invoice Yes/No"; Boolean)
//         {
//             Caption = 'Sales Invoice Y/N';
//             DataClassification = CustomerContent;
//         }
//         field(50017; "BC6 Sales Credit Memo Yes/No"; Boolean)
//         {
//             Caption = 'Sales Credit Memo Y/N';
//             DataClassification = CustomerContent;
//         }
//         field(50018; "BC6 Sales Blanket Order Yes/No"; Boolean)
//         {
//             Caption = 'Sales Blanket Order Y/N';
//             DataClassification = CustomerContent;
//         }
//         field(50019; "BC6 Sales Return Order Yes/No"; Boolean)
//         {
//             Caption = 'Sales Return Order Y/N';
//             DataClassification = CustomerContent;
//         }
//         field(50020; "BC6 Purchases Quote Yes/No"; Boolean)
//         {
//             Caption = 'Purchases Quote Y/N';
//             DataClassification = CustomerContent;
//         }
//         field(50021; "BC6 Purchases Order Yes/No"; Boolean)
//         {
//             Caption = 'Purchases Order Y/N';
//             DataClassification = CustomerContent;
//         }
//         field(50022; "BC6 Purchases Invoice Yes/No"; Boolean)
//         {
//             Caption = 'Purchases Invoice Y/N';
//             DataClassification = CustomerContent;
//         }
//         field(50023; "BC6 Purchases Credit Memo Yes/No"; Boolean)
//         {
//             Caption = 'Purchases Credit Memo Y/N';
//             DataClassification = CustomerContent;
//         }
//         field(50024; "BC6 Purchases Blanket Order Yes/No"; Boolean)
//         {
//             Caption = 'Purchases Blanket Order Y/N';
//             DataClassification = CustomerContent;
//         }
//         field(50025; "BC6 Purchases Return Order Yes/No"; Boolean)
//         {
//             Caption = 'Purchases Return Order Y/N';
//             DataClassification = CustomerContent;
//         }
//     }
//}

