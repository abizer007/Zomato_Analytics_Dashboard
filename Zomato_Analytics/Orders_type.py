import pandas as pd

# Load Excel file
df = pd.read_excel("orders_Type.xlsx")

# SQL escape function
def escape(val):
    if pd.isna(val):
        return "NULL"
    if isinstance(val, str):
        return "'" + val.replace("'", "''") + "'"
    if isinstance(val, pd.Timestamp):
        return f"'{val.date()}'"
    return str(val)

# Define PostgreSQL-compatible types
sql_types = {
    "int64": "INTEGER",
    "float64": "FLOAT",
    "object": "TEXT",
    "datetime64[ns]": "DATE",
    "bool": "BOOLEAN"
}

# Build CREATE TABLE statement
columns = []
for col in df.columns:
    dtype = str(df[col].dtype)
    col_type = sql_types.get(dtype, "TEXT")
    columns.append(f"{col} {col_type}")
create_stmt = "CREATE TABLE orders_type (\n    " + ",\n    ".join(columns) + "\n);"

# Build INSERT statements
insert_stmts = []
for _, row in df.iterrows():
    values = ", ".join(escape(row[col]) for col in df.columns)
    insert_stmts.append(f"INSERT INTO orders_type VALUES ({values});")

# Save SQL to file
with open("insert_orders_type.sql", "w", encoding="utf-8") as f:
    f.write(create_stmt + "\n" + "\n".join(insert_stmts))
