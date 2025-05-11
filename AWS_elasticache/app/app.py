from flask import Flask, jsonify
from db import fetch_data_from_db
from cache import get_cached_data, set_cached_data

app = Flask(__name__)

@app.route('/products', methods=['GET'])
def get_products():
    cache_key = "products"

    # Check if data is in cache
    cached_data = get_cached_data(cache_key)
    if cached_data:
        return jsonify({"source": "cache", "data": cached_data})

    # If not in cache, fetch from RDS
    data = fetch_data_from_db()
    
    # Store data in cache
    set_cached_data(cache_key, data)

    return jsonify({"source": "database", "data": data})

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
