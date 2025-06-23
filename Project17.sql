CREATE DATABASE hiring;
USE hiring;

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    hire_date DATE,
    source VARCHAR(50)
);

INSERT INTO Employees (employee_id, name, hire_date, source) VALUES
(1, 'Alice', '2024-01-10', 'LinkedIn'),
(2, 'Bob', '2024-02-15', 'Referral'),
(3, 'Clara', '2024-03-20', 'Job Portal'),
(4, 'David', '2024-03-25', 'LinkedIn'),
(5, 'Eva', '2024-04-05', 'Referral'),
(6, 'Frank', '2024-04-18', 'Campus'),
(7, 'Grace', '2024-05-10', 'LinkedIn'),
(8, 'Henry', '2024-05-22', 'Job Portal');

-- Query to Evaluate Hiring Source Effectiveness
SELECT 
    source,
    COUNT(*) AS total_hires
FROM Employees
GROUP BY source
ORDER BY total_hires DESC;

