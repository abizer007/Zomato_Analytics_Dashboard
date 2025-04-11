import pandas as pd

# Load Excel file
df = pd.read_excel("restaurant.xlsx")

# Escape single quotes for SQL
def escape_sql(value):
    if pd.isna(value):
        return "NULL"
    value = str(value).replace("'", "''")
    return f"'{value}'"

# Table name
table_name = "restaurants"

# Create table SQL
create_table = f"""
CREATE TABLE {table_name} (
    id INTEGER PRIMARY KEY,
    name TEXT,
    country TEXT,
    city TEXT,
    rating TEXT,
    rating_count TEXT,
    cuisine TEXT,
    link TEXT,
    address TEXT
);
"""

# Insert rows
insert_lines = []
for _, row in df.iterrows():
    values = ", ".join(escape_sql(row[col]) for col in df.columns)
    insert_lines.append(f"INSERT INTO {table_name} VALUES ({values});")

# Save to file
with open("insert_restaurants.sql", "w", encoding="utf-8") as f:
    f.write(create_table + "\n" + "\n".join(insert_lines))
