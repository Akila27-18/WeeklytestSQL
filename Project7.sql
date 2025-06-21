CREATE DATABASE cat;
USE cat;
-- Tables
CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
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

-- Insert DAta

INSERT INTO Categories (category_name) VALUES
('Electronics'),
('Accessories'),
('Peripherals');

INSERT INTO Products (name, price, category_id) VALUES
('Laptop', 750.00, 1),
('Monitor', 150.00, 1),
('Mouse', 20.00, 2),
('Keyboard', 25.00, 2),
('Webcam', 45.00, 3);

INSERT INTO Orders (order_date) VALUES
('2024-01-15'),
('2024-02-10'),
('2024-03-05');

INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES
-- Order 1
(1, 1, 1),   -- Laptop
(1, 3, 2),   -- Mouse

-- Order 2
(2, 2, 1),   -- Monitor
(2, 4, 1),   -- Keyboard

-- Order 3
(3, 3, 1),   -- Mouse
(3, 5, 1);   -- Webcam

-- Average Order Value by Category

SELECT 
    c.category_name,
    ROUND(AVG(od_total.total_value), 2) AS avg_order_value
FROM (
    SELECT 
        o.order_id,
        p.category_id,
        SUM(od.quantity * p.price) AS total_value
    FROM Orders o
    JOIN OrderDetails od ON o.order_id = od.order_id
    JOIN Products p ON od.product_id = p.product_id
    GROUP BY o.order_id, p.category_id
) AS od_total
JOIN Categories c ON od_total.category_id = c.category_id
GROUP BY c.category_name;

-- Explanation
-- | Concept    | Purpose                                                    |
-- | ---------- | ---------------------------------------------------------- |
-- | `JOIN`     | Connect `Orders`, `Products`, `Categories`, `OrderDetails` |
-- | `GROUP BY` | Group values by `category_id`, then `category_name`        |
-- | `AVG()`    | Compute average value per category across orders           |
-- | `SUM()`    | Calculate total value of each order per category           |

