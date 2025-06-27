-- USE finance;
-- CREATE TABLE Users3 (
--   user_id INT PRIMARY KEY,
--   name VARCHAR(50)
-- );
-- CREATE TABLE Loans (
--   loan_id INT PRIMARY KEY,
--   user_id INT,
--   principal DECIMAL(10,2),
--   interest_rate DECIMAL(5,2), -- annual interest rate (%)
--   tenure_months INT,
--   start_date DATE,
--   FOREIGN KEY (user_id) REFERENCES Users3(user_id)
-- );
-- -- Users
-- INSERT INTO Users3 (user_id, name) VALUES
-- (1, 'Akila');

-- -- Loans
-- INSERT INTO Loans (loan_id, user_id, principal, interest_rate, tenure_months, start_date) VALUES
-- (101, 1, 60000.00, 12.00, 6, '2025-07-01');

-- WITH RECURSIVE EMI_Schedule AS (
--   -- Anchor member: first EMI
--   SELECT
--     l.loan_id,
--     u.name AS user_name,
--     l.start_date AS due_date,
--     ROUND(
--       (l.principal * monthly_rate * POW(1 + monthly_rate, l.tenure_months)) /
--       (POW(1 + monthly_rate, l.tenure_months) - 1), 2
--     ) AS emi_amount,
--     1 AS month_no,
--     l.tenure_months
--   FROM Loans l
--   JOIN Users3 u ON l.user_id = u.user_id,
--   (
--     SELECT 0.01 AS monthly_rate -- Assuming fixed for query (12% annual)
--   ) r
--   UNION ALL
-- -- EMI Schedule Generator (MySQL 8+ using Recursive CTE)
--   -- Recursive member: next EMI
--   SELECT
--     s.loan_id,
--     s.user_name,
--     DATE_ADD(s.due_date, INTERVAL 1 MONTH),
--     s.emi_amount,
--     s.month_no + 1,
--     s.tenure_months
--   FROM EMI_Schedule s
--   WHERE s.month_no < s.tenure_months
-- )

-- SELECT * FROM EMI_Schedule
-- ORDER BY loan_id, month_no;

-- -- EMI Formula
-- -- We use the standard EMI formula:
-- -- Where:

-- -- P = Principal amount

-- -- r = Monthly interest rate = annual rate / 12 / 100

-- -- n = tenure in months

-- -- For example:

-- -- P = 60000

-- -- Interest = 12% per annum → r = 0.01

-- -- n = 6 months
-- -- EMI = approx. ₹10,246.98


-- Explanation
-- | Concept       | Purpose                                       |
-- | ------------- | --------------------------------------------- |
-- | Recursive CTE | Generate repeated EMI rows without a loop     |
-- | EMI formula   | Financial formula for fixed monthly repayment |
-- | `DATE_ADD()`  | Generate due dates every month                |
-- | `ROUND()`     | Show EMI to 2 decimal places                  |
-- | `POW()`       | Calculate power terms in EMI formula          |

