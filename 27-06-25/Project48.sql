USE education;
CREATE TABLE Students6 (
  student_id INT PRIMARY KEY,
  name VARCHAR(50),
  class VARCHAR(10)
);
CREATE TABLE Marks3 (
  mark_id INT PRIMARY KEY,
  student_id INT,
  subject VARCHAR(50),
  marks_obtained DECIMAL(5,2),
  FOREIGN KEY (student_id) REFERENCES Students6(student_id)
);

-- Students
INSERT INTO Students6 VALUES
(1, 'Akila', '10A'),
(2, 'Raj', '10A'),
(3, 'Kumar', '10A');

-- Marks
INSERT INTO Marks3 VALUES
(1, 1, 'Math', 85.00),
(2, 1, 'Science', 78.00),
(3, 1, 'English', 82.00),

(4, 2, 'Math', 45.00),
(5, 2, 'Science', 55.00),
(6, 2, 'English', 38.00),

(7, 3, 'Math', 60.00),
(8, 3, 'Science', 62.00),
(9, 3, 'English', 65.00);

-- Pass/Fail by Subject Criteria
SELECT 
  s.name AS student_name,
  s.class,
  COUNT(m.subject) AS total_subjects,
  SUM(CASE WHEN m.marks_obtained >= 40 THEN 1 ELSE 0 END) AS subjects_passed,
  CASE 
    WHEN SUM(CASE WHEN m.marks_obtained >= 40 THEN 1 ELSE 0 END) = COUNT(m.subject)
    THEN 'Pass'
    ELSE 'Fail'
  END AS result
FROM Students6 s
JOIN Marks3 m ON s.student_id = m.student_id
GROUP BY s.student_id, s.name, s.class
ORDER BY s.class, s.name;

-- Explanation
-- | Clause / Logic                                      | Purpose                                      |
-- | --------------------------------------------------- | -------------------------------------------- |
-- | `marks_obtained >= 40`                              | Defines pass condition per subject           |
-- | `SUM(CASE WHEN ... THEN 1)`                         | Counts number of subjects passed per student |
-- | `WHEN subjects_passed = total_subjects THEN 'Pass'` | Student must pass **all subjects**           |
-- | `GROUP BY student_id`                               | One row per student                          |
