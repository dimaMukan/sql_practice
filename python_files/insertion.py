from connection import get_connection
from random import choice, randint
from datetime import datetime
import time


def insert_data():
    conn = get_connection()
    cur = conn.cursor()


    cur.close()
    conn.close()
    print("Finished generating 1000 events!")