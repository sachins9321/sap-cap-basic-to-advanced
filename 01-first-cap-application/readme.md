# 01 - First CAP Application

## 📌 Overview

This project is the first SAP Cloud Application Programming Model (CAP) application.

The application exposes a simple Books entity through an OData service using SAP CAP Generic Providers.

---

## 🎯 Learning Objectives

- Understand SAP CAP project structure
- Create CDS entities
- Expose entities as OData services
- Load sample data using CSV files
- Run CAP locally using SQLite
- Test OData endpoints

---

## 📚 Prerequisites

- SAP Business Application Studio
- Node.js
- npm
- CAP CLI

Install CAP CLI:

```bash
npm install -g @sap/cds-dk
```

---

## 🏗 Project Structure

```text
01-first-cap-applicaiton/
│
├── db/
│   ├── schema.cds
│   └── data/
│       └── my.bookshop-Books.csv
│
├── srv/
│   └── catalog-service.cds
│
└── package.json
```

---

## 📊 Data Model

```cds
namespace my.bookshop;

entity Books {
    key ID : Integer;
    title  : String(100);
    author : String(100);
    price  : Decimal(9,2);
}
```

---

## 🔗 Service Definition

```cds
service CatalogService {

    entity Books as projection on my.bookshop.Books;

}
```

---

## 📝 Implementation Steps

### Step 1

Create CAP project

```bash
cds init cap-bookshop
```

### Step 2

Install dependencies

```bash
npm install
```

### Step 3

Create CDS data model

```text
db/schema.cds
```

### Step 4

Create OData service

```text
srv/catalog-service.cds
```

### Step 5

Load sample data

```text
db/data/my.bookshop-Books.csv
```

### Step 6

Run project

```bash
cds watch
```

---

## 🧪 Testing

### Books API

```http
GET

/odata/v4/catalog/Books
```

---

## ✅ Expected Output

```json
{
  "value": [
    {
      "ID": 1,
      "title": "SAP CAP Beginner Guide",
      "author": "Sachin",
      "price": "499.00"
    }
  ]
}
```

---

## 📸 Screenshots

### Home Page

```text
screenshots/home-page.png
```

### Metadata

```text
screenshots/metadata.png
```

### Books API

```text
screenshots/books-api.png
```

---

## 🔍 Key Concepts

### CDS

Core Data Services used to model data.

### Entity

Represents a database table.

### Service

Exposes entities as OData endpoints.

### Generic Provider

CAP automatically generates CRUD APIs.

---

## 🎤 Interview Questions

### What is SAP CAP?

SAP Cloud Application Programming Model is a framework for building cloud-native applications on SAP BTP.

---

### What is CDS?

Core Data Services is SAP's modeling language used in CAP.

---

### What is Generic Provider?

CAP automatically creates CRUD operations without custom code.

---

### Which database is used locally?

SQLite.

---

## 🏢 Real-World Use Case

Online Book Management System

Features:

- Store books
- Manage prices
- Expose catalog data
- Enable future UI integration

---

## 📖 Commands Used

```bash
cds init 01-first-cap-application

npm install

cds watch

cds deploy

cds build
```

---

## 💡 Learnings

1. CAP follows convention over configuration.
2. CDS is used for modeling entities.
3. OData services are generated automatically.
4. Local development uses SQLite.
5. CSV data is loaded automatically.

---

## ✅ Topic Completion Checklist

- [x] Create CAP Project
- [x] Create CDS Entity
- [x] Create Service
- [x] Load Sample Data
- [x] Run Application
- [x] Test Endpoint
- [x] Update README
- [ ] Add Screenshots

---

## 🏷 Tags

#SAPCAP
#SAPBTP
#CDS
#OData
#NodeJS
#SQLite

---

## 👨‍💻 Repository Information

| Property | Value |
|-----------|---------|
| Topic | First CAP Application |
| Level | Beginner |
| Technology | SAP CAP |
| Language | Node.js |
| Database | SQLite |
| Status | Completed ✅ |