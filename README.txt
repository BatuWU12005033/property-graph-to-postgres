
# Property Graph to PostgreSQL – Complete Setup & Execution Guide (Bachelor Thesis – Part 2)

This guide explains how to import a property graph (Neo4j JSON export) into a relational PostgreSQL database,
enforce PG-Schema constraints using triggers, and test the correctness of the validation logic.

---

## 📦 Required Files

Ensure the following files are present in the same folder:

- setup_tables.sql – creates all required tables
- import_pg_data.py – Python script to import data from Neo4j JSON
- insert_constraints.sql – inserts PG-Schema constraint definitions
- setup_triggers.sql – defines and activates the triggers
- records01.json – the data dump from Neo4j (nodes + edges)
- README.txt – this guide

---

## ✅ Step-by-Step Execution Order

### 1. Execute: `setup_tables.sql`

Creates the base tables for:
- nodes, node_properties
- edges, edge_properties
- constraint tables (mandatory, exclusive, singleton)

#### How to run:
**Option A – in DBeaver or pgAdmin:**
- Open the SQL file
- Connect to your PostgreSQL database
- Execute the full script

**Option B – in terminal (psql):**
```bash
psql -U your_user -d your_database -f setup_tables.sql
```

---

### 2. Run: `import_pg_data.py`

Imports all nodes and edges (including properties) from `records01.json`.

#### How to run:
1. Make sure Python and the package `psycopg2` are installed:
```bash
pip install psycopg2
```
2. Edit the database connection in the script:
```python
conn = psycopg2.connect(
    dbname="your_database",
    user="your_user",
    password="your_password",
    host="localhost",
    port="5432"
)
```
3. Open terminal or command prompt in the script folder and run:
```bash
python import_pg_data.py
```

---

### 3. Execute: `insert_constraints.sql`

Populates the constraint tables:
- mandatory_constraints
- exclusive_constraints
- singleton_constraints

#### How to run (same as Step 1):
```bash
psql -U your_user -d your_database -f insert_constraints.sql
```

---

### 4. Execute: `setup_triggers.sql`

Creates and activates the PostgreSQL triggers that enforce the constraints.

```bash
psql -U your_user -d your_database -f setup_triggers.sql
```

---

## 🧪 Trigger Testing Instructions

After trigger activation, try inserting data manually to verify enforcement.

### A. Mandatory Constraint Test
```sql
INSERT INTO nodes (label) VALUES ('Person');
-- Use actual node_id returned (e.g., 99):
INSERT INTO node_properties (node_id, key, value)
VALUES (99, 'username', 'testuser');
-- Triggers error: missing 'email' for node 99
```

### B. Exclusive Constraint Test
```sql
-- Assuming 'alice@example.com' already exists:
INSERT INTO node_properties (node_id, key, value)
VALUES (1, 'email', 'alice@example.com');
-- Triggers uniqueness error
```

### C. Singleton Constraint Test
```sql
-- Only one 'priority' allowed:
INSERT INTO node_properties (node_id, key, value)
VALUES (2, 'priority', 'high');
-- Triggers singleton violation if another exists
```

---

## ✅ Expected Final Result

- The property graph from Neo4j is imported and stored relationally
- All new inserts are validated against mandatory, exclusive, and singleton constraints
- The system reflects a clean PG-Schema mapping and validation logic

---

## 🗂 File Overview

| File                   | Purpose                                              |
|------------------------|------------------------------------------------------|
| setup_tables.sql       | Creates schema and structure                         |
| import_pg_data.py      | Loads data from Neo4j JSON                           |
| insert_constraints.sql | Defines the constraints used by PG-Schema            |
| setup_triggers.sql     | Enforces the rules using PostgreSQL trigger functions|
| records01.json         | Source data in JSON format                           |
| README.txt             | Execution and test instructions                      |
