USE hospital;
CREATE TABLE Patients5 (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100),
    date_of_birth DATE
);
INSERT INTO Patients5 VALUES
(1, 'Aarav Mehta', '2015-04-10'),   -- Age 10
(2, 'Sneha Rao', '1998-07-25'),     -- Age 26
(3, 'Manoj Kumar', '1985-03-12'),   -- Age 40
(4, 'Lata Joshi', '1970-11-05'),    -- Age 54
(5, 'Kiran Sahu', '2008-09-18'),    -- Age 16
(6, 'Rekha Sharma', '1960-01-01');  -- Age 65

-- Age Group Distribution
SELECT 
  CASE 
    WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 0 AND 18 THEN '0–18'
    WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 19 AND 35 THEN '19–35'
    WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 36 AND 50 THEN '36–50'
    WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 51 AND 65 THEN '51–65'
    ELSE '66+'
  END AS age_group,
  COUNT(*) AS number_of_patients
FROM 
  Patients5
GROUP BY 
  age_group
ORDER BY 
  age_group;

-- Explanation
-- | Clause                                | Purpose                              |
-- | ------------------------------------- | ------------------------------------ |
-- | `TIMESTAMPDIFF(YEAR, dob, CURDATE())` | Computes exact age in years          |
-- | `CASE ...`                            | Categorizes patients into age groups |
-- | `COUNT(*)`                            | Tallies number in each group         |
-- | `GROUP BY age_group`                  | Aggregates by each category          |
