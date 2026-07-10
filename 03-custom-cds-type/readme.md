# Exercise 03 – Custom CDS Types in SAP CAP

## Overview

This exercise demonstrates how to create and use **Custom CDS Types** in SAP Cloud Application Programming Model (CAP).

Custom Types help standardize data definitions and improve reusability across multiple entities. In this exercise, we will create:

- Custom Decimal Types
- Structured Types
- Nested Structures
- Multiple Entities using reusable types
- OData Service Exposure
- Sample Data Loading through CSV Files

---

## Objective

By completing this exercise, you will learn how to:

- Define custom CDS scalar types
- Create reusable structured types
- Use nested structures within entities
- Reuse custom types across multiple entities
- Load structured data using CSV files
- Expose entities via CAP services
- Understand complex OData entity structures

---

# Project Structure

```text
03-custom-cds-type
│
├── db
│   ├── schema.cds
│   └── data
│       ├── com.acc.customtype-CustomerEntity.csv
│       ├── com.acc.customtype-ProductEntity.csv
│       └── com.acc.customtype-PharmProductEntity.csv
│
├── srv
│   └── cat-service.cds
│
├── test
│   ├── EX1-request.http
│   └── sample.txt
│
├── screenshots
│
└── README.md
```

---

# Understanding Custom CDS Types

Custom Types allow you to define reusable data structures.

Benefits:

- Reduces duplicate code
- Improves maintainability
- Enforces consistency
- Simplifies domain modeling

---

# Create Custom Types

Navigate to:

```text
db/schema.cds
```

Add the following custom types:

```cds
namespace com.acc.customtype;

type priceDecimal : Decimal(9, 2);
type averageDecimal : Decimal(11, 1);
type limitDecimal : Decimal(9, 2);

type AddressType {
    city : String;
    street : String;
    streetNumber : Integer;
}
```

---

## Decimal Types

### priceDecimal

```cds
type priceDecimal : Decimal(9,2);
```

Used for:

- Order Price
- Selling Price

Example:

```text
5000.45
2345.67
```

---

### averageDecimal

```cds
type averageDecimal : Decimal(11,1);
```

Used for:

- Average Counts
- Measurements
- Statistics

Example:

```text
100.1
300.1
```

---

### limitDecimal

```cds
type limitDecimal : Decimal(9,2);
```

Used for:

- Threshold Values
- Toxin Limits
- Business Limits

Example:

```text
2345.12
```

---

# Structured Type

Create a reusable address structure.

```cds
type AddressType {
    city : String;
    street : String;
    streetNumber : Integer;
}
```

Example:

```json
{
  "city":"Mumbai",
  "street":"MG Road",
  "streetNumber":100
}
```

---

# Product Entity

```cds
entity ProductEntity {

    key productID : String;

    productName : String;

    supplierCompanyName : String;

    supplierAddress : AddressType;

    responsibleEmployeeName : String;

    responsibleEmployeeAddress : AddressType;

    deliveryCustomerName : String;

    deliverCustomerAddress : AddressType;
}
```

---

## Purpose

Demonstrates reusing the same Address structure multiple times within a single entity.

AddressType is used for:

- Supplier Address
- Employee Address
- Delivery Customer Address

---

# Pharma Product Entity

```cds
entity PharmProductEntity {

    key id : String;

    orderPrice : priceDecimal;

    sellingPrice : priceDecimal;

    averageCount : averageDecimal;

    toxLimit : limitDecimal;
}
```

---

## Purpose

Demonstrates the use of custom numeric types in CAP.

Business Scenarios:

- Pharmaceutical Products
- Inventory Management
- Product Costing
- Toxicity Monitoring

---

# Customer Entity

```cds
entity CustomerEntity {

    key id : String;

    name : String;

    contact : {

        homepage : String;

        email : String;

        address : AddressType;

    };

    company : String;
}
```

---

## Purpose

Demonstrates nested structures.

Example:

```json
{
  "name":"Cust1",
  "contact":{
      "homepage":"www.cust1.com",
      "email":"cust1@test.com",
      "address":{
         "city":"City1"
      }
  }
}
```

---

# Sample Data

## CustomerEntity Data

File:

```text
db/data/com.acc.customtype-CustomerEntity.csv
```

