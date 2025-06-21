CREATE DATABASE city;
USE city;

-- Create Table
-- Customer
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    region VARCHAR(50),
    city VARCHAR(50)
);

-- Products
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    price DECIMAL(10, 2)
);

-- Orders
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Orderdetails
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert Data into Table

INSERT INTO Customers (name, email, region, city) VALUES
('Alice', 'alice@sales.com', 'North', 'Delhi'),
('Bob', 'bob@sales.com', 'South', 'Chennai'),
('Charlie', 'charlie@sales.com', 'West', 'Mumbai'),
('David', 'david@sales.com', 'East', 'Kolkata'),
('Eva', 'eva@sales.com', 'South', 'Chennai');

INSERT INTO Products (name, price) VALUES
('Laptop', 750.00),
('Mouse', 20.00),
('Keyboard', 25.00),
('Monitor', 150.00);

INSERT INTO Orders (customer_id, order_date) VALUES
(1, '2024-01-10'), -- Alice
(2, '2024-01-15'), -- Bob
(3, '2024-02-05'), -- Charlie
(4, '2024-02-25'), -- David
(5, '2024-03-01'); -- Eva

INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES
(1, 1, 1),  -- Alice: Laptop
(1, 2, 2),  -- Alice: Mouse
(2, 1, 1),  -- Bob: Laptop
(2, 3, 1),  -- Bob: Keyboard
(3, 4, 2),  -- Charlie: Monitor
(4, 3, 3),  -- David: Keyboard
(5, 2, 5);  -- Eva: Mouse

-- Sales by region/city
SELECT 
    c.region,
    c.city,
    SUM(od.quantity * p.price) AS total_sales
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
GROUP BY c.region, c.city
ORDER BY total_sales DESC;

-- Explanation
-- We join all tables to access region and city from Customers, and quantity * price from OrderDetails and Products.

-- We use GROUP BY region, city to calculate total sales for each city within a region.

-- SUM(quantity × price) gives the total sales value.

-- | Concept    | Use                                      |
-- | ---------- | ---------------------------------------- |
-- | `JOIN`     | Combine data across all 4 tables         |
-- | `GROUP BY` | Aggregate sales by `region` and `city`   |
-- | `SUM()`    | Calculate total sales (quantity × price) |
