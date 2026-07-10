# 05 - Associations and Compositions in SAP CAP

## Overview

In enterprise applications, business objects are often related to each other.

Examples:

- Sales Order belongs to a Customer.
- Sales Order contains multiple Items.
- Customer owns an Address.
- Purchase Order contains multiple Line Items.

SAP CAP provides two ways to model such relationships:

1. **Associations** – Represents references between entities.
2. **Compositions** – Represents ownership relationships between entities.

This exercise demonstrates both concepts using a Sales Order Management application.

---

# Learning Objectives

After completing this exercise, you will be able to:

- Create Associations in CDS
- Create Compositions in CDS
- Understand Parent-Child Relationships
- Implement Deep Insert Operations
- Use OData Expand Queries
- Understand Cascade Delete Behavior
- Expose CDS Entities as OData Services
- Model Real-world Business Scenarios

---

# Business Scenario

A company manages customer sales orders.

Business Rules:

- A Customer can place multiple Sales Orders.
- Each Sales Order belongs to one Customer.
- A Sales Order contains multiple Items.
- A Customer has one Address.
- If a Sales Order is deleted, its Items should also be deleted.
- If a Customer is deleted, the Address should also be deleted.

---

# CAP Project Creation

## Create New Project

```bash
mkdir 05-associations-compositions
cd 05-associations-compositions

cds init --add mta
npm install
```

Start the application:

```bash
cds watch
```

---

# Project Structure

```text
05-associations-compositions
│
├── db
│   └── order-data-model.cds
│
├── srv
│   ├── order-service.cds
│   └── order-service-test.http
│
├── package.json
├── mta.yaml
└── README.md
```

---

# Data Model

Create file:

```text
db/order-data-model.cds
```

## Code

```cds
namespace my.salesorder;

entity SalesOrders {
  key ID          : String(10);
      description : String(50) not null;
      salesOrg    : String(4);

      customerNo  : String(10);

      customer    : Association to Customers
                      on customer.customerNo = customerNo;

      items       : Composition of many SalesOrderItems
                      on items.salesOrder = $self;
}

entity SalesOrderItems {
  key salesOrder : Association to one SalesOrders;
  key item       : Integer;

      material   : String(18);
      quantity   : Decimal(10,2);
}

entity Customers {
  key customerNo   : String(10);
      customerName : String(50);

      addresses    : Composition of one Addresses;
}

entity Addresses {
  key ID      : Integer;
      city    : String(50);
      country : String(10);
      contact : ContactType;
}

type ContactType {
  phonenumber : String(10);
  email       : String(50);
}
```

---

# Data Model Explanation

## SalesOrders

Represents Customer Sales Orders.

Fields:

| Field | Description |
|---------|------------|
| ID | Sales Order Number |
| description | Order Description |
| salesOrg | Sales Organization |
| customerNo | Customer Reference |

---

## SalesOrderItems

Represents Order Line Items.

Fields:

| Field | Description |
|---------|------------|
| salesOrder | Parent Order |
| item | Item Number |
| material | Product |
| quantity | Ordered Quantity |

---

## Customers

Represents Customer Master Data.

Fields:

| Field | Description |
|---------|------------|
| customerNo | Customer Number |
| customerName | Customer Name |

---

## Addresses

Represents Customer Address Information.

Fields:

| Field | Description |
|---------|------------|
| ID | Address ID |
| city | City |
| country | Country |

---

# Understanding Associations

## Association Example

```cds
customer : Association to Customers
  on customer.customerNo = customerNo;
```

### Meaning

A Sales Order references a Customer.

### Characteristics

- Independent Lifecycle
- No Cascade Delete
- Acts like Foreign Key Relationship

### Example

```text
Sales Order
      |
      |
      V
Customer
```

Deleting the Sales Order does NOT delete the Customer.

---

# Understanding Compositions

## Composition Example

```cds
items : Composition of many SalesOrderItems
```

### Meaning

Sales Order owns Sales Order Items.

### Characteristics

- Parent owns Child
- Supports Deep Insert
- Supports Cascade Delete
- Child should not exist without Parent

---

### Example

```text
Sales Order
    |
    +---- Item 10
    +---- Item 20
    +---- Item 30
```

Deleting Sales Order deletes all Items automatically.

---

# Relationship Diagram

```text
Customers
    |
    | Composition (1:1)
    |
Addresses


SalesOrders
    |
    | Association
    |
Customers


SalesOrders
    |
    | Composition (1:N)
    |
SalesOrderItems
```

