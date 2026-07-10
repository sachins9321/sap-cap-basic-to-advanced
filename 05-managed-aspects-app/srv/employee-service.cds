using {learning.managed as emp} from '../db/schema';

service EmployeeService {

    entity Employees       as projection on emp.Employees;
    entity Products        as projection on emp.Products;
    entity Offices         as projection on emp.Offices;
    entity EmployeeHistory as projection on emp.EmployeeHistory;

}