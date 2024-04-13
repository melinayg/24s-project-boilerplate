from flask import Blueprint, request, jsonify
from src import db

transportation_blueprint = Blueprint('transportation', __name__)

# Create a new transportation record
@transportation_blueprint.route('/transportation', methods=['POST'])
def create_transportation():
    data = request.get_json()
    try:
        budget = data['budget']
        cleanliness_safety = data['cleanliness_safety']

        query = '''
            INSERT INTO Transportation (Budget, CleanlinessSafety) 
            VALUES (%s, %s)
        '''
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute(query, (budget, cleanliness_safety))
        conn.commit()

        return jsonify({"message": "Transportation record created successfully.", "id": cur.lastrowid}), 201
    except KeyError as e:
        return jsonify({"error": f"Missing field: {e}"}), 400
    except Exception as e:
        return jsonify({"error": "An error occurred creating the transportation record."}), 500

# Retrieve all transportation records
@transportation_blueprint.route('/transportation', methods=['GET'])
def get_all_transportation():
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('SELECT * FROM Transportation')
        transportation_records = cur.fetchall()

        return jsonify(transportation_records), 200
    except Exception as e:
        return jsonify({"error": "An error occurred fetching the transportation records."}), 500

# Retrieve a single transportation record by ID
@transportation_blueprint.route('/transportation/<int:transportation_id>', methods=['GET'])
def get_transportation(transportation_id):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('SELECT * FROM Transportation WHERE TransportationID = %s', (transportation_id,))
        transportation_record = cur.fetchone()

        if transportation_record:
            return jsonify(transportation_record), 200
        else:
            return jsonify({"error": "Transportation record not found."}), 404
    except Exception as e:
        return jsonify({"error": "An error occurred fetching the transportation record."}), 500

# Update a transportation record
@transportation_blueprint.route('/transportation/<int:transportation_id>', methods=['PUT'])
def update_transportation(transportation_id):
    data = request.get_json()
    try:
        budget = data['budget']
        cleanliness_safety = data['cleanliness_safety']

        query = '''
            UPDATE Transportation 
            SET Budget = %s, CleanlinessSafety = %s
            WHERE TransportationID = %s
        '''
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute(query, (budget, cleanliness_safety, transportation_id))
        conn.commit()

        if cur.rowcount == 0:
            return jsonify({"error": "Transportation record not found."}), 404

        return jsonify({"message": "Transportation record updated successfully."}), 200
    except KeyError as e:
        return jsonify({"error": f"Missing field: {e}"}), 400
    except Exception as e:
        return jsonify({"error": "An error occurred updating the transportation record."}), 500

# Delete a transportation record
@transportation_blueprint.route('/transportation/<int:transportation_id>', methods=['DELETE'])
def delete_transportation(transportation_id):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('DELETE FROM Transportation WHERE TransportationID = %s', (transportation_id,))
        conn.commit()

        if cur.rowcount == 0:
            return jsonify({"error": "Transportation record not found."}), 404

        return jsonify({"message": "Transportation record deleted successfully."}), 200
    except Exception as e:
        return jsonify({"error": "An error occurred deleting the transportation record."}), 500

# Retrieve transportation records by type
@transportation_blueprint.route('/transportation/type/<string:type>', methods=['GET'])
def get_transportation_by_type(type):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('SELECT * FROM Transportation WHERE Type = %s', (type,))
        results = cur.fetchall()

        if not results:
            return jsonify({"message": "No transportation records found for this type."}), 404

        return jsonify(results), 200
    except Exception as e:
        return jsonify({"error": "An error occurred fetching the transportation records: " + str(e)}), 500

# Retrieve transportation records by location
@transportation_blueprint.route('/transportation/location/<string:location>', methods=['GET'])
def get_transportation_by_location(location):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('SELECT * FROM Transportation WHERE Location = %s', (location,))
        results = cur.fetchall()

        if not results:
            return jsonify({"message": "No transportation records found for this location."}), 404

        return jsonify(results), 200
    except Exception as e:
        return jsonify({"error": "An error occurred fetching the transportation records: " + str(e)}), 500

# Don't forget to register this blueprint in the main application file
# app.register_blueprint(transportation_blueprint, url_prefix='/api')
