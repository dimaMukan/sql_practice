import psycopg2
from random import choice, randint
from datetime import datetime, timedelta
import time

conn = psycopg2.connect(
    dbname="project_cw",
    user="postgres",
    password="d10052004",
    host="localhost",
    port="5432"
)
cur = conn.cursor()

cur.execute("SELECT current_database();")
print("Connected to DB:", cur.fetchone())

# ID
cur.execute("SELECT patient_id FROM patient;")
patient_ids = [row[0] for row in cur.fetchall()]

cur.execute("SELECT visitor_id FROM visitor;")
visitor_ids = [row[0] for row in cur.fetchall()]

cur.execute("SELECT staff_id FROM staff;")
staff_ids = [row[0] for row in cur.fetchall()]

cur.execute("SELECT device_id FROM wearable_device;")
device_ids = [row[0] for row in cur.fetchall()]

cur.execute("SELECT zone_id FROM hospital_zone;")
zone_ids = [row[0] for row in cur.fetchall()]

cur.execute("SELECT permission_id FROM access_permission;")
access_permission_ids = [row[0] for row in cur.fetchall()]


print("Patients:", patient_ids)
print("Visitors:", visitor_ids)
print("Staff:", staff_ids)
print("Devices:", device_ids)
print("Zones:", zone_ids)
print("Access permissions:", access_permission_ids)



MAX_EVENTS = 1000
SLEEP_TIME = 0.01

count = 0

while count < MAX_EVENTS:
    device_id = choice(device_ids)
    zone_id = choice(zone_ids)
    cur.execute(
        "INSERT INTO Location_Tracking (device_id, zone_id, timestamp) VALUES (%s, %s, %s)",
        (device_id, zone_id, datetime.now())
    )

    device_id = choice(device_ids)
    alert_type = choice(["High Heart Rate", "Low Oxygen", "Fall Detected"])
    alert_value = str(randint(50, 200))
    cur.execute(
        "INSERT INTO Sensor_Alert (device_id, alert_type, alert_value, timestamp) VALUES (%s, %s, %s, %s)",
        (device_id, alert_type, alert_value, datetime.now())
    )

    access_permission_id = choice(access_permission_ids)
    action_type = choice(["entry", "exit"])
    cur.execute(
        "INSERT INTO Access_Log (access_permission_id, timestamp, action_type) VALUES (%s, %s, %s)",
        (access_permission_id, datetime.now(), action_type)
    )

    conn.commit()
    count += 1
    if count % 10 == 0:
        print(f"Inserted {count}/{MAX_EVENTS} events")
    time.sleep(SLEEP_TIME)

cur.close()
conn.close()
print("Finished generating 1000 events!")
