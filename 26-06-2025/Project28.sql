USE hospital;
CREATE TABLE Admissions1 (
    admission_id INT PRIMARY KEY,
    patient_id INT,
    admission_date DATE,
    discharge_date DATE
);
INSERT INTO Admissions1 VALUES
(1, 101, '2024-12-28', '2025-01-02'),
(2, 102, '2025-01-10', '2025-01-14'),
(3, 103, '2025-01-25', '2025-01-30'),
(4, 104, '2025-02-05', '2025-02-10'),
(5, 105, '2025-03-15', NULL),
(6, 106, '2025-03-18', NULL),
(7, 107, '2025-06-10', NULL),
(8, 108, '2025-06-11', NULL);

-- Admission Trends
SELECT 
    YEAR(admission_date) AS admission_year,
    MONTH(admission_date) AS admission_month,
    COUNT(*) AS number_of_admissions
FROM 
    Admissions
GROUP BY 
    YEAR(admission_date), MONTH(admission_date)
ORDER BY 
    admission_year, admission_month;
    
    -- Explanation
 --    | Line                   | Explanation                                  |
-- | ---------------------- | -------------------------------------------- |
-- | `YEAR()` and `MONTH()` | Extract year and month from `admission_date` |
-- | `COUNT(*)`             | Count number of admissions per month         |
-- | `GROUP BY`             | Aggregate by year and month                  |
-- | `ORDER BY`             | Ensure results appear chronologically        |


