USE education;
CREATE TABLE Students8 (
  student_id INT PRIMARY KEY,
  name VARCHAR(50),
  class VARCHAR(10)
);
CREATE TABLE Assignments (
  assignment_id INT PRIMARY KEY,
  title VARCHAR(100),
  due_date DATE
);
CREATE TABLE Submissions (
  submission_id INT PRIMARY KEY,
  student_id INT,
  assignment_id INT,
  submission_date DATE,
  FOREIGN KEY (student_id) REFERENCES Students8(student_id),
  FOREIGN KEY (assignment_id) REFERENCES Assignments(assignment_id)
);

-- Students
INSERT INTO Students8 VALUES
(1, 'Akila', '10A'),
(2, 'Raj', '10A'),
(3, 'Kumar', '10A');

-- Assignments
INSERT INTO Assignments VALUES
(101, 'Math Homework 1', '2025-06-25'),
(102, 'Science Project', '2025-06-26');

-- Submissions
INSERT INTO Submissions VALUES
(1, 1, 101, '2025-06-24'), -- Akila submitted Math
(2, 2, 101, '2025-06-25'), -- Raj submitted Math
(3, 1, 102, '2025-06-26'); -- Akila submitted Science

-- Assignment Submission Status
SELECT 
  a.title AS assignment_title,
  s.name AS student_name,
  s.class,
  CASE 
    WHEN sub.submission_id IS NOT NULL THEN 'Submitted'
    ELSE 'Not Submitted'
  END AS submission_status
FROM Students8 s
CROSS JOIN Assignments a
LEFT JOIN Submissions sub ON s.student_id = sub.student_id AND a.assignment_id = sub.assignment_id
ORDER BY a.assignment_id, s.name;

-- Explanation
-- | Clause / Logic                         | Purpose                                   |
-- | -------------------------------------- | ----------------------------------------- |
-- | `CROSS JOIN Assignments`               | Pairs every student with every assignment |
-- | `LEFT JOIN Submissions`                | Brings in submission data (if any)        |
-- | `CASE WHEN submission_id IS NOT NULL`  | Checks if submission exists               |
-- | `ORDER BY assignment_id, student_name` | Organizes data neatly                     |
