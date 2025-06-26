USE hospital;
CREATE TABLE Doctors1 (
    doctor_id INT PRIMARY KEY,
    name VARCHAR(100),
    specialization VARCHAR(100)
);

CREATE TABLE Patients1 (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100),
    date_of_birth DATE
);

CREATE TABLE Appointments1 (
    appointment_id INT PRIMARY KEY,
    doctor_id INT,
    patient_id INT,
    appointment_date DATE,
    time_slot VARCHAR(50),
    FOREIGN KEY (doctor_id) REFERENCES Doctors1(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES Patients1(patient_id)
);

-- Doctors
INSERT INTO Doctors1 VALUES
(1, 'Dr. Anjali Rao', 'Cardiology'),
(2, 'Dr. Ravi Kumar', 'Neurology');

-- Patients
INSERT INTO Patients1 VALUES
(1, 'Amit Shah', '1985-06-15'),
(2, 'Priya Mehta', '1992-09-23'),
(3, 'Kiran Das', '1978-12-05');

-- Appointments
INSERT INTO Appointments1 VALUES
(1001, 1, 1, '2025-06-25', '10:00 AM - 10:30 AM'),
(1002, 2, 2, '2025-06-25', '11:00 AM - 11:30 AM'),
(1003, 1, 3, '2025-06-26', '09:30 AM - 10:00 AM');

-- Doctor Appointment Calendar
SELECT 
    d.name AS doctor_name,
    DATE_FORMAT(a.appointment_date, '%Y-%m-%d') AS appointment_date,
    p.name AS patient_name,
    a.time_slot
FROM 
    Appointments1 a
JOIN 
    Doctors1 d ON a.doctor_id = d.doctor_id
JOIN 
    Patients1 p ON a.patient_id = p.patient_id
ORDER BY 
    a.appointment_date, d.name, a.time_slot;

-- Explanation
-- | Line                     | Purpose                                                  |
-- | ------------------------ | -------------------------------------------------------- |
-- | `d.name AS doctor_name`  | Fetch doctor’s full name.                                |
-- | `DATE_FORMAT(...)`       | Format date in `YYYY-MM-DD` for clean calendar view.     |
-- | `p.name AS patient_name` | Fetch patient’s name for the appointment.                |
-- | `a.time_slot`            | Fetch exact scheduled time.                              |
-- | `JOIN ...`               | Combine the three tables using foreign keys.             |
-- | `ORDER BY`               | Sort appointments first by date, then doctor, then time. |


