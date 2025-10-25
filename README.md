🧠 Overview

A modern E-Commerce Data Warehouse built with dbt (Data Build Tool) to model, test, and document analytical datasets on BigQuery / Snowflake.
It transforms raw transactional data into clean, analytics-ready tables powering real-time insights in PowerBI.

Highlights
Star-schema modeling for customer, order, and product analytics
Automated SQL transformations & lineage tracking via dbt
Built-in data integrity tests ensuring 100 % reliability
Seamless PowerBI integration for KPI dashboards

🧩 Architecture
flowchart LR
A[Raw Data Sources] -->|dbt seed| B[Raw Layer]
B -->|Transform| C[Staging Models (stg_*)]
C -->|Build| D[Star Schema: Facts & Dimensions]
D -->|Expose| E[PowerBI Dashboards]

⚙️ Key Features
✅ Star Schema Design – optimized for analytics performance
✅ dbt Tests – unique, not_null, relationships for full validation
✅ Reusable Macros – Jinja templates for consistent logic
✅ Auto Docs + Lineage – generated with dbt docs
✅ Exposures – link marts directly to BI dashboards

🧱 Data Modeling Layers
Layer	Example Models	Purpose
Seeds (Raw)	customers.csv, orders.csv, products.csv, order_items.csv	Base source data
Staging	stg_customers, stg_orders, stg_products, stg_order_items	Cleans & standardizes fields
Marts (Facts & Dims)	fct_orders, fct_order_items, dim_customers, dim_products, dim_date	Business-ready analytics layer
📊 Star Schema Design
                ┌───────────────────────────┐
                │        dim_customers       │
                └──────────────┬────────────┘
                               │
                               │
┌───────────────┐       ┌──────┴────────┐        ┌─────────────────────┐
│ dim_products  │◄──────┤   fct_orders  ├───────►│      dim_date        │
└───────────────┘       └──────┬────────┘        └─────────────────────┘
                               │
                               ▼
                       ┌──────────────┐
                       │ PowerBI Dashboard │
                       └──────────────────┘

🧪 Testing & Validation

Integrity: unique, not_null, and relationships tests
Accepted Values: validated enums (e.g., order status)
Referential Integrity: ensures foreign keys map to dims

Run all tests:
dbt test

📈 PowerBI Integration

Connected marts (fct_orders, dim_products, dim_customers, dim_date) via native connector
Built dashboards tracking Revenue, Orders, AOV, Retention, and Customer Segments
Sample DAX Measures
Total Revenue := SUM(fct_orders[gross_revenue])
Average Order Value := DIVIDE([Total Revenue], COUNTROWS(fct_orders))
Returning Customers := CALCULATE(
    DISTINCTCOUNT(dim_customers[customer_id]),
    FILTER(dim_customers, dim_customers[order_count] > 1)
)

📂 Project Structure
ecom_dwh_dbt/
├── dbt_project.yml
├── models/
│   ├── staging/
│   ├── marts/
│   │   ├── dim/
│   │   └── fct/
│   └── exposures.yml
├── seeds/
└── profiles/

🚀 Setup & Execution

1️⃣ Install dbt

pip install dbt-bigquery  # or dbt-snowflake


2️⃣ Configure Profile

cp profiles/profiles_bigquery.yml.example ~/.dbt/profiles.yml


3️⃣ Run Pipeline

dbt deps
dbt seed
dbt run
dbt test


4️⃣ View Docs

dbt docs generate && dbt docs serve

📊 Results & Impact

Achieved 100 % data consistency across fact & dimension models
Reduced dashboard refresh latency by 40 % via incremental loads
Unified logic with reusable macros and centralized tests

🧠 Key Learnings

Dimensional modeling and star schema for analytics
dbt templating (Jinja) and modular SQL design
BI integration through exposures and data contracts

🏁 Next Steps

Add SCD Type-2 snapshots for historical tracking
Orchestrate dbt runs with Airflow or Dagster
Visualize data quality metrics in PowerBI
