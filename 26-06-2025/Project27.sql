USE hospital;
CREATE TABLE LabTests (
    test_id INT PRIMARY KEY,
    test_name VARCHAR(100),
    test_type VARCHAR(100)
);

CREATE TABLE TestRequests (
    request_id INT PRIMARY KEY,
    test_id INT,
    patient_id INT,
    request_date DATETIME,
    FOREIGN KEY (test_id) REFERENCES LabTests(test_id)
);

CREATE TABLE TestResults (
    result_id INT PRIMARY KEY,
    request_id INT,
    result_date DATETIME,
    result_data TEXT,
    FOREIGN KEY (request_id) REFERENCES TestRequests(request_id)
);

-- LabTests
INSERT INTO LabTests VALUES
(1, 'Complete Blood Count', 'Blood'),
(2, 'X-Ray Chest', 'Imaging');

-- TestRequests
INSERT INTO TestRequests VALUES
(101, 1, 1001, '2025-06-24 09:15:00'),
(102, 2, 1002, '2025-06-24 10:30:00');

-- TestResults
INSERT INTO TestResults VALUES
(201, 101, '2025-06-24 13:45:00', 'Normal'),
(202, 102, '2025-06-25 11:00:00', 'Minor Infection');

-- Lab Test Completion Time
SELECT 
    lt.test_name,
    tr.request_date,
    res.result_date,
    TIMESTAMPDIFF(HOUR, tr.request_date, res.result_date) AS completion_time_hours
FROM 
    TestRequests tr
JOIN 
    LabTests lt ON tr.test_id = lt.test_id
JOIN 
    TestResults res ON tr.request_id = res.request_id
ORDER BY 
    res.result_date;

-- Explanation
-- | Clause                          | Explanation                                                 |
-- | ------------------------------- | ----------------------------------------------------------- |
-- | `JOIN`                          | Combines test info with requests and results                |
-- | `TIMESTAMPDIFF(HOUR, ..., ...)` | Computes the time taken in hours between request and result |
-- | `ORDER BY res.result_date`      | Sorts results in chronological order                        |


