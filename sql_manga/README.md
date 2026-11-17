# TP - SQL - Manga

## Overview

A manga rental shop wants to modernize how it tracks its business. It has customers, invoices, mangas, mangakas (manga authors), genres, and several rental types.

This project consists of building the database, loading realistic data, and writing SQL queries to answer business needs: browsing the catalog, analyzing rentals, computing revenue, and updating records.

## Learning objectives

- Write selection queries with `WHERE`, `LIKE`, `IN`, and `ORDER BY`.
- Use calculations and aggregate functions: `COUNT`, `SUM`, `AVG`, `MAX`.
- Join multiple tables.
- Build cross-analyses with `CASE WHEN`.
- Run action queries: `INSERT`, `UPDATE`, `DELETE`.

## Requirements

- Ubuntu with **MySQL 8.0** installed (see the [main README](../README.md#installing-mysql))
- A running MySQL server (`sudo service mysql start` in a container)

## Database schema

The database is named `tp_manga` and contains 7 tables:

| Table | Description | Primary key |
| --- | --- | --- |
| `clients` | Customers (title, name, address, phone, birth date, number of children) | `code_client` |
| `factures` | Invoices, each linked to a customer | `num_facture` |
| `types_location` | Rental types with a price coefficient and a duration in days | `code_type` |
| `mangakas` | Manga authors (name, birth year, country) | `code_mangaka` |
| `genres_manga` | Manga genres | `code_genre` |
| `mangas` | Catalog: title, base price, author, genre, year, description, duration | `num_manga` |
| `table_location` | Rentals: which manga was rented on which invoice, with which rental type, and its return date | (`num_facture`, `num_manga`) |

### Relationships

- `factures.code_client` → `clients.code_client`
- `mangas.code_mangaka` → `mangakas.code_mangaka`
- `mangas.code_genre` → `genres_manga.code_genre`
- `table_location.num_facture` → `factures.num_facture`
- `table_location.num_manga` → `mangas.num_manga`
- `table_location.code_type` → `types_location.code_type`

## Setup

Create the two files below in this directory, copying the scripts provided in the project instructions:

- `TP_SQL_Manga_DDL.sql`: creates the database and the tables
- `TP_SQL_Manga_dump_data.sql`: inserts the test data

Run them **in this order** (add `sudo` if your configuration requires it):

```bash
mysql -u root -p < TP_SQL_Manga_DDL.sql
mysql -u root -p tp_manga < TP_SQL_Manga_dump_data.sql
```

> The DDL script starts with `DROP DATABASE IF EXISTS tp_manga;`, so running it again resets the database to a clean state.

### Checking the result

After the DDL script, `SHOW TABLES` should list the 7 tables. After the data script, you should get:

| Query | Expected result |
| --- | --- |
| `SELECT COUNT(*) AS nb_clients FROM clients;` | 12 |
| `SELECT COUNT(*) AS nb_mangas FROM mangas;` | 24 |
| `SELECT COUNT(*) AS nb_locations FROM table_location;` | 25 |

To explore the database interactively:

```bash
mysql -u root -p tp_manga
```

To run a query file:

```bash
mysql -u root -p tp_manga < my_query.sql
```

## Tips

- Run the DDL script first, then the data script.
- Keep the ERD at hand; it is essential to understand the tables and their relationships.
- Break big problems into small ones: solve the general case first, check the result, then add conditions and filters one at a time.
- Use short, readable aliases (`c` for `clients`, `m` for `mangas`, ...).
- Always check your joins to avoid duplicate rows.
- Before a `DELETE`, run a `SELECT` with the same `WHERE` clause.
- Use `ROUND(..., 2)` for monetary amounts.

## Rules

- No AI tools may be used to solve the exercises.
- You are responsible for verifying your own SQL results.
- You may be asked to present and explain a solution, or to attend a manual review.