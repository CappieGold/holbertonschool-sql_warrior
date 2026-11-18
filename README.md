# SQL Warrior

A collection of SQL training projects built while preparing for the **RNCP 6** certification at Holberton School. Each project lives in its own directory and focuses on a specific set of SQL skills.

## Projects

| Directory | Description | Topics |
| --- | --- | --- |
| [sql_manga](./sql_manga) | Manga rental shop database: schema creation, test data, and business queries | `SELECT`, `WHERE`, `LIKE`, `IN`, `ORDER BY`, aggregate functions, joins, `CASE WHEN`, `INSERT`, `UPDATE`, `DELETE` |
| [sql_velo](./sql_velo) | Bike rental system database: schema with constraints, test data, and statistics queries | `INNER JOIN`, `LEFT JOIN`, `GROUP BY`, aggregate functions, constraints, transactions |

## Requirements

- Ubuntu (a VM, WSL, or a dev container)
- MySQL 8.0
- A text editor or VS Code

### Installing MySQL

```bash
sudo apt update
sudo apt install -y mysql-server
mysql --version
```

In a container there is usually no `systemd`, so start the server manually:

```bash
sudo service mysql start
sudo service mysql status
```

Check that you can connect:

```bash
sudo mysql
```

## Repository layout

```
holbertonschool-sql_warrior/
├── README.md
├── sql_manga/
│   └── README.md
└── sql_velo/
    └── README.md
```

## Good practices

- Run the schema (DDL) script before the data script.
- Build complex queries step by step, checking the result at each stage.
- Use short, readable aliases (`c` for `clients`, `m` for `mangas`, ...).
- Always check joins for unwanted duplicates.
- Run a `SELECT` with the same `WHERE` clause before any `DELETE` or `UPDATE`.
- Use `ROUND(..., 2)` for monetary amounts.

## Notes

These projects are meant to be solved without AI tools. Verifying your own SQL results is part of the exercise.
