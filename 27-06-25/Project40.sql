USE finance;
CREATE TABLE Users8 (
  user_id INT PRIMARY KEY,
  name VARCHAR(50),
  alert_threshold DECIMAL(10,2) -- User-defined minimum balance
);
CREATE TABLE Transactions4 (
  txn_id INT PRIMARY KEY,
  user_id INT,
  txn_date DATE,
  txn_type VARCHAR(10),  -- 'Credit' or 'Debit'
  amount DECIMAL(10,2),
  FOREIGN KEY (user_id) REFERENCES Users8(user_id)
);

-- Users
INSERT INTO Users8 VALUES
(1, 'Akila', 3000.00),
(2, 'Raj', 1000.00);

-- Transactions
INSERT INTO Transactions4 VALUES
(1, 1, '2025-06-01', 'Credit', 5000.00),
(2, 1, '2025-06-03', 'Debit', 2500.00),
(3, 1, '2025-06-05', 'Debit', 1000.00),
(4, 2, '2025-06-01', 'Credit', 1200.00),
(5, 2, '2025-06-02', 'Debit', 300.00),
(6, 2, '2025-06-03', 'Debit', 200.00),
(7, 2, '2025-06-04', 'Debit', 900.00);

-- Detect Users Below Threshold
SELECT 
  u.name AS user_name,
  u.alert_threshold,
  SUM(CASE WHEN t.txn_type = 'Credit' THEN t.amount ELSE -t.amount END) AS current_balance,
  CASE 
    WHEN SUM(CASE WHEN t.txn_type = 'Credit' THEN t.amount ELSE -t.amount END) < u.alert_threshold
    THEN 'Below Threshold'
    ELSE 'Safe'
  END AS balance_status
FROM Users8 u
LEFT JOIN Transactions4 t ON u.user_id = t.user_id
GROUP BY u.user_id, u.name, u.alert_threshold
ORDER BY user_name;

-- Explanation
-- | Clause / Logic                                   | Purpose                                         |
-- | ------------------------------------------------ | ----------------------------------------------- |
-- | `SUM(CASE WHEN txn_type = 'Credit' THEN +amount` | Adds credits to balance                         |
-- | `ELSE -amount END)`                              | Subtracts debits                                |
-- | `GROUP BY user_id`                               | Calculates balance per user                     |
-- | `CASE WHEN balance < alert_threshold THEN '...'` | Compares current balance to threshold           |
-- | `LEFT JOIN Transactions`                         | Ensures users with no transactions are included |


