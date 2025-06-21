CREATE DATABASE topselling;
USE topselling;

-- Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE NOT NULL
);

-- OrderDetails Table
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert into products
INSERT INTO Products (name, price) VALUES
('Laptop', 750.00),
('Mouse', 20.00),
('Keyboard', 25.00),
('Monitor', 150.00),
('USB Cable', 5.00);

-- Insert into Orders
INSERT INTO Orders (order_date) VALUES
('2024-01-10'),
('2024-01-15'),
('2024-02-05'),
('2024-02-20'),
('2024-03-10'),
('2024-03-25');

-- Insert into Orderdetails

INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES
-- January Orders
(1, 1, 2),  -- 2 Laptops
(1, 2, 5),  -- 5 Mice
(2, 2, 3),  -- 3 Mice

-- February Orders
(3, 3, 4),  -- 4 Keyboards
(3, 2, 2),  -- 2 Mice
(4, 3, 1),  -- 1 Keyboard
(4, 5, 10), -- 10 USB Cables

-- March Orders
(5, 4, 2),  -- 2 Monitors
(6, 5, 15); -- 15 USB Cables

-- Month-wise top products by quantity sold.

WITH MonthlySales AS (
  SELECT 
    MONTH(o.order_date) AS sale_month,
    p.name AS product_name,
    SUM(od.quantity) AS total_quantity,
    RANK() OVER (
      PARTITION BY MONTH(o.order_date)
      ORDER BY SUM(od.quantity) DESC
    ) AS rank_in_month
  FROM OrderDetails od
  JOIN Orders o ON od.order_id = o.order_id
  JOIN Products p ON od.product_id = p.product_id
  GROUP BY MONTH(o.order_date), p.product_id
)
SELECT 
  sale_month,
  product_name,
  total_quantity
FROM MonthlySales
WHERE rank_in_month = 1
ORDER BY sale_month;


-- | Concept          | Use in Query                                           |
-- | ---------------- | ------------------------------------------------------ |
-- | `JOIN`           | Combine orders with product and quantity               |
-- | `MONTH()`        | Extract month number from `order_date`                 |
-- | `SUM()`          | Total quantity sold per product per month              |
-- | `GROUP BY`       | Group results by month and product                     |
-- | `RANK()`         | Rank products within each month by total quantity sold |
-- | `WHERE rank = 1` | Filter only the **top-selling product(s)** per month   |
