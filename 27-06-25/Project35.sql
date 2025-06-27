USE finance;
CREATE TABLE Loans1 (
  loan_id INT PRIMARY KEY,
  user_id INT,
  loan_amount DECIMAL(10,2),
  start_date DATE,
  tenure_months INT
);
CREATE TABLE LoanPayments1 (
  payment_id INT PRIMARY KEY,
  loan_id INT,
  due_date DATE,
  paid_date DATE,  -- NULL if unpaid
  FOREIGN KEY (loan_id) REFERENCES Loans1(loan_id)
);

CREATE TABLE Users4 (
  user_id INT PRIMARY KEY,
  name VARCHAR(50)
);

-- Users
INSERT INTO Users4 VALUES
(1, 'Akila'),
(2, 'Raj');

-- Loans
INSERT INTO Loans1 VALUES
(101, 1, 60000.00, '2025-01-01', 6),
(102, 2, 40000.00, '2025-02-01', 4);

-- LoanPayments
INSERT INTO LoanPayments1 VALUES
(1, 101, '2025-02-01', '2025-02-03'), -- Late
(2, 101, '2025-03-01', NULL),        -- Missed
(3, 101, '2025-04-01', '2025-04-01'),-- On time
(4, 102, '2025-03-01', NULL),        -- Missed
(5, 102, '2025-04-01', '2025-04-10');-- Late


-- Missed or Late Payments
SELECT 
  u.name AS user_name,
  l.loan_id,
  p.due_date,
  p.paid_date,
  CASE 
    WHEN p.paid_date IS NULL THEN 'Missed'
    WHEN p.paid_date > p.due_date THEN 'Late'
    ELSE 'On Time'
  END AS payment_status
FROM LoanPayments1 p
JOIN Loans1 l ON p.loan_id = l.loan_id
JOIN Users4 u ON l.user_id = u.user_id
WHERE p.paid_date IS NULL OR p.paid_date > p.due_date
ORDER BY user_name, due_date;

-- Explanation
-- | **Line / Clause**                                       | **Purpose / Description**                                                         |
-- | ------------------------------------------------------- | --------------------------------------------------------------------------------- |
-- | `SELECT`                                                | Starts the query and specifies the columns to fetch.                              |
-- | `u.name AS user_name`                                   | Fetches user name from `Users` table, aliasing it as `user_name`.                 |
-- | `l.loan_id`                                             | Selects the loan ID to identify which loan the payment belongs to.                |
-- | `p.due_date`                                            | Selects the scheduled due date of the EMI from `LoanPayments`.                    |
-- | `p.paid_date`                                           | Selects the actual date the EMI was paid (can be NULL).                           |
-- | `CASE ... END AS payment_status`                        | Uses a conditional logic:                                                         |
-- |                                                         | → `paid_date IS NULL`: labels as `'Missed'`                                       |
-- |                                                         | → `paid_date > due_date`: labels as `'Late'`                                      |
-- |                                                         | → Otherwise (optional), labeled as `'On Time'` (this part is filtered out later). |
-- | `FROM LoanPayments p`                                   | Specifies the base table, alias `p` for `LoanPayments`.                           |
-- | `JOIN Loans l ON p.loan_id = l.loan_id`                 | Joins with `Loans` to get user info via loan\_id.                                 |
-- | `JOIN Users u ON l.user_id = u.user_id`                 | Joins with `Users` to get borrower name.                                          |
-- | `WHERE p.paid_date IS NULL OR p.paid_date > p.due_date` | Filters only missed or late payments (excludes "on time").                        |
-- | `ORDER BY user_name, due_date`                          | Sorts the final result alphabetically by user, and chronologically by due date.   |
