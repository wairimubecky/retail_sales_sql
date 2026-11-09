# Retail Sales & Customer Intelligence Using PostgreSQL
## Project Overview
This project explores retail sales data using PostgreSQL to investigate sales performance, customer purchasing behaviour, product performance and business profitability. The analysis is based on an electronics retailer, Duka Smart Electronics.

The project uses SQL to transform raw transactional data into meaningful business information, answering questions that can support decision-making in areas such as sales strategy, customer retention, product performance and revenue management.

## Project Objectives
The main objectives of this project are to:
- Explore and understand the structure of the retail sales database.
- Analyse sales performance, revenue and profitability.
- Examine customer purchasing patterns and customer segments.
- Identify high-performing products and product categories.
- Apply SQL techniques to answer business questions.
- Translate query results into actionable business insights and recommendations.

## Tools and Technologies
- **PostgreSQL:** Relational database management system used to store and analyse the data.
- **DBeaver:** Database management tool used to connect to PostgreSQL, execute SQL queries and inspect query results.
- **SQL:** Used for data retrieval, transformation, aggregation and analysis.
- **Git and GitHub:** Used for version control and project documentation.

## Database Overview
The project uses two main relational tables:
**Customers**
Contains customer information, including customer ID, name, gender, city, registration date and customer segment.
**Orders**
Contains transactional information, including order ID, customer ID, order date, product name, product category, quantity, unit price, cost price, discount, payment method and order status.

The two tables are connected through `customer_id`, which links each order to the customer who placed it.

The dataset contains 150 customers and 800 orders, covering the period from January 2025 to September 2026.

## Business Rules and Calculations
The following business rules guide the analysis:
- Revenue = Quantity × Unit Price × (1 − Discount / 100)
- Cost = Quantity × Cost Price
- Profit = Revenue − Cost
- Profit Margin = (Profit / Revenue) × 100

## SQL Analysis
The project addresses 46 business questions organised into the following areas:
1. **SQL Fundamentals:** Basic data retrieval, filtering, sorting and conditional expressions.
2. **Aggregate Functions:** Calculations involving counts, sums, averages, minimums and maximums.
3. **Joins and Customer Analytics:** Combining customer and order data to explore purchasing behaviour.
4. **Subqueries and Common Table Expressions:** Breaking down more complex analytical problems into manageable queries.
5. **Window Functions:** Analysing rankings, running totals and comparisons across groups.
6. **Advanced Business Intelligence:** Applying SQL techniques to more complex business questions and management reporting.

## Project Structure
The repository contains the SQL scripts used to create the database tables, populate the dataset, verify the data and perform the analysis. It also includes documentation of the findings and selected query outputs.

## How to Run the Project
1. Install PostgreSQL and DBeaver.
2. Connect DBeaver to your PostgreSQL server.
3. Create a database for the project.
4. Open and execute the SQL scripts in the appropriate order:
   - `02_create_tables.sql`
   - `03_insert_customers.sql`
   - `04_insert_orders.sql`
   - `05_verify_data.sql`
5. Open the analysis queries and execute them against the database.

## Project Deliverables
- SQL scripts containing the database structure, data insertion and analysis queries.
- Solutions to 46 business questions.
- Business insights derived from the analysis.
- Recommendations informed by the findings.
- Selected screenshots demonstrating query execution and results.


