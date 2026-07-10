namespace learning.cds;

using {cuid,managed} from '@sap/cds/common';

/*
 * Custom Type
 */
type Email : String(255);


/*
 * Enum
 */
type EmployeeStatus : String enum {
    Active;
    Inactive;
    OnLeave;
};


/*
 * Main Entity
 */
entity Employees : cuid, managed {

    name         : localized String(100);
    email        : Email;
    designation  : String(100);
    salary       : Decimal(15,2);
    joiningDate  : Date;
    status       : EmployeeStatus default 'Active';
}