import io
import os
import logging
from datetime import datetime, timedelta
import pandas as pd
import pyarrow as pa
import pyarrow.parquet as pq

from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.providers.amazon.aws.hooks.s3 import S3Hook

log = logging.getLogger(__name__)

# CONFIGURATION
POSTGRES_CONN_ID = "postgres_adventureworks"  # Buat ID di airlow
SEAWEEDFS_CONN_ID = "seaweedfs_s3"           # Connection ID dikondigurasi di docker
SEAWEEDFS_BUCKET = os.getenv("SEAWEEDFS_BUCKET", "adventure-bucket")

default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "retries": 2,
    "retry_delay": timedelta(minutes=3),
    "email_on_failure": False
}

INGEST_TABLES = [
    {"schema": "HumanResources", "table": "Employee", "folder": "employee"},
    {"schema": "HumanResources", "table": "EmployeePayHistory", "folder": "employee_pay_history"},
    {"schema": "HumanResources", "table": "EmployeeDepartmentHistory", "folder": "employee_department_history"},
    {"schema": "HumanResources", "table": "Department", "folder": "department"},
    {"schema": "Person", "table": "Person", "folder": "person"}
]

def df_to_parquet_bytes(df: pd.DataFrame) -> bytes:
    """Konversi DataFrame ke Bytes Parquet"""
    table = pa.Table.from_pandas(df, preserve_index=False)
    buffer = io.BytesIO()
    pq.write_table(table, buffer, compression="snappy")
    return buffer.getvalue()

def check_connection():
    """Tugas 1: Cek Koneksi ke Postgres & SeaweedFS"""
    # 1. Test PostgreSQL
    pg_hook = PostgresHook(postgres_conn_id=POSTGRES_CONN_ID)
    conn = pg_hook.get_conn()
    cursor = conn.cursor()
    cursor.execute("SELECT 1;")
    cursor.close()
    conn.close()
    log.info("✅ Connection to PostgreSQL AdventureWorks Successful!")

    # 2. Test SeaweedFS S3 via S3Hook
    s3_hook = S3Hook(aws_conn_id=SEAWEEDFS_CONN_ID)
    if not s3_hook.check_for_bucket(bucket_name=SEAWEEDFS_BUCKET):
        s3_hook.create_bucket(bucket_name=SEAWEEDFS_BUCKET)
        log.info(f"✅ Connection to SeaweedFS Successful! Bucket created: {SEAWEEDFS_BUCKET}")
    else:
        log.info(f"✅ Connection to SeaweedFS Successful! Bucket exists: {SEAWEEDFS_BUCKET}")

def ingest_table_to_seaweed(schema: str, table: str, folder: str, **context):
    """Tugas 2: Ekstraksi Postgres & Upload Parquet ke SeaweedFS"""
    logical_date = context["ds"]
    object_path = f"sources/{folder}/dt={logical_date}/data.parquet"

    pg_hook = PostgresHook(postgres_conn_id=POSTGRES_CONN_ID)
    query = f'SELECT * FROM "{schema}"."{table}";'

    log.info(f"Fetch data from {schema}.{table} with query: {query}")
    df = pg_hook.get_pandas_df(query)
    log.info(f"Fetched {len(df)} rows from {schema}.{table}")

    # FIX: Hapus timezone offset agar PyArrow / Parquet tidak error
    for col in df.select_dtypes(include=["datetimetz", "datetime"]).columns:
        df[col] = df[col].dt.tz_localize(None)

    parquet_bytes = df_to_parquet_bytes(df)

    # Upload ke SeaweedFS via S3Hook
    s3_hook = S3Hook(aws_conn_id=SEAWEEDFS_CONN_ID)
    s3_hook.load_bytes(
        bytes_data=parquet_bytes,
        key=object_path,
        bucket_name=SEAWEEDFS_BUCKET,
        replace=True
    )

    log.info(f" ✅ Ingested {len(df)} rows from {schema}.{table} to SeaweedFS at {object_path}")

    return {
        "table": table,
        "rows": len(df),
        "path": object_path
    }

def validate_ingestion(**context):
    """Tugas 3: Validasi Keberadaan & Schema File Parquet"""
    s3_hook = S3Hook(aws_conn_id=SEAWEEDFS_CONN_ID)
    s3_client = s3_hook.get_conn()  # Menghubungkan ke boto3 client yang sudah terkonfigurasi S3Hook
    ti = context["ti"]

    # Ambil hasil dari Dynamic Task Ingestion
    ingested_tables = ti.xcom_pull(task_ids="ingest_table_to_seaweed")

    if not ingested_tables:
        raise ValueError("No ingestion results found in XCom. Please check the ingestion tasks.")

    results = {}

    for result in ingested_tables:
        table = result["table"]
        rows = result["rows"]
        path = result["path"]

        try:
            # Mengambil object dari SeaweedFS via boto3 S3 client
            response = s3_client.get_object(Bucket=SEAWEEDFS_BUCKET, Key=path)
            file_content = response['Body'].read()
            buf = io.BytesIO(file_content)
            schema_pq = pq.read_schema(buf)

            results[table] = {
                "status": "success",
                "rows": rows,
                "path": path,
                "schema": schema_pq
            }
        except Exception as e:
            log.error(f"❌ File does not exist in SeaweedFS: {path}. Error: {e}")
            results[table] = {"status": "failure", "rows": rows, "path": path}

    log.info("Validation Summary:")
    for table, result in results.items():
        log.info(f"  {table}: {result['status']} ({result['rows']} rows at {result['path']})")

    failed_tables = [table for table, result in results.items() if result["status"] == "failure"]
    if failed_tables:
        raise ValueError(f"❌ Validation failed for tables: {', '.join(failed_tables)}")

    log.info("✅ All ingested tables validated successfully on SeaweedFS.")

# DAG DEFINITION
with DAG(
    dag_id="dag_ingestion_seaweedfs",
    default_args=default_args,
    description="Ingest AdventureWorks HR & Person Data to SeaweedFS Lakehouse",
    schedule_interval="@daily",
    start_date=datetime(2026, 9, 9),
    catchup=False,
    tags=["assignment", "ingestion", "seaweedfs"],
) as dag:

    check_conn_task = PythonOperator(
        task_id="check_connection",
        python_callable=check_connection
    )

    tasks_ingest = PythonOperator.partial(
        task_id="ingest_table_to_seaweed",
        python_callable=ingest_table_to_seaweed
    ).expand(
        op_kwargs=INGEST_TABLES
    )

    task_validate = PythonOperator(
        task_id="validate_ingestion",
        python_callable=validate_ingestion
    )

    check_conn_task >> tasks_ingest >> task_validate