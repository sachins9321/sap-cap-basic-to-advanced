# This exercise provide details on how to Create Table and expose table as CAP service.

# Exercise 2 – Domain Modelling in SAP CAP

## Overview

This exercise demonstrates how to create a data model in the SAP Cloud Application Programming Model (CAP), load sample data into database entities, expose the entities through a service, and verify the results using the CAP service endpoints.

---

## Objective

By completing this exercise, you will learn how to:

- Create database entities using CDS domain models
- Organize CAP project structure
- Load initial data using CSV files
- Expose entities as OData services
- Run and test a CAP application

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
├── package.json
└── README.md
``