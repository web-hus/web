import psycopg2

host = "localhost"
port = 5432  # Cổng của PostgreSQL 17
user = "postgres"
password = "admin1234"
database = "web_restaurant"

try:
    conn = psycopg2.connect(
        host=host,
        user=user,
        port=port,  
        password=password,
        dbname=database
    )
    cursor = conn.cursor()
    
    cursor.execute("SELECT COUNT(DISTINCT phone) AS unique_phone_count FROM users;")
    result = cursor.fetchall()
    
    for row in result:
        print(row)
    
    cursor.close()
    conn.close()

except Exception as e:
    print(f"Lỗi: {e}")
