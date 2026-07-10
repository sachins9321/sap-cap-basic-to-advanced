# 04 - Associations

## 📌 Overview

This project demonstrates Associations in SAP CAP.

Associations are used to establish relationships between entities while maintaining independent lifecycles.

Example:

Department → Employee

Book → Author

Customer → Order

---

## 🎯 Learning Objectives

After completing this topic I can:

- Create To-One Associations
- Create To-Many Associations
- Understand Foreign Keys
- Use Navigation Properties
- Execute OData Expand Queries
- Model Real-world Relationships

---

## 📚 Concepts Covered

### To-One Association

```cds
department : Association to Departments;
```

One employee belongs to one department.

---

### To-Many Association

```cds
employees : Association to many Employees;
```

One department contains many employees.

---

### Foreign Key

CAP generates foreign keys automatically.

Example:

```text
department_ID
```

---

### Navigation

Relationship access through:

```http
$expand
```

---

## 🏗 Project Structure

```text
db/
├── schema.cds
├── data/

srv/
└── catalog-service.cds
```

---

## 📊 Data Model

### Department

```cds
entity Departments {

    departmentName : String;

}
```

### Employee

```cds
entity Employees {

    employeeName : String;

    department : Association to Departments;

}
```

---

## 🔗 Service Definition

```cds
service EmployeeService {

    entity Employees;

    entity Departments;

}
```

---

## 🧪 Testing

### Get Employees

```http
GET

/odata/v4/employee/Employees
```

### Expand Department Information

```http
GET

/odata/v4/employee/Employees?$expand=department
```

---

## 🎤 Interview Questions

### What is an Association?

An Association defines a relationship between two entities.

---

### Difference Between Association and Composition?

Association:

- Independent lifecycle
- Child can exist without parent

Composition:

- Parent owns child
- Child cannot exist independently
- Cascade delete supported

---

### What does CAP generate automatically?

Foreign Key Fields.

Example:

```text
department_ID
```

---

### What is $expand?

Used to fetch related entity data in a single request.

Example:

```http
?$expand=department
```

---

### Can Associations be To-Many?

Yes.

Example:

```cds
employees : Association to many Employees;
```

---

## 🏢 Real World Examples

### Employee Management

```text
Employee → Department
```

### Library System

```text
Book → Author
```

### E-Commerce

```text
Product → Category
```

### Order Management

```text
Order → Customer
```

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

1. Associations model relationships.
2. CAP creates foreign keys automatically.
3. Associations support navigation.
4. $expand improves data retrieval.
5. To-One and To-Many are common patterns.

---

## ✅ Completion Checklist

- [x] Created Departments Entity
- [x] Created Employees Entity
- [x] Added To-One Association
- [x] Added Sample Data
- [x] Exposed OData Service
- [x] Tested API
- [x] Tested $expand Query
- [ ] Added Screenshots

---

## 🏷 Tags

#SAPCAP
#CDS
#Associations
#OData
#BTP

---

## 👨‍💻 Repository Information

| Property | Value |
|-----------|---------|
| Topic | Associations |
| Level | Beginner |
| Technology | SAP CAP |
| Database | SQLite |
| Status | Completed ✅ |