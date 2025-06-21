CREATE DATABASE promo;
USE promo;
-- CREATe table
CREATE TABLE Promotions (
    promotion_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    discount_percent DECIMAL(5,2)
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
    price DECIMAL(10, 2) -- price after discount
);

-- Insert DAta
INSERT INTO Promotions (product_id, discount_percent) VALUES
(1, 10.00),  -- Product 1 is on discount
(3, 20.00);  -- Product 3 is on discount

INSERT INTO Orders (order_date) VALUES
('2024-01-10'),
('2024-02-15'),
('2024-03-05'),
('2024-03-20');

INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES
-- With discount
(1, 1, 2, 675.00),  -- Product 1 (discounted)
(2, 3, 1, 80.00),   -- Product 3 (discounted)

-- Without discount
(3, 2, 3, 20.00),   -- Product 2 (no promotion)
(4, 1, 1, 750.00);  -- Product 1 (no discount used)

-- Compare Sales With vs. Without Discount
SELECT
    od.product_id,
    CASE 
        WHEN p.promotion_id IS NOT NULL THEN 'With Discount'
        ELSE 'Without Discount'
    END AS discount_status,
    SUM(od.quantity) AS total_quantity_sold,
    SUM(od.quantity * od.price) AS total_revenue
FROM OrderDetails od
LEFT JOIN Promotions p ON od.product_id = p.product_id
GROUP BY od.product_id, discount_status
ORDER BY od.product_id, discount_status;

-- EXPLANATION
-- | Concept     | Use                                                          |
-- | ----------- | ------------------------------------------------------------ |
-- | `JOIN`      | Identify which products are part of a promotion              |
-- | `GROUP BY`  | Compare grouped totals (quantity/revenue) by discount status |
-- | `CASE WHEN` | Label each order detail as discounted or not                 |
-- | `SUM()`     | Total quantity and revenue per group                         |
