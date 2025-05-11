import redis
import json
from config import REDIS_HOST, REDIS_PORT, CACHE_TTL

cache = redis.StrictRedis(host=REDIS_HOST, port=REDIS_PORT, decode_responses=True)

def get_cached_data(key):
    data = cache.get(key)
    return json.loads(data) if data else None

def set_cached_data(key, value):
    cache.setex(key, CACHE_TTL, json.dumps(value))
