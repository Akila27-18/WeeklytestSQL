CREATE DATABASE purchase;
USE purchase;

-- Create Table

-- Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- Orderdetails Table
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert into Customers
INSERT INTO Customers (name, email) VALUES
('Alice Johnson', 'alice@example.com'),
('Bob Smith', 'bob@example.com'),
('Charlie Davis', 'charlie@example.com');

-- Insert into Products
INSERT INTO Products (name, price) VALUES
('Laptop', 750.00),
('Mouse', 20.00),
('Keyboard', 25.00),
('Monitor', 150.00),
('USB Cable', 5.00);

-- Insert into Orders
INSERT INTO Orders (customer_id, order_date) VALUES
(1, '2024-01-10'),
(1, '2024-02-05'),
(2, '2024-03-15'),
(3, '2024-04-01');

-- Insert into Orderdetails
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES
-- Alice's first order
(1, 1, 1),  -- Laptop
(1, 2, 2),  -- Mouse

-- Alice's second order
(2, 4, 1),  -- Monitor
(2, 5, 3),  -- USB Cable

-- Bob's order
(3, 3, 1),  -- Keyboard

-- Charlie's order
(4, 2, 1),  -- Mouse
(4, 3, 1);  -- Keyboard

-- SQL Concepts: JOINs
SELECT 
    c.customer_id,
    c.name AS customer_name,
    o.order_id,
    o.order_date,
    p.name AS product_name,
    od.quantity,
    (od.quantity * p.price) AS total_price
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
ORDER BY c.customer_id, o.order_date, o.order_id;

-- SQL Concepts: JOINs, Groupby

SELECT 
    o.order_id,
    c.name AS customer_name,
    o.order_date,
    p.name AS product_name,
    SUM(od.quantity) AS total_quantity,
    SUM(od.quantity * p.price) AS total_price
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
GROUP BY o.order_id, c.name, o.order_date, p.name
ORDER BY o.order_date, o.order_id;


