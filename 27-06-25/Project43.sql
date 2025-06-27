USE education;
CREATE TABLE Students2 (
  student_id INT PRIMARY KEY,
  name VARCHAR(50),
  class VARCHAR(10)
);
DROP TABLE Attendance;
CREATE TABLE Attendance (
  attendance_id INT PRIMARY KEY,
  student_id INT,
  attendance_date DATE,
  status VARCHAR(10),  -- 'Present', 'Absent'
  FOREIGN KEY (student_id) REFERENCES Students2(student_id)
);

-- Students
INSERT INTO Students2 VALUES
(1, 'Akila', '10A'),
(2, 'Raj', '10A');

-- Attendance for June (10 working days)
INSERT INTO Attendance VALUES
(1, 1, '2025-06-01', 'Present'),
(2, 1, '2025-06-02', 'Present'),
(3, 1, '2025-06-03', 'Absent'),
(4, 1, '2025-06-04', 'Present'),
(5, 1, '2025-06-05', 'Present'),
(6, 1, '2025-06-06', 'Present'),
(7, 1, '2025-06-07', 'Present'),
(8, 1, '2025-06-08', 'Absent'),
(9, 1, '2025-06-09', 'Present'),
(10, 1, '2025-06-10', 'Present'),

(11, 2, '2025-06-01', 'Present'),
(12, 2, '2025-06-02', 'Absent'),
(13, 2, '2025-06-03', 'Absent'),
(14, 2, '2025-06-04', 'Present'),
(15, 2, '2025-06-05', 'Absent'),
(16, 2, '2025-06-06', 'Present'),
(17, 2, '2025-06-07', 'Present'),
(18, 2, '2025-06-08', 'Present'),
(19, 2, '2025-06-09', 'Absent'),
(20, 2, '2025-06-10', 'Present');

-- Attendance Rate %

SELECT 
  s.name AS student_name,
  s.class,
  COUNT(a.attendance_id) AS total_days,
  SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) AS present_days,
  ROUND(
    (SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) * 100.0) / 
    COUNT(a.attendance_id), 2
  ) AS attendance_percentage
FROM Students2 s
JOIN Attendance a ON s.student_id = a.student_id
GROUP BY s.student_id, s.name, s.class
ORDER BY attendance_percentage DESC;

-- Explanation
-- | Clause / Logic                        | Purpose                                 |
-- | ------------------------------------- | --------------------------------------- |
-- | `COUNT(attendance_id)`                | Total attendance records (working days) |
-- | `SUM(CASE WHEN status = 'Present')`   | Count only present days                 |
-- | `ROUND(... * 100 / total, 2)`         | Computes percentage                     |
-- | `GROUP BY student_id`                 | Summary per student                     |
-- | `ORDER BY attendance_percentage DESC` | Rank students by highest attendance     |
