# AdventureWorks HR Attrition & Workforce Analytics ELT Pipeline

![Apache Airflow](https://img.shields.io/badge/Apache%20Airflow-2.8.1-blue?logo=apacheairflow)
![DuckDB](https://img.shields.io/badge/DuckDB-Latest-yellow?logo=duckdb)
![SeaweedFS](https://img.shields.io/badge/Storage-SeaweedFS%2FMinIO-green)
![PostgreSQL](https://img.shields.io/badge/Source-PostgreSQL-blue?logo=postgresql)

An end-to-end Data Engineering ELT (Extract, Load, Transform) pipeline built using **Apache Airflow**, **SeaweedFS/MinIO (S3-compatible Object Storage)**, and **DuckDB** as the in-memory SQL transformation engine. 

This project extracts HR data from an OLTP PostgreSQL database (**AdventureWorks**), loads raw Parquet partitions into an S3-compatible Data Lakehouse, and executes dynamic SQL transformations via DuckDB into a Data Warehouse (`dwh`) schema.

---

## 📌 Case & Business Focus
- **Student Name:** Ilham Zamzami
- **Batch / Class:** DE 15
- **Case Objective:** CASE 1 — HR Attrition & Workforce Analytics
- **Target Filter:** Karyawan di departemen **Production** dan **Engineering**
- **Core Metrics Analyzed:**
  - Average employee tenure per department
  - Correlation between pay rate and tenure
  - Employee movement/department transfer counts (`IsMover`)

---

## 🏗️ Architecture & Data Pipeline (Medallion Pattern)

```
┌──────────────────────────────┐
│  OLTP PostgreSQL             │
│  (AdventureWorks Database)   │
└──────────────┬───────────────┘
               │ (Airflow Task Flow / Ingestion)
               ▼
┌──────────────────────────────┐
│  Data Lake (SeaweedFS / S3)  │  <-- BRONZE LAYER (Raw Parquet)
│  dt=YYYY-MM-DD/*.parquet     │
└──────────────┬───────────────┘
               │ (Direct SQL Stream Query via DuckDB HTTPFS)
               ▼
┌──────────────────────────────┐
│  DuckDB Transformation Engine│
│  ├── dwh.stg_hr_employees    │  <-- SILVER LAYER (Staging / Filtered)
│  ├── dwh.trf_hr_workforce    │  <-- SILVER LAYER (Transformed / Enriched)
│  └── dwh.fact_hr_workforce   │  <-- GOLD LAYER (Fact Table / Business Ready)
└──────────────────────────────┘
```

### Why ELT with DuckDB?
1. **Decoupled Architecture:** Heavy SQL transformations run inside DuckDB's multi-threaded engine rather than wasting Airflow's worker RAM.
2. **Zero In-Memory Overhead:** Airflow only orchestrates tasks; data streams directly from S3 to DuckDB tables without local disk downloads.
3. **Idempotency:** Re-running the DAG overwrites staging/fact tables cleanly for the targeted `logical_date` execution.

---

## 📂 Project Structure

```
airflow_seaweedFS/
├── config/
│   └── s3.json                 # SeaweedFS S3 ACL & Credential Config
├── dags/
│   ├── duckdb/
│   │   └── AdventureWorks.duckdb # Target DuckDB Data Warehouse File
│   ├── dag_ingestion_pg.py     # Ingestion DAG (PostgreSQL -> S3 Parquet)
│   └── dag_hr_transformation.py# ELT DAG (S3 Parquet -> DuckDB Mart)
├── logs/                       # Airflow Execution Logs
├── plugins/                    # Custom Airflow Plugins
├── .env                        # Environment Variables (Ports, Keys, Credentials)
├── build.sh                    # Automated shell script to build AdventureWorks Postgres Image
├── Dockerfile                  # Custom Dockerfile for Postgres container
├── docker-compose.yml          # Main Stack Orchestration (Airflow, Postgres, SeaweedFS)
├── docker-init.sh              # Entrypoint script for PostgreSQL init
├── docker-reconfigure.sh       # Reconfiguration script for database user privileges
├── install-a.sql               # AdventureWorks Schema Part 1
├── install-b.sql               # AdventureWorks Schema Part 2
├── install-c.sql               # AdventureWorks Schema Part 3
└── install-d.sql               # AdventureWorks Schema Part 4
```

---

## ⚙️ Data Warehouse Schema (Grain Definition)

| Table | Layer | Grain | Description |
| :--- | :--- | :--- | :--- |
| `dwh.stg_hr_employees` | Staging (Silver) | 1 row per employee | Filtered for current department in (`Engineering`, `Production`). Joined with CTEs for latest pay rate and transfer count. |
| `dwh.trf_hr_workforce` | Transform (Silver)| 1 row per employee | Cleaned names, calculated tenure (`TenureYears`), and derived boolean `IsMover`. |
| `dwh.fact_hr_workforce` | Fact (Gold) | 1 row per employee | Final analytics table enriched with audit columns (`LoadTimestamp`, `BatchDate`). |

---

## 📊 Analytical Queries & Key Insights

### Query 1: Average Tenure per Department
```sql
SELECT 
    "DepartmentName",
    COUNT(*) AS "TotalKaryawan",
    ROUND(AVG("TenureYears"), 2) AS "AvgTenureYears",
    ROUND(MIN("TenureYears"), 2) AS "MinTenureYears",
    ROUND(MAX("TenureYears"), 2) AS "MaxTenureYears"
FROM "dwh"."fact_hr_workforce"
GROUP BY "DepartmentName"
ORDER BY "AvgTenureYears" DESC;
```
* **Insight:** Employees in **Engineering** have a slightly higher average tenure (**17.67 years**) compared to **Production** (**17.53 years**).

---

### Query 2: Top 5 Highest Paid Employees vs Tenure
```sql
SELECT
    fhw."FullName",
    fhw.JobTitle,
    fhw.DepartmentName,
    ROUND(fhw."LatestPayRate", 2) AS "LatestPayRate",
    fhw."TenureYears",
    RANK() OVER (PARTITION BY fhw.DepartmentName ORDER BY fhw.LatestPayRate DESC) AS "RankInDept"
FROM dwh.fact_hr_workforce fhw
ORDER BY "LatestPayRate" DESC
LIMIT 5;
```
* **Insight:** Out of the top 5 highest earners, 4 belong to the Engineering department. Pay rate does not show a strong linear correlation with tenure, as average tenure across all brackets remains around 17 years.

---

### Query 3: Department Transfer Rate (`IsMover`)
```sql
SELECT 
    "DepartmentName",
    COUNT(*) AS "TotalKaryawan",
    SUM(CASE WHEN "IsMover" = TRUE THEN 1 ELSE 0 END) AS "TotalMover",
    ROUND(SUM(CASE WHEN "IsMover" = TRUE THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS "MoverPct"
FROM "dwh"."fact_hr_workforce"
GROUP BY "DepartmentName"
ORDER BY "MoverPct" DESC;
```
* **Insight:** Department mover rate is 0% for current active employees in these two targeted departments based on active department filtering.

---

## 🚀 Getting Started & Local Setup

### 1. Prerequisites
- Docker Desktop & Docker Compose installed
- Bash shell (WSL2 for Windows users)

### 2. Build Source Database (AdventureWorks)
```bash
# Execute the automated build script to pull and initialize AdventureWorks
chmod +x build.sh
./build.sh

# Run AdventureWorks PostgreSQL container
docker run -d --name adventureworks-pg -p 5433:5432 chriseaton/adventureworks:postgres
```

### 3. Spin up Airflow & SeaweedFS Stack
```bash
# Start all containers in background
docker compose up -d
```

### 4. Verify Connections
- **Airflow UI:** Open `http://localhost:8080` (Credentials: `admin` / `admin`).
- **SeaweedFS S3 Endpoint:** Access `http://localhost:8333`.
- **DBeaver DB Connection:** Connect to DuckDB file at `./dags/duckdb/AdventureWorks.duckdb` or via `:memory:` with S3 HTTPFS extension enabled.

---

## 🛠️ Future Improvements
- [ ] **SCD Type 2 Implementation:** Track salary change history and historical department movements over time rather than taking only the latest snapshot.
- [ ] **Star Schema Expansion:** Separate model into formal dimension tables (`dim_employee`, `dim_department`) and fact table (`fact_hr`).