# Database Structure and Key Validation

## 1. Objective

The objective of this stage was to understand the structure of the six Telco Customer Churn tables and validate their Primary Keys (PK) and Foreign Keys (FK) before proceeding with data cleaning and merging.

The following tables were examined:

- MAIN
- DEMOGRAPHICS
- SERVICES
- STATUS
- LOCATION
- POPULATION

---

## 2. Candidate Primary Key (PK) Validation

### 2.1 Purpose

A Primary Key uniquely identifies each record in a table.

To identify valid Primary Key candidates, the following checks were performed:

1. Total number of rows.
2. Missing IDs.
3. Duplicate IDs.
4. Number of unique IDs.

### 2.2 Candidate Keys Identified

| Table | Candidate Primary Key |
|---|---|
| MAIN | CustomerID |
| DEMOGRAPHICS | Customer ID |
| SERVICES | Customer ID |
| STATUS | Customer ID |
| LOCATION | Customer ID |
| POPULATION | ID |

### 2.3 Validation Results

| Table | Total Rows | Missing IDs | Duplicate IDs | Unique IDs |
|---|---:|---:|---:|---:|
| MAIN | 7043 | 0 | 0 | 7043 |
| DEMOGRAPHICS | 7043 | 0 | 0 | 7043 |
| SERVICES | 7043 | 0 | 0 | 7043 |
| STATUS | 7043 | 0 | 0 | 7043 |
| LOCATION | 7043 | 0 | 0 | 7043 |
| POPULATION | 1671 | 0 | 0 | 1671 |

### 2.4 Conclusion

All six selected candidate Primary Keys have:

- Zero missing values.
- Zero duplicate values.
- Unique values equal to the total number of rows.

Therefore, all six columns passed the initial Primary Key validation.

---

## 3. Foreign Key (FK) Validation

### 3.1 Purpose

A Foreign Key connects one table to another by referencing a key in the parent table.

The MAIN table was selected as the parent table.

The Customer ID columns in the following four tables were checked against `MAIN.CustomerID`:

- DEMOGRAPHICS
- SERVICES
- STATUS
- LOCATION

### 3.2 Validation Results

| Child Table | Foreign Key Column | Total Customers | Matched | Unmatched |
|---|---|---:|---:|---:|
| DEMOGRAPHICS | Customer ID | 7043 | 7043 | 0 |
| SERVICES | Customer ID | 7043 | 7043 | 0 |
| STATUS | Customer ID | 7043 | 7043 | 0 |
| LOCATION | Customer ID | 7043 | 7043 | 0 |

### 3.3 Conclusion

All Customer IDs in the four child tables matched the Customer IDs in MAIN.

No unmatched customer IDs were found.

This confirms that all four tables have matching customer references to MAIN.

---

## 4. Population and Location Relationship Validation

### 4.1 Purpose

The POPULATION table is connected to the LOCATION table using the Zip Code column.

The Zip Codes from LOCATION were checked against the Zip Codes in POPULATION.

### 4.2 Validation Results

| Check | Result |
|---|---:|
| Total LOCATION records | 7043 |
| Matched Zip Codes | 7043 |
| Unmatched Zip Codes | 0 |

### 4.3 Conclusion

All customer Zip Codes in LOCATION have a matching record in POPULATION.

The relationship is one-to-many:

**POPULATION (one) → LOCATION (many)**

One Zip Code in POPULATION can be associated with multiple customer records in LOCATION.

---

## 5. Identified Database Relationships

| Parent Table | Child Table | Joining Column | Relationship |
|---|---|---|---|
| MAIN | DEMOGRAPHICS | Customer ID | One-to-one |
| MAIN | SERVICES | Customer ID | One-to-one |
| MAIN | STATUS | Customer ID | One-to-one |
| MAIN | LOCATION | Customer ID | One-to-one |
| POPULATION | LOCATION | Zip Code | One-to-many |

**Note:** The one-to-one relationships are based on the unique customer IDs and complete matching results in the respective tables.

---

## 6. Overall Findings

The initial database structure and key validation was completed.

Key findings:

- Six candidate Primary Keys passed the initial validation.
- Four customer-level Foreign Key relationships were successfully matched.
- All 7043 customer Zip Codes had corresponding records in POPULATION.
- No unmatched customer IDs or customer Zip Codes were identified.

---

