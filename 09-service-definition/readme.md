# 06 - Service Definition

## 📌 Overview

This project demonstrates how to expose CDS entities using Service Definitions in SAP CAP.

It covers:

- Service Creation
- Projections
- Multiple Services
- Read-Only Services
- Field Restriction
- Field Renaming

---

## 🎯 Learning Objectives

After completing this topic I can:

- Create CAP Services
- Expose Entities
- Create Projections
- Restrict Fields
- Rename Fields
- Create Multiple Service Layers

---

## 📚 Concepts Covered

### Service

A service exposes CDS entities as OData APIs.

```cds
service CatalogService
```

---

### Projection

Projection exposes selected fields.

```cds
entity Employees as projection on Employees
```

---

### Restricted Fields

Only expose necessary data.

```cds
ID,
employeeName,
designation
```

---

### Multiple Services

Different consumers can use different services.

Example:

```text
CatalogService

AdminService
```

---

### Read Only

```cds
@readonly
```

Supports only GET operations.

---

## 🏗 Project Structure

```text
db/
├── schema.cds

srv/
├── catalog-service.cds
└── admin-service.cds
```

---

## 📊 Data Model

```cds
entity Employees {

    employeeName : String;

    email : String;

    designation : String;

    department : String;

    salary : Decimal;
}
```

---

## 🔗 Services

### Catalog Service

```cds
entity Employees as projection on Employees {
    ID,
    employeeName,
    designation,
    department
}
```

### Admin Service

```cds
entity Employees as projection on Employees;
```


### Projection with Rename

```cds
service EmployeeView {

    entity Employees as projection on emp.Employees {

        employeeName as Name,
        designation as Role,
        department as Team
    };
}
```

### Read-Only Service
```cds
service CatalogService1 {
    @readonly
    entity Employees as projection on emp.Employees;

}
```

---

## 🧪 Testing

### Catalog Service

```http
GET /odata/v4/catalog/Employees
```

### Admin Service

```http
GET /odata/v4/admin/Employees
```

---

## 🎤 Interview Questions

### What is a Service Definition?

A service exposes CDS entities as OData APIs.

---

### Why use Projections?

To expose only required fields.

---

### Why create Multiple Services?

Different consumers need different levels of access.

---

### What is @readonly?

Makes an entity read-only and blocks write operations.

---

### Difference between Entity and Service?

Entity:
Database structure.

Service:
API layer.

---

## 🏢 Real World Example

Employee Management

### Public Service

```text
Employee Name
Department
Designation
```

### HR Service

```text
Employee Name
Salary
Email
Department
```

Different services expose different information.

---

## 📖 Commands Used

```bash
cds watch

cds deploy

cds build

cds compile
```

---

## 💡 Key Learnings

1. Never expose database entities directly.
2. Use projections for API design.
3. Hide sensitive fields.
4. Create separate services for different consumers.
5. Service layer acts as a security boundary.

---

## ✅ Completion Checklist

- [x] Created Service Definition
- [x] Created Projection
- [x] Created Catalog Service
- [x] Created Admin Service
- [x] Renamed Fields
- [x] Added Read-Only Example
- [x] Tested APIs
- [x] Updated README

---

## 🏷 Tags

#SAPCAP
#ServiceDefinition
#OData
#Projection
#SAPBTP

---

## 👨‍💻 Repository Information

| Property | Value |
|-----------|---------|
| Topic | Service Definition |
| Level | Beginner |
| Technology | SAP CAP |
| Database | SQLite |
| Status | Completed ✅ |