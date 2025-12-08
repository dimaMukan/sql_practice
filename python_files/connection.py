import psycopg2

def get_connection():
    return psycopg2.connect(
        dbname="project_cw",
        user="postgres",
        password="d10052004",
        host="localhost",
        port="5432"
    )