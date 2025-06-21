CREATE DATABASE revenue;
USE revenue;

-- CREATE TABLE
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE
);

CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
-- Insert Data
INSERT INTO Products (name, price) VALUES
('Laptop', 750.00),
('Mouse', 20.00),
('Keyboard', 25.00),
('Monitor', 150.00);

INSERT INTO Orders (order_date) VALUES
('2024-01-15'),  -- Q1
('2024-02-20'),  -- Q1
('2024-04-10'),  -- Q2
('2024-05-12'),  -- Q2
('2024-08-05'),  -- Q3
('2024-10-18'),  -- Q4
('2024-12-22');  -- Q4

INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES
(1, 1, 1),  -- Laptop
(1, 2, 2),  -- Mouse
(2, 3, 1),  -- Keyboard
(3, 4, 2),  -- Monitor
(4, 1, 1),  -- Laptop
(5, 2, 10), -- Mouse
(6, 1, 1),  -- Laptop
(7, 3, 3);  -- Keyboard

SELECT 
    QUARTER(o.order_date) AS quarter,
    SUM(od.quantity * p.price) AS total_revenue
FROM Orders o
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
GROUP BY QUARTER(o.order_date)
ORDER BY quarter;

-- Explanation
-- | Concept     | Purpose                                       |
-- | ----------- | --------------------------------------------- |
-- | `QUARTER()` | Extracts quarter number from `order_date`     |
-- | `SUM()`     | Calculates total revenue (`price × quantity`) |
-- | `GROUP BY`  | Groups revenue by quarter                     |


