# Použijeme Python 3.10 jako základní obraz
FROM python:3.10-slim

# Nastavíme pracovní adresář v kontejneru
WORKDIR /app

# Nainstalujeme Poetry
RUN pip install poetry==2.1.2

# Kopírujeme soubory pro správu závislostí
COPY pyproject.toml poetry.lock* ./

# Konfigurace Poetry - nevytvářet virtuální prostředí v kontejneru (není potřeba)
RUN poetry config virtualenvs.create false

# Instalace závislostí pomocí Poetry
RUN poetry install --no-interaction --no-ansi --only main

# Kopírujeme zdrojové soubory
COPY src/ ./src/

# Spustíme generování dat při startu kontejneru
CMD ["python", "src/data/generate_data.py"]

# Definujeme výstupní volume pro přístup k vygenerovaným datům
VOLUME ["/app/data"] 