import io
import os
import logging
from datetime import datetime, timedelta
import pandas as pd
import duckdb

from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.providers.amazon.aws.hooks.s3 import S3Hook


log = logging.getLogger(__name__)

SEAWEEDFS_CONN_ID = "seaweedfs_s3"           # Connection ID dikondigurasi di docker
SEAWEEDFS_BUCKET = os.getenv("SEAWEEDFS_BUCKET", "adventure-bucket")
SEAWEED_ACCESS_KEY=os.getenv("SEAWEED_ACCESS_KEY")
SEAWEED_SECRET_KEY=os.getenv("SEAWEED_SECRET_KEY")

DUCKDB_PATH = "/opt/airflow/dags/duckdb/AdventureWorks.duckdb"

S3_PREFIX = f"s3://{SEAWEEDFS_BUCKET}"

default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "retries": 2,
    "retry_delay": timedelta(minutes=3),
    "email_on_failure": False
}

#Check koneksi
def check_connection_seaweed():
    s3_hook = S3Hook(SEAWEEDFS_CONN_ID)

    try:
        s3_bucket = s3_hook.check_for_bucket(bucket_name=SEAWEEDFS_BUCKET)
        print(f"Bucket {s3_bucket} is ready")

    except Exception as e:
        log.error(f"Failed to connect to SeaweedFS. Error: {e}")
        raise e 

    return s3_bucket

#Connect ke duck DB
def get_duckDB_conn() -> duckdb.DuckDBPyConnection:
    os.makedirs(os.path.dirname(DUCKDB_PATH), exist_ok=True)
    conn = duckdb.connect(DUCKDB_PATH)

    conn.execute("INSTALL httpfs; LOAD httpfs;")

    # Ambil credential langsung dari Airflow Connection 'seaweedfs_s3'
    try:
        s3_hook = S3Hook(aws_conn_id=SEAWEEDFS_CONN_ID)
        s3_conn = s3_hook.get_connection(SEAWEEDFS_CONN_ID)
        access_key = s3_conn.login or SEAWEED_ACCESS_KEY 
        secret_key = s3_conn.password or SEAWEED_SECRET_KEY 
    except Exception as e:
        log.warning(f"Failed to get S3Hook connection, using env fallback: {e}")
        access_key = SEAWEED_ACCESS_KEY 
        secret_key = SEAWEED_SECRET_KEY

    seaweed_endpoint = "seaweedfs:8333"

    conn.execute(f"SET s3_endpoint='{seaweed_endpoint}';")
    conn.execute(f"SET s3_access_key_id='{access_key}';")
    conn.execute(f"SET s3_secret_access_key='{secret_key}';")
    conn.execute("SET s3_use_ssl=false;")
    conn.execute("SET s3_url_style='path';") 

    return conn

#ambil parition terakhir
def get_latest_partition(folder:str, logical_date:str)->str:
    return f"{S3_PREFIX}/sources/{folder}/dt={logical_date}/*.parquet"

#setup duck db
def check_connection_s3(**context):
    logical_date = context["ds"]
    schema = "dwh"

    try:
        conn = get_duckDB_conn()
        conn.execute(f"CREATE SCHEMA IF NOT EXISTS {schema}")
        log.info(f"Schema {schema} is ready")

        table_to_check = [
            "employee",
            "employee_pay_history",
            "employee_department_history",
            "department",
            "person"
        ]

        for folder in table_to_check:
            path = get_latest_partition(folder, logical_date)
            print(f"Verify access to {path}..")

            result = conn.execute(
                f"SELECT COUNT(*) AS jumlah FROM read_parquet('{path}') "
            ).fetchone()
            log.info(f"{folder}: {result[0]:,} rows aceessible via S3")

        log.info("ducDB is connect")
    except Exception as e:
        log.error(f"Error connecting/verifying DuckDB: {e}")
    finally:
        if conn is not None:
            conn.close()

