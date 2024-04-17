from flask import Blueprint, request, jsonify, make_response
from src import db

festivals_blueprint = Blueprint('festivals', __name__)

# Create a new music festival
@festivals_blueprint.route('/festivals', methods=['POST'])
def create_festival():
    data = request.get_json()
    try:
        name = data['name']
        music_type = data['music_type']
        crowd_size = data['crowd_size']
        location = data['location']
        overall_rating = data['overall_rating']
        activity_type_id = data['activity_type_id']

        query = '''
            INSERT INTO MusicFestivals (Name, MusicType, CrowdSize, Location, OverallRating, ActivityTypeID) 
            VALUES (%s, %s, %s, %s, %s, %s)
        '''
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute(query, (name, music_type, crowd_size, location, overall_rating, activity_type_id))
        conn.commit()

        return jsonify({"message": "Festival created successfully.", "id": cur.lastrowid}), 201
    except KeyError as e:
        return jsonify({"error": f"Missing field: {e}"}), 400
    except Exception as e:
        return jsonify({"error": "An error occurred creating the festival."}), 500

# Retrieve all festivals
@festivals_blueprint.route('/festivals', methods=['GET'])
def get_user_info():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM MusicFestivals')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Retrieve a single festival by ID
@festivals_blueprint.route('/festivals/<int:festival_id>', methods=['GET'])
def get_festival_by_id(festival_id):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('SELECT * FROM MusicFestivals WHERE FestivalID = %s', (festival_id,))
        festival = cur.fetchone()

        if not festival:
            return jsonify({"error": "Festival not found."}), 404

        return jsonify(festival), 200
    except Exception as e:
        return jsonify({"error": "An error occurred fetching the festival: " + str(e)}), 500

# Update a festival
@festivals_blueprint.route('/festivals/<int:festival_id>', methods=['PUT'])
def update_festival(festival_id):
    data = request.get_json()
    try:
        name = data['name']
        music_type = data['music_type']
        crowd_size = data['crowd_size']
        location = data['location']
        overall_rating = data['overall_rating']
        activity_type_id = data['activity_type_id']

        query = '''
            UPDATE MusicFestivals
            SET Name = %s, MusicType = %s, CrowdSize = %s, Location = %s, OverallRating = %s, ActivityTypeID = %s
            WHERE FestivalID = %s
        '''
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute(query, (name, music_type, crowd_size, location, overall_rating, activity_type_id, festival_id))
        conn.commit()

        if cur.rowcount == 0:
            return jsonify({"error": "Festival not found."}), 404

        return jsonify({"message": "Festival updated successfully."}), 200
    except KeyError as e:
        return jsonify({"error": f"Missing field: {e}"}), 400
    except Exception as e:
        return jsonify({"error": "An error occurred updating the festival."}), 500

# Delete a festival
@festivals_blueprint.route('/festivals/<int:festival_id>', methods=['DELETE'])
def delete_festival(festival_id):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('DELETE FROM MusicFestivals WHERE FestivalID = %s', (festival_id,))
        conn.commit()

        if cur.rowcount == 0:
            return jsonify({"error": "Festival not found."}), 404

        return jsonify({"message": "Festival deleted successfully."}), 200
    except Exception as e:
        return jsonify({"error": "An error occurred deleting the festival."}), 500

# Retrieve festivals by music type
@festivals_blueprint.route('/festivals/type/<string:music_type>', methods=['GET'])
def get_festivals_by_type(music_type):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('SELECT * FROM MusicFestivals WHERE MusicType = %s', (music_type,))
        festivals = cur.fetchall()

        if not festivals:
            return jsonify({"message": "No festivals found with this music type."}), 404

        return jsonify(festivals), 200
    except Exception as e:
        return jsonify({"error": "An error occurred fetching the festivals by music type: " + str(e)}), 500

# Retrieve music festivals by rating
@festivals_blueprint.route('/festivals/rating/<int:rating>', methods=['GET'])
def get_festivals_by_rating(rating):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('SELECT * FROM MusicFestivals WHERE OverallRating = %s', (rating,))
        festivals = cur.fetchall()

        if not festivals:
            return jsonify({"message": "No festivals found with this rating."}), 404

        return jsonify(festivals), 200
    except Exception as e:
        return jsonify({"error": "An error occurred fetching the festivals: " + str(e)}), 500

# Add a rating to a music festival
@festivals_blueprint.route('/festivals/rating', methods=['POST'])
def add_festival_rating():
    data = request.get_json()
    try:
        festival_id = data['festival_id']
        rating = data['rating']

        query = '''
            UPDATE MusicFestivals
            SET OverallRating = %s
            WHERE FestivalID = %s
        '''
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute(query, (rating, festival_id))
        conn.commit()

        if cur.rowcount == 0:
            return jsonify({"error": "Festival not found or rating not changed."}), 404

        return jsonify({"message": "Festival rating added successfully."}), 200
    except KeyError as e:
        return jsonify({"error": f"Missing field: {e}"}), 400
    except Exception as e:
        return jsonify({"error": "An error occurred adding the festival rating."}), 500

# Update a music festival rating
@festivals_blueprint.route('/festivals/rating/<int:festival_id>', methods=['PUT'])
def update_festival_rating(festival_id):
    data = request.get_json()
    try:
        new_rating = data['new_rating']

        query = '''
            UPDATE MusicFestivals
            SET OverallRating = %s
            WHERE FestivalID = %s
        '''
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute(query, (new_rating, festival_id))
        conn.commit()

        if cur.rowcount == 0:
            return jsonify({"error": "Festival not found or rating unchanged."}), 404

        return jsonify({"message": "Festival rating updated successfully."}), 200
    except KeyError as e:
        return jsonify({"error": f"Missing field: {e}"}), 400
    except Exception as e:
        return jsonify({"error": "An error occurred updating the festival rating."}), 500

# Remove a rating from a music festival
@festivals_blueprint.route('/festivals/rating/<int:festival_id>', methods=['DELETE'])
def remove_festival_rating(festival_id):
    try:
        query = '''
            UPDATE MusicFestivals
            SET OverallRating = NULL
            WHERE FestivalID = %s
        '''
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute(query, (festival_id,))
        conn.commit()

        if cur.rowcount == 0:
            return jsonify({"error": "Festival not found or rating already null."}), 404

        return jsonify({"message": "Festival rating removed successfully."}), 200
    except Exception as e:
        return jsonify({"error": "An error occurred removing the festival rating."}), 500

# GET: Retrieves a list of music festivals and attached prices (assuming Price is a separate attribute or can be derived)
@festivals_blueprint.route('/festivals/price', methods=['GET'])
def get_festivals_with_prices():
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('SELECT FestivalID, Name, Location, OverallRating AS Price FROM MusicFestivals')
        festivals = cur.fetchall()
        return jsonify(festivals), 200
    except Exception as e:
        return jsonify({"error": "An error occurred fetching the festivals with prices: " + str(e)}), 500

# GET: Lists the locations where music festivals are happening (Location is a TEXT in MusicFestivals table)
@festivals_blueprint.route('/festivals/location', methods=['GET'])
def get_festival_locations():
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('SELECT DISTINCT Location FROM MusicFestivals')
        locations = cur.fetchall()
        return jsonify(locations), 200
    except Exception as e:
        return jsonify({"error": "An error occurred fetching the festival locations: " + str(e)}), 500