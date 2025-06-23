CREATE DATABASE band;
USE band;
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    salary DECIMAL(10, 2)
);
INSERT INTO Employees (employee_id, name, department_id, salary) VALUES
(1, 'Alice', 101, 18000),
(2, 'Bob', 102, 25000),
(3, 'Charlie', 101, 32000),
(4, 'David', 103, 45000),
(5, 'Eva', 102, 55000),
(6, 'Frank', 103, 12000),
(7, 'Grace', 101, 27000),
(8, 'Helen', 102, 39000),
(9, 'Ivy', 104, 52000),
(10, 'John', 104, 9900);

-- Salary Band Distribution Query
SELECT 
  CASE 
    WHEN salary BETWEEN 10000 AND 19999 THEN '10K–20K'
    WHEN salary BETWEEN 20000 AND 29999 THEN '20K–30K'
    WHEN salary BETWEEN 30000 AND 39999 THEN '30K–40K'
    WHEN salary BETWEEN 40000 AND 49999 THEN '40K–50K'
    WHEN salary >= 50000 THEN '50K+'
    ELSE 'Below 10K'
  END AS salary_band,
  COUNT(*) AS employee_count
FROM Employees
GROUP BY salary_band
ORDER BY salary_band;
