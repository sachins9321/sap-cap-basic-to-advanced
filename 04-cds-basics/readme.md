# 04 -CDS Basics

## 📌 Overview

This project demonstrates the core concepts of CDS (Core Data Services), which is the primary modeling language in SAP CAP.

The project includes:

- Entity Definition
- Data Types
- Custom Types
- Enum
- cuid
- managed
- localized

---

## 🎯 Learning Objectives

After completing this topic I can:

- Create CDS entities
- Use CAP common aspects
- Define custom types
- Define enums
- Use localized fields
- Expose CDS entities as OData services

---

## 📚 Concepts Covered

### Entity

```cds
entity Employees
```

Creates a database table.

### Type

```cds
type Email : String(255);
```

Reusable datatype.

### Enum

```cds
type EmployeeStatus : String enum {
    Active;
    Inactive;
    OnLeave;
}
```

Restricts values.

### cuid

```cds
entity Employees : cuid
```

Auto-generates UUID key.

### managed

```cds
entity Employees : managed
```

Adds audit fields automatically.

### localized

```cds
name : localized String;
```

Provides translation support.

---

## 🏗 Project Structure

```text
db/
├── schema.cds
└── data/

srv/
└── catalog-service.cds
```

---

## 📊 Data Model

```cds
entity Employees : cuid, managed {

    name : localized String(100);

    email : Email;

    designation : String(100);

    salary : Decimal(15,2);

    joiningDate : Date;

    status : EmployeeStatus;
}
```

---

## 🔗 Service Definition

```cds
service EmployeeService {

    entity Employees as projection on learning.cds.Employees;

}
```

---

## 🧪 Testing

### Get Employees

```http
GET /odata/v4/employee/Employees
```

---

## 🎤 Interview Questions

### What is CDS?

Core Data Services is the data modeling language used in SAP CAP.

---

### What is cuid?

A reusable CAP aspect that automatically creates UUID primary keys.

---

### What is managed?

A CAP aspect that automatically maintains auditing fields.

---

### What is localized?

Provides support for multilingual content.

---

### Why use enums?

Enums restrict values to predefined constants.

---

## 💡 Key Learnings

1. CDS is the foundation of SAP CAP.
2. Common aspects reduce boilerplate code.
3. Enums improve data consistency.
4. Custom types improve reusability.
5. localized supports multi-language applications.

---

## ✅ Topic Completion Checklist

- [x] Created Entity
- [x] Used Data Types
- [x] Created Custom Type
- [x] Implemented Enum
- [x] Used cuid
- [x] Used managed
- [x] Used localized
- [x] Exposed Service
- [x] Tested OData Endpoint

---

## 🏷 Tags

#SAPCAP
#CDS
#NodeJS
#SAPBTP
#OData

---

## 👨‍💻 Repository Information

| Property | Value |
|-----------|---------|
| Topic | CDS Basics |
| Level | Beginner |
| Technology | SAP CAP |
| Database | SQLite |
| Status | Completed ✅ |