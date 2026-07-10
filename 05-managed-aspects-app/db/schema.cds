namespace learning.managed;

using {
    cuid,
    managed,
    temporal,
    Currency,
    Country
} from '@sap/cds/common';


entity Employees : cuid, managed {

    name        : String(100);
    designation : String(100);
}


entity Products : cuid, managed {

    name         : String(100);
    price        : Decimal(15,2);
    currency     : Currency;
}


entity Offices : cuid, managed {

    officeName   : String(100);
    country      : Country;
}


/*
 * Temporal Data Example
 */

entity EmployeeHistory : cuid, managed, temporal {

    employeeName : String(100);
    department   : String(100);
}