```csv
id;name;contact_homepage;contact_email;contact_address_city;contact_address_street;contact_address_streetNumber;company
1000;Cust1;www.cust1.com;cust1@test.com;city1;street1;1000;company1
2000;Cust2;www.cust2.com;cust2@test.com;city2;street2;2000;company2
3000;Cust3;www.cust3.com;cust3@test.com;city3;street3;3000;company3
```

---

## ProductEntity Data

File:

```text
db/data/com.acc.customtype-ProductEntity.csv
```

```csv
productID;productName;supplierCompanyName;supplierAddress_city;supplierAddress_street;supplierAddress_streetNumber;responsibleEmployeeName;responsibleEmployeeAddress_city;responsibleEmployeeAddress_street;responsibleEmployeeAddress_streetNumber;deliveryCustomerName;deliverCustomerAddress_city;deliverCustomerAddress_street;deliverCustomerAddress_streetNumber
1000;Poduct1;SupplierCompany;City;Street;2345;Test1;empcity;empstreet;34567;devcustname;devcustcity;devcuststreet;4567
```

---

## PharmProductEntity Data

File:

```text
db/data/com.acc.customtype-PharmProductEntity.csv
```

```csv
id;orderPrice;sellingPrice;averageCount;toxLimit
100;5000.45;2345.67;100.1;2345.12
200;4567.89;2367.98;300.1;8765.23
```

---

# Create Service

Navigate to:

```text
srv/cat-service.cds
```

Add:

```cds
using {com.acc.customtype as my } from '../db/schema';

service ProductService @(path:'/browse') {

    entity Products as projection on my.ProductEntity;

    entity PharmaProducts as projection on my.PharmProductEntity;

    entity Customers as projection on my.CustomerEntity;

}
```

---

# Service Endpoints

Base URL:

```text
http://localhost:4004/browse
```

---

## Available Endpoints

| Entity | Endpoint |
|----------|----------|
| Products | `/browse/Products` |
| PharmaProducts | `/browse/PharmaProducts` |
| Customers | `/browse/Customers` |
| Metadata | `/browse/$metadata` |

---

# Run the Application

Execute:

```bash
cds watch
```

Expected Output:

```text
server listening on http://localhost:4004
```

---

# HTTP Testing

Create:

```text
test/EX1-request.http
```

## Service Document

```http
GET http://localhost:4004/
```

---

## Metadata

```http
GET http://localhost:4004/browse/$metadata
```

---

## Get Products

```http
GET http://localhost:4004/browse/Products
```

---

## Get Product By ID

```http
GET http://localhost:4004/browse/Products('1000')
```

---

## Get Pharma Products

```http
GET http://localhost:4004/browse/PharmaProducts
```

---

## Get Customers

```http
GET http://localhost:4004/browse/Customers
```

---

# Understanding Flattened Fields

CAP automatically flattens structured types.

Example:

```cds
supplierAddress : AddressType;
```

becomes:

```text
supplierAddress_city
supplierAddress_street
supplierAddress_streetNumber
```

in CSV files.

---

# Verification Checklist

✅ Created custom decimal types

✅ Created AddressType structure

✅ Created ProductEntity

✅ Created PharmProductEntity

✅ Created CustomerEntity

✅ Loaded sample data using CSV files

✅ Created ProductService

✅ Started CAP application

✅ Verified OData metadata

✅ Accessed all entities successfully

---

# Key Concepts Learned

### Custom Type

```cds
type priceDecimal : Decimal(9,2);
```

Reusable scalar definition.

---

### Structured Type

```cds
type AddressType {
}
```

Reusable object structure.

---

### Nested Structure

```cds
contact {
}
```

Embedded object definitions.

---

### Entity Projection

```cds
entity Products as projection on ...
```

Used to expose entities as services.

---

### CSV Flattening

Structured fields become flattened CSV columns.

Example:

```text
contact_address_city
contact_address_street
```

---

# Learning Outcomes

After completing this exercise, you will understand:

✅ Custom CDS Types

✅ Reusable Structures

✅ Nested Objects

✅ Decimal Type Definitions

✅ CSV Mapping for Structured Fields

✅ Service Projections

✅ OData Service Exposure

✅ CAP Data Modeling Best Practices

✅ Structured Data Handling in SAP CAP

---

# Summary

In this exercise, we created reusable CDS custom types, structured address types, nested object structures, and multiple entities that leverage those types. We exposed these entities through a CAP service and loaded sample data using CSV files. This approach improves maintainability, consistency, and reusability when designing enterprise-scale SAP CAP applications.