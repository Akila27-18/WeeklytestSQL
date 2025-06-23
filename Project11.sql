CREATE DATABASE attendance;
USE attendance;
-- Create Table
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE AttendanceLogs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    date DATE,
    status ENUM('Present', 'Absent'),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

-- Insert Employees
INSERT INTO Employees (employee_id, name) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Michael Lee');

-- Insert Attendance Logs (June 2025)
INSERT INTO AttendanceLogs (employee_id, date, status) VALUES
-- John Doe
(101, '2025-06-01', 'Present'),
(101, '2025-06-02', 'Absent'),
(101, '2025-06-03', 'Present'),
(101, '2025-06-04', 'Present'),
(101, '2025-06-05', 'Absent'),
(101, '2025-06-06', 'Present'),

-- Jane Smith
(102, '2025-06-01', 'Present'),
(102, '2025-06-02', 'Present'),
(102, '2025-06-03', 'Absent'),
(102, '2025-06-04', 'Present'),
(102, '2025-06-05', 'Present'),
(102, '2025-06-06', 'Absent'),

-- Michael Lee
(103, '2025-06-01', 'Absent'),
(103, '2025-06-02', 'Absent'),
(103, '2025-06-03', 'Present'),
(103, '2025-06-04', 'Present'),
(103, '2025-06-05', 'Present'),
(103, '2025-06-06', 'Present');

SELECT 
    e.employee_id,
    e.name,
    DATE_FORMAT(a.date, '%Y-%m') AS month,
    SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) AS days_present,
    SUM(CASE WHEN a.status = 'Absent' THEN 1 ELSE 0 END) AS days_absent
FROM 
    Employees e
JOIN 
    AttendanceLogs a ON e.employee_id = a.employee_id
GROUP BY 
    e.employee_id, e.name, DATE_FORMAT(a.date, '%Y-%m')
ORDER BY 
    e.employee_id, month;
    
-- Explanation
-- | Line                                                  | Description                                                                                    |
-- | ----------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
-- | `SELECT`                                              | We're choosing what columns to display: employee ID, name, month, present count, absent count. |
-- | `DATE_FORMAT(a.date, '%Y-%m')`                        | Extracts only the **year and month** from the date (e.g., `'2025-06'`).                        |
-- | `SUM(CASE WHEN status = 'Present' THEN 1 ELSE 0 END)` | Adds 1 for each day present; otherwise 0.                                                      |
-- | `JOIN`                                                | Connects `Employees` with `AttendanceLogs` using `employee_id`.                                |
-- | `GROUP BY`                                            | Groups the data by employee and by month, so we get one row per employee per month.            |
-- | `ORDER BY`                                            | Sorts the final result first by employee, then by month.                                       |

