USE education;
CREATE TABLE Students3 (
  student_id INT PRIMARY KEY,
  name VARCHAR(50),
  class VARCHAR(10),
  admission_date DATE
);
INSERT INTO Students3 VALUES
(1, 'Akila', '10A', '2022-06-10'),
(2, 'Raj', '10A', '2023-05-15'),
(3, 'Kumar', '9B', '2023-06-18'),
(4, 'Divya', '11C', '2023-07-20'),
(5, 'Arun', '12A', '2024-04-05'),
(6, 'Sneha', '8C', '2024-06-01'),
(7, 'Manoj', '6B', '2024-06-12');

-- Admission Trend by Year
SELECT 
  YEAR(admission_date) AS admission_year,
  COUNT(*) AS total_admissions
FROM Students3
GROUP BY YEAR(admission_date)
ORDER BY admission_year;

-- Explanation
-- | Clause / Logic                  | Purpose                                     |
-- | ------------------------------- | ------------------------------------------- |
-- | `YEAR(admission_date)`          | Extracts admission year from full date      |
-- | `COUNT(*)`                      | Counts number of students admitted per year |
-- | `GROUP BY YEAR(admission_date)` | Aggregates data year-wise                   |
-- | `ORDER BY admission_year`       | Ensures chronological trend analysis        |
