USE finance;
CREATE TABLE Users7 (
  user_id INT PRIMARY KEY,
  name VARCHAR(50)
);
CREATE TABLE Transactions3 (
  txn_id INT PRIMARY KEY,
  user_id INT,
  txn_date DATE,
  txn_type VARCHAR(10),   -- 'Credit' or 'Debit'
  amount DECIMAL(10,2),
  category VARCHAR(50),
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Users
INSERT INTO Users7 VALUES (1, 'Akila');

-- Transactions
INSERT INTO Transactions3 VALUES
(1, 1, '2025-06-01', 'Credit', 15000.00, 'Salary'),
(2, 1, '2025-06-05', 'Debit', 5000.00, 'Rent'),
(3, 1, '2025-06-10', 'Debit', 2000.00, 'Food'),
(4, 1, '2025-06-20', 'Credit', 4000.00, 'Freelancing'),
(5, 1, '2025-06-25', 'Debit', 1000.00, 'Utilities');

--  Monthly P&L Statement
SELECT 
  u.name AS user_name,
  DATE_FORMAT(t.txn_date, '%Y-%m') AS month,
  SUM(CASE WHEN t.txn_type = 'Credit' THEN t.amount ELSE 0 END) AS total_income,
  SUM(CASE WHEN t.txn_type = 'Debit' THEN t.amount ELSE 0 END) AS total_expense,
  SUM(CASE WHEN t.txn_type = 'Credit' THEN t.amount ELSE 0 END) -
  SUM(CASE WHEN t.txn_type = 'Debit' THEN t.amount ELSE 0 END) AS net_profit
FROM Transactions3 t
JOIN Users7 u ON u.user_id = t.user_id
GROUP BY u.name, DATE_FORMAT(t.txn_date, '%Y-%m')
ORDER BY month;

-- Explanation
-- | Clause / Logic                              | Purpose                                      |
-- | ------------------------------------------- | -------------------------------------------- |
-- | `DATE_FORMAT(txn_date, '%Y-%m')`            | Groups data by month-year (e.g., 2025-06)    |
-- | `CASE WHEN txn_type = 'Credit' THEN amount` | Sums only income transactions                |
-- | `CASE WHEN txn_type = 'Debit' THEN amount`  | Sums only expense transactions               |
-- | `total_income - total_expense`              | Calculates net profit (positive or negative) |
-- | \`GROUP BY user, month                      |                                              |



