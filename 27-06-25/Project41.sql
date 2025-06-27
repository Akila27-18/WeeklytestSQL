USE education;
CREATE TABLE Students (
  student_id INT PRIMARY KEY,
  name VARCHAR(50),
  class VARCHAR(10)
);

CREATE TABLE Subjects (
  subject_id INT PRIMARY KEY,
  subject_name VARCHAR(50)
);

CREATE TABLE Marks (
  mark_id INT PRIMARY KEY,
  student_id INT,
  subject_id INT,
  marks_obtained DECIMAL(5,2),
  FOREIGN KEY (student_id) REFERENCES Students(student_id),
  FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);


-- Students
INSERT INTO Students VALUES
(1, 'Akila', '10A'),
(2, 'Raj', '10A');

-- Subjects
INSERT INTO Subjects VALUES
(101, 'Math'),
(102, 'Science'),
(103, 'English');

-- Marks
INSERT INTO Marks VALUES
(1, 1, 101, 95.0),
(2, 1, 102, 88.0),
(3, 1, 103, 91.0),
(4, 2, 101, 70.0),
(5, 2, 102, 55.0),
(6, 2, 103, 65.0);

-- Grade Book Summary with Grade 
SELECT 
  s.name AS student_name,
  s.class,
  COUNT(m.subject_id) AS total_subjects,
  SUM(m.marks_obtained) AS total_marks,
  ROUND(AVG(m.marks_obtained), 2) AS average_marks,
  CASE 
    WHEN AVG(m.marks_obtained) >= 90 THEN 'A'
    WHEN AVG(m.marks_obtained) >= 75 THEN 'B'
    WHEN AVG(m.marks_obtained) >= 60 THEN 'C'
    ELSE 'Fail'
  END AS grade
FROM Students s
JOIN Marks m ON s.student_id = m.student_id
GROUP BY s.student_id, s.name, s.class
ORDER BY s.name;

-- Explanation
-- | Clause / Logic        | Purpose                          |
-- | --------------------- | -------------------------------- |
-- | `COUNT(subject_id)`   | Total number of subjects written |
-- | `SUM(marks_obtained)` | Total marks scored               |
-- | `AVG(marks_obtained)` | Average across subjects          |
-- | `CASE ... THEN`       | Assign grade based on average    |
-- | `GROUP BY student_id` | Summarizes per student           |

