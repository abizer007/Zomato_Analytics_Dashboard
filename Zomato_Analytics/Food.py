import pandas as pd

# Load the Excel file
df = pd.read_excel("food (1).xlsx")

# Function to escape SQL values
def escape(val):
    if pd.isna(val):
        return "NULL"
    if isinstance(val, str):
        return "'" + val.replace("'", "''") + "'"
    if isinstance(val, pd.Timestamp):
        return f"'{val.date()}'"
    return str(val)

# Define column types for PostgreSQL
sql_types = {
    "int64": "INTEGER",
    "float64": "FLOAT",
    "object": "TEXT",
    "datetime64[ns]": "DATE",
    "bool": "BOOLEAN"
}

# Create table SQL
columns = []
for col in df.columns:
    dtype = str(df[col].dtype)
    col_type = sql_types.get(dtype, "TEXT")
    columns.append(f"{col} {col_type}")
create_stmt = "CREATE TABLE food (\n    " + ",\n    ".join(columns) + "\n);"

# Create INSERT statements
insert_stmts = []
for _, row in df.iterrows():
    values = ", ".join(escape(row[col]) for col in df.columns)
    insert_stmts.append(f"INSERT INTO food VALUES ({values});")

# Write to file
with open("insert_food.sql", "w", encoding="utf-8") as f:
    f.write(create_stmt + "\n" + "\n".join(insert_stmts))
