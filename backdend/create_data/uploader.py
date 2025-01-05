from sqlalchemy import create_engine, types as sqlalchemy_types
import pandas as pd
from typing import Dict, Any
import numpy as np
from datetime import datetime
import time

def create_db_engine(host: str,
                    port: str, 
                    database: str,
                    username: str,
                    password: str) -> Any:
    """Create database connection engine"""
    connection_string = f"postgresql://{username}:{password}@{host}:{port}/{database}"
    return create_engine(connection_string)

def validate_users_data(df: pd.DataFrame) -> None:
    """Validate users data before upload"""
    # Kiểm tra giá trị gender
    valid_genders = {'M', 'F'}  # Chữ in hoa
    invalid_genders = set(df['gender'].unique()) - valid_genders
    if invalid_genders:
        raise ValueError(f"Invalid gender values found: {invalid_genders}")
    
    # Kiểm tra các ràng buộc khác
    if (df['age'] < 18).any():
        raise ValueError("Found users under 18 years old")
    
    if df['user_id'].duplicated().any():
        raise ValueError("Duplicate user_ids found")

def upload_dataframes(tables: Dict[str, pd.DataFrame], 
                     engine: Any,
                     chunk_size: int = 1000) -> None:
    """
    Upload DataFrame vào các bảng trong database
    
    Tham số:
        tables: Dictionary có key là tên bảng và value là DataFrame
        engine: SQLAlchemy engine instance
        chunk_size: Số lượng dòng trong mỗi chunk để upload
    """
    try:
        for table_name, df in tables.items():
            print(f"\nUploading {table_name} table...")
            
            # Tạo bản sao để tránh thay đổi DataFrame gốc
            upload_df = df.copy()
            
            # Xử lý dữ liệu users
            if table_name == 'users':
                # Validate trước khi xử lý
                validate_users_data(upload_df)
                
                # Chuyển đổi kiểu dữ liệu
                upload_df['user_role'] = upload_df['user_role'].astype(int)
                upload_df['age'] = upload_df['age'].astype(int)
                upload_df['user_id'] = upload_df['user_id'].astype(int)
                upload_df['gender'] = upload_df['gender'].str.upper()  # Chuyển về uppercase
                
                # Đảm bảo gender là string có độ dài 1
                upload_df['gender'] = upload_df['gender'].str.ljust(1)
                
                print("Data types after conversion:")
                print(upload_df.dtypes)
                print("\nSample data:")
                print(upload_df.head())
            
            start_time = time.time()
            
            # Upload với transaction
            with engine.begin() as connection:
                upload_df.to_sql(
                    name=table_name,
                    con=connection,
                    if_exists='append',
                    index=False,
                    chunksize=chunk_size,
                    method='multi',
                    dtype={
                        'gender': sqlalchemy_types.CHAR(1)  # Chỉ định kiểu dữ liệu CHAR(1)
                    } if table_name == 'users' else None
                )
            
            duration = time.time() - start_time
            print(f"Uploaded {len(upload_df)} rows to {table_name} in {duration:.2f} seconds")
            
    except Exception as e:
        print(f"Error uploading data: {str(e)}")
        print(f"Table: {table_name}")
        print(f"DataFrame info:")
        print(upload_df.info())
        print("\nSample of problematic data:")
        print(upload_df.head())
        raise

if __name__ == "__main__":
    from gen_all_tables import generate_all_tables
        
    # Các tham số kết nối database
    DB_CONFIG = {
        'host': 'localhost',
        'port': '5432',
        'database': 'Web_database',
        'username': 'postgres',
        'password': 'postgre'
    }
    
    # Tậo các bảng
    start_date = datetime(2024, 11, 1)
    end_date = datetime(2024, 12, 30)
    tables = generate_all_tables(start_date, end_date)
    
    # Upload dữ liệu
    engine = create_db_engine(**DB_CONFIG)
    upload_dataframes(tables, engine)