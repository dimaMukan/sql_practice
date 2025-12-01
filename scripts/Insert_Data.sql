
-- =======================================================
-- SAMPLE DATA
-- =======================================================

INSERT INTO Patient (first_name,last_name,date_of_birth,gender,phone,email)
VALUES ('John','Doe','1980-01-01','Male','+441234567890','john@example.com');

INSERT INTO Visitor (first_name,last_name,date_of_birth,phone,email)
VALUES ('Jane','Smith','1990-05-12','+441234567891','jane@example.com');

INSERT INTO Staff (first_name,last_name,position,department,email)
VALUES ('Alice','Brown','Doctor','Cardiology','alice@example.com');

INSERT INTO QR_Badge (issue_date,expiry_date)
VALUES ('2025-11-01','2026-11-01');

INSERT INTO Pre_Registration (patient_id, visitor_id, qr_badge_id)
VALUES (1,NULL,1);

INSERT INTO Hospital_Zone (name,description,floor_number)
VALUES ('Ward A','Cardiology ward',1);

INSERT INTO Access_Point (zone_id,location_description)
VALUES (1,'Main Entrance');

INSERT INTO Access_Permission (staff_id,access_point_id,start_date,end_date)
VALUES (1,1,'2025-11-01','2025-12-01');

INSERT INTO Access_Log (access_permission_id,timestamp,action_type)
VALUES (1,NOW(),'entry');

INSERT INTO Visit_Log (patient_id,visitor_id,zone_id,timestamp)
VALUES (1,1,1,NOW());

INSERT INTO Wearable_Device (patient_id,type,status)
VALUES (1,'Heart Monitor','active');

INSERT INTO Location_Tracking (device_id,zone_id,timestamp)
VALUES (1,1,NOW());

INSERT INTO Sensor_Alert (device_id,alert_type,alert_value,timestamp)
VALUES (1,'High Heart Rate','150 bpm',NOW());

INSERT INTO Emergency_Type (name,description)
VALUES ('Fire','Fire emergency event');

INSERT INTO Emergency_Event (emergency_type_id,zone_id,timestamp,description)
VALUES (1,1,NOW(),'Fire detected in Ward A');

INSERT INTO Emergency_Response (emergency_event_id,staff_id,action_taken,timestamp)
VALUES (1,1,'Evacuated all patients',NOW());
