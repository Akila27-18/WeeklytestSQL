USE education;
CREATE TABLE Students1 (
  student_id INT PRIMARY KEY,
  name VARCHAR(50)
);
CREATE TABLE Courses (
  course_id INT PRIMARY KEY,
  course_name VARCHAR(100)
);

CREATE TABLE Enrollments (
  enrollment_id INT PRIMARY KEY,
  student_id INT,
  course_id INT,
  status VARCHAR(20), -- 'Completed', 'In Progress', 'Not Started'
  completion_percent INT, -- from 0 to 100
  FOREIGN KEY (student_id) REFERENCES Students1(student_id),
  FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Students
INSERT INTO Students1 VALUES
(1, 'Akila'),
(2, 'Raj');

-- Courses
INSERT INTO Courses VALUES
(101, 'SQL Basics'),
(102, 'Python for Data Science'),
(103, 'Web Development');

-- Enrollments
INSERT INTO Enrollments VALUES
(1, 1, 101, 'Completed', 100),
(2, 1, 102, 'In Progress', 60),
(3, 1, 103, 'Not Started', 0),
(4, 2, 101, 'In Progress', 50),
(5, 2, 102, 'Completed', 100);

-- Course Completion Tracker
SELECT 
  s.name AS student_name,
  c.course_name,
  e.status,
  e.completion_percent
FROM Enrollments e
JOIN Students1 s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id
ORDER BY s.name, c.course_name;

-- Explanation
-- | Clause / Logic       | Purpose                                               |
-- | -------------------- | ----------------------------------------------------- |
-- | `JOIN Students`      | Get student names                                     |
-- | `JOIN Courses`       | Get course titles                                     |
-- | `status`             | Describes whether the course is completed or pending  |
-- | `completion_percent` | Helps in progress tracking / dashboard visualizations |

