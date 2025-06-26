USE hospital;
CREATE TABLE Treatments (
    treatment_id INT PRIMARY KEY,
    treatment_type VARCHAR(100),
    description TEXT
);

CREATE TABLE Patients3 (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE Billing (
    billing_id INT PRIMARY KEY,
    patient_id INT,
    treatment_id INT,
    amount DECIMAL(10,2),
    billing_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients3(patient_id),
    FOREIGN KEY (treatment_id) REFERENCES Treatments(treatment_id)
);

-- Treatments
INSERT INTO Treatments VALUES
(1, 'Surgery', 'Minor surgery procedure'),
(2, 'Physiotherapy', 'Muscle rehab'),
(3, 'Consultation', 'Doctor consultation');

-- Patients
INSERT INTO Patients3 VALUES
(1, 'Ravi Kumar'),
(2, 'Anita Singh'),
(3, 'Sujatha Pillai');

-- Billing
INSERT INTO Billing VALUES
(101, 1, 1, 15000.00, '2025-06-20'),
(102, 2, 2, 2000.00, '2025-06-21'),
(103, 3, 2, 2500.00, '2025-06-22'),
(104, 2, 1, 17000.00, '2025-06-23'),
(105, 3, 3, 800.00, '2025-06-24');

-- Average Cost per Treatment Type
SELECT 
    t.treatment_type,
    AVG(b.amount) AS average_cost
FROM 
    Billing b
JOIN 
    Treatments t ON b.treatment_id = t.treatment_id
GROUP BY 
    t.treatment_type
ORDER BY 
    average_cost DESC;
    
    -- Explanation
--     | Line                         | Purpose                                   |
-- | ---------------------------- | ----------------------------------------- |
-- | `JOIN Treatments`            | To get treatment type from billing info   |
-- | `AVG(b.amount)`              | Calculates the average cost per treatment |
-- | `GROUP BY t.treatment_type`  | Groups all records of the same treatment  |
-- | `ORDER BY average_cost DESC` | Shows most expensive treatments first     |

    

