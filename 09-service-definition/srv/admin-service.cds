using {learning.service as emp} from '../db/schema';

service AdminService {

    entity Employees as projection on emp.Employees;

}