CREATE DATABASE promotion;
USE promotion;
CREATE TABLE Employees1 (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE EmployeeTitles1 (
    employee_id INT,
    title VARCHAR(100),
    promotion_date DATE,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

-- Employees
INSERT INTO Employees1 (employee_id, name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Clara');

-- EmployeeTitles (historical titles showing promotions)
INSERT INTO EmployeeTitles1 (employee_id, title, promotion_date) VALUES
(1, 'Junior Analyst', '2021-01-10'),
(1, 'Analyst', '2022-03-15'),
(1, 'Senior Analyst', '2023-06-20'),
(2, 'Sales Associate', '2022-01-05'),
(2, 'Sales Manager', '2023-04-25'),
(3, 'Engineer', '2022-08-18'); -- No promotion yet
-- Promotions Count and Latest Title

SELECT 
    e.employee_id,
    e.name,
    COUNT(t.title) - 1 AS promotions_count,  -- Subtract 1 if first title is entry-level
    (
        SELECT title
        FROM EmployeeTitles1 t2
        WHERE t2.employee_id = e.employee_id
        ORDER BY t2.promotion_date DESC
        LIMIT 1
    ) AS latest_title
FROM Employees1 e
JOIN EmployeeTitles1 t ON e.employee_id = t.employee_id
GROUP BY e.employee_id, e.name
ORDER BY promotions_count DESC;
