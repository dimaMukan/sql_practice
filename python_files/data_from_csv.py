# import pandas as pd
import csv
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent

def load_csv(file_path:str) -> list[dict]:
    with open(file_path, newline='') as csvfile:
        return list(csv.DictReader(csvfile))

customers = load_csv(f"{BASE_DIR}/raw_datafiles/customers_raw.csv")
products = load_csv(f"{BASE_DIR}/raw_datafiles/products_raw.csv")
orders = load_csv(f"{BASE_DIR}/raw_datafiles/orders_raw.csv")
tickets = load_csv(f"{BASE_DIR}/raw_datafiles/tickets_raw.csv")


print(customers)
# print(products)
# print(orders)
# print(tickets)
