# Hotel Room Booking System

A SQL-based **Hotel Room Booking System** designed to manage rooms, customers, bookings, payments, room availability, and billing.

## 📌 Project Overview

This project demonstrates how SQL can be used to build and manage a basic hotel booking database. It includes multiple related tables, foreign-key relationships, SQL queries, triggers, joins, calculations, and revenue analysis.

## 🗃️ Database Tables

* **Rooms** — Stores room details, room type, price, and availability status.
* **Customers** — Stores customer information.
* **Bookings** — Records room reservations, check-in/check-out dates, total days, and total amount.
* **Payments** — Stores payment information related to bookings.

## ⚙️ Features

* Create and manage hotel rooms
* Store customer information
* Book rooms for customers
* Check room availability
* Automatically calculate total booking days
* Automatically calculate the total bill
* Automatically update room status to **Occupied** after booking
* Generate booking bills using SQL `JOIN`
* Record customer payments
* Calculate total revenue per room
* Check room availability for a specific date

## 🔑 SQL Concepts Used

* `CREATE TABLE`
* Primary Keys
* Foreign Keys
* `INSERT`
* `SELECT`
* `WHERE`
* `JOIN`
* `GROUP BY`
* `HAVING`
* Date calculations
* Database Triggers
* Aggregate functions such as `SUM()`

## 🔄 Triggers

### 1. Automatic Room Status Update

After a booking is created, the corresponding room status is automatically changed from **Available** to **Occupied**.

### 2. Automatic Bill Calculation

Before inserting a booking, the trigger automatically calculates:

* Total number of days
* Total booking amount based on the room's daily price

## 🛠️ Technology

* **Database:** Oracle Database
* **Language:** SQL / PL/SQL

## 📂 Project Structure

```text
Hotel-Room-Booking-System/
│
├── miniproj.sql
└── README.md
```

## 🎯 Learning Outcomes

This project helped demonstrate practical knowledge of relational databases, table relationships, SQL queries, joins, constraints, triggers, calculations, and database management.

## 👩‍💻 Author

**Fiza Zulfiqar**
