# 🎓 Volunteer Management & Analytics Dashboard

A comprehensive **ASP.NET Web Forms** application designed to manage student volunteer activities, track event participation, and provide real-time data analytics through a SQL Server backend.

## 🚀 Key Features

* **Student Management (CRUD):** Full Create, Read, Update, and Delete operations for student profiles.
* **Event Tracking:** A Many-to-Many ($* - *$ ) relationship model between Students and Events.
* **Dynamic Analytics Dashboard:** Visualizes participation data using various chart types (Pie, Column, Line).
* **Automated Ranking System:** A SQL-based logic that assigns ranks (Bronze, Silver, Gold) based on volunteer activity levels.
* **Advanced Search:** Filterable results powered by complex stored procedures with input and output parameters.

---

## 🛠 Tech Stack

* **Frontend:** ASP.NET Web Forms, HTML5, CSS3, Bootstrap.
* **Backend:** C# (ASP.NET), ADO.NET.
* **Database:** SQL Server (T-SQL).
* **Data Visualization:** ASP.NET Chart Controls.

---

## 📊 Database Architecture & Logic

The project demonstrates advanced database integration techniques as required by professional standards:

### 1. Data Binding & Connectivity

* **SqlDataAdapter:** Used to fetch multiple result sets (cursors) into a `DataSet` for synchronized Chart and GridView updates.
* **SqlDataReader:** Employed for high-performance, forward-only reading of specific student ranks.
* **SqlDataSource:** Implemented for automated CRUD operations in the management interface.

### 2. Stored Procedures & Functions

* **Stored Procedure (`GetEventsByStudentNameWithCount`):** Utilizes `INNER JOIN`, `GROUP BY`, and `COUNT` to return aggregated data and a total count via an **OUTPUT parameter**.
* **Scalar Function (`GetStudentRank`):** Encapsulates business logic within the DB to return a string representation of a student's status.

---

## 📈 Visualizations

The dashboard provides a "Data Aggregation" layer where raw participation records are grouped by location. Users can toggle between:

* **Column Charts:** For comparing participation volume across cities.
* **Pie Charts:** To see the distribution of volunteers.
* **Line Charts:** To visualize trends.

