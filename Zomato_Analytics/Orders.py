import pandas as pd

# Load Excel file
df = pd.read_excel("orders.xlsx")

# Escape function
def escape_sql_value(val):
    if pd.isna(val):
        return "NULL"
    if isinstance(val, str):
        return "'" + val.replace("'", "''") + "'"
    if isinstance(val, pd.Timestamp):
        return f"'{val.date()}'"
    return str(val)

# SQL schema
create_sql = """
CREATE TABLE orders (
    order_date DATE,
    sales_qty INTEGER,
    sales_amount INTEGER,
    currency TEXT,
    user_id INTEGER,
    r_id INTEGER
);
"""

# Insert data
insert_sql = []
for _, row in df.iterrows():
    values = ", ".join(escape_sql_value(row[col]) for col in df.columns)
    insert_sql.append(f"INSERT INTO orders VALUES ({values});")

# Save SQL file
with open("insert_orders.sql", "w", encoding="utf-8") as f:
    f.write(create_sql + "\n" + "\n".join(insert_sql))
