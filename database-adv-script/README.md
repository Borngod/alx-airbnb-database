## Unleashing Advanced Querying Power

### 0\. Write Complex Queries with Joins


**Objective:** Master SQL joins by writing complex queries using different types of joins.

**Instructions:**

- Write a query using an `INNER JOIN` to retrieve all bookings and the respective users who made those bookings.
    
- Write a query using a`LEFT JOIN` to retrieve all properties and their reviews, including properties that have no reviews.
    
- Write a query using a `FULL OUTER JOIN` to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
    

**Repo:**

- GitHub repository: `alx-airbnb-database`
- Directory: `database-adv-script`
- File: `joins_queries.sql, README.md`

---

### 1\. Practice Subqueries


**Objective:** Write both correlated and non-correlated subqueries.

**Instructions:**

- Write a query to find all properties where the average rating is greater than 4.0 using a subquery.
    
- Write a correlated subquery to find users who have made more than 3 bookings.
    

**Repo:**

- GitHub repository: `alx-airbnb-database`
- Directory: `database-adv-script`
- File: `subqueries.sql, README.md`

---
### 2\. Apply Aggregations and Window Functions

**Objective:** Use SQL aggregation and window functions to analyze data.

**Instructions:**

- Write a query to find the total number of bookings made by each user, using the `COUNT` function and `GROUP BY` clause.
    
- Use a window function (`ROW_NUMBER, RANK`) to rank properties based on the total number of bookings they have received.
    

**Repo:**

- GitHub repository: `alx-airbnb-database`
- Directory: `database-adv-script`
- File: `aggregations_and_window_functions.sql, README.md`

---
### 3\. Implement Indexes for Optimization


**Objective**: Identify and create indexes to improve query performance.

**Instructions:**

- Identify high-usage columns in your `User`, `Booking`, and `Property` tables (e.g., columns used in WHERE, JOIN, ORDER BY clauses).
    
- Write SQL `CREATE INDEX` commands to create appropriate indexes for those columns and save them on `database_index.sql`
    
- Measure the query performance before and after adding indexes using `EXPLAIN` or `ANALYZE`.
    

**Repo:**

- GitHub repository: `alx-airbnb-database`
- Directory: `database-adv-script`
- File: `index_performance.md`

---
### 4\. Optimize Complex Queries


**Objective:** Refactor complex queries to improve performance.

**Instructions:**

- Write an initial query that retrieves all bookings along with the user details, property details, and payment details and save it on `perfomance.sql`
    
- Analyze the query’s performance using `EXPLAIN` and identify any inefficiencies.
    
- Refactor the query to reduce execution time, such as reducing unnecessary joins or using indexing.
    

**Repo:**

- GitHub repository: `alx-airbnb-database`
- Directory: `database-adv-script`
- File: `optimization_report.md, perfomance.sql`
