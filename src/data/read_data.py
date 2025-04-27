import pandas as pd



def main():
    # Cesta k parquet souborům
    PARQUET_PATH = "data"

    try:
        # Načtení parquet souborů
        customers = pd.read_parquet(f'{PARQUET_PATH}/customers.parquet')
        products = pd.read_parquet(f'{PARQUET_PATH}/products.parquet')
        orders = pd.read_parquet(f'{PARQUET_PATH}/orders.parquet')
        
        # Výpis informací o dataframech
        print("=== CUSTOMERS ===")
        print(f"Počet záznamů: {len(customers)}")
        print(customers.head(3))  # Zobrazí první 3 záznamy
        print("\n")
        
        print("=== PRODUCTS ===")
        print(f"Počet záznamů: {len(products)}")
        print(products.head(3))
        print("\n")
        
        print("=== ORDERS ===")
        print(f"Počet záznamů: {len(orders)}")
        print(orders.head(3))
        
    except Exception as e:
        print(f"Chyba při načítání dat: {e}")


if __name__ == "__main__":
    main()