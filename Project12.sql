CREATE DATABASE turnover;
USE turnover;
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    join_date DATE,
    resign_date DATE  -- NULL if still active
);
INSERT INTO Employees (employee_id, name, join_date, resign_date) VALUES
(1, 'Alice',  '2021-03-01', '2023-04-15'),
(2, 'Bob',    '2021-07-12', NULL),
(3, 'Carol',  '2022-01-10', '2023-12-30'),
(4, 'David',  '2022-05-20', NULL),
(5, 'Eve',    '2023-03-15', NULL),
(6, 'Frank',  '2023-06-10', '2024-03-20'),
(7, 'Grace',  '2024-02-01', NULL),
(8, 'Heidi',  '2024-09-01', NULL);

SELECT
    y.year,
    
    COUNT(CASE WHEN YEAR(e.join_date) = y.year THEN 1 END) AS joined,
    COUNT(CASE WHEN YEAR(e.resign_date) = y.year THEN 1 END) AS `left`,
    
    -- Avg headcount approx = (start + end) / 2
    COALESCE(
        ROUND(
            (COUNT(CASE WHEN YEAR(e.join_date) <= y.year THEN 1 END)
            + COUNT(CASE WHEN YEAR(e.join_date) <= y.year AND (e.resign_date IS NULL OR YEAR(e.resign_date) > y.year) THEN 1 END)) / 2,
        2),
    0) AS avg_headcount,
    
    ROUND(
        IFNULL(COUNT(CASE WHEN YEAR(e.resign_date) = y.year THEN 1 END) / 
        NULLIF(
            ((COUNT(CASE WHEN YEAR(e.join_date) <= y.year THEN 1 END)
            + COUNT(CASE WHEN YEAR(e.join_date) <= y.year AND (e.resign_date IS NULL OR YEAR(e.resign_date) > y.year) THEN 1 END)) / 2), 0)
        * 100, 0), 2) AS turnover_percent
FROM
    Employees e
JOIN
    (
        SELECT 2021 AS year UNION
        SELECT 2022 UNION
        SELECT 2023 UNION
        SELECT 2024
    ) y
GROUP BY
    y.year
ORDER BY
    y.year;

-- Explanation
-- | Concept            | Usage                                      |
-- | ------------------ | ------------------------------------------ |
-- | `COUNT()`          | Counts employees joined/left               |
-- | `DATE_RANGE` logic | `YEAR(join_date)`, `YEAR(resign_date)`     |
-- | `COALESCE()`       | Replaces `NULL` with 0 for safe division   |
-- | `NULLIF()`         | Avoids division by 0 in percentage formula |
-- | `ROUND()`          | Formats turnover to 2 decimal places       |
-- COALESCE(expr1, expr2, ..., exprN) returns the first non-NULL value from the list of expressions.
-- 🔎 Why?
-- Sometimes the calculation might result in NULL (e.g., if there are no employees for that year).
-- COALESCE(..., 0) replaces that NULL with 0.
-- | Purpose                         | Result                               |
-- | ------------------------------- | ------------------------------------ |
-- | Avoid `NULL` in numeric reports | Safer calculations (like turnover %) |
-- | Prevent division by zero        | Combine with `NULLIF`                |
-- | Simplify fallback logic         | Cleaner than `CASE WHEN`             |

