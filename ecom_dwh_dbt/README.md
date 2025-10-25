# E‑Commerce Data Warehouse (dbt + Snowflake/BigQuery + PowerBI)

This repo builds a **star-schema** warehouse for e‑commerce analytics using **dbt**. It includes:
- **Seeds** (raw layer) for `customers`, `products`, `orders`, `order_items`, `calendar`
- **Staging** models to conform/clean data
- **Marts** with `dim_customers`, `dim_products`, `dim_date`, `fct_orders`, `fct_order_items`
- **Tests** (unique, not_null, relationships, accepted_values)
- **Exposure** definition for a PowerBI dashboard

## Choose your Warehouse

### BigQuery
1. Install adapter: `pip install dbt-bigquery`
2. Copy `profiles/profiles_bigquery.yml.example` to `~/.dbt/profiles.yml` and fill values.
3. Create dataset: `ecom_dwh` in your GCP project.
4. Run:
   ```bash
   dbt deps
   dbt seed
   dbt run
   dbt test
   dbt docs generate && dbt docs serve
   ```

### Snowflake
1. Install adapter: `pip install dbt-snowflake`
2. Copy `profiles/profiles_snowflake.yml.example` to `~/.dbt/profiles.yml` and fill values.
3. Ensure `ANALYTICS` database and `ECOM_DWH` schema exist or adjust values.
4. Run:
   ```bash
   dbt deps
   dbt seed
   dbt run
   dbt test
   dbt docs generate && dbt docs serve
   ```

## PowerBI (or any BI)
Connect to your warehouse and model:
- **Dimensions**: `dim_customers`, `dim_products`, `dim_date`
- **Facts**: `fct_orders`, `fct_order_items`

Suggested relationships:
- `fct_orders.customer_id` → `dim_customers.customer_id`
- `fct_order_items.product_id` → `dim_products.product_id`
- `fct_orders.order_date` → `dim_date.date_day`
- `fct_order_items.order_date` → `dim_date.date_day`

### Sample DAX (PowerBI)
```
Total Revenue := SUM(fct_orders[gross_revenue])

Total Orders := COUNTROWS(fct_orders)

Avg Order Value := DIVIDE([Total Revenue], [Total Orders])

Units Sold := SUM(fct_order_items[quantity])

Revenue by Product := SUM(fct_order_items[line_revenue])
```

## Talking Points (Interview‑Ready)
- **Dimensional modeling** with conformed dims and granular facts.
- **Data tests** ensure referential integrity and clean status values.
- **Seeded raw layer** mimics ingestion from OLTP → staged → marts.
- **dbt macros** for surrogate keys; easy to extend SCDs with snapshots.
- **Exposure** connects data models to downstream BI (PowerBI).

## Notes
- Numeric types are generic; Snowflake and BigQuery will coerce accordingly.
- If you prefer partitioned tables, configure in the adapter (e.g., BQ partition on `order_date`).

Enjoy building!
