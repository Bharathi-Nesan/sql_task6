# SQL Subqueries and Nested Queries

This repository contains SQL queries demonstrating the use of scalar and correlated subqueries in `SELECT`, `WHERE`, and `FROM` clauses.

##  Objective

To build advanced SQL query logic using:
- Scalar subqueries
- Correlated subqueries
- Nested logic inside SELECT, WHERE, and FROM

##  Files

- `subqueries_nested.sql` — Main SQL file with 15 examples
  - 5 Subqueries in `SELECT`
  - 5 Subqueries in `WHERE`
  - 5 Subqueries in `FROM`

##  Tools

Compatible with:
- MySQL Workbench

##  Sample Schema Used

### Customers Table
| customer_id | name     | city    |
|-------------|----------|---------|
| 1           | Alice    | Chennai |
| 2           | Bob      | Mumbai  |
| 3           | Charlie  | Delhi   |
| 4           | Diana    | Chennai |

### Orders Table
| order_id | customer_id | amount |
|----------|-------------|--------|
| 1        | 1           | 500    |
| 2        | 1           | 300    |
| 3        | 2           | 800    |
| 4        | 3           | 200    |
| 5        | 4           | 1000   |

