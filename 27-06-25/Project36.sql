USE finance;
CREATE TABLE Users5 (
  user_id INT PRIMARY KEY,
  name VARCHAR(50)
);
CREATE TABLE Transactions1 (
  txn_id INT PRIMARY KEY,
  user_id INT,
  txn_date DATE,
  txn_type VARCHAR(10),   -- 'Credit' or 'Debit'
  amount DECIMAL(10,2),
  description VARCHAR(100),
  FOREIGN KEY (user_id) REFERENCES Users5(user_id)
);

-- Users
INSERT INTO Users5 VALUES
(1, 'Akila'),
(2, 'Raj');

-- Transactions
INSERT INTO Transactions1 VALUES
(1, 1, '2025-06-01', 'Credit', 10000.00, 'Salary'),
(2, 1, '2025-06-03', 'Debit', 2000.00, 'Groceries'),
(3, 1, '2025-06-05', 'Debit', 1500.00, 'Electricity Bill'),
(4, 1, '2025-06-10', 'Credit', 5000.00, 'Freelance Income'),
(5, 2, '2025-06-02', 'Credit', 8000.00, 'Consulting'),
(6, 2, '2025-06-04', 'Debit', 3000.00, 'Rent');


-- Ledger with Running Balance

SELECT 
  u.name AS user_name,
  t.txn_date,
  t.txn_type,
  t.description,
  t.amount,
  SUM(
    CASE 
      WHEN t.txn_type = 'Credit' THEN t.amount 
      ELSE -t.amount 
    END
  ) OVER (PARTITION BY t.user_id ORDER BY t.txn_date, t.txn_id) AS running_balance
FROM Transactions1 t
JOIN Users5 u ON t.user_id = u.user_id
ORDER BY u.name, t.txn_date, t.txn_id;


-- Explanation
-- | Clause / Logic                                           | Purpose                                                |
-- | -------------------------------------------------------- | ------------------------------------------------------ |
-- | `CASE WHEN txn_type = 'Credit' THEN +amount`             | Adds to balance if transaction is credit               |
-- | `ELSE -amount`                                           | Subtracts from balance if transaction is debit         |
-- | `SUM(...) OVER (PARTITION BY user_id ORDER BY txn_date)` | Calculates running total per user in transaction order |
-- | `JOIN Users`                                             | Adds user names to results                             |

