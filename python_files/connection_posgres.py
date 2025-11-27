import psycopg2
from datetime import datetime
import random

# --- Подключение к базе ---
conn = psycopg2.connect(
    dbname="postgres",
    user="postgres",
    password="d10052004",
    host="localhost",
    port="5432"
)
cur = conn.cursor()

# -------------------------------
# Получаем существующие ID для FK
# -------------------------------
cur.execute("SELECT badge_id FROM qr_badge;")
badge_ids = [row[0] for row in cur.fetchall()]

cur.execute("SELECT access_point_id FROM access_point;")
access_point_ids = [row[0] for row in cur.fetchall()]

cur.execute("SELECT visitor_id FROM visitor;")
visitor_ids = [row[0] for row in cur.fetchall()]

cur.execute("SELECT patient_id FROM patient;")
patient_ids = [row[0] for row in cur.fetchall()]

cur.execute("SELECT zone_id FROM hospital_zone;")
zone_ids = [row[0] for row in cur.fetchall()]

cur.execute("SELECT device_id FROM wearable_device;")
device_ids = [row[0] for row in cur.fetchall()]

cur.execute("SELECT staff_id FROM staff;")
staff_ids = [row[0] for row in cur.fetchall()]

cur.execute("SELECT emergency_type_id FROM emergency_type;")
emergency_type_ids = [row[0] for row in cur.fetchall()]

# -------------------------------
# INSERT в ACCESS_LOG
# -------------------------------

'''
ok, how do i insert the python code , my project with adding the scripts into the db, into the sam GitHub project, so ill have all consoles which i pushed before  in one of the files and in another file its going to be the python project, just give me step by step instructions, i want it to look like this:
two files in one project  : with python code and with sql consoles(already pushed)
 
'''
for _ in range(5):
    cur.execute("""
        INSERT INTO access_log (badge_id, access_point_id, access_timestamp, access_result)
        VALUES (%s, %s, %s, %s)
    """, (
        random.choice(badge_ids),
        random.choice(access_point_ids),
        datetime.now(),
        random.choice(['allowed', 'denied'])
    ))

# -------------------------------
# INSERT в VISIT_LOG
# -------------------------------
for _ in range(3):
    cur.execute("""
        INSERT INTO visit_log (visitor_id, patient_id, check_in, check_out)
        VALUES (%s, %s, %s, %s)
    """, (
        random.choice(visitor_ids),
        random.choice(patient_ids),
        datetime.now(),
        datetime.now()
    ))

# -------------------------------
# INSERT в LOCATION_TRACKING
# -------------------------------
for _ in range(5):
    cur.execute("""
        INSERT INTO location_tracking (badge_id, zone_id, timestamp)
        VALUES (%s, %s, %s)
    """, (
        random.choice(badge_ids),
        random.choice(zone_ids),
        datetime.now()
    ))

# -------------------------------
# INSERT в SENSOR_ALERT
# -------------------------------
alert_types = ['fall', 'HR high', 'HR low']
for _ in range(3):
    cur.execute("""
        INSERT INTO sensor_alert (device_id, alert_type, alert_value, alert_timestamp)
        VALUES (%s, %s, %s, %s)
    """, (
        random.choice(device_ids),
        random.choice(alert_types),
        str(random.randint(80, 180)),
        datetime.now()
    ))

# -------------------------------
# INSERT в EMERGENCY_EVENT и EMERGENCY_RESPONSE
# -------------------------------
cur.execute("""
    INSERT INTO emergency_event (emergency_type_id, triggered_by_badge_id, event_timestamp, location_zone_id)
    VALUES (%s, %s, %s, %s) RETURNING emergency_event_id
""", (
    random.choice(emergency_type_ids),
    random.choice(badge_ids),
    datetime.now(),
    random.choice(zone_ids)
))
event_id = cur.fetchone()[0]

# Ответ персонала
cur.execute("""
    INSERT INTO emergency_response (emergency_event_id, staff_id, response_timestamp, action_taken)
    VALUES (%s, %s, %s, %s)
""", (
    event_id,
    random.choice(staff_ids),
    datetime.now(),
    "Responded to emergency"
))

# -------------------------------
# Сохраняем изменения
# -------------------------------
conn.commit()
cur.close()
conn.close()

print("Unstable data inserted successfully!")
