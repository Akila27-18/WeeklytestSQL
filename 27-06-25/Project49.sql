USE education;
CREATE TABLE Students7 (
  student_id INT PRIMARY KEY,
  name VARCHAR(50),
  class VARCHAR(10),
  family_income DECIMAL(10,2)
);
CREATE TABLE Marks4 (
  mark_id INT PRIMARY KEY,
  student_id INT,
  subject VARCHAR(50),
  marks_obtained DECIMAL(5,2),
  FOREIGN KEY (student_id) REFERENCES Students7(student_id)
);

-- Students
INSERT INTO Students7 VALUES
(1, 'Akila', '10A', 180000.00),
(2, 'Raj', '10A', 250000.00),
(3, 'Kumar', '10A', 195000.00);

-- Marks
INSERT INTO Marks4 VALUES
(1, 1, 'Math', 92.00),
(2, 1, 'Science', 88.00),
(3, 1, 'English', 91.00),

(4, 2, 'Math', 75.00),
(5, 2, 'Science', 68.00),
(6, 2, 'English', 74.00),

(7, 3, 'Math', 85.00),
(8, 3, 'Science', 87.00),
(9, 3, 'English', 89.00);

-- Scholarship Eligibility Checker
SELECT 
  s.name AS student_name,
  s.class,
  s.family_income,
  ROUND(AVG(m.marks_obtained), 2) AS average_marks,
  CASE 
    WHEN AVG(m.marks_obtained) >= 85 AND s.family_income <= 200000
    THEN 'Eligible'
    ELSE 'Not Eligible'
  END AS scholarship_status
FROM Students7 s
JOIN Marks4 m ON s.student_id = m.student_id
GROUP BY s.student_id, s.name, s.class, s.family_income
ORDER BY scholarship_status DESC, average_marks DESC;

-- Explanation
-- | Clause / Logic                                  | Purpose                                                  |
-- | ----------------------------------------------- | -------------------------------------------------------- |
-- | `AVG(marks_obtained)`                           | Calculates student’s average marks                       |
-- | `family_income <= 200000`                       | Filters low-income students                              |
-- | `CASE WHEN both conditions met THEN 'Eligible'` | Labels students based on academic and financial criteria |
-- | `GROUP BY student_id`                           | One row per student                                      |
