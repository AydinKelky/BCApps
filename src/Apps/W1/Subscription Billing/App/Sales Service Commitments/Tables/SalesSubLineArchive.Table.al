namespace Microsoft.SubscriptionBilling;

using Microsoft.Inventory.Item;
using Microsoft.Sales.Document;
using Microsoft.Sales.Archive;
using Microsoft.Sales.Pricing;

table 8069 "Sales Sub. Line Archive"
{
    DataClassification = CustomerContent;
    Caption = 'Sales Subscription Line Archive';
    PasteIsValid = false;
    DrillDownPageId = "Sales Serv. Comm. Archive List";
    LookupPageId = "Sales Serv. Comm. Archive List";

    fields
    {
        field(1; "Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Document Type';
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Sales Header Archive"."No." where("Document Type" = field("Document Type"));
        }
        field(3; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
            AutoIncrement = true;
        }
        field(5; "Version No."; Integer)
        {
            Caption = 'Version No.';
        }
        field(6; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
        }
        field(10; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(11; "Item Description"; Text[100])
        {
            Caption = 'Item Description';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Editable = false;
        }
        field(12; Partner; Enum "Service Partner")
        {
            Caption = 'Partner';
        }
        field(13; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(14; "Calculation Base Type"; Enum "Calculation Base Type")
        {
            Caption = 'Calculation Base Type';
        }
        field(15; "Calculation Base Amount"; Decimal)
        {
            Caption = 'Calculation Base Amount';
            MinValue = 0;
            BlankZero = true;
            AutoFormatType = 1;
            AutoFormatExpression = Rec."Currency Code";
        }
        field(16; "Calculation Base %"; Decimal)
        {
            Caption = 'Calculation Base %';
            MinValue = 0;
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            AutoFormatType = 0;
        }
        field(17; "Price"; Decimal)
        {
            Caption = 'Price';
            Editable = false;
            BlankZero = true;
            AutoFormatType = 2;
            AutoFormatExpression = Rec."Currency Code";
        }
        field(18; "Discount %"; Decimal)
        {
            Caption = 'Discount %';
            MinValue = 0;
            MaxValue = 100;
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            AutoFormatType = 0;
        }
        field(19; "Discount Amount"; Decimal)
        {
            Caption = 'Discount Amount';
            MinValue = 0;
            BlankZero = true;
            AutoFormatType = 1;
            AutoFormatExpression = Rec."Currency Code";
        }
        field(20; Amount; Decimal)
        {
            Caption = 'Amount';
            BlankZero = true;
            AutoFormatType = 1;
            AutoFormatExpression = Rec."Currency Code";
        }
        field(21; "Sub. Line Start Formula"; DateFormula)
        {
            Caption = 'Subscription Line Start Formula';
        }
        field(22; "Agreed Sub. Line Start Date"; Date)
        {
            Caption = 'Agreed Subscription Line Start Date';
        }
        field(23; "Initial Term"; DateFormula)
        {
            Caption = 'Initial Term';
        }
        field(24; "Notice Period"; DateFormula)
        {
            Caption = 'Notice Period';
        }
        field(25; "Extension Term"; DateFormula)
        {
            Caption = 'Subsequent Term';
        }
        field(26; "Billing Base Period"; DateFormula)
        {
            Caption = 'Billing Base Period';
        }
        field(27; "Billing Rhythm"; DateFormula)
        {
            Caption = 'Billing Rhythm';
        }
        field(28; "Invoicing via"; Enum "Invoicing Via")
        {
            Caption = 'Invoicing via';
        }
        field(30; Template; Code[20])
        {
            Caption = 'Template';
            TableRelation = "Sub. Package Line Template";
            ValidateTableRelation = false;
        }
        field(31; "Package Code"; Code[20])
        {
            Caption = 'Package Code';
            TableRelation = "Subscription Package";
        }
        field(32; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            Editable = false;
            TableRelation = "Customer Price Group";
        }
        field(34; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
        }
        field(60; "Linked to No."; Code[20])
        {
            Caption = 'Linked to No.';
            Editable = false;
        }
        field(61; "Linked to Line No."; Integer)
        {
            Caption = 'Linked to Line No.';
            Editable = false;
        }
        field(62; Process; Enum Process)
        {
            Caption = 'Process';
            Editable = false;
        }
        field(100; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            AutoFormatType = 2;
            AutoFormatExpression = Rec."Currency Code";
        }
        field(101; "Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            AutoFormatExpression = '';
            Caption = 'Unit Cost (LCY)';
        }
    }

    keys
    {
        key(PK; "Line No.")
        {
            Clustered = true;
        }
        key(SK1; "Document Type", "Document No.", "Document Line No.", "Doc. No. Occurrence", "Version No.")
        {
        }
    }

    internal procedure FilterOnSalesLineArchive(SalesLineArchive: Record "Sales Line Archive")
    begin
        Rec.SetRange("Document Type", SalesLineArchive."Document Type");
        Rec.SetRange("Document No.", SalesLineArchive."Document No.");
        Rec.SetRange("Document Line No.", SalesLineArchive."Line No.");
        Rec.SetRange("Doc. No. Occurrence", SalesLineArchive."Doc. No. Occurrence");
        Rec.SetRange("Version No.", SalesLineArchive."Version No.");
    end;
}