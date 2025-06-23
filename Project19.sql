CREATE DATABASE appraisal;
USE appraisal;
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT
);

CREATE TABLE Appraisals (
    appraisal_id INT PRIMARY KEY,
    employee_id INT,
    year INT,
    rating DECIMAL(3,2),
    comments TEXT,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

-- Employees
INSERT INTO Employees (employee_id, name, department_id) VALUES
(1, 'Alice', 101),
(2, 'Bob', 102),
(3, 'Clara', 101);

-- Appraisals
INSERT INTO Appraisals (appraisal_id, employee_id, year, rating, comments) VALUES
(1, 1, 2023, 4.5, 'Excellent performance'),
(2, 1, 2023, 4.2, 'Exceeded expectations'),
(3, 2, 2023, 3.8, 'Met goals'),
(4, 3, 2023, 4.0, 'Consistent performer'),
(5, 1, 2024, 4.6, 'Leadership improved'),
(6, 2, 2024, 4.0, 'Better collaboration'),
(7, 3, 2024, 4.3, 'Great attitude and delivery');

-- Annual Appraisal Summary Query
SELECT 
    e.employee_id,
    e.name AS employee_name,
    e.department_id,
    a.year,
    ROUND(AVG(a.rating), 2) AS avg_rating,
    COUNT(*) AS total_appraisals,
    GROUP_CONCAT(a.comments SEPARATOR '; ') AS comments_summary
FROM Employees e
JOIN Appraisals a ON e.employee_id = a.employee_id
GROUP BY e.employee_id, a.year
ORDER BY e.department_id, e.employee_id, a.year;


