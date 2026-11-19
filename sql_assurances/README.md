# TP - SQL - Fleet Insurance

## Overview

A company manages a fleet of vehicles used by its employees for business trips. Each vehicle has a type, a registration number, an insurance contract and an insurer. Employees make trips with the available vehicles.

This project consists of building a relational database to manage vehicles, vehicle types, insurers, contracts, employees and trips, then writing queries on it. It also covers a SQL **function**, a **stored procedure** and a **trigger**.

## Learning objectives

- Create a MySQL 8.0 database and relational tables.
- Use primary keys, foreign keys and SQL constraints (`CHECK`, `UNIQUE`, `NOT NULL`).
- Insert consistent data.
- Write complex queries with joins (`INNER JOIN`, `LEFT JOIN`).
- Use `GROUP BY` and aggregate functions.
- Create a SQL function, a stored procedure and a MySQL trigger.

## Requirements

- Ubuntu with **MySQL 8.0** installed (see the [main README](../README.md#installing-mysql))
- A running MySQL server (`sudo service mysql start` in a container)

## Database schema

The database is named `assurance_flotte` (charset `utf8mb4`) and contains 6 tables:

| Table | Description | Primary key |
| --- | --- | --- |
| `types_vehicules` | Vehicle types: label (unique) and number of seats (between 2 and 7) | `id` (`VARCHAR(5)`, e.g. `CITY`) |
| `vehicules` | Vehicles: model, color (optional), unique registration, type | `id` |
| `assureurs` | Insurers: name, address, phone | `id` (`VARCHAR(2)`, e.g. `AX`) |
| `contrats` | Insurance contracts: start date, duration (> 0), insurer, vehicle | `id` |
| `employes` | Employees: last name, first name, driving license number (optional, unique) | `id` |
| `deplacements` | Trips: which employee used which vehicle, from when to when, and where | (`employe`, `vehicule`, `debut_dep`) |

### Relationships

- `vehicules.type_voiture` → `types_vehicules.id`
- `contrats.assureur` → `assureurs.id`
- `contrats.vehicule` → `vehicules.id`
- `deplacements.employe` → `employes.id`
- `deplacements.vehicule` → `vehicules.id`

Notes:

- A vehicle can have **several contracts** (for example vehicles 101, 102 and 103), and some vehicles have **none**.
- The table `deplacements` has a **composite primary key** of 3 columns: the same employee can use the same vehicle on different dates.
- Constraints: `nbplaces BETWEEN 2 AND 7`, `duree > 0`, `fin_dep > debut_dep`.
- Column names differ from the usual `*_id` pattern: for instance `contrats.vehicule` and `deplacements.employe` are foreign keys. Check the ERD before writing a `JOIN`.

## Setup

The two scripts are in this directory:

- `TP_SQL_Assurance_DDL.sql`: creates the database and the tables
- `TP_SQL_Assurance_dump_data.sql`: inserts the test data

Run them **in this order** (add `sudo` if your configuration requires it):

```bash
sudo mysql < TP_SQL_Assurance_DDL.sql
sudo mysql assurance_flotte < TP_SQL_Assurance_dump_data.sql
```

> The DDL script starts with `DROP DATABASE IF EXISTS assurance_flotte;`, so running it again resets the database to a clean state.

### Checking the result

After the DDL script, `SHOW TABLES` should list the 6 tables. After the data script, each table contains **12 rows**:

| Query | Expected result |
| --- | --- |
| `SELECT COUNT(*) FROM types_vehicules;` | 12 |
| `SELECT COUNT(*) FROM vehicules;` | 12 |
| `SELECT COUNT(*) FROM assureurs;` | 12 |
| `SELECT COUNT(*) FROM contrats;` | 12 |
| `SELECT COUNT(*) FROM employes;` | 12 |
| `SELECT COUNT(*) FROM deplacements;` | 12 |

To explore the database interactively:

```bash
sudo mysql assurance_flotte
```

To run a query file:

```bash
sudo mysql assurance_flotte < task_1.sql
```

## Things to watch in the data

The data has gaps on purpose, useful for `LEFT JOIN` and `NULL` handling:

- Some vehicles have **no contract**, and some have **no trip**.
- Some insurers have **no contract**.
- Some employees have **no trip** and **no driving license** (`NULL`).
- Vehicle 104 has **no color** (`NULL`).
- Several employees share the **same trip** (same vehicle, same dates), so a join can produce several rows per trip.

## Stored objects (functions, procedures, triggers)

The last exercises ask for a function, a procedure and a trigger. Reminders:

- In the `mysql` client, change the delimiter so that the `;` inside the body does not end the statement early:

  ```sql
  DELIMITER $$
  -- CREATE FUNCTION / PROCEDURE / TRIGGER ... END$$
  DELIMITER ;
  ```

- Inside a trigger, `NEW` is the row being inserted or updated, and `OLD` is the row before the change or deletion.
- Useful commands: `SHOW FUNCTION STATUS WHERE Db = 'assurance_flotte';`, `SHOW PROCEDURE STATUS WHERE Db = 'assurance_flotte';`, `SHOW TRIGGERS;`
- Test your triggers inside a transaction (`START TRANSACTION` ... `ROLLBACK`) so you can undo the test rows.
- Useful date functions: `DATE_ADD`, `CURRENT_DATE`, `DATEDIFF`.

## Tips

- Run the DDL script first, then the data script.
- Keep the ERD at hand; it is essential to understand the tables and their relationships.
- Break big problems into small ones: solve the general case first, check the result, then add conditions and filters one at a time.
- Use short, readable aliases (`v` for `vehicules`, `tv` for `types_vehicules`, `c` for `contrats`, ...).
- Check your joins progressively, and watch out for duplicates.
- Do not confuse `INNER JOIN` and `LEFT JOIN`.
- Respect data types, and use the `YYYY-MM-DD HH:MM:SS` format for dates.
- Column names must match the expected result exactly.

## Rules

- No AI tools may be used to solve the exercises.
- You are responsible for verifying your own SQL results.
- You may be asked to present and explain a solution, or to attend a manual review.
