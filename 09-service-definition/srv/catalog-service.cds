using {learning.service as emp} from '../db/schema';

service CatalogService {

    entity Employees as projection on emp.Employees {

        ID,
        employeeName,
        designation,
        department

    };

}


//Projection with Rename
service EmployeeView {

    entity Employees as projection on emp.Employees {

        employeeName as Name,
        designation as Role,
        department as Team
    };

}

//Read-Only Service
service CatalogService1 {
    @readonly
    entity Employees as projection on emp.Employees;

}
