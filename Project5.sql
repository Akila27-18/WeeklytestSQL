CREATE DATABASE stock;
USE stock;

-- Tables
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    stock_quantity INT NOT NULL,
    reorder_level INT NOT NULL
);

INSERT INTO Products (name, stock_quantity, reorder_level) VALUES
('Laptop', 5, 10),
('Mouse', 50, 20),
('Keyboard', 15, 10),
('Monitor', 2, 5),
('USB Cable', 0, 15),
('Webcam', 25, 10);

-- Stock Alert list of products below reorder level

SELECT 
    product_id,
    name,
    stock_quantity,
    reorder_level,
    CASE 
        WHEN stock_quantity = 0 THEN 'Out of Stock'
        WHEN stock_quantity < reorder_level THEN 'Low Stock'
        ELSE 'Sufficient Stock'
    END AS stock_status
FROM Products
WHERE stock_quantity < reorder_level;

-- Explanation
-- | Concept     | Use                                                  |
-- | ----------- | ---------------------------------------------------- |
-- | `WHERE`     | Filters only products below `reorder_level`          |
-- | `CASE WHEN` | Assigns readable status labels based on stock levels |


