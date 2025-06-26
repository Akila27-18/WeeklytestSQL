USE hospital;
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE Diagnoses (
    diagnosis_id INT PRIMARY KEY,
    doctor_id INT,
    patient_id INT,
    diagnosis_date DATE,
    diagnosis_desc TEXT,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);
-- Departments
INSERT INTO Departments VALUES
(1, 'Cardiology'),
(2, 'Neurology'),
(3, 'Orthopedics');

-- Doctors
INSERT INTO Doctors VALUES
(101, 'Dr. Rao', 1),
(102, 'Dr. Meena', 2),
(103, 'Dr. Patel', 2),
(104, 'Dr. Singh', 3);

-- Diagnoses
INSERT INTO Diagnoses VALUES
(1001, 101, 1, '2025-05-01', 'High BP'),
(1002, 101, 2, '2025-05-02', 'Chest pain'),
(1003, 102, 3, '2025-05-03', 'Migraine'),
(1004, 103, 4, '2025-05-04', 'Epilepsy'),
(1005, 103, 5, '2025-05-05', 'Seizure'),
(1006, 104, 6, '2025-05-06', 'Fracture');

-- Diagonosis count per department
SELECT 
    d.department_name,
    COUNT(g.diagnosis_id) AS diagnosis_count
FROM 
    Diagnoses g
JOIN 
    Doctors doc ON g.doctor_id = doc.doctor_id
JOIN 
    Departments d ON doc.department_id = d.department_id
GROUP BY 
    d.department_id, d.department_name
ORDER BY 
    diagnosis_count DESC;

-- Explanation
-- SELECT d.department_name, COUNT(g.diagnosis_id) AS diagnosis_count
-- d.department_name:
-- Retrieves the name of the department from the Departments table.

-- COUNT(g.diagnosis_id) AS diagnosis_count:
-- Counts how many diagnoses are associated with that department.
-- The alias diagnosis_count is used for a readable output column.

-- FROM Diagnoses g
-- We start from the Diagnoses table (aliased as g), which contains all individual diagnosis records.

-- JOIN Doctors doc ON g.doctor_id = doc.doctor_id
-- We join the Doctors table (aliased as doc) to match each diagnosis with the doctor who made it, using the doctor_id foreign key.

-- JOIN Departments d ON doc.department_id = d.department_id
-- Then we join the Departments table (aliased as d) to match each doctor to their department, using the department_id.

-- GROUP BY d.department_id, d.department_name
-- We group the results by department to aggregate diagnosis counts per department.
-- Including both department_id and department_name is a best practice to ensure unique grouping (especially in some SQL engines).

-- ORDER BY diagnosis_count DESC
-- Finally, we sort the output in descending order, so departments with the highest number of diagnoses appear first.

