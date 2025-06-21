CREATE DATABASE ret;
USE ret;
-- Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE
);
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT
);
CREATE TABLE Returns (
    return_id INT PRIMARY KEY AUTO_INCREMENT,
    order_detail_id INT,
    return_date DATE,
    quantity_returned INT,
    FOREIGN KEY (order_detail_id) REFERENCES OrderDetails(order_detail_id)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    category VARCHAR(50)
);

-- Insert
INSERT INTO Products (name, category) VALUES
('Laptop', 'Electronics'),
('Mouse', 'Accessories'),
('Keyboard', 'Accessories');

INSERT INTO Orders (order_date) VALUES
('2024-01-10'),
('2024-02-15');

INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES
(1, 1, 2),   -- 2 Laptops
(1, 2, 3),   -- 3 Mice
(2, 3, 4);   -- 4 Keyboards

INSERT INTO Returns (order_detail_id, return_date, quantity_returned) VALUES
(1, '2024-01-20', 1),  -- 1 Laptop returned
(3, '2024-02-20', 2);  -- 2 Keyboards returned

-- Return Rate per Product
SELECT 
    p.category,
    COUNT(DISTINCT od.order_detail_id) AS total_orders,
    COUNT(DISTINCT r.return_id) AS total_returns
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
LEFT JOIN Returns r ON od.order_detail_id = r.order_detail_id
GROUP BY p.category;

-- Count Returns per product with product name
SELECT 
    p.product_id,
    p.name AS product_name,
    COUNT(DISTINCT od.order_detail_id) AS total_orders,
    COUNT(DISTINCT r.return_id) AS total_returns
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
LEFT JOIN Returns r ON od.order_detail_id = r.order_detail_id
GROUP BY p.product_id, p.name
ORDER BY p.name;
-- EXPLANATION
-- | Concept    | Usage                                                          |
-- | ---------- | -------------------------------------------------------------- |
-- | `COUNT()`  | Measure number of orders or returns                            |
-- | `GROUP BY` | Segment totals per product, category, customer, or time period |
-- | SQL Part                    | Role                                                  |
-- | --------------------------- | ----------------------------------------------------- |
-- | `COUNT(od.order_detail_id)` | Counts how many times each product was sold           |
-- | `COUNT(r.return_id)`        | Counts how many return records exist for that product |
-- | `GROUP BY od.product_id`    | Tells SQL to perform counts **per product**           |
-- | SQL Element                       | Description                                |
-- | --------------------------------- | ------------------------------------------ |
-- | `JOIN Products p`                 | To fetch product name and category         |
-- | `COUNT(DISTINCT order_detail_id)` | Number of unique order lines per product   |
-- | `COUNT(DISTINCT return_id)`       | Number of return records per product       |
-- | `GROUP BY p.product_id, p.name`   | Groups the results by product for counting |





