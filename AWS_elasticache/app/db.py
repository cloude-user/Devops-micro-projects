# import mysql.connector
import mysql.connector
from config import DB_CONFIG

def get_db_connection():
    return mysql.connector.connect(**DB_CONFIG)

def fetch_data_from_db():
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    
    cursor.execute("SELECT id, name, price FROM products LIMIT 10;")
    result = cursor.fetchall()
    
    cursor.close()
    connection.close()
    return result
