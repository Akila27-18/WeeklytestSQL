USE hospital;
CREATE TABLE Medicines (
    medicine_id INT PRIMARY KEY,
    medicine_name VARCHAR(100),
    batch_number VARCHAR(50),
    expiry_date DATE,
    stock_quantity INT
);

INSERT INTO Medicines VALUES
(1, 'Paracetamol', 'B101', '2024-12-31', 120),
(2, 'Amoxicillin', 'B202', '2025-06-01', 50),
(3, 'Cetirizine', 'B303', '2025-12-01', 80),
(4, 'Ibuprofen', 'B404', '2023-10-15', 0),
(5, 'Metformin', 'B505', '2025-06-20', 30);

-- Expired Medicine Alert
SELECT 
    medicine_name,
    batch_number,
    expiry_date,
    stock_quantity
FROM 
    Medicines
WHERE 
    expiry_date < CURDATE()
ORDER BY 
    expiry_date ASC;

-- Explanation
-- | Clause                          | Purpose                                                           |
-- | ------------------------------- | ----------------------------------------------------------------- |
-- | `WHERE expiry_date < CURDATE()` | Filters all medicines whose expiry date is **before today**       |
-- | `ORDER BY expiry_date ASC`      | Lists **earliest expired medicines first** for priority attention |

