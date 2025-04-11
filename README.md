# 🍽️ Zomato Data Analytics – SQL & Power BI Based Business Intelligence Platform

> **Semester Project – B.Tech CSE (DBMS Course)**  
> **Academic Year: 2024–2025**  
> **Team Members:**  
> - E034 – Abizer Masavi  
> - E037 – Subham Mohapatra  
> - E039 – Arzaan Mulla  

---

## 📘 Project Description

This project simulates a real-time food delivery analytics system using **PostgreSQL** and **Power BI**. By emulating Zomato’s operational environment, we created a full-stack data pipeline—from raw data preprocessing to advanced query analytics and KPI visualization.

The objective was to derive actionable insights into:
- Restaurant performance  
- User behavior patterns  
- Cuisine popularity  
- Sales trends across time and geography  

---

## 🛠️ Tech Stack & Tools

| Category               | Tools Used                          |
|------------------------|-------------------------------------|
| Database Engine        | PostgreSQL + pgAdmin4               |
| Data Visualization     | Microsoft Power BI                  |
| Data Processing        | Python + Pandas                     |
| Schema & Modeling      | Draw.io (ERD), SQL (DDL)            |
| SQL Concepts           | CTEs, Window Functions, Correlation |
| Data Import / Export   | Excel, Python-generated SQL         |

---

## 🔗 Key Links

- 📂 **GitHub Repository**: [github.com/your-org/zomato-analytics](#) *(Replace with real link)*    
- 📊 **Live Power BI Dashboard**: [View Interactive Dashboard](#) *(Public Power BI link)*

---

## 🧱 Database Schema Overview

- **6 Core Tables**: `users`, `restaurants`, `orders`, `order_type`, `menu`, `food`
- **1 Normalized Bridge Table**: `menu_cuisine`
- Complies with **1NF, 2NF, 3NF**
- Supports **foreign keys**, **one-to-many**, and **composite relationships**

> 📎 ER Diagram: Available in `ERD.drawio` and in `/screenshots/erd.png`

---

## 🧮 Advanced SQL Query Highlights

- 🥇 Top-rated restaurants per city  
- 📆 Yearly + monthly + seasonal sales aggregation  
- 💡 Customer lifetime value & segmentation  
- 🍛 Most popular cuisines per geography  
- 📉 High-rated but underperforming restaurants  
- 📊 Sales trend correlation using `CORR()` over time  

> ✅ Full SQL query set

---

## 🧠 Power BI Dashboard Features

- 📌 Toggle between **Sales Amount** and **Order Quantity**
- 📍 Visualize **Top Performing Cities**
- 🧑‍🍳 Analyze **User behavior** by gender, age, and retention
- 🧾 Compare **Sales by Cuisine**, **Ratings vs Revenue**, and **Seasonal Variations**
- 🧭 Drill-downs for deep dives into city-level metrics

---

## 🖼️ Screenshots

> Please replace `#` with actual image file paths from `/screenshots/` directory

### 1️⃣ Index Page  
![image](https://github.com/user-attachments/assets/80800781-8b28-4ebc-a84d-a1a46babe014)


### 2️⃣ Year-wise Sales & User Trends  
![image](https://github.com/user-attachments/assets/233f466b-7874-4ea6-b058-d57d867ea816)


### 3️⃣ User-Wise Performance & Ratings  
![image](https://github.com/user-attachments/assets/cbed04c3-cb22-4c54-a67c-c03ded75928b)


### 4️⃣ City Performance 
![image](https://github.com/user-attachments/assets/7bd89598-03a3-4f95-93d4-4e60e11dbf0f)


---

## ⚙️ Python Automation – Data Insertion

We used Python to generate SQL `INSERT` statements dynamically from Excel:

```python
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

```

Full code in: [`scripts/generate_insert_queries.py`](#)

---

## 🧪 Learning Outcomes

- Built production-style **normalized relational schema**
- Applied **correlation, seasonal**, and **trend analysis** via SQL
- Learned **DAX**, **Power Query**, and custom **Power BI visuals**
- Gained experience in **ETL**, **data cleaning**, and **real-time reporting**

---

## ⚠️ Known Challenges & Solutions

| Issue                                | Solution |
|-------------------------------------|----------|
| PostgreSQL import performance       | Used PgAdmin4 & optimized batch inserts |
| Power BI slowness with big data     | Used **DirectQuery** and **aggregated imports** |
| 1NF Violation (Multi-cuisine)       | Created bridge table `menu_cuisine` |
| Missing & inconsistent entries      | Cleaned using Pandas & SQL filters |

---

## 📚 Recommended Use

This repository is ideal for:
- Students building **database-backed analytics systems**
- Analysts learning **SQL + Power BI integration**
- Academic demonstration of **data pipeline architecture**

---

## 👋 Contact

For queries or collaborations, feel free to reach out:

- **Abizer** – abizer.masavi@gmail.com 
- **Subham** – subham.mohapatra0905@gmail.com
- **Arzaan** – arzaanm2005@gmail.com

---

> **“Data is only as powerful as the decisions it fuels.”**
