namespace learning.associations;

using {
    cuid,
    managed
} from '@sap/cds/common';

entity Departments : cuid, managed {

    departmentName : String(100);
    location       : String(100);
    employees : Association to many Employees
                on employees.department = $self; // reverse association:

}

entity Employees : cuid, managed {

    employeeName   : String(100);
    designation    : String(100);
    salary         : Decimal(15,2);
    department     : Association to Departments;

}
