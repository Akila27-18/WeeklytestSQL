CREATE DATABASE id;
USE id;
-- Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
-- Insert
INSERT INTO Customers (name, email) VALUES
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com'),
('Charlie', 'charlie@example.com'),
('Diana', 'diana@example.com');

INSERT INTO Orders (customer_id, order_date) VALUES
(1, '2024-01-10'),
(1, '2024-03-15'),
(2, '2024-02-20'),
(3, '2024-03-05'),
(1, '2024-04-10'),
(3, '2024-06-01');

-- Repeat Customer Identification
SELECT 
    c.customer_id,
    c.name,
    c.email,
    COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.email
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC;

-- Explanation
-- | Concept    | Purpose                                    |
-- | ---------- | ------------------------------------------ |
-- | `JOIN`     | Link customers with their orders           |
-- | `GROUP BY` | Group rows by customer                     |
-- | `COUNT()`  | Count how many orders each customer placed |
-- | `HAVING`   | Filter only those with `COUNT > 1`         |

