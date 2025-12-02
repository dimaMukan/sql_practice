
-- Patients
INSERT INTO Patient (first_name,last_name,date_of_birth,gender,phone,email)
VALUES
('John','Doe','1980-01-01','Male','+441234567890','john@example.com'),
('Mary','Johnson','1975-03-15','Female','+441234567891','mary@example.com'),
('Peter','Williams','1990-07-22','Male','+441234567892','peter@example.com');

-- Visitors
INSERT INTO Visitor (first_name,last_name,date_of_birth,phone,email)
VALUES
('Jane','Smith','1990-05-12','+441234567893','jane@example.com'),
('Michael','Brown','1985-08-20','+441234567894','michael@example.com'),
('Linda','Davis','1992-11-05','+441234567895','linda@example.com');

-- Staff
INSERT INTO Staff (first_name,last_name,position,department,email)
VALUES
('Alice','Brown','Doctor','Cardiology','alice@example.com'),
('Robert','Taylor','Nurse','ICU','robert@example.com'),
('Emily','Wilson','Security','Main Gate','emily@example.com');

-- QR Badges
INSERT INTO QR_Badge (issue_date,expiry_date)
VALUES
('2025-11-01','2026-11-01'),
('2025-11-05','2026-11-05'),
('2025-11-10','2026-11-10');

-- Pre_Registrations
INSERT INTO Pre_Registration (patient_id, visitor_id, qr_badge_id)
VALUES
(1,NULL,1),
(2,2,2),
(3,3,3);

-- Hospital Zones
INSERT INTO Hospital_Zone (name,description,floor_number)
VALUES
('Ward A','Cardiology ward',1),
('Ward B','ICU ward',2),
('Main Hall','Entrance and lobby',0);

-- Access Points
INSERT INTO Access_Point (zone_id,location_description)
VALUES
(1,'Main Entrance Ward A'),
(2,'ICU Entrance Ward B'),
(3,'Lobby Main Entrance');

-- Access Permissions
INSERT INTO Access_Permission (staff_id, patient_id, visitor_id,access_point_id,start_date,end_date)
VALUES
(1,1,2,3,'2025-11-01','2025-12-01'),
(2,2,1,3,'2025-11-05','2025-12-05'),
(3,3,3,1,'2025-11-10','2025-12-10');

-- Visit Logs
INSERT INTO Visit_Log (patient_id,visitor_id,zone_id,timestamp)
VALUES
(1,1,1,NOW()),
(2,2,2,NOW()),
(3,3,3,NOW());

-- Wearable Devices
INSERT INTO Wearable_Device (patient_id, visitor_id, type, status)
VALUES
(1, NULL, 'Heart Monitor', 'active'),
(1, NULL, 'Blood Pressure Monitor', 'active'),
(2, 1, 'Visitor Tracker', 'active'),
(2, NULL, 'Oxygen Monitor', 'active'),
(NULL, 2, 'Visitor Tracker', 'active'),
(3, NULL, 'Heart Monitor', 'inactive');

-- Location Tracking
INSERT INTO Location_Tracking (device_id,zone_id,timestamp)
VALUES
(1,1,NOW()),
(2,1,NOW()),
(3,1,NOW()),
(4,2,NOW()),
(5,2,NOW()),
(6,3,NOW());

-- Emergency Types
INSERT INTO Emergency_Type (name,description)
VALUES
('Fire','Fire emergency event'),
('Medical','Medical emergency');

-- Emergency Events
INSERT INTO Emergency_Event (emergency_type_id,zone_id,timestamp,description)
VALUES
(1,1,NOW(),'Fire detected in Ward A'),
(2,2,NOW(),'Patient critical in ICU');

-- Emergency Responses
INSERT INTO Emergency_Response (emergency_event_id,staff_id,action_taken,timestamp)
VALUES
(1,1,'Evacuated all patients',NOW()),
(2,2,'Administered emergency care',NOW());
