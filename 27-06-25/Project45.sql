USE education;
CREATE TABLE Students4 (
  student_id INT PRIMARY KEY,
  name VARCHAR(50),
  class VARCHAR(10)
);
CREATE TABLE Subjects1 (
  subject_id INT PRIMARY KEY,
  subject_name VARCHAR(50)
);
CREATE TABLE Marks1 (
  mark_id INT PRIMARY KEY,
  student_id INT,
  subject_id INT,
  marks_obtained DECIMAL(5,2),
  FOREIGN KEY (student_id) REFERENCES Students4(student_id),
  FOREIGN KEY (subject_id) REFERENCES Subjects1(subject_id)
);
-- Students
INSERT INTO Students4 VALUES
(1, 'Akila', '10A'),
(2, 'Raj', '10A'),
(3, 'Kumar', '10A');

-- Subjects
INSERT INTO Subjects1 VALUES
(101, 'Math'),
(102, 'Science'),
(103, 'English');

-- Marks
INSERT INTO Marks1 VALUES
(1, 1, 101, 90.00), -- Akila - Math
(2, 1, 102, 85.00),
(3, 1, 103, 95.00),
(4, 2, 101, 70.00), -- Raj - Math
(5, 2, 102, 65.00),
(6, 2, 103, 75.00),
(7, 3, 101, 80.00), -- Kumar - Math
(8, 3, 102, 70.00),
(9, 3, 103, 85.00);

-- Subject-wise Avg Marks
SELECT 
  sub.subject_name,
  ROUND(AVG(m.marks_obtained), 2) AS average_marks
FROM Marks1 m
JOIN Subjects1 sub ON m.subject_id = sub.subject_id
GROUP BY sub.subject_name
ORDER BY average_marks DESC;

-- Explanation
-- | Clause / Logic                | Purpose                                     |
-- | ----------------------------- | ------------------------------------------- |
-- | `AVG(marks_obtained)`         | Calculates average marks per subject        |
-- | `ROUND(..., 2)`               | Rounds result to 2 decimal places           |
-- | `JOIN Subjects`               | Get subject names from IDs                  |
-- | `GROUP BY subject_name`       | Summarizes per subject                      |
-- | `ORDER BY average_marks DESC` | Lists subjects by highest to lowest average |

