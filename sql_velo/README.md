# TP - SQL - Bike Rental System

## Overview

An urban mobility company wants to launch a bike rental platform. The system must manage users, stations, bikes, rentals, payments, subscriptions and maintenance.

This project consists of building the relational database, loading test data, and writing SQL queries to produce business statistics. It is a good place to practice `LEFT JOIN`, because the data deliberately contains missing relations (rentals without payment, bikes never rented, empty tables).

## Learning objectives

- Create a relational SQL database.
- Use SQL constraints (`PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `CHECK`, `ENUM`, `DEFAULT`).
- Use `INNER JOIN` and `LEFT JOIN`.
- Write complex queries with aggregate functions (`COUNT`, `AVG`, `SUM`) and `GROUP BY`.
- Understand SQL transactions.

## Requirements

- Ubuntu with **MySQL 8.0** installed (see the [main README](../README.md#installing-mysql))
- A running MySQL server (`sudo service mysql start` in a container)

## Database schema

The database is named `location_velos` and contains 7 tables:

| Table | Description | Primary key |
| --- | --- | --- |
| `utilisateurs` | Users (full name, unique email, phone, password hash, creation date) | `id` |
| `stations` | Bike stations (name, address, GPS coordinates, capacity > 0) | `id` |
| `velos` | Bikes (unique code, type, status, current station) | `id` |
| `locations` | Rentals: who rented which bike, from which station to which station, start/end dates, status | `id` |
| `paiements` | Payments for rentals (amount, method, status, date) | `id` |
| `abonnements` | User subscriptions (plan name, price, start/end dates, status) | `id` |
| `rapports_maintenance` | Maintenance reports on bikes, optionally reported by a user | `id` |

### Relationships

- `velos.station_actuelle_id` → `stations.id` (nullable)
- `locations.utilisateur_id` → `utilisateurs.id` (`ON DELETE CASCADE`)
- `locations.velo_id` → `velos.id`
- `locations.station_depart_id` → `stations.id`
- `locations.station_retour_id` → `stations.id` (nullable: the rental may still be active)
- `paiements.location_id` → `locations.id`
- `abonnements.utilisateur_id` → `utilisateurs.id`
- `rapports_maintenance.velo_id` → `velos.id`
- `rapports_maintenance.signale_par` → `utilisateurs.id` (nullable)

`locations` references `stations` **twice** (departure and return). To display both station names in one query, join `stations` twice with two different aliases.

### Enumerated values

| Column | Allowed values |
| --- | --- |
| `velos.type_velo` | `classique`, `electrique` |
| `velos.statut` | `disponible`, `loue`, `maintenance`, `perdu` |
| `locations.statut` | `active`, `terminee`, `annulee` |
| `paiements.methode_paiement` | `carte`, `portefeuille`, `especes` |
| `paiements.statut_paiement` | `en_attente`, `paye`, `echec`, `rembourse` |
| `abonnements.statut` | `actif`, `expire`, `annule` |
| `rapports_maintenance.statut` | `ouvert`, `en_cours`, `resolu` |

## Setup

The two scripts are in this directory:

- `TP_SQL_Velo_DDL.sql`: creates the database and the tables
- `TP_SQL_Velo_dump_data.sql`: inserts the test data

Run them **in this order** (add `sudo` if your configuration requires it):

```bash
sudo mysql < TP_SQL_Velo_DDL.sql
sudo mysql location_velos < TP_SQL_Velo_dump_data.sql
```

> The DDL script starts with `DROP DATABASE IF EXISTS location_velos;`, so running it again resets the database to a clean state.

### Checking the result

After the DDL script, `SHOW TABLES` should list the 7 tables. After the data script, you should get:

| Table | Expected rows |
| --- | --- |
| `utilisateurs` | 5 |
| `stations` | 4 |
| `velos` | 10 |
| `locations` | 5 |
| `paiements` | 3 |
| `abonnements` | 0 |
| `rapports_maintenance` | 0 |

For example:

```sql
SELECT COUNT(*) AS nb_locations FROM locations;   -- 5
```

To explore the database interactively:

```bash
sudo mysql location_velos
```

To run a query file:

```bash
sudo mysql location_velos < my_query.sql
```

## Where `LEFT JOIN` matters

An `INNER JOIN` only keeps rows that match on both sides. A `LEFT JOIN` keeps **every row of the left table**, and fills the columns of the right table with `NULL` when there is no match.

```sql
SELECT a.col, b.col
FROM a
LEFT JOIN b ON b.a_id = a.id;
```

The test data has gaps on purpose:

- Some rentals have **no payment** yet.
- Some bikes have **never been rented**.
- `abonnements` and `rapports_maintenance` contain **no rows** at all, so any user or bike joined to them gets `NULL`.
- Rentals still `active` have no end date and no return station.
- Some stations have never been used in a rental.

Reminders:

- The table in the `FROM` is the one whose rows you want to keep **all** of.
- To find rows **without** a match, use `LEFT JOIN ... WHERE right_table.id IS NULL`.
- A filter on the right table placed in the `WHERE` clause cancels the `LEFT JOIN` (the `NULL` rows are removed). Put it in the `ON` clause to keep unmatched rows.
- `COUNT(*)` counts the `NULL` row produced by the `LEFT JOIN`. Use `COUNT(right_table.id)` to count only real matches.

## Tips

- Run the DDL script first, then the data script.
- Keep the ERD at hand; it is essential to understand the tables and their relationships.
- Break big problems into small ones: solve the general case first, check the result, then add conditions and filters one at a time.
- Use short, readable aliases (`u` for `utilisateurs`, `v` for `velos`, `l` for `locations`, ...).
- Always check your joins to avoid duplicate rows.
- Before a `DELETE` or `UPDATE`, run a `SELECT` with the same `WHERE` clause.
- Use `ROUND(..., 2)` for monetary amounts.
- Use `START TRANSACTION` and `ROLLBACK` to test risky `UPDATE` or `DELETE` statements.

## Rules

- No AI tools may be used to solve the exercises.
- You are responsible for verifying your own SQL results.
- You may be asked to present and explain a solution, or to attend a manual review.
