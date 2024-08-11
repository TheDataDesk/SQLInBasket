# SQL IN BASKET 

# SQLInBucket

Welcome to **SQLInBucket**, your ultimate resource for mastering SQL through hands-on projects using an e-commerce database. This repository provides a curated set of SQL exercises designed to enhance your SQL skills by working on real-world scenarios that simulate common tasks in an e-commerce environment. Whether you are a beginner or an intermediate learner, this repository will help you build a solid foundation in SQL.

## Table of Contents

- [About the Project](#about-the-project)
- [Getting Started](#getting-started)
- [Database Schema](#database-schema)
- [Projects](#projects)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgments](#acknowledgments)

## About the Project

SQLInBucket is more than just a collection of SQL queries; it's a structured learning journey. The projects are designed to be progressively challenging, covering various aspects of SQL such as data retrieval, aggregation, subqueries, joins, and more. By working through these projects, you'll gain practical experience in writing efficient SQL queries and solving real-world problems.

### Key Features:
- **Realistic E-commerce Database**: Simulate operations of a typical online store with tables representing products, customers, orders, payments, and more.
- **Incremental Learning**: Start with simple queries and gradually progress to complex ones.
- **Project-Based**: Each project focuses on different SQL concepts, ensuring comprehensive coverage.
- **Practice Problems**: Test your skills with additional problems after each project.

## Getting Started

### Prerequisites

To start working on the projects, you need the following:

- Basic understanding of SQL syntax and concepts.
- A SQL database management system (DBMS) like MySQL, PostgreSQL, or SQLite installed on your machine.
- A SQL client or an IDE such as MySQL Workbench, DBeaver, or pgAdmin.

### Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/TheDataDesk/SQLInBucket.git
    cd SQLInBucket
    ```

2. Import the database schema:
   - Use the SQL file provided in the `schema/` directory to set up the e-commerce database on your DBMS.
   - Example for MySQL:
     ```bash
     mysql -u yourusername -p yourpassword < schema/ecommerce_schema.sql
     ```

3. You're ready to start coding in SQL!

## Database Schema

The e-commerce database consists of several tables, each representing a different entity in an online store. Below is a brief overview:

- **Customers**: Information about customers, including names, emails, and addresses.
- **Products**: Details of products available in the store, including name, price, and stock levels.
- **Orders**: Records of customer orders, including order dates and statuses.
- **OrderItems**: Line items within each order, linking products to orders.
- **Payments**: Information on payments made for each order, including amounts and payment methods.
- **Categories**: Categories to which products belong, aiding in organizing the store’s inventory.

For a detailed schema diagram, refer to the `schema/ecommerce_schema_diagram.png` file.

## Projects

The repository is organized into a series of projects. Each project folder contains:

- A README file with project instructions.
- SQL files with example queries.
- Practice problems for additional learning.

### Project List

1. **Basic Queries**: Retrieve data from single tables using `SELECT`, `WHERE`, `ORDER BY`, etc.
2. **Joins and Relationships**: Work with multiple tables using `JOIN` statements.
3. **Aggregation and Grouping**: Analyze data using `GROUP BY`, `HAVING`, and aggregate functions like `COUNT`, `SUM`, `AVG`.
4. **Subqueries**: Use subqueries to solve complex problems.
5. **Advanced Topics**: Learn about window functions, CTEs, and optimizing queries.

## Usage

1. Navigate to the project directory you're working on.
2. Read the README file for instructions.
3. Open your SQL client and start executing the queries.
4. Try to solve the practice problems on your own before checking the solutions provided.

Example:
```bash
cd projects/basic_queries
cat README.md
