CREATE DATABASE gender;
USE gender;
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    gender VARCHAR(10),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);
-- Departments
INSERT INTO Departments (department_id, name) VALUES
(1, 'HR'),
(2, 'Engineering'),
(3, 'Sales');

-- Employees
INSERT INTO Employees (employee_id, name, gender, department_id) VALUES
(1, 'Alice', 'Female', 1),
(2, 'Bob', 'Male', 2),
(3, 'Clara', 'Female', 2),
(4, 'David', 'Male', 3),
(5, 'Eva', 'Female', 3),
(6, 'Frank', 'Male', 3),
(7, 'Grace', 'Female', 1),
(8, 'Henry', 'Male', 2);

-- Gender Distribution by Department Query
SELECT 
    d.name AS department,
    e.gender,
    COUNT(*) AS count
FROM Employees e
JOIN Departments d ON e.department_id = d.department_id
GROUP BY d.name, e.gender
ORDER BY d.name, e.gender;