#create staging->transform->load
def create_staging_table(**context):
    #ini akan menjadi dwh.stg_hr_employees
    logical_date = context["ds"]

    try:
        conn = get_duckDB_conn()
        log.info("Create staing => dwh.stg_hr_employees")

        p_emp    = get_latest_partition("employee", logical_date)
        p_eph    = get_latest_partition("employee_pay_history", logical_date)
        p_edh    = get_latest_partition("employee_department_history", logical_date)
        p_dept   = get_latest_partition("department", logical_date)
        p_person = get_latest_partition("person", logical_date)

        conn.execute("DROP TABLE IF EXISTS dwh.stg_hr_employees;")
        conn.execute(f"""
            create table dwh.stg_hr_employees AS
            with LatestPayRate as (
                select 
                    eph."BusinessEntityID",
                    eph."Rate" as "PayRate",
                    eph."RateChangeDate" as "RateChangeDate",
                    ROW_NUMBER() over(partition by eph."BusinessEntityID" order by eph."RateChangeDate"  DESC) as "LatestPay"
                from read_parquet('{p_eph}') eph 
            ), MovingDepartment as (
                select 
                    edh."BusinessEntityID",
                    COUNT(edh."DepartmentID" ) as "CountMovDepartment"
                from read_parquet('{p_edh}') edh
                group by edh."BusinessEntityID"
            ), CurrentDept AS(
                select 
                    edh."BusinessEntityID" ,
                    edh."DepartmentID",
                    edh."StartDate" ,
                    edh."EndDate" ,
                    row_number() over(partition by  edh."BusinessEntityID" order by edh."StartDate" DESC) as "RightNowDep"
                from read_parquet('{p_edh}') edh 
            )
            select
                e."BusinessEntityID" as "EmployeeID",
                CONCAT(p."FirstName" ,' ', p."LastName" ) as "FullName",
                e."JobTitle" as "JobTitle",
                d."Name" as "DepartmentName",
                e."HireDate",
                lp."PayRate" as "LatestPayRate" ,
                lp."RateChangeDate",
                md."CountMovDepartment" as "DeptChangeCount"
            from read_parquet('{p_emp}') e
            left join MovingDepartment  md
                on md."BusinessEntityID" = e."BusinessEntityID"
            left join CurrentDept cd
                on cd."BusinessEntityID" = e."BusinessEntityID" 
            left join read_parquet('{p_dept}') d 
                on d."DepartmentID" = cd."DepartmentID" 
            left join LatestPayRate lp
                on lp."BusinessEntityID" = e."BusinessEntityID"
            left join read_parquet('{p_person}') p 
                on p."BusinessEntityID" = e."BusinessEntityID" 
            where 
                lp."LatestPay" = 1 AND
                cd."RightNowDep" = 1 AND
                d."Name" in ('Engineering','Production');
        """)

        cnt = conn.execute("SELECT COUNT(*) AS total FROM dwh.stg_hr_employees").fetchone()[0]
        log.info(f"dwh.stg_hr_employees : {cnt} rows")

        log.info("Extract Completed")
    finally:
        conn.close()

def create_transform_table(**context):

    try:
        conn = get_duckDB_conn()
        log.info("Create Transform => dwh.trf_hr_workforce")

        conn.execute("DROP TABLE IF EXISTS dwh.trf_hr_workforce;")
        conn.execute("""
            create table dwh.trf_hr_workforce AS
            select 
                she."EmployeeID" ,
                TRIM(she."FullName") as "FullName" ,
                she."JobTitle" ,
                she."DepartmentName" ,
                she."HireDate",
                date_part('year', AGE(NOW(), "HireDate")) as "TenureYears",
                she."LatestPayRate",
                case  
                    when she."DeptChangeCount" > 1 then true
                    else false 
                end as "IsMover",
                she."DeptChangeCount"
            from dwh.stg_hr_employees she;
        """)
        cnt = conn.execute("SELECT COUNT(*) AS total FROM dwh.trf_hr_workforce").fetchone()[0]
        log.info(f"dwh.trf_hr_workforce: {cnt} rows")
        
        log.info("Transform Completed")
    finally:
        conn.close()

def create_load_table(**context):
    logcal_date = context["ds"]

    try:
        conn = get_duckDB_conn()
        log.info("Create Load => dwh.fact_hr_workforce")
        conn.execute("DROP TABLE IF EXISTS dwh.fact_hr_workforce;")

        conn.execute(f"""
            create table dwh.fact_hr_workforce AS
            select 
                thw."EmployeeID" ,
                thw."FullName",
                thw."JobTitle" ,
                thw."DepartmentName",
                thw."HireDate",
                thw. "TenureYears",
                thw."LatestPayRate",
                thw."IsMover",
                thw."DeptChangeCount",
                CURRENT_TIMESTAMP as "LoadTimestamp",
                '{logcal_date}'::DATE as "BatchDate"
            from dwh.trf_hr_workforce thw;
        """)

        cnt = conn.execute("SELECT COUNT(*) FROM dwh.fact_hr_workforce").fetchone()[0]
        log.info(f"dwh.fact_hr_workforce : {cnt:,} rows")

        log.info("Load Completed")
    finally:
        conn.close()

with DAG(
    dag_id = "dag_hr_workforce_ilhamV2",
    default_args = default_args,
    description = "DAG to process ETL from AdventureWorks on Schema dwh: extract -> transform -> load",
    schedule_interval="30 2 * * *",
    start_date = datetime(2026, 9, 17),
    catchup=False,
    tags=["elt", "duckdb", "transform", "assignmentD32"],
) as dag:

    check_connection = PythonOperator(
        task_id = "check_connection_s3",
        python_callable = check_connection_s3
    )

    task_extract = PythonOperator(
        task_id = "extract",
        python_callable = create_staging_table
    )

    task_transform = PythonOperator(
        task_id = "transform",
        python_callable = create_transform_table
    )
    task_load = PythonOperator(
        task_id = "load",
        python_callable = create_load_table
    )

    (
        check_connection >> task_extract >> task_transform >> task_load
    )