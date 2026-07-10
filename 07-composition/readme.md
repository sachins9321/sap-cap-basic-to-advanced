# 05 - Compositions

## 📌 Overview

This project demonstrates Composition in SAP CAP.

Composition represents ownership between entities and supports:

- Deep Insert
- Deep Update
- Cascade Delete
- Parent-Child Relationships

---

## 🎯 Learning Objectives

- Understand Composition
- Create Parent-Child Models
- Implement Deep Insert
- Implement Deep Read
- Understand Cascade Delete
- Model Real-world Business Documents

---

## 📚 Concepts Covered

### Composition

```cds
Composition of many
```

Represents ownership.

---

### Parent Entity

```cds
Orders
```

---

### Child Entity

```cds
OrderItems
```

---

### Deep Insert

Create parent and children in one request.

---

### Deep Read

```http
?$expand=Items
```

---

### Cascade Delete

Deleting parent removes child records automatically.

---

## 🏗 Project Structure

```text
db/
├── schema.cds
├── data/

srv/
└── order-service.cds
```

---

## 📊 Data Model

### Orders

```cds
entity Orders {

    orderNumber : String;

    Items : Composition of many OrderItems
            on Items.parent = $self;
}
```

### Order Items

```cds
entity OrderItems {

    key parent : Association to Orders;

    key itemNo : Integer;

}
```

---

## 🧪 Testing

### Get Orders

```http
GET /odata/v4/order/Orders
```

### Deep Read

```http
GET /odata/v4/order/Orders?$expand=Items
```

### Create Order

```http
POST /odata/v4/order/Orders
```

---

## 🎤 Interview Questions

### What is Composition?

Composition represents ownership between entities.

---

### Difference Between Association and Composition?

Association:

- Independent lifecycle

Composition:

- Parent owns child
- Cascade delete supported

---

### What is Deep Insert?

Creating parent and child records in a single request.

---

### What is Cascade Delete?

Deleting a parent automatically deletes its child entities.

---

### Real Example of Composition?

```text
Order → Order Items

Purchase Order → Line Items

Invoice → Invoice Lines
```

---

## 🏢 Real World Use Case

### Sales Order

```text
Order
 |
 |-- Item 1
 |-- Item 2
 |-- Item 3
```

Items cannot exist without Order.

Composition is the correct choice.

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

1. Composition represents strong ownership.
2. Child lifecycle depends on parent.
3. Deep Insert reduces coding effort.
4. Cascade delete is automatic.
5. Widely used in Fiori applications.

---

## ✅ Completion Checklist

- [x] Created Orders Entity
- [x] Created OrderItems Entity
- [x] Added Composition
- [x] Added Sample Data
- [x] Tested Deep Read
- [x] Tested Deep Insert
- [x] Tested Cascade Delete
- [x] Updated Documentation

---

## 🏷 Tags

#SAPCAP
#CDS
#Composition
#DeepInsert
#OData
#SAPBTP

---

## 👨‍💻 Repository Information

| Property | Value |
|-----------|---------|
| Topic | Compositions |
| Level | Beginner |
| Technology | SAP CAP |
| Database | SQLite |
| Status | Completed ✅ |