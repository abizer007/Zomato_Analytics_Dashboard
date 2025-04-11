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
- 🧩 **PostgreSQL SQL Dump**: [`zomato_schema.sql`](#) *(Schema + Insert Queries)*  
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

> ✅ Full SQL query set: [`analytics_queries.sql`](#)

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

### 1️⃣ Dashboard Home  
![Dashboard Home](#)

### 2️⃣ Year-wise Sales & User Trends  
![Sales Trend](#)

### 3️⃣ City-Wise Performance & Ratings  
![City Metrics](#)

### 4️⃣ Cuisine & Order Patterns  
![Cuisines](#)

---

## ⚙️ Python Automation – Data Insertion

We used Python to generate SQL `INSERT` statements dynamically from Excel:

```python
import pandas as pd
df = pd.read_excel("restaurants.xlsx")
def escape(val): return f"'{str(val).replace("'", "''")}'" if pd.notna(val) else "NULL"
for _, row in df.iterrows():
    print(f"INSERT INTO restaurants (...) VALUES ({...});")
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

- **Abizer** – abizer.masavi@example.com  
- **Subham** – subham.mohapatra@example.com  
- **Arzaan** – arzaan.mulla@example.com  

---

> **“Data is only as powerful as the decisions it fuels.”**
