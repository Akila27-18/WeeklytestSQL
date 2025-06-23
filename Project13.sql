CREATE DATABASE tenure;
USE tenure;
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    join_date DATE,
    resign_date DATE, -- NULL if still active
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

INSERT INTO Departments VALUES
(1, 'HR'),
(2, 'Engineering'),
(3, 'Sales');

INSERT INTO Employees VALUES
(1, 'Alice', 1, '2020-01-10', '2023-01-01'),
(2, 'Bob', 2, '2019-05-01', NULL),
(3, 'Carol', 2, '2021-03-15', '2024-02-01'),
(4, 'David', 3, '2022-06-10', NULL),
(5, 'Eve', 1, '2023-08-01', NULL);

-- Average Tenure by Department (in Months)
SELECT 
    d.department_name,
    ROUND(AVG(
        DATEDIFF(COALESCE(e.resign_date, CURDATE()), e.join_date) / 30
    ), 2) AS avg_months_worked
FROM 
    Employees e
JOIN 
    Departments d ON e.department_id = d.department_id
GROUP BY 
    d.department_name
ORDER BY 
    avg_months_worked DESC;

-- Explanation
-- | Concept         | Description                                                         |
-- | --------------- | ------------------------------------------------------------------- |
-- | `DATEDIFF()`    | Calculates the number of days between `resign_date` and `join_date` |
-- | `COALESCE()`    | Uses `CURDATE()` if `resign_date` is NULL (i.e., still working)     |
-- | `AVG()`         | Computes average tenure (in days → months) per department           |
-- | `GROUP BY`      | Aggregates data per department                                      |
-- | `ROUND(..., 2)` | Rounds to 2 decimal places                                          |
