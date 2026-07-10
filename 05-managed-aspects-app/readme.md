# 05 - Managed Entities and Common Aspects

## 📌 Overview

This project demonstrates how SAP CAP reuse aspects simplify CDS development.

Rather than creating common fields manually, CAP provides reusable aspects such as:

- cuid
- managed
- temporal

The project also demonstrates SAP common datatypes like Country and Currency.

---

## 🎯 Learning Objectives

- Understand reuse aspects
- Use cuid
- Use managed
- Use temporal
- Use SAP common datatypes
- Follow CAP best practices

---

## 📚 Concepts Covered

### cuid

Automatically generates UUID primary key.

```cds
entity Employee : cuid
```

---

### managed

Automatically generates audit fields.

```text
createdAt
createdBy
modifiedAt
modifiedBy
```

---

### temporal

Automatically generates:

```text
validFrom
validTo
```

Supports historical records.

---

### Country

Standard SAP country codes.

Example:

```text
IN
US
DE
FR
```

---

### Currency

Standard SAP currency codes.

Example:

```text
USD
INR
EUR
GBP
```

---

## 🏗 Project Structure

```text
db/
│
├── schema.cds
├── data/
│
srv/
│
└── employee-service.cds
```

---

## 📊 Data Model

### Employees

```cds
entity Employees : cuid, managed {

    name : String(100);

    designation : String(100);

}
```

### Products

```cds
entity Products : cuid, managed {

    name : String(100);

    price : Decimal(15,2);

    currency : Currency;

}
```

---

## 🧪 Testing

### Employees API

```http
GET

/odata/v4/employee/Employees
```

### Products API

```http
GET

/odata/v4/employee/Products
```

---

## 🎤 Interview Questions

### What is cuid?

A CAP reusable aspect that automatically creates UUID primary keys.

---

### What is managed?

A CAP reusable aspect that automatically creates audit fields.

---

### What is temporal?

A reusable aspect that supports time-dependent data by adding:

```text
validFrom
validTo
```

---

### Why use reuse aspects?

- Less code
- Better maintainability
- SAP best practices
- Standardized models

---

## 🏢 Real World Use Cases

### Employee Management

Use:

```cds
cuid
managed
```

---

### Product Catalog

Use:

```cds
Currency
```

---

### Office Locations

Use:

```cds
Country
```

---

### Price History

Use:

```cds
temporal
```

---

## 📖 Common CAP Commands

```bash
cds watch

cds deploy

cds compile

cds build
```

---

## 💡 Key Learnings

1. Never create UUIDs manually.
2. Use managed for audit tracking.
3. Use temporal for historical data.
4. Prefer SAP common datatypes.
5. Reduce boilerplate wherever possible.

---

## ✅ Completion Checklist

- [x] Used cuid
- [x] Used managed
- [x] Used temporal
- [x] Used Country datatype
- [x] Used Currency datatype
- [x] Exposed Services
- [x] Tested APIs

---

## 🏷 Tags

#SAPCAP
#CDS
#Managed
#CUID
#Temporal
#SAPBTP

---

## 👨‍💻 Repository Information

| Property | Value |
|-----------|---------|
| Topic | Managed Entities and Common Aspects |
| Level | Beginner |
| Technology | SAP CAP |
| Database | SQLite |
| Status | Completed ✅ |