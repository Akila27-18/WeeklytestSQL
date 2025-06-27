USE education;
CREATE TABLE Students5 (
  student_id INT PRIMARY KEY,
  name VARCHAR(50),
  class VARCHAR(10)
);
CREATE TABLE Marks2 (
  mark_id INT PRIMARY KEY,
  student_id INT,
  subject VARCHAR(50),
  marks_obtained DECIMAL(5,2),
  FOREIGN KEY (student_id) REFERENCES Students5(student_id)
);

-- Students
INSERT INTO Students5 VALUES
(1, 'Akila', '10A'),
(2, 'Raj', '10A'),
(3, 'Kumar', '10A');

-- Marks
INSERT INTO Marks2 VALUES
(1, 1, 'Math', 95.00),
(2, 1, 'Science', 88.00),
(3, 1, 'English', 90.00),

(4, 2, 'Math', 85.00),
(5, 2, 'Science', 80.00),
(6, 2, 'English', 82.00),

(7, 3, 'Math', 78.00),
(8, 3, 'Science', 74.00),
(9, 3, 'English', 70.00);

-- Student Rank List
SELECT 
  s.name AS student_name,
  s.class,
  SUM(m.marks_obtained) AS total_marks,
  ROUND(AVG(m.marks_obtained), 2) AS average_marks,
  RANK() OVER (PARTITION BY s.class ORDER BY SUM(m.marks_obtained) DESC) AS rank_position
FROM Students5 s
JOIN Marks2 m ON s.student_id = m.student_id
GROUP BY s.student_id, s.name, s.class
ORDER BY s.class, rank_position;

-- Explanation
-- | Clause / Logic                                            | Purpose                                  |
-- | --------------------------------------------------------- | ---------------------------------------- |
-- | `SUM(marks_obtained)`                                     | Total marks for each student             |
-- | `AVG(marks_obtained)`                                     | Average marks for tie-breaker or display |
-- | `RANK() OVER (PARTITION BY class ORDER BY SUM(...) DESC)` | Ranking students within their class      |
-- | `GROUP BY student_id`                                     | One row per student                      |
