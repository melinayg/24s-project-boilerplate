from flask import Blueprint, request, jsonify, make_response
import json
from src import db

cafes_blueprint = Blueprint('cafes', __name__)


# Get name and budget from cafe 
@cafes_blueprint.route('/cafes', methods=['GET'])
def get_cafe_info():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Cafes')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Update cafe information
@cafes_blueprint.route('/cafes', methods=['PUT'])
def update_cafes():
    info = request.json
    id = info['CafeID']
    Cuisine = info['Cuisine']
    name = info["Name"]
    OverallRating = info['OverallRating']
    ActivityTypeID = info['ActivityTypeID']
    Price_Tag = info["Price_Tag"]
    
    query = 'UPDATE cafes SET Name = %s, OverallRating = %s, ActivityTypeID = %s, Cuisine = %s, Price_Tag = %s WHERE CafeID = %s'

    data = (name, OverallRating, ActivityTypeID, Cuisine, Price_Tag, id)
    cursor = db.get_db().cursor()
    x = cursor.execute(query, data)
    db.get_db().commit()
    return 'Cafes info is now updated.'

# Retrieve cafe pricing
@cafes_blueprint.route('/cafes/price/<price_tag>', methods=['GET'])
def cafe_price(price_tag):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('SELECT * FROM cafes WHERE PriceTag = %s', (price_tag,))
        price = cur.fetchall()

        if price:
            return jsonify(price), 200
        else:
            return jsonify({"error": "No cafes can be found in this price range."}), 404
    except Exception as e:
        return jsonify({"error": "An error occurred."}), 500

# Delete a rating for a cafe
@cafes_blueprint.route('/cafes/<int:cafe_id>/rating', methods=['DELETE'])
def delete_cafe_rating(cafe_id):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('UPDATE Cafes SET OverallRating = NULL WHERE CafeID = %s', (cafe_id,))
        conn.commit()

        if cur.rowcount == 0:
            return jsonify({"error": "Cafe rating not found."}), 404

        return jsonify({"message": "Cafe rating deleted successfully."}), 200
    except Exception as e:
        return jsonify({"error": "An error occurred deleting the cafe rating."}), 500

# # posts cafe
# @cafes_blueprint.route('/cafes', methods=['POST'])
# def create_cafe():
#     data = request.get_json()
#     try:
#         id = data['CafeID']
#         Cuisine = data['Cuisine']
#         name = data["Name"]
#         OverallRating = data['OverallRating']
#         ActivityTypeID = data['ActivityTypeID']
#         Price_Tag = data["Price_Tag"]

#         query = '''
#             INSERT INTO Cafes (CafeID, Name, PriceTag, Cuisine, ActivityTypeID, OverallRating) 
#             VALUES (%s, %s, %s, %s, %s, %s)
#         '''
#         conn = db.get_db()
#         cur = conn.cursor()
#         cur.execute(query, (id, name, Price_Tag, Cuisine, ActivityTypeID, OverallRating))
#         conn.commit()

#         return jsonify({"message": "Cafe created successfully.", "id": cur.lastrowid}), 201
#     except KeyError as e:
#         return jsonify({"error": f"Missing required field: {str(e)}"}), 400
#     except Exception as e:
#         return jsonify({"error": "An error occurred while creating the cafe."}), 500
    

@cafes_blueprint.route('/cafes', methods=['POST'])
def create_cafe():
    data = request.get_json()
    try:
        name = data['Name']
        cuisine = data['Cuisine']
        overall_rating = data['OverallRating']
        activity_type_id = data['ActivityTypeID']
        price_tag = data['PriceTag']

        query = '''
            INSERT INTO Cafes (Name, Cuisine, OverallRating, ActivityTypeID, PriceTag) 
            VALUES (%s, %s, %s, %s, %s)
        '''
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute(query, (name, cuisine, overall_rating, activity_type_id, price_tag))
        conn.commit()

        return jsonify({"message": "Cafe created successfully.", "id": cur.lastrowid}), 201
    except KeyError as e:
        return jsonify({"error": f"Missing field: {e}"}), 400
    except Exception as e:
        return jsonify({"error": "An error occurred creating the cafe."}), 500


# Retrieve by cuisine
@cafes_blueprint.route('/cafes/cuisine/<cuisine>', methods=['GET'])
def get_cafes_by_cuisine(cuisine):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('SELECT * FROM Cafes WHERE Cuisine = %s', (cuisine,))
        cafes = cur.fetchall()

        if cafes:
            return jsonify(cafes), 200
        else:
            return jsonify({"error": "Cafes with the specified cuisine not found."}), 404
    except Exception as e:
        return jsonify({"error": "An error occurred fetching cafes by cuisine."}), 500
    
# delete cafe id 
@cafes_blueprint.route('/cafes/<int:cafe_id>', methods=['DELETE'])
def delete_cafe(cafe_id):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('DELETE FROM Cafes WHERE CafeID = %s', (cafe_id,))
        conn.commit()

        if cur.rowcount > 0:
            return jsonify({"message": f"Cafe with ID {cafe_id} deleted successfully."}), 200
        else:
            return jsonify({"error": f"Cafe with ID {cafe_id} not found."}), 404
    except Exception as e:
        return jsonify({"error": "An error occurred while deleting the cafe."}), 500