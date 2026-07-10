
using {learning.cds as emp} from '../db/schema';

service EmployeeService {

    entity Employees as projection on emp.Employees;

}
