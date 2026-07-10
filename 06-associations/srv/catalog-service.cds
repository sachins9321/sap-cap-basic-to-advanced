
using {learning.associations as emp} from '../db/schema';

service EmployeeService {

    entity Employees   as projection on emp.Employees;
    entity Departments as projection on emp.Departments;

}
