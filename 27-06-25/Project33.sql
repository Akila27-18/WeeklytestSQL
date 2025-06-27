USE finance;
CREATE TABLE Users2 (
  user_id INT PRIMARY KEY,
  name VARCHAR(50)
);
CREATE TABLE CardTransactions (
  txn_id INT PRIMARY KEY,
  user_id INT,
  card_type VARCHAR(10), -- 'Debit' or 'Credit'
  amount DECIMAL(10,2),
  txn_date DATE,
  FOREIGN KEY (user_id) REFERENCES Users2(user_id)
);

-- Users
INSERT INTO Users2 (user_id, name) VALUES
(1, 'Akila'),
(2, 'Raj'),
(3, 'Nila');

-- Transactions
INSERT INTO CardTransactions (txn_id, user_id, card_type, amount, txn_date) VALUES
(1, 1, 'Credit', 2500.00, '2025-06-01'),
(2, 1, 'Debit', 700.00, '2025-06-03'),
(3, 2, 'Credit', 900.00, '2025-06-10'),
(4, 2, 'Credit', 1200.00, '2025-06-15'),
(5, 3, 'Debit', 1000.00, '2025-06-05'),
(6, 3, 'Debit', 500.00, '2025-06-06'),
(7, 3, 'Credit', 3000.00, '2025-06-07');

-- Card Usage Summary
SELECT 
  u.name AS user_name,
  ct.card_type,
  COUNT(ct.txn_id) AS total_transactions,
  SUM(ct.amount) AS total_amount,
  ROUND(AVG(ct.amount), 2) AS avg_transaction
FROM 
  CardTransactions ct
JOIN 
  Users2 u ON u.user_id = ct.user_id
GROUP BY 
  u.name, ct.card_type
ORDER BY 
  u.name, ct.card_type;


-- 🔍 Explanation
-- COUNT(txn_id): Number of card transactions per user and card type.

-- SUM(amount): Total money spent via each card type.

-- AVG(amount): Average transaction amount to see card usage behavior.

-- GROUP BY user_name, card_type: Grouped to analyze by user and card.



