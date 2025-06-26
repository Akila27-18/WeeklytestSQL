USE hospital;
CREATE TABLE Patients4 (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE InsuranceClaims (
    claim_id INT PRIMARY KEY,
    patient_id INT,
    claim_amount DECIMAL(10,2),
    status CHAR(1), -- 'A'=Approved, 'P'=Pending, 'R'=Rejected
    claim_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients4(patient_id)
);

-- Patients
INSERT INTO Patients4 VALUES
(1, 'Sandeep Roy'),
(2, 'Meena Iyer'),
(3, 'Karthik Nair');

-- InsuranceClaims
INSERT INTO InsuranceClaims VALUES
(101, 1, 15000.00, 'A', '2025-05-12'),
(102, 2, 10000.00, 'P', '2025-06-01'),
(103, 3, 12000.00, 'R', '2025-06-10'),
(104, 1, 5000.00, 'P', '2025-06-20');

-- Insurance Claim Status Tracker
SELECT 
    p.name AS patient_name,
    ic.claim_amount,
    CASE 
        WHEN ic.status = 'A' THEN 'Approved'
        WHEN ic.status = 'P' THEN 'Pending'
        WHEN ic.status = 'R' THEN 'Rejected'
        ELSE 'Unknown'
    END AS claim_status,
    ic.claim_date
FROM 
    InsuranceClaims ic
JOIN 
    Patients4 p ON ic.patient_id = p.patient_id
ORDER BY 
    ic.claim_date DESC;

-- Explanation
-- | Clause                     | Purpose                                                 |
-- | -------------------------- | ------------------------------------------------------- |
-- | `JOIN Patients`            | To fetch patient names along with claim info            |
-- | `CASE`                     | Converts status code (`A`, `P`, `R`) into readable text |
-- | `ORDER BY claim_date DESC` | Shows latest claims first                               |


