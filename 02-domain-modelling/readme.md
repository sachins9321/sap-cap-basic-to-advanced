# Exercise 2 – Domain Modelling in SAP CAP

## Overview

This exercise demonstrates how to create a data model in the SAP Cloud Application Programming Model (CAP), load sample data into database entities, expose the entities through an OData service, and test the service using HTTP requests.

---

## Objective

By completing this exercise, you will learn how to:

- Create database entities using CDS domain models
- Organize CAP project structure
- Load initial data using CSV files
- Expose entities as OData services
- Run and test a CAP application
- Perform CRUD operations using HTTP requests
- Verify OData V4 endpoints and metadata

---

## Project Structure

After completing this exercise, the project structure should look like:

```text
CAPDemo
│
├── db
│   ├── schema.cds
│   └── data
│       ├── demo-Projects.csv
│       └── demo-Users.csv
│
├── srv
│   └── project-service.cds
│
├── test
│   ├── request.http
│
├── package.json
└── README.md
```

---

## Domain Model

Navigate to the `db` folder and create the file:

```text
db/schema.cds
```

### schema.cds

```cds
namespace demo;

entity Users {
    key id : Integer;
    name   : String(100);
    email  : String(100);
    phone  : String(100);
    gender : String(100);
}

entity Projects {
    key id          : Integer;
    name            : String(100);
    description     : String(100);
}
```

---

## Sample Data

Create a folder:

```text
db/data
```

### demo-Users.csv

```csv
id;name;email;phone;gender
1000;user1;user1@test.com;123456;female
2000;user2;user2@test.com;9856748;female
3000;user3;user3@test.com;9856748;male
4000;user4;user4@test.com;9856748;female
5000;user5;user5@test.com;9856748;male
```

### demo-Projects.csv

```csv
id;name;description
1;project1;testingproject1
2;project2;testingproject2
3;project3;testingproject3
4;project4;testingproject4
5;project5;testingproject5
6;project6;testingproject6
7;project7;testingproject7
```

---

## Service Definition

Navigate to the `srv` folder and create:

```text
srv/project-service.cds
```

```cds
using { demo } from '../db/schema';

service project {

    entity Users as select from demo.Users;

    entity Projects as select from demo.Projects;

}
```

---

## Service Information

The CAP application exposes the following OData service:

```text
http://localhost:4004/odata/v4/project
```

### Available Endpoints

| Entity | Endpoint |
|----------|----------|
| Users | `/odata/v4/project/Users` |
| Projects | `/odata/v4/project/Projects` |
| Metadata | `/odata/v4/project/$metadata` |
| Service Document | `/` |

---

## Run the Application

Open the integrated terminal and execute:

```bash
cds watch
```

Expected output:

```text
server listening on http://localhost:4004
```

Open the application in your browser and verify the service is available.

---

# HTTP API Testing

Create the following file:

```text
test/EX1-request.http
```

The requests can be executed directly using:

- SAP Business Application Studio
- VS Code REST Client Extension

---

## Service Document

Returns all available services.

```http
GET http://localhost:4004/
Accept: application/json
```

---

## Service Metadata

Returns the OData metadata document.

```http
GET http://localhost:4004/odata/v4/project/$metadata
Accept: application/xml
```

Use this endpoint to:

- Verify entity definitions
- Review service structure
- Confirm endpoint exposure

---

# Users API

## Get All Users

```http
GET http://localhost:4004/odata/v4/project/Users
Accept: application/json
```

---

## Get User By ID

```http
GET http://localhost:4004/odata/v4/project/Users(1000)
Accept: application/json
```

---

## Create User

```http
POST http://localhost:4004/odata/v4/project/Users
Content-Type: application/json

{
  "id": 6000,
  "name": "John Doe",
  "email": "john.doe@test.com",
  "phone": "9999999999",
  "gender": "male"
}
```

---

## Update User

```http
PATCH http://localhost:4004/odata/v4/project/Users(1000)
Content-Type: application/json

{
  "email": "updated@test.com"
}
```

---

## Delete User

```http
DELETE http://localhost:4004/odata/v4/project/Users(1000)
```

---

# Projects API

## Get All Projects

```http
GET http://localhost:4004/odata/v4/project/Projects
Accept: application/json
```

---

## Get Project By ID

```http
GET http://localhost:4004/odata/v4/project/Projects(1)
Accept: application/json
```

---

## Create Project

```http
POST http://localhost:4004/odata/v4/project/Projects
Content-Type: application/json

{
  "id": 8,
  "name": "New Project",
  "description": "Testing CAP CRUD Operations"
}
```

---

## Update Project

```http
PATCH http://localhost:4004/odata/v4/project/Projects(1)
Content-Type: application/json

{
  "description": "Updated project description"
}
```

---

## Delete Project

```http
DELETE http://localhost:4004/odata/v4/project/Projects(1)
```

---

# CRUD Operations Summary

## Users

| Operation | Method | Endpoint |
|------------|----------|----------|
| Read All Users | GET | `/Users` |
| Read User By ID | GET | `/Users(1000)` |
| Create User | POST | `/Users` |
| Update User | PATCH | `/Users(1000)` |
| Delete User | DELETE | `/Users(1000)` |

---

## Projects

| Operation | Method | Endpoint |
|------------|----------|----------|
| Read All Projects | GET | `/Projects` |
| Read Project By ID | GET | `/Projects(1)` |
| Create Project | POST | `/Projects` |
| Update Project | PATCH | `/Projects(1)` |
| Delete Project | DELETE | `/Projects(1)` |

---

## Verification Checklist

✅ Created CDS entities

✅ Created CSV data files

✅ Created service definition

✅ Started application using `cds watch`

✅ Verified service metadata

✅ Retrieved Users data

✅ Retrieved Projects data

✅ Tested CRUD operations using HTTP requests

✅ Validated OData endpoints

---

## Learning Outcomes

After completing this exercise, you will understand:

- CDS Domain Modelling
- Entity Creation
- Sample Data Loading using CSV
- OData V4 Service Exposure
- Service Metadata Inspection
- CRUD Operations
- HTTP Request Testing
- REST Client Usage
- End-to-End CAP Development Flow

---

## Important Notes

- The request payload fields must match the entity definitions in `db/schema.cds`.
- POST, PATCH, and DELETE operations require writable entities.
- Use the metadata endpoint to verify entity names and field definitions.
- CSV files are automatically loaded by CAP during startup.

---

## Summary

In this exercise, we created two entities (`Users` and `Projects`), loaded initial data using CSV files, exposed the entities using an OData V4 service, and tested CRUD operations through `EX1-request.http`. This exercise provides a solid foundation for advanced SAP CAP topics such as Associations, Compositions, Actions, Authentication, HANA Cloud Integration, and Fiori Applications.