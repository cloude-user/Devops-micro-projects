import os
from dotenv import load_dotenv

load_dotenv()

# RDS Database Config
DB_CONFIG = {
    "host": os.getenv("RDS_HOST"),
    "user": os.getenv("DB_USER"),
    "password": os.getenv("DB_PASSWORD"),
    "database": os.getenv("DB_NAME"),
}

# Redis Cache Config
REDIS_HOST = os.getenv("REDIS_HOST")
REDIS_PORT = 6379  # Default Redis port
CACHE_TTL = 300  # Cache expiry time in seconds
