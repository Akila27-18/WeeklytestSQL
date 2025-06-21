CREATE DATABASE cart;
USE cart;

-- Table
CREATE TABLE Carts (
    cart_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    created_at DATE
);

CREATE TABLE CartItems (
    cart_item_id INT PRIMARY KEY AUTO_INCREMENT,
    cart_id INT,
    product_id INT,
    quantity INT
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    cart_id INT,
    order_date DATE
);

-- Inserting DAta
INSERT INTO Carts (customer_id, created_at) VALUES
(1, '2024-06-01'),
(2, '2024-06-01'),
(3, '2024-06-02'),
(4, '2024-06-02'),
(5, '2024-06-03'),
(6, '2024-06-03'),
(7, '2024-06-04');

INSERT INTO CartItems (cart_id, product_id, quantity) VALUES
(1, 101, 1),
(1, 102, 2),
(2, 103, 1),
(3, 101, 1),
(4, 104, 1),
(5, 102, 2),
(6, 105, 1),
(7, 106, 1);

INSERT INTO Orders (cart_id, order_date) VALUES
(1, '2024-06-01'),
(4, '2024-06-02'),
(6, '2024-06-03');

-- Output: % of abandoned carts per day/week.
SELECT 
    c.created_at AS date,
    COUNT(c.cart_id) AS total_carts,
    COUNT(CASE WHEN o.order_id IS NOT NULL THEN 1 END) AS checked_out,
    COUNT(CASE WHEN o.order_id IS NULL THEN 1 END) AS abandoned,
    ROUND(
        COUNT(CASE WHEN o.order_id IS NULL THEN 1 END) * 100.0 / COUNT(c.cart_id), 2
    ) AS abandonment_rate_percent
FROM Carts c
LEFT JOIN Orders o ON c.cart_id = o.cart_id
GROUP BY c.created_at
ORDER BY c.created_at;


-- Explanation
-- LEFT JOIN
-- Ensures all carts are included.

-- If a cart does not have a matching order, it will still appear (with NULL in o.order_id).

-- This allows us to identify abandoned carts.

-- | Expression                                           | Meaning                         |
-- | ---------------------------------------------------- | ------------------------------- |
-- | `COUNT(c.cart_id)`                                   | Total carts created             |
-- | `COUNT(CASE WHEN o.order_id IS NOT NULL THEN 1 END)` | Carts that were checked out     |
-- | `COUNT(CASE WHEN o.order_id IS NULL THEN 1 END)`     | Carts that were abandoned       |
-- | `ROUND(... * 100.0 / COUNT(...))`                    | Converts to a percentage (rate) |

-- CASE WHEN Allows Conditional Counting
-- COUNT(CASE WHEN o.order_id IS NOT NULL THEN 1 END) → checked out carts  
-- COUNT(CASE WHEN o.order_id IS NULL THEN 1 END)     → abandoned carts

-- | Concept     | Purpose                                 |
-- | ----------- | --------------------------------------- |
-- | `LEFT JOIN` | Include all carts, even if not ordered  |
-- | `COUNT()`   | Count total, checked out, and abandoned |
-- | `CASE WHEN` | Enable conditional counting             |

