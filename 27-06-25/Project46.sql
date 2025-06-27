USE education;
CREATE TABLE Faculty (
  faculty_id INT PRIMARY KEY,
  name VARCHAR(50),
  department VARCHAR(50)
);
CREATE TABLE Subjects2 (
  subject_id INT PRIMARY KEY,
  subject_name VARCHAR(50),
  faculty_id INT,
  FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id)
);
DROP TABLE Ratings;
CREATE TABLE Ratings (
  rating_id INT PRIMARY KEY,
  subject_id INT,
  student_id INT,
  rating INT CHECK (rating BETWEEN 1 AND 5),
  FOREIGN KEY (subject_id) REFERENCES Subjects2(subject_id)
);

-- Faculty
INSERT INTO Faculty VALUES
(1, 'Dr. Akila', 'Math'),
(2, 'Prof. Raj', 'Science');

-- Subjects
INSERT INTO Subjects2 VALUES
(101, 'Algebra', 1),
(102, 'Physics', 2);

-- Ratings (1 to 5 scale)
INSERT INTO Ratings VALUES
(1, 101, 1, 5),
(2, 101, 2, 4),
(3, 101, 3, 5),
(4, 102, 1, 3),
(5, 102, 2, 2),
(6, 102, 3, 4);

-- Average Rating per Faculty
SELECT 
  f.name AS faculty_name,
  f.department,
  ROUND(AVG(r.rating), 2) AS average_rating,
  COUNT(r.rating_id) AS total_reviews,
  CASE 
    WHEN AVG(r.rating) >= 4.5 THEN 'Excellent'
    WHEN AVG(r.rating) >= 3.5 THEN 'Good'
    WHEN AVG(r.rating) >= 2.5 THEN 'Average'
    ELSE 'Needs Improvement'
  END AS rating_category
FROM Ratings r
JOIN Subjects2 s ON r.subject_id = s.subject_id
JOIN Faculty f ON s.faculty_id = f.faculty_id
GROUP BY f.faculty_id, f.name, f.department
ORDER BY average_rating DESC;

-- Explanation
-- | Clause / Logic            | Purpose                                  |
-- | ------------------------- | ---------------------------------------- |
-- | `AVG(r.rating)`           | Compute average rating                   |
-- | `CASE ... THEN`           | Classify faculty based on average rating |
-- | `COUNT(r.rating_id)`      | Count of student feedback entries        |
-- | `JOIN Subjects / Faculty` | Link rating to subject and faculty       |
-- | `GROUP BY faculty`        | One summary per faculty                  |




