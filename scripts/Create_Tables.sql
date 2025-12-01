
DROP TABLE IF EXISTS Emergency_Response;
DROP TABLE IF EXISTS Emergency_Event;
DROP TABLE IF EXISTS Emergency_Type;
DROP TABLE IF EXISTS Sensor_Alert;
DROP TABLE IF EXISTS Location_Tracking;
DROP TABLE IF EXISTS Wearable_Device;
DROP TABLE IF EXISTS Visit_Log;
DROP TABLE IF EXISTS Access_Log;
DROP TABLE IF EXISTS Access_Permission;
DROP TABLE IF EXISTS Access_Point;
DROP TABLE IF EXISTS Hospital_Zone;
DROP TABLE IF EXISTS Pre_Registration;
DROP TABLE IF EXISTS QR_Badge;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Visitor;
DROP TABLE IF EXISTS Patient;


CREATE TABLE Patient (
    patient_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    gender VARCHAR(10),
    phone VARCHAR(20),
    email VARCHAR(50)
);


CREATE TABLE Visitor (
    visitor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    phone VARCHAR(20),
    email VARCHAR(50)
);


CREATE TABLE Staff (
    staff_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    position VARCHAR(50),
    department VARCHAR(50),
    email VARCHAR(50)
);


CREATE TABLE QR_Badge (
    qr_badge_id SERIAL PRIMARY KEY,
    issue_date DATE,
    expiry_date DATE
);


CREATE TABLE Pre_Registration (
    pre_reg_id SERIAL PRIMARY KEY,
    patient_id INT REFERENCES Patient(patient_id),
    visitor_id INT REFERENCES Visitor(visitor_id),
    qr_badge_id INT NOT NULL REFERENCES QR_Badge(qr_badge_id)
);


CREATE TABLE Hospital_Zone (
    zone_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    description TEXT,
    floor_number INT
);


CREATE TABLE Access_Point (
    access_point_id SERIAL PRIMARY KEY,
    zone_id INT REFERENCES Hospital_Zone(zone_id),
    location_description TEXT
);


CREATE TABLE Access_Permission (
    permission_id SERIAL PRIMARY KEY,
    staff_id INT REFERENCES Staff(staff_id),
    patient_id INT REFERENCES Patient(patient_id),
    visitor_id INT REFERENCES Visitor(visitor_id),
    access_point_id INT NOT NULL REFERENCES Access_Point(access_point_id),
    start_date DATE,
    end_date DATE
);


CREATE TABLE Access_Log (
    access_log_id SERIAL PRIMARY KEY,
    access_permission_id INT REFERENCES Access_Permission(permission_id),
    timestamp TIMESTAMP,
    action_type VARCHAR(10)  -- entry / exit
);


CREATE TABLE Visit_Log (
    visit_log_id SERIAL PRIMARY KEY,
    patient_id INT REFERENCES Patient(patient_id),
    visitor_id INT REFERENCES Visitor(visitor_id),
    zone_id INT REFERENCES Hospital_Zone(zone_id),
    timestamp TIMESTAMP
);


CREATE TABLE Wearable_Device (
    device_id SERIAL PRIMARY KEY,
    patient_id INT REFERENCES Patient(patient_id),
    visitor_id INT REFERENCES Visitor(visitor_id),
    type VARCHAR(50),
    status VARCHAR(20)
);


CREATE TABLE Location_Tracking (
    tracking_id SERIAL PRIMARY KEY,
    device_id INT REFERENCES Wearable_Device(device_id),
    zone_id INT REFERENCES Hospital_Zone(zone_id),
    timestamp TIMESTAMP
);


CREATE TABLE Sensor_Alert (
    alert_id SERIAL PRIMARY KEY,
    device_id INT REFERENCES Wearable_Device(device_id),
    alert_type VARCHAR(50),
    alert_value VARCHAR(200),
    timestamp TIMESTAMP
);


CREATE TABLE Emergency_Type (
    emergency_type_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    description TEXT
);


CREATE TABLE Emergency_Event (
    emergency_event_id SERIAL PRIMARY KEY,
    emergency_type_id INT REFERENCES Emergency_Type(emergency_type_id),
    zone_id INT REFERENCES Hospital_Zone(zone_id),
    timestamp TIMESTAMP,
    description TEXT
);


CREATE TABLE Emergency_Response (
    response_id SERIAL PRIMARY KEY,
    emergency_event_id INT REFERENCES Emergency_Event(emergency_event_id),
    staff_id INT REFERENCES Staff(staff_id),
    action_taken TEXT,
    timestamp TIMESTAMP
);
