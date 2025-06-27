USE finance;
CREATE TABLE Branches (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(50),
  location VARCHAR(50)
);

CREATE TABLE BranchTargets (
  branch_id INT,
  target_month DATE,
  target_amount DECIMAL(10,2),
  PRIMARY KEY (branch_id, target_month),
  FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
);

CREATE TABLE Sales (
  sale_id INT PRIMARY KEY,
  branch_id INT,
  sale_date DATE,
  amount DECIMAL(10,2),
  FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
);

-- Branches
INSERT INTO Branches VALUES
(1, 'Chennai Main', 'Chennai'),
(2, 'Coimbatore Center', 'Coimbatore');

-- Targets (for June 2025)
INSERT INTO BranchTargets VALUES
(1, '2025-06-01', 100000.00),
(2, '2025-06-01', 80000.00);

-- Sales
INSERT INTO Sales VALUES
(1, 1, '2025-06-05', 40000.00),
(2, 1, '2025-06-15', 30000.00),
(3, 1, '2025-06-25', 35000.00),
(4, 2, '2025-06-03', 20000.00),
(5, 2, '2025-06-20', 30000.00);

-- Branch vs Target Comparison
SELECT 
  b.branch_name,
  DATE_FORMAT(t.target_month, '%Y-%m') AS month,
  t.target_amount,
  COALESCE(SUM(s.amount), 0) AS actual_sales,
  COALESCE(SUM(s.amount), 0) - t.target_amount AS performance_diff,
  CASE 
    WHEN COALESCE(SUM(s.amount), 0) >= t.target_amount THEN 'Met or Exceeded'
    ELSE 'Below Target'
  END AS performance_status
FROM BranchTargets t
JOIN Branches b ON t.branch_id = b.branch_id
LEFT JOIN Sales s 
  ON t.branch_id = s.branch_id 
  AND MONTH(s.sale_date) = MONTH(t.target_month) 
  AND YEAR(s.sale_date) = YEAR(t.target_month)
GROUP BY b.branch_name, t.target_month, t.target_amount
ORDER BY b.branch_name;

-- Explanation
-- | Clause / Logic                 | Purpose                                                     |
-- | ------------------------------ | ----------------------------------------------------------- |
-- | `SUM(s.amount)`                | Calculates actual sales per branch for the month            |
-- | `COALESCE(..., 0)`             | Ensures branches with no sales still show 0 instead of NULL |
-- | `target_amount - actual_sales` | Computes difference between actual and target               |
-- | `CASE ... THEN ...`            | Classifies performance: met/exceeded or below target        |
-- | `LEFT JOIN Sales`              | So branches with 0 sales still show up                      |
