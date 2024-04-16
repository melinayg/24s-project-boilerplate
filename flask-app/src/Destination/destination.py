from flask import Blueprint, request, jsonify
from src import db

destination_blueprint = Blueprint('destination', __name__)

# Create a new destination
@destination_blueprint.route('/destination', methods=['POST'])
def create_destination():
    data = request.get_json()
    try:
        address = data['address']
        street = data['street']
        zipcode = data['zipcode']
        city = data['city']
        state = data['state']
        distance = data['distance']
        proximity = data['proximity']
        weather_recommendations = data['weather_recommendations']

        query = '''
            INSERT INTO Destination (Address, Street, Zipcode, City, State, Distance, Proximity, WeatherRecommendations) 
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        '''
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute(query, (address, street, zipcode, city, state, distance, proximity, weather_recommendations))
        conn.commit()

        return jsonify({"message": "Destination created successfully.", "id": address}), 201
    except KeyError as e:
        return jsonify({"error": f"Missing field: {e}"}), 400
    except Exception as e:
        return jsonify({"error": "An error occurred creating the destination."}), 500

# Retrieve all destinations
@destination_blueprint.route('/destination', methods=['GET'])
def get_all_destinations():
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('SELECT * FROM Destination')
        destinations = cur.fetchall()

        return jsonify(destinations), 200
    except Exception as e:
        return jsonify({"error": "An error occurred fetching the destinations."}), 500

# Retrieve a single destination by address
@destination_blueprint.route('/destination/<string:address>', methods=['GET'])
def get_destination(address):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('SELECT * FROM Destination WHERE Address = %s', (address,))
        destination = cur.fetchone()

        if not destination:
            return jsonify({"message": "No destination found with this address."}), 404

        return jsonify(destination), 200
    except Exception as e:
        return jsonify({"error": "An error occurred fetching the destination: " + str(e)}), 500

# Update a destination
@destination_blueprint.route('/destination/<string:address>', methods=['PUT'])
def update_destination(address):
    data = request.get_json()
    try:
        street = data['street']
        zipcode = data['zipcode']
        city = data['city']
        state = data['state']
        distance = data['distance']
        proximity = data['proximity']
        weather_recommendations = data['weather_recommendations']

        query = '''
            UPDATE Destination
            SET Street = %s, Zipcode = %s, City = %s, State = %s, Distance = %s, Proximity = %s, WeatherRecommendations = %s
            WHERE Address = %s
        '''
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute(query, (street, zipcode, city, state, distance, proximity, weather_recommendations, address))
        conn.commit()

        if cur.rowcount == 0:
            return jsonify({"error": "Destination not found."}), 404

        return jsonify({"message": "Destination updated successfully."}), 200
    except KeyError as e:
        return jsonify({"error": f"Missing field: {e}"}), 400
    except Exception as e:
        return jsonify({"error": "An error occurred updating the destination."}), 500

# Delete a destination
@destination_blueprint.route('/destination/<string:address>', methods=['DELETE'])
def delete_destination(address):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('DELETE FROM Destination WHERE Address = %s', (address,))
        conn.commit()

        if cur.rowcount == 0:
            return jsonify({"error": "Destination not found."}), 404

        return jsonify({"message": "Destination deleted successfully."}), 200
    except Exception as e:
        return jsonify({"error": "An error occurred deleting the destination."}), 500

# Additional routes for sorting or filtering destinations can be added here, following the same pattern.
