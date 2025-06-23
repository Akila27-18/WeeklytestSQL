CREATE DATABASE leavereq;
USE leavereq;
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100)
);
CREATE TABLE LeaveRequests (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    leave_days INT,
    leave_type VARCHAR(50),  -- e.g., 'Sick', 'Casual', 'Annual'
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

INSERT INTO Employees (employee_id, name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');

INSERT INTO LeaveRequests (employee_id, leave_days, leave_type) VALUES
(1, 2, 'Sick'),
(1, 3, 'Casual'),
(1, 5, 'Annual'),
(2, 1, 'Sick'),
(2, 4, 'Annual'),
(3, 2, 'Casual'),
(3, 2, 'Casual');

-- Leave Balance Summary Query
SELECT 
    e.employee_id,
    e.name,
    lr.leave_type,
    SUM(lr.leave_days) AS total_days_taken
FROM 
    Employees e
JOIN 
    LeaveRequests lr ON e.employee_id = lr.employee_id
GROUP BY 
    e.employee_id, e.name, lr.leave_type
ORDER BY 
    e.employee_id, lr.leave_type;

-- Explanation
-- | Concept    | Usage                                   |
-- | ---------- | --------------------------------------- |
-- | `SUM()`    | Adds total leave days taken per type    |
-- | `GROUP BY` | Groups by employee and leave type       |
-- | `JOIN`     | Combines employee names with leave data |
-- | `ORDER BY` | Sorts the result for easy reading       |

