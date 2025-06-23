CREATE DATABASE overtime;
USE overtime;
CREATE TABLE Promotions (
    promotion_id INT PRIMARY KEY,
    employee_id INT,
    old_title VARCHAR(100),
    new_title VARCHAR(100),
    promotion_date DATE
);
INSERT INTO Promotions (promotion_id, employee_id, old_title, new_title, promotion_date) VALUES
(1, 101, 'Intern', 'Junior Developer', '2021-01-10'),
(2, 101, 'Junior Developer', 'Developer', '2022-03-15'),
(3, 101, 'Developer', 'Senior Developer', '2023-06-20'),
(4, 102, 'Sales Associate', 'Sales Executive', '2022-05-01'),
(5, 103, 'Analyst', 'Senior Analyst', '2023-07-10');

-- Promotions Count + Latest Title per Employee
SELECT 
    p.employee_id,
    COUNT(*) AS promotion_count,
    (
        SELECT new_title
        FROM Promotions p2
        WHERE p2.employee_id = p.employee_id
        ORDER BY p2.promotion_date DESC
        LIMIT 1
    ) AS latest_title
FROM Promotions p
GROUP BY p.employee_id
ORDER BY promotion_count DESC;
