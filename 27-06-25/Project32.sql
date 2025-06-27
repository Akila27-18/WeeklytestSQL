USE finance;
CREATE TABLE Users1 (
  user_id INT PRIMARY KEY,
  name VARCHAR(50)
);

CREATE TABLE Expenses1 (
  expense_id INT PRIMARY KEY,
  user_id INT,
  amount DECIMAL(10,2),
  category VARCHAR(30),
  expense_date DATE,
  FOREIGN KEY (user_id) REFERENCES Users1(user_id)
);

-- Users
INSERT INTO Users1 (user_id, name) VALUES
(1, 'Akila'),
(2, 'Raj');

-- Expenses
INSERT INTO Expenses1 (expense_id, user_id, amount, category, expense_date) VALUES
(101, 1, 1500.00, 'Groceries', '2025-05-15'),
(102, 1, 2000.00, 'Rent', '2025-05-01'),
(103, 1, 800.00,  'Utilities', '2025-06-05'),
(104, 1, 500.00,  'Transport', '2025-06-10'),
(105, 1, 700.00,  'Shopping', '2025-06-12'),
(106, 2, 1200.00, 'Travel', '2025-05-20'),
(107, 2, 700.00,  'Groceries', '2025-06-01'),
(108, 2, 300.00,  'Medical', '2025-06-10'),
(109, 2, 100.00,  'Books', '2025-06-15');

-- Top 3 Spending Categories Per User

SELECT *
FROM (
  SELECT 
    u.name AS user_name,
    e.category,
    SUM(e.amount) AS total_spent,
    RANK() OVER (PARTITION BY u.user_id ORDER BY SUM(e.amount) DESC) AS `rank`
  FROM 
    Expenses1 e
  JOIN 
    Users1 u ON u.user_id = e.user_id
  GROUP BY 
    u.user_id, u.name, e.category
) ranked
WHERE `rank` <= 3
ORDER BY user_name, `rank`;


-- 🔍 Explanation
-- SUM(e.amount): Total amount spent per user per category.

-- GROUP BY u.user_id, e.category: Groups expenses by user and category.

-- RANK() OVER (PARTITION BY u.user_id ORDER BY SUM(e.amount) DESC): Ranks categories per user from highest spending to lowest.

-- WHERE rank <= 3: Filters top 3 categories for each user.

-- ORDER BY: Neatly displays output sorted by user and rank.