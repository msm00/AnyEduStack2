from faker import Faker
import pandas as pd
import numpy as np
import uuid
from datetime import datetime, timedelta
import os

fake = Faker()
Faker.seed(42)

PARQUET_PATH = "data"

def generate_customers(n):
    return [{
        'customer_id': str(uuid.uuid4()),
        'name': fake.name(),
        'email': fake.email(),
        'address': fake.address(),
        'registered_at': fake.date_between(start_date='-2y', end_date='today').isoformat()
    } for _ in range(n)]

def generate_products(n):
    categories = ['Electronics', 'Books', 'Clothing', 'Home', 'Toys']
    return [{
        'product_id': str(uuid.uuid4()),
        'name': fake.word().capitalize(),
        'category': np.random.choice(categories),
        'price': round(np.random.uniform(5.0, 500.0), 2)
    } for _ in range(n)]

def generate_orders(customers, products, n):
    return [{
        'order_id': str(uuid.uuid4()),
        'customer_id': np.random.choice(customers)['customer_id'],
        'product_id': np.random.choice(products)['product_id'],
        'quantity': np.random.randint(1, 5),
        'order_date': fake.date_between(start_date='-1y', end_date='today').isoformat()
    } for _ in range(n)]

if __name__ == "__main__":
    os.makedirs(PARQUET_PATH, exist_ok=True)
    
    customers = generate_customers(100)
    products = generate_products(50)
    orders = generate_orders(customers, products, 500)

    pd.DataFrame(customers).to_parquet(f'{PARQUET_PATH}/customers.parquet', index=False)
    pd.DataFrame(products).to_parquet(f'{PARQUET_PATH}/products.parquet', index=False)
    pd.DataFrame(orders).to_parquet(f'{PARQUET_PATH}/orders.parquet', index=False)