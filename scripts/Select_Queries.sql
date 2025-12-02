TRUNCATE TABLE Location_Tracking RESTART IDENTITY CASCADE;
SELECT * FROM Location_Tracking ORDER BY timestamp DESC;

SELECT * FROM Sensor_Alert ORDER BY timestamp DESC;

SELECT *
FROM staff;

SELECT * FROM Access_Log ORDER BY timestamp DESC;

SELECT lt.tracking_id, wd.type AS device_type, hz.name AS zone_name, lt.timestamp
FROM Location_Tracking lt
JOIN Wearable_Device wd ON lt.device_id = wd.device_id
JOIN Hospital_Zone hz ON lt.zone_id = hz.zone_id
ORDER BY lt.timestamp DESC
LIMIT 2000;

SELECT first_name,last_name, email
FROM Patient;

SELECT first_name,department
FROM staff
WHERE department = 'ICU';


SELECT p.first_name, p.last_name, w.type, w.status
FROM Patient p
JOIN Wearable_Device w ON p.patient_id = w.patient_id;

SELECT qr_badge_id,expiry_date
FROM qr_badge
WHERE expiry_date >= now();

SELECT name,floor_number
FROM hospital_zone
WHERE floor_number = 1;

SELECT type,status
FROM Wearable_Device
WHERE status = 'active';

SELECT first_name,last_name,gender,type
FROM patient p
JOIN wearable_device w ON p.patient_id = w.patient_id;

SELECT *
FROM patient;

SELECT *
FROM visit_log
WHERE timestamp >= CURRENT_DATE - INTERVAL '7 days';

SELECT vl.visit_log_id, vl.timestamp,
       p.first_name AS patient_first, p.last_name AS patient_last,
       v.first_name AS visitor_first, v.last_name AS visitor_last,
       hz.name AS zone_name
FROM Visit_Log vl
JOIN Patient p ON vl.patient_id = p.patient_id
JOIN Visitor v ON vl.visitor_id = v.visitor_id
JOIN Hospital_Zone hz ON vl.zone_id = hz.zone_id;

SELECT p.first_name, p.last_name, pnt.location_description
FROM Access_Permission ap
JOIN patient p ON ap.patient_id = p.patient_id
JOIN access_point pnt ON ap.access_point_id = pnt.access_point_id;
