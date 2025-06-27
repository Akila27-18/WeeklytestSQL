USE finance;
CREATE TABLE Users (
  user_id INT PRIMARY KEY,
  name VARCHAR(50)
);

CREATE TABLE Expenses (
  expense_id INT PRIMARY KEY,
  user_id INT,
  amount DECIMAL(10,2),
  category VARCHAR(30),
  expense_date DATE,
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
INSERT INTO Users VALUES
(1, 'Akila'), (2, 'Raj'), (3, 'Nila');

INSERT INTO Expenses VALUES
(101, 1, 1500.00, 'Groceries', '2025-06-01'),
(102, 1, 2000.00, 'Rent', '2025-06-05'),
(103, 2, 1200.00, 'Travel', '2025-05-20'),
(104, 3, 3000.00, 'Medical', '2025-06-10'),
(105, 1, 500.00, 'Utilities', '2025-05-30');

-- Monthly Expense Summary Query

SELECT 
  u.name AS user_name,
  DATE_FORMAT(e.expense_date, '%Y-%m') AS month,
  SUM(e.amount) AS total_spent
FROM 
  Expenses e
JOIN 
  Users u ON e.user_id = u.user_id
GROUP BY 
  u.name, DATE_FORMAT(e.expense_date, '%Y-%m')
ORDER BY 
  u.name, month;

-- Explanation
-- JOIN: Combines Users and Expenses to associate expense data with usernames.

-- DATE_FORMAT(e.expense_date, '%Y-%m'): Extracts just the year and month from the expense date.

-- SUM(e.amount): Calculates the total spending by user per month.

-- GROUP BY: Groups the data by user name and month to aggregate totals.

-- ORDER BY: Sorts the results neatly by user and month.