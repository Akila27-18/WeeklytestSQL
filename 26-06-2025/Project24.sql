USE hospital;
CREATE TABLE Beds (
    bed_id INT PRIMARY KEY,
    ward_name VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE Patients2 (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE Admissions (
    admission_id INT PRIMARY KEY,
    bed_id INT,
    patient_id INT,
    admission_date DATE,
    discharge_date DATE,
    FOREIGN KEY (bed_id) REFERENCES Beds(bed_id),
    FOREIGN KEY (patient_id) REFERENCES Patients2(patient_id)
);

-- Beds
INSERT INTO Beds VALUES
(1, 'ICU', TRUE),
(2, 'ICU', TRUE),
(3, 'General', TRUE),
(4, 'General', TRUE),
(5, 'General', TRUE);

-- Patients
INSERT INTO Patients2 VALUES
(1, 'Rajiv Menon'),
(2, 'Latha Devi');

-- Admissions
INSERT INTO Admissions VALUES
(1001, 1, 1, '2025-06-20', NULL),    -- still admitted
(1002, 3, 2, '2025-06-18', '2025-06-25'); -- discharged

-- Bed Occupancy report
SELECT 
    b.ward_name,
    COUNT(b.bed_id) AS total_beds,
    COUNT(CASE WHEN a.admission_id IS NOT NULL AND a.discharge_date IS NULL THEN 1 END) AS occupied_beds,
    COUNT(CASE WHEN a.admission_id IS NULL OR a.discharge_date IS NOT NULL THEN 1 END) AS available_beds
FROM 
    Beds b
LEFT JOIN 
    Admissions a ON b.bed_id = a.bed_id
    AND (a.discharge_date IS NULL OR a.discharge_date >= CURRENT_DATE())
GROUP BY 
    b.ward_name
ORDER BY 
    b.ward_name;

-- Explanation
-- | Line                       | Purpose                                                          |
-- | -------------------------- | ---------------------------------------------------------------- |
-- | `LEFT JOIN Admissions a`   | Ensures all beds are included, even unoccupied ones.             |
-- | `a.discharge_date IS NULL` | Filters currently admitted patients only.                        |
-- | `COUNT(CASE WHEN ...)`     | Used to **conditionally count** only occupied or available beds. |
-- | `GROUP BY ward_name`       | Groups results **per ward**.                                     |
-- | `ORDER BY`                 | Sorts wards alphabetically in output.                            |

