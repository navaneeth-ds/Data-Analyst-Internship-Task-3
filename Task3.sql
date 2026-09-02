-- Task 3: SQL for Data Analysis
-- Database: ecommerce
-- Tool: MySQL Workbench

DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;

-- Create tables
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE
);

-- Insert sample data
INSERT INTO customers VALUES
(1, 'Rahul', 'Hyderabad'),
(2, 'Priya', 'Mumbai'),
(3, 'Amit', 'Delhi'),
(4, 'Sneha', 'Bangalore');

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 55000.00),
(102, 'Mobile Phone', 'Electronics', 25000.00),
(103, 'Headphones', 'Accessories', 2000.00),
(104, 'Keyboard', 'Accessories', 1500.00),
(105, 'Monitor', 'Electronics', 12000.00);

INSERT INTO orders VALUES
(1001, 1, 101, 2, '2026-01-10'),
(1002, 2, 102, 1, '2026-01-15'),
(1003, 1, 103, 3, '2026-01-20'),
(1004, 3, 104, 2, '2026-02-01'),
(1005, 4, 105, 1, '2026-02-05'),
(1006, 3, 102, 2, '2026-02-10'),
(1007, 2, 101, 1, '2026-02-15');

-- Basic SELECT
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;

-- Total sales
SELECT SUM(p.price * o.quantity) AS total_sales
FROM orders o
JOIN products p ON o.product_id = p.product_id;

-- Sales by category
SELECT p.category, SUM(p.price * o.quantity) AS total_sales
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

-- WHERE
SELECT * FROM products
WHERE price > 10000;

-- Average price
SELECT AVG(price) AS average_price
FROM products;

-- Subquery
SELECT product_name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- INNER JOIN
SELECT o.order_id, c.customer_name, p.product_name, o.quantity
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN products p ON o.product_id = p.product_id;

-- LEFT JOIN
SELECT c.customer_name, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- RIGHT JOIN
SELECT p.product_name, o.order_id
FROM orders o
RIGHT JOIN products p ON o.product_id = p.product_id;

-- VIEW
CREATE VIEW category_revenue AS
SELECT p.category, SUM(o.quantity * p.price) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category;

SELECT * FROM category_revenue;

-- INDEX
CREATE INDEX idx_customer_id
ON orders(customer_id);
