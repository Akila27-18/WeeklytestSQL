USE finance;
CREATE TABLE Users6 (
  user_id INT PRIMARY KEY,
  name VARCHAR(50)
);
CREATE TABLE Transactions2 (
  txn_id INT PRIMARY KEY,
  user_id INT,
  txn_time DATETIME,
  amount DECIMAL(10,2),
  FOREIGN KEY (user_id) REFERENCES Users6(user_id)
);
-- Users
INSERT INTO Users6 VALUES
(1, 'Akila'),
(2, 'Raj');

-- Transactions
INSERT INTO Transactions2 VALUES
(1, 1, '2025-06-01 10:00:00', 60000.00),
(2, 1, '2025-06-01 10:25:00', 55000.00), -- suspicious
(3, 1, '2025-06-01 12:00:00', 2000.00),
(4, 2, '2025-06-02 09:00:00', 80000.00),
(5, 2, '2025-06-02 09:45:00', 10000.00),
(6, 2, '2025-06-02 09:15:00', 70000.00); -- suspicious

-- Detect Large Transfers Within 30 Minutes

SELECT 
  u.name AS user_name,
  t1.txn_id AS txn1_id,
  t1.txn_time AS txn1_time,
  t1.amount AS txn1_amount,
  t2.txn_id AS txn2_id,
  t2.txn_time AS txn2_time,
  t2.amount AS txn2_amount,
  TIMESTAMPDIFF(MINUTE, t1.txn_time, t2.txn_time) AS minutes_diff
FROM Transactions2 t1
JOIN Transactions2 t2 
  ON t1.user_id = t2.user_id
  AND t1.txn_time < t2.txn_time
  AND TIMESTAMPDIFF(MINUTE, t1.txn_time, t2.txn_time) <= 30
  AND t1.amount >= 50000
  AND t2.amount >= 50000
JOIN Users6 u ON u.user_id = t1.user_id
ORDER BY user_name, t1.txn_time;


-- Explanation

-- | Clause / Logic                                    | Purpose                                                       |
-- | ------------------------------------------------- | ------------------------------------------------------------- |
-- | `t1.amount >= 50000 AND t2.amount >= 50000`       | Filter for **high-value** transactions only                   |
-- | `t1.txn_time < t2.txn_time`                       | Ensure we’re looking at **sequential transfers**              |
-- | `TIMESTAMPDIFF(MINUTE, t1.txn_time, t2.txn_time)` | Calculate **minutes between transactions**                    |
-- | `<= 30`                                           | Capture if the second transaction happened **within 30 mins** |
-- | `JOIN Users`                                      | Attach **user name** to the results                           |
