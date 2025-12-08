from connection import get_connection


def select_data():
    conn = get_connection()
    cur = conn.cursor()

    cur.execute("select * from patient")
    rows = cur.fetchall()
    return rows
    # print(rows)