-- Create Database 
CREATE DATABASE ECommerceWelt; 

-- Use Database 
USE ECommerceWelt; 

-- Table: Categories
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL
);

-- Table: Products
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    CategoryID INT,
    Price DECIMAL(10, 2) NOT NULL,
    Description TEXT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Table: ProductAttributes
CREATE TABLE ProductAttributes (
    AttributeID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    AttributeName VARCHAR(100),
    AttributeValue VARCHAR(100),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Table: Customers
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    DateOfBirth DATE
);

-- Table: Addresses
CREATE TABLE Addresses (
    AddressID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    StreetAddress VARCHAR(255),
    City VARCHAR(100),
    PostalCode VARCHAR(20),
    Country VARCHAR(100) DEFAULT 'Germany',
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Table: Orders
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    ShippingAddressID INT,
    BillingAddressID INT,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ShippingAddressID) REFERENCES Addresses(AddressID),
    FOREIGN KEY (BillingAddressID) REFERENCES Addresses(AddressID)
);

-- Table: OrderItems
CREATE TABLE OrderItems (
    OrderItemID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


-- Table: Reviews
CREATE TABLE Reviews (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    CustomerID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    ReviewText TEXT,
    ReviewDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Table: Payments
CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    PaymentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    PaymentAmount DECIMAL(10, 2),
    PaymentMethod VARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Table: Stock
CREATE TABLE Stock (
    ProductID INT PRIMARY KEY,
    QuantityInStock INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


-- Insert Sample Data

-- Categories
INSERT INTO Categories (CategoryName) VALUES
('Electronics'),
('Fashion'),
('Home & Garden'),
('Books'),
('Toys');

-- Products
INSERT INTO Products (ProductName, CategoryID, Price, Description) VALUES
('Smartphone', 1, 299.99, 'Latest model with advanced features.'),
('Leather Jacket', 2, 129.99, 'Genuine leather jacket for all seasons.'),
('Coffee Maker', 3, 89.99, 'Brews coffee quickly and efficiently.'),
('The Great Gatsby', 4, 10.99, 'Classic novel by F. Scott Fitzgerald.'),
('Toy Car', 5, 15.99, 'Durable toy car for kids.');

-- ProductAttributes
INSERT INTO ProductAttributes (ProductID, AttributeName, AttributeValue) VALUES
(1, 'Color', 'Black'),
(1, 'Storage', '128GB'),
(2, 'Size', 'L'),
(2, 'Color', 'Brown'),
(3, 'Capacity', '1.5L'),
(4, 'Author', 'F. Scott Fitzgerald'),
(5, 'Age Group', '3-5 years');

-- Customers
INSERT INTO Customers (FirstName, LastName, Email, Phone, DateOfBirth) VALUES
('John', 'Doe', 'john.doe@example.com', '+491234567890', '1985-05-15'),
('Jane', 'Smith', 'jane.smith@example.com', '+491234567891', '1990-09-22');

-- Addresses
INSERT INTO Addresses (CustomerID, StreetAddress, City, PostalCode, Country) VALUES
(1, 'Hauptstraße 1', 'Berlin', '10115', 'Germany'),
(2, 'Berliner Straße 25', 'Hamburg', '20095', 'Germany');

-- Orders
INSERT INTO Orders (CustomerID, ShippingAddressID, BillingAddressID, TotalAmount) VALUES
(1, 1, 1, 299.99),
(2, 2, 2, 129.99);

-- OrderItems
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 299.99),
(2, 2, 1, 129.99);

-- Reviews
INSERT INTO Reviews (ProductID, CustomerID, Rating, ReviewText) VALUES
(1, 1, 5, 'Excellent smartphone with great features.'),
(2, 2, 4, 'Very stylish jacket, but a bit pricey.');

-- Payments
INSERT INTO Payments (OrderID, PaymentAmount, PaymentMethod) VALUES
(1, 299.99, 'Credit Card'),
(2, 129.99, 'PayPal');

-- Stock
INSERT INTO Stock (ProductID, QuantityInStock) VALUES
(1, 50),
(2, 20),
(3, 30),
(4, 100),
(5, 150);


SELECT * FROM categories; 
SELECT * FROM Products; 
SELECT * FROM ProductAttributes; 
SELECT * FROM customers; 
SELECT * FROM orders; 
SELECT * FROM orderitems; 
SELECT * FROM reviews; 
SELECT * FROM payments; 
SELECT * FROM stock; 
SELECT * FROM addresses; 
-- **BASIC SQL QUERIES** 

-- 1. What are the names and prices of all products available in each category? 

SELECT p.productname, p.price FROM products p 
JOIN categories c ON p.categoryID = c.categoryID 
ORDER BY c.CategoryName, p.ProductName;

-- 2. Which customers have made purchases, and what are their email addresses?

SELECT c.customerid, CONCAT(c.firstname, ' ', c.lastname) AS customername, c.email FROM customers c
JOIN orders o ON c.customerid = o.customerid;

-- 3. What are the details of each order, including the products and quantities ordered?

SELECT p.productname, oi.productid, oi.quantity FROM orderitems oi 
JOIN orders o ON oi.orderid = o.orderid
JOIN products p ON p.productID = oi.productID
ORDER BY p.productname; 

-- 4. What is the total sales amount for each product?

SELECT P.productname, SUM(oi.quantity * oi.price) AS total_sales FROM orderitems oi 
JOIN products p ON p.productid = oi.productid
GROUP BY oi.productid; 


-- 5. Which customers have left reviews for a specific product, 
-- And what ratings and comments did they provide?

SELECT CONCAT(c.firstname, ' ', c.lastname) AS customername, 
p.productname, r.rating, r.reviewtext FROM reviews r 
JOIN customers c ON c.customerid = r.customerid
JOIN products p ON p.productid = r.productid
WHERE p.productid = 1; 

-- 6. Which products have not been ordered by any customers?

SELECT p.productid FROM products p 
JOIN orderitems oi ON p.productid = oi.productid
WHERE p.productid IS NULL; 

-- 7. What are the total number of orders placed by each customer?

SELECT COUNT(*) AS total_orders FROM orders o 
JOIN customers c ON c.customerid = o.customerid
GROUP BY o.customerid; 


-- 8. List all categories that have no products associated with them.

SELECT c.categoryname FROM category c 
JOIN products p ON p.categoryid = c.categoryid
WHERE p.productid IS NULL; 

-- 9. Which customers have placed the most orders?

SELECT c.firstname, COUNT(o.orderid) AS order_count
FROM customers c
JOIN orders o ON c.customerid = o.customerid
GROUP BY c.customerid,c.firstname
ORDER BY order_count DESC;


-- 10. What is the average order value (total price) for each order?

SELECT orderid, ROUND(AVG(totalamount),2) as average_order_value 
FROM orders
GROUP BY orderid
ORDER BY orderid; 


-- 11. List all products that have received a rating of 4 stars or higher.

SELECT r.rating, p.productname 
FROM reviews r JOIN products p 
WHERE r.rating >= 4
ORDER BY r.rating DESC; 

-- 12. How many products are in each category?

SELECT COUNT(p.productid) as product_count, c.categoryname
FROM categories c JOIN products p ON 
c.categoryid = c.categoryid
GROUP BY categoryname; 

-- 13. What are the names and email addresses of customers who have never made a purchase?

SELECT CONCAT(c.firstname, ' ' , c.lastname) AS customername, c.email FROM customers c 
JOIN orders o ON c.customerid NOT IN (o.customerid); 

-- 14. Which products are low in stock (e.g., quantity on hand is less than 10)?

SELECT p.productname, s.quantityinstock FROM products p JOIN stock s ON 
p.productid = s.productid 
WHERE s.quantityinstock<10; 

-- 15. What is the highest-rated product in each category?

SELECT p.productname, c.categoryname FROM products p 
JOIN reviews r ON p.productid = r.productid 
JOIN categories c ON c.categoryid = p.categoryid
GROUP BY c.categoryname,p.productname,r.rating
ORDER BY r.rating DESC LIMIT 1; 

-- 16. List all orders that were placed in the last 30 days.

SELECT * FROM orders WHERE orderdate >= DATE_SUB(CURDATE(), INTERVAL 30 DAY); 

-- 17. Find the top 5 most expensive products available in the store.

SELECT * FROM products 
ORDER BY price DESC LIMIT 5; 


-- 18. What is the total number of products sold in each month of the current year?

SELECT
    MONTH(o.orderdate) AS month,
    SUM(oi.quantity) AS total_products_sold
FROM
    orders o JOIN orderitems oi ON o.orderid = oi.orderid
WHERE
    YEAR(o.orderdate) = YEAR(CURDATE())
GROUP BY
    MONTH(orderdate)
ORDER BY
    MONTH(orderdate);

-- 19. Which products have been ordered the most by customers from a specific city?

-- product details from products table -- productid, categoryid
-- max.ordered item from orderitem table -- product id, orderid, orderitemid 
-- orders -- orderid, cusCustomerIDtomerid
-- customer from city addresses table  -- addressid, customerid
SELECT 
    p.productid,
    p.categoryid,
    COUNT(oi.orderitemid) AS total_orders
FROM 
    Products p
INNER JOIN 
    OrderItems oi ON p.productid = oi.productid
INNER JOIN 
    Orders o ON oi.orderid = o.orderid
INNER JOIN 
    Addresses a ON o.customerid = a.customerid
WHERE 
    a.city = 'Hamburg' 
GROUP BY 
    p.productid, p.categoryid
ORDER BY 
    total_orders DESC;
