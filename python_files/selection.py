from connection import get_connection


def select_data():
    conn = get_connection()
    cur = conn.cursor()