---

# Service Definition

Create file:

```text
srv/order-service.cds
```

## Code

```cds
using my.salesorder as my from '../db/order-data-model';

service SalesOrderService @(path:'/SalesOrderService')
{
    entity SalesOrders
        as projection on my.SalesOrders;

    entity SalesOrderItems
        as projection on my.SalesOrderItems;

    entity Customers
        as projection on my.Customers;

    entity Addresses
        as projection on my.Addresses;
}
```

---

# Service Endpoints

Available URLs:

```text
/SalesOrderService/SalesOrders

/SalesOrderService/SalesOrderItems

/SalesOrderService/Customers

/SalesOrderService/Addresses
```

Metadata URL:

```text
http://localhost:4004/SalesOrderService/$metadata
```

---

# Testing

Create file:

```text
srv/order-service-test.http
```

---

# Test 1 - Metadata

```http
GET http://localhost:4004/SalesOrderService/$metadata
```

Purpose:

- Verify service exposure
- Verify entities are available

---

# Test 2 - Create Sales Order

```http
POST http://localhost:4004/SalesOrderService/SalesOrders
Content-Type: application/json

{
  "ID": "1",
  "description": "Order 1",
  "customerNo": "C1",
  "salesOrg":"US01"
}
```

---

# Test 3 - Create Order Item

```http
POST http://localhost:4004/SalesOrderService/SalesOrderItems
Content-Type: application/json

{
  "salesOrder_ID": "1",
  "item": 10,
  "material": "Pen",
  "quantity": 100
}
```

---

# Test 4 - Expand Query

```http
GET http://localhost:4004/SalesOrderService/SalesOrders?$expand=items,customer
```

Purpose:

Retrieve:

- Sales Order
- Related Items
- Related Customer

in a single request.

---

# Test 5 - Deep Insert (Order + Items)

```http
POST http://localhost:4004/SalesOrderService/SalesOrders
```

Create Parent and Child records together.

Result:

- Order Created
- All Items Created Automatically

---

# Test 6 - Deep Insert (Customer + Address)

```http
POST http://localhost:4004/SalesOrderService/Customers
```

Result:

- Customer Created
- Address Created Automatically

---

# Test 7 - Cascade Delete

Delete Sales Order:

```http
DELETE http://localhost:4004/SalesOrderService/SalesOrders(ID='1')
```

Result:

```text
SalesOrder Deleted

SalesOrderItems Deleted Automatically
```

---

Delete Customer:

```http
DELETE http://localhost:4004/SalesOrderService/Customers(customerNo='C1')
```

Result:

```text
Customer Deleted

Address Deleted Automatically
```

---

# Association vs Composition

| Feature | Association | Composition |
|----------|------------|-------------|
| Ownership | No | Yes |
| Parent Child Relationship | No | Yes |
| Deep Insert | No | Yes |
| Cascade Delete | No | Yes |
| Independent Existence | Yes | No |
| Typical Example | Sales Order → Customer | Sales Order → Items |

---

# Common Interview Questions

### What is Association?

Association represents a relationship between two independent entities.

Example:

```cds
Association to Customers
```

---

### What is Composition?

Composition represents ownership where child entities depend on a parent.

Example:

```cds
Composition of many SalesOrderItems
```

---

### What is Deep Insert?

Creating Parent and Child records in a single request.

Example:

Sales Order + Items.

---

### What is Cascade Delete?

Deleting a parent automatically deletes all child records.

---

### Difference between Association and Composition?

Association is a reference relationship.

Composition is an ownership relationship.

---

# Useful Commands

Start Application

```bash
cds watch
```

Build Project

```bash
cds build
```

Compile CDS

```bash
cds compile db/order-data-model.cds
```

Check CDS Version

```bash
cds -v
```

---

# Key Takeaways

✅ Associations create relationships between entities

✅ Compositions create ownership relationships

✅ Compositions support Deep Insert

✅ Compositions support Cascade Delete

✅ Expand retrieves related entities in one request

✅ CAP automatically manages parent-child behavior

✅ Commonly used in enterprise applications

---

# Git Commit

```bash
git add .
git commit -m "feat: implement associations and compositions in CAP sales order application"
```

---

## Topic Tags

```text
SAP CAP
CDS Modeling
Associations
Compositions
Deep Insert
Expand
Cascade Delete
OData
BTP
CAP Learning Repository
```