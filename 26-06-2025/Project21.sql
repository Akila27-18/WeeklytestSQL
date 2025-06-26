USE hospital;
-- Patients Table
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    gender VARCHAR(10),
    date_of_birth DATE
);

-- Visits Table
CREATE TABLE Visits (
    visit_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    visit_date DATE,
    reason VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);
-- Insert into Patients
INSERT INTO Patients (name, gender, date_of_birth) VALUES
('John Smith', 'Male', '1980-03-12'),
('Jane Doe', 'Female', '1990-07-05'),
('Michael Lee', 'Male', '1975-11-30'),
('Aisha Khan', 'Female', '1988-01-18');

-- Insert into Visits
INSERT INTO Visits (patient_id, visit_date, reason) VALUES
(1, '2025-01-05', 'Fever'),
(1, '2025-03-20', 'Checkup'),
(1, '2025-06-10', 'Follow-up'),

(2, '2025-02-12', 'Injury'),
(2, '2025-04-10', 'Headache'),
(2, '2025-06-05', 'Follow-up'),

(3, '2025-03-15', 'Back pain'),

(4, '2025-01-22', 'Cold'),
(4, '2025-03-10', 'Cough'),
(4, '2025-05-18', 'Allergy');

-- Patient Visit Frequency

SELECT 
    p.name AS patient_name,
    COUNT(v.visit_id) AS visit_count,
    MAX(v.visit_date) AS last_visit_date
FROM 
    Patients p
JOIN 
    Visits v ON p.patient_id = v.patient_id
GROUP BY 
    p.patient_id, p.name
ORDER BY 
    visit_count DESC, last_visit_date DESC;

-- Explanation
-- | Concept    | Purpose                                               |
-- | ---------- | ----------------------------------------------------- |
-- | `JOIN`     | Combine `Patients` and `Visits` based on `patient_id` |
-- | `COUNT()`  | Count how many visits each patient made               |
-- | `MAX()`    | Find the latest visit date per patient                |
-- | `GROUP BY` | Aggregate visit count and max date per patient        |
-- | `ORDER BY` | Show most frequent and recent visitors first          |

