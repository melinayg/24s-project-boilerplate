########################################################
# Sample customers blueprint of endpoints
# Remove this file if you are not using it in your project
########################################################
from flask import Blueprint, request, jsonify, make_response
import json
from src import db

hobbies_blueprint = Blueprint('hobbies', __name__)

# would we have to create fake hobby data thru code or mockaroo
@hobbies_blueprint.route('/hobbies', methods=['POST'])
def create_hobbies():
    data = request.get_json()
    try:
        physical = data['physical']
        art = data['art']
        cooking = data['cooking']
        music = data['music']
        hobby_id = data['hobby_id']

        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('INSERT INTO Interests_Hobbies (physical, art, cooking, music, hobby_id) VALUES (%s, %s, %s, %s, %s)', 
                    (physical, art, cooking, music, hobby_id)
                )
        conn.commit()
        

        return jsonify({"message": "Hobby created successfully.", "id": cur.lastrowid}), 201
    except KeyError as e:
        return jsonify({"error": f"Missing field: {e}"}), 400
    except Exception as e:
        return jsonify({"error": "An error occurred creating the hobby."}), 500


# Get name and budget from user 
@hobbies_blueprint.route('/hobbies', methods=['GET'])
def get_hobbies_info():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Interests_Hobbies')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


# Retrieve a single hobby
@hobbies_blueprint.route('/hobbies/<int:hobby_id>', methods=['GET'])
def get_hobby(hobby_id):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('SELECT * FROM Interests_Hobbies WHERE hobby_id = %s', (hobby_id))
        hobby = cur.fetchone()

        if hobby:
            return jsonify(hobby), 200
        else:
            return jsonify({"error": "hobby not found."}), 404
    except Exception as e:
        return jsonify({"error": "An error occurred fetching the hobby."}), 500
    
# adding a new hobby
@hobbies_blueprint.route('/hobbies', methods=['POST'])
def create_hobbies():
    data = request.get_json()
    try:
        hobby_id = data['hobby_id']
        new_hobby = data.pop('new_hobby', None)  # Removes 'new_hobby' from data dictionary if present

        # Build the SQL query dynamically
        columns = ', '.join(data.keys())  # Gets column names excluding 'hobbies_id'
        placeholders = ', '.join(['%s'] * len(data))  # Generates placeholders for the values
        values = tuple(data.values())  # Get the values corresponding to the columns

        conn = db.get_db()
        cur = conn.cursor()

        if new_hobby:  # If a new hobby is provided, add it to the SQL query
            columns += ', new_hobby'
            placeholders += ', %s'
            values += (new_hobby,)

        query = f'INSERT INTO Interests_Hobbies ({columns}, hobby_id) VALUES ({placeholders}, %s)'
        cur.execute(query, values + (hobby_id,))  # Executes the SQL query with values and hobbies_id
        conn.commit()

        return jsonify({"message": "Hobby created successfully.", "id": cur.lastrowid}), 201
    except KeyError as e:
        return jsonify({"error": f"Missing field: {e}"}), 400
    except Exception as e:
        return jsonify({"error": "An error occurred creating the hobby."}), 500
    

# Delete a hobby
@hobbies_blueprint.route('/hobbies/<int:hobby_id>', methods=['DELETE'])
def delete_hobby(hobby_id):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('DELETE FROM Interests_Hobbies WHERE hobby_id = %s', (hobby_id,))
        conn.commit()

        if cur.rowcount == 0:
            return jsonify({"error": "Hobby not found."}), 404

        return jsonify({"message": "Hobby deleted successfully."}), 200
    except Exception as e:
        return jsonify({"error": "An error occurred deleting the Hobby."}), 500
    
# updating hobby information
@hobbies_blueprint.route('/hobbies', methods=['PUT'])
def update_customer():
    try:
        data = request.json()
        physical = data['physical']
        art = data['art']
        cooking = data['cooking']
        music = data['music']
        hobby_id = data['hobby_id']

        query = 'UPDATE Interests_Hobbies SET physical = %s, art = %s, cooking = %s, music = %s WHERE hobby_id = %s'
        data = (physical, art, cooking, music, hobby_id)

        cursor = db.get_db().cursor()
        cursor.execute(query, data)
        db.get_db().commit()

        return 'Hobby info updated.', 200
    except KeyError as e:
        return jsonify({"error": f"Missing field: {e}"}), 400
    except Exception as e:
        return jsonify({"error": "An error occurred while updating hobby info."}), 500