namespace learning.service;

using {
    cuid,
    managed
} from '@sap/cds/common';

entity Employees : cuid, managed {

    employeeName : String(100);
    email        : String(100);
    designation  : String(100);
    department   : String(50);
    salary       : Decimal(15,2);

}