DROP TABLE IF EXISTS emergency_response;
DROP TABLE IF EXISTS emergency_event;
DROP TABLE IF EXISTS emergency_type;
DROP TABLE IF EXISTS sensor_alert;
DROP TABLE IF EXISTS wearable_device;
DROP TABLE IF EXISTS location_tracking;
DROP TABLE IF EXISTS visit_log;
DROP TABLE IF EXISTS access_log;
DROP TABLE IF EXISTS access_permission;
DROP TABLE IF EXISTS access_point;
DROP TABLE IF EXISTS qr_badge;
DROP TABLE IF EXISTS pre_registration;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS visitor;
DROP TABLE IF EXISTS patient;
DROP TABLE IF EXISTS hospital_zone;

-- 1. PATIENT
-- Stores basic patient personal information
CREATE TABLE patient (
    patient_id SERIAL PRIMARY KEY,         -- Unique ID for each patient
    first_name VARCHAR(100),               -- Patient's first name
    last_name VARCHAR(100),                -- Patient's last name
    date_of_birth DATE,                    -- DOB for age/medical records
    gender VARCHAR(20),                    -- Gender of the patient
    phone VARCHAR(50),                     -- Contact phone
    email VARCHAR(150)                     -- Contact email
);

-- 2. VISITOR
-- Stores information about visitors entering the hospital
CREATE TABLE visitor (
    visitor_id SERIAL PRIMARY KEY,         -- Unique ID for each visitor
    first_name VARCHAR(100),               -- Visitor first name
    last_name VARCHAR(100),                -- Visitor last name
    phone VARCHAR(50)                      -- Contact phone
);

-- 3. STAFF
-- Stores staff details across all hospital departments
CREATE TABLE staff (
    staff_id SERIAL PRIMARY KEY,           -- Unique staff ID
    first_name VARCHAR(100),               -- Staff first name
    last_name VARCHAR(100),                -- Staff last name
    role VARCHAR(100),                     -- Job role (doctor, nurse, security)
    department VARCHAR(100),               -- Department name
    salary INT                             -- Salary (for admin use)
);

-- 4. PRE-REGISTRATION
-- When a patient is pre-registered before the actual visit
CREATE TABLE pre_registration (
    pre_reg_id SERIAL PRIMARY KEY,         -- Unique preregistration ID
    patient_id INT REFERENCES patient(patient_id), -- Patient being preregistered
    scheduled_datetime TIMESTAMP,          -- Scheduled arrival time
    reason VARCHAR(255)                    -- Reason for visit
);

-- 5. QR BADGE
-- Stores badge info and who it was issued to
CREATE TABLE qr_badge (
    badge_id SERIAL PRIMARY KEY,           -- Unique badge ID
    issued_to_type VARCHAR(20) CHECK (issued_to_type IN ('patient','visitor','staff')),
                                             -- Defines the badge holder type
    issued_to_id INT,                      -- ID of the person (patient/visitor/staff)
    qr_code VARCHAR(255) UNIQUE,           -- Unique QR code printed on the badge
    issue_datetime TIMESTAMP,              -- When badge was issued
    expire_datetime TIMESTAMP              -- When badge becomes invalid
);

-- 6. HOSPITAL ZONE
-- Defines physical areas of the hospital
CREATE TABLE hospital_zone (
    zone_id SERIAL PRIMARY KEY,            -- Unique zone ID
    zone_name VARCHAR(100),                -- Name of the zone (ICU, Lobby, etc.)
    floor_number INT                       -- Location of the zone by floor
);

-- 7. ACCESS POINT
-- Doors/gates/scanners connected to hospital zones
CREATE TABLE access_point (
    access_point_id SERIAL PRIMARY KEY,    -- Unique access point ID
    zone_id INT REFERENCES hospital_zone(zone_id), -- Zone where scanner is located
    point_name VARCHAR(100)                -- Description/name of the access point
);

-- 8. ACCESS PERMISSION
-- Defines which badge can access which zones
CREATE TABLE access_permission (
    permission_id SERIAL PRIMARY KEY,      -- Unique permission ID
    badge_id INT REFERENCES qr_badge(badge_id),  -- Badge receiving access
    zone_id INT REFERENCES hospital_zone(zone_id), -- Allowed zone
    allowed BOOLEAN DEFAULT TRUE           -- TRUE = allowed, FALSE = denied
);

-- 9. ACCESS LOG
-- Tracks all attempts to enter through access points
CREATE TABLE access_log (
    access_log_id SERIAL PRIMARY KEY,      -- Unique log entry ID
    badge_id INT REFERENCES qr_badge(badge_id),      -- Badge used
    access_point_id INT REFERENCES access_point(access_point_id), -- Scanner used
    access_timestamp TIMESTAMP,            -- Date and time of attempt
    access_result VARCHAR(20)              -- 'allowed' or 'denied'
);

-- 10. VISIT LOG
-- Logs visits between visitors and patients
CREATE TABLE visit_log (
    visit_log_id SERIAL PRIMARY KEY,       -- Unique visit log entry
    visitor_id INT REFERENCES visitor(visitor_id), -- Visitor entering
    patient_id INT REFERENCES patient(patient_id), -- Patient being visited
    check_in TIMESTAMP,                    -- Time visitor arrived
    check_out TIMESTAMP                    -- Time visitor left
);

-- 11. LOCATION TRACKING
-- Tracks badge movement through hospital zones
CREATE TABLE location_tracking (
    tracking_id SERIAL PRIMARY KEY,        -- Unique tracking record ID
    badge_id INT REFERENCES qr_badge(badge_id),  -- Badge being tracked
    zone_id INT REFERENCES hospital_zone(zone_id), -- Zone where detected
    timestamp TIMESTAMP                    -- Time of detection
);

-- 12. WEARABLE DEVICE
-- Wearable medical devices assigned to patients
CREATE TABLE wearable_device (
    device_id SERIAL PRIMARY KEY,          -- Unique device ID
    assigned_to_patient_id INT REFERENCES patient(patient_id), -- Assigned patient
    device_type VARCHAR(100),              -- Device type (HR monitor, fall sensor)
    active BOOLEAN DEFAULT TRUE            -- Whether device is active
);

-- 13. SENSOR ALERT
-- Alerts triggered by wearable devices
CREATE TABLE sensor_alert (
    alert_id SERIAL PRIMARY KEY,           -- Unique alert ID
    device_id INT REFERENCES wearable_device(device_id), -- Triggering device
    alert_type VARCHAR(100),               -- Type of alert (fall, HR high)
    alert_value VARCHAR(100),              -- Value/reading that triggered alert
    alert_timestamp TIMESTAMP              -- Time alert occurred
);

-- 14. EMERGENCY TYPE
-- Catalog of emergency event types
CREATE TABLE emergency_type (
    emergency_type_id SERIAL PRIMARY KEY,  -- Unique emergency type ID
    type_name VARCHAR(100),                -- Name of emergency
    severity_level INT                     -- Severity rating
);

-- 15. EMERGENCY EVENT
-- An actual emergency that occurred
CREATE TABLE emergency_event (
    emergency_event_id SERIAL PRIMARY KEY, -- Unique event ID
    emergency_type_id INT REFERENCES emergency_type(emergency_type_id), -- Type of emergency
    triggered_by_badge_id INT REFERENCES qr_badge(badge_id), -- Badge that triggered event
    event_timestamp TIMESTAMP,             -- When event happened
    location_zone_id INT REFERENCES hospital_zone(zone_id) -- Where event occurred
);

-- 16. EMERGENCY RESPONSE
-- Logs staff actions taken during emergency events
CREATE TABLE emergency_response (
    response_id SERIAL PRIMARY KEY,        -- Unique response ID
    emergency_event_id INT REFERENCES emergency_event(emergency_event_id), -- Related event
    staff_id INT REFERENCES staff(staff_id), -- Staff member responding
    response_timestamp TIMESTAMP,          -- When response happened
    action_taken VARCHAR(255)              -- Description of action taken
);

-- 1. PATIENT
INSERT INTO patient (first_name, last_name, date_of_birth, gender, phone, email)
VALUES
('Alice', 'Smith', '2000-01-15', 'Female', '07123456789', 'alice@email.com'),
('Bob1', 'Johnson', '1985-07-22', 'Male', '07234567890', 'bob@email.com'),
('Carol', 'Davis', '1995-03-30', 'Female', '07345678901', 'carol@email.com');

-- 2. VISITOR
INSERT INTO visitor (first_name, last_name, phone)
VALUES
('Charlie', 'Brown', '07456789012'),
('David', 'Wilson', '07567890123'),
('Eva', 'Taylor', '07678901234');

-- 3. STAFF
INSERT INTO staff (first_name, last_name, role, department, salary)
VALUES
('Dr.', 'Who', 'Doctor', 'ICU', 80000),
('Nurse', 'Joy', 'Nurse', 'ICU', 40000),
('Security', 'Mike', 'Security', 'Lobby', 30000);

-- 4. HOSPITAL ZONE
INSERT INTO hospital_zone (zone_name, floor_number)
VALUES
('ICU', 2),
('Lobby', 1),
('ER', 1),
('Radiology', 3);

-- 5. QR BADGE
INSERT INTO qr_badge (issued_to_type, issued_to_id, qr_code, issue_datetime, expire_datetime)
VALUES
('patient', 1, 'QR001', '2025-11-27 10:00', '2026-11-27 10:00'),
('patient', 2, 'QR002', '2025-11-27 10:05', '2026-11-27 10:05'),
('visitor', 1, 'QR003', '2025-11-27 10:10', '2025-12-27 10:10'),
('staff', 1, 'QR004', '2025-11-27 10:15', '2026-11-27 10:15'),
('staff', 2, 'QR005', '2025-11-27 10:20', '2026-11-27 10:20');

-- 6. ACCESS POINT
INSERT INTO access_point (zone_id, point_name)
VALUES
(1, 'ICU Main Door'),
(2, 'Lobby Entrance'),
(3, 'ER Gate'),
(4, 'Radiology Door');

-- 7. ACCESS PERMISSION (Many-to-Many: badge ↔ zone)
INSERT INTO access_permission (badge_id, zone_id, allowed)
VALUES
(1, 2, TRUE), -- Alice can access Lobby
(2, 2, TRUE), -- Bob can access Lobby
(3, 2, TRUE), -- Visitor Charlie can access Lobby
(4, 1, TRUE), -- Dr. Who can access ICU
(4, 3, TRUE), -- Dr. Who can access ER
(5, 2, TRUE), -- Nurse Joy can access Lobby
(5, 1, TRUE); -- Nurse Joy can access ICU

-- 8. VISIT LOG (Many-to-Many: patient ↔ visitor)
INSERT INTO visit_log (visitor_id, patient_id, check_in, check_out)
VALUES
(1, 1, '2025-11-27 11:00', '2025-11-27 11:45'), -- Charlie visits Alice
(2, 2, '2025-11-27 11:10', '2025-11-27 11:50'), -- David visits Bob
(3, 3, '2025-11-27 12:00', '2025-11-27 12:30'); -- Eva visits Carol

-- 9. LOCATION TRACKING
INSERT INTO location_tracking (badge_id, zone_id, timestamp)
VALUES
(1, 2, '2025-11-27 09:15'), -- Alice in Lobby
(2, 2, '2025-11-27 09:20'), -- Bob in Lobby
(4, 1, '2025-11-27 09:25'); -- Dr. Who in ICU

-- 10. WEARABLE DEVICE
INSERT INTO wearable_device (assigned_to_patient_id, device_type, active)
VALUES
(1, 'Heart Rate Monitor', TRUE),
(2, 'Fall Sensor', TRUE);

-- 11. SENSOR ALERT
INSERT INTO sensor_alert (device_id, alert_type, alert_value, alert_timestamp)
VALUES
(1, 'High Heart Rate', '120 bpm', '2025-11-27 09:20'),
(2, 'Fall Detected', 'N/A', '2025-11-27 09:25');

-- 12. EMERGENCY TYPE
INSERT INTO emergency_type (type_name, severity_level)
VALUES
('Cardiac Arrest', 5),
('Fire', 4);

-- 13. EMERGENCY EVENT
INSERT INTO emergency_event (emergency_type_id, triggered_by_badge_id, event_timestamp, location_zone_id)
VALUES
(1, 1, '2025-11-27 09:25', 1), -- Cardiac Arrest by Alice in ICU
(2, 2, '2025-11-27 09:30', 2); -- Fire by Bob in Lobby

-- 14. EMERGENCY RESPONSE (Many-to-Many: staff ↔ emergency_event)
INSERT INTO emergency_response (emergency_event_id, staff_id, response_timestamp, action_taken)
VALUES
(1, 1, '2025-11-27 09:26', 'CPR initiated by Dr. Who'),
(1, 2, '2025-11-27 09:27', 'Assisted in CPR by Nurse Joy'),
(2, 2, '2025-11-27 09:31', 'Evacuation assisted by Nurse Joy'),
(2, 3, '2025-11-27 09:32', 'Security managed crowd by Security Mike');


SELECT * FROM patient;
SELECT current_database();
SELECT * FROM access_log LIMIT 10;


-- 1. Посмотреть последние 10 записей в access_log
SELECT *
FROM access_log
ORDER BY access_timestamp DESC
LIMIT 10;

-- 2. Посмотреть последние 10 записей в visit_log
SELECT *
FROM visit_log
ORDER BY check_in DESC
LIMIT 10;

-- 3. Посмотреть последние 10 записей в location_tracking
SELECT *
FROM location_tracking
ORDER BY timestamp DESC
LIMIT 10;

-- 4. Посмотреть последние 10 записей в sensor_alert
SELECT *
FROM sensor_alert
ORDER BY alert_timestamp DESC
LIMIT 10;

-- 5. Посмотреть последние 5 emergency_event с откликами персонала
SELECT ee.emergency_event_id,
       ee.emergency_type_id,
       ee.triggered_by_badge_id,
       ee.event_timestamp,
       ee.location_zone_id,
       er.staff_id,
       er.response_timestamp,
       er.action_taken
FROM emergency_event ee
LEFT JOIN emergency_response er ON ee.emergency_event_id = er.emergency_event_id
ORDER BY ee.event_timestamp DESC
LIMIT 5;
