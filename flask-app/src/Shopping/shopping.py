from flask import Blueprint, request, jsonify
from src import db

shopping_blueprint = Blueprint('shopping', __name__)

# Create a new shopping item
@shopping_blueprint.route('/shopping', methods=['POST'])
def create_shopping_item():
    data = request.get_json()
    try:
        name = data['name']
        price_tag = data['price_tag']
        shopping_area_size = data['shopping_area_size']
        overall_rating = data['overall_rating']
        activity_type_id = data['activity_type_id']

        query = '''
            INSERT INTO Shopping (Name, PriceTag, Shopping_Area_Size, OverallRating, ActivityTypeID) 
            VALUES (%s, %s, %s, %s, %s)
        '''
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute(query, (name, price_tag, shopping_area_size, overall_rating, activity_type_id))
        conn.commit()

        return jsonify({"message": "Shopping item created successfully.", "id": cur.lastrowid}), 201

    except KeyError as e:
        return jsonify({"error": f"Missing field: {e}"}), 400
    except Exception as e:
        return jsonify({"error": "An error occurred creating the shopping item."}), 500

# Retrieve all shopping items
@shopping_blueprint.route('/shopping', methods=['GET'])
def get_all_shopping_items():
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('SELECT * FROM Shopping')
        items = cur.fetchall()

        return jsonify(items), 200
    except Exception as e:
        return jsonify({"error": "An error occurred fetching the shopping items."}), 500

# Retrieve a single shopping item by ID
@shopping_blueprint.route('/shopping/<int:shopping_id>', methods=['GET'])
def get_shopping_item(shopping_id):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('SELECT * FROM Shopping WHERE ShoppingID = %s', (shopping_id,))
        item = cur.fetchone()

        if item:
            return jsonify(item), 200
        else:
            return jsonify({"error": "Shopping item not found."}), 404
    except Exception as e:
        return jsonify({"error": "An error occurred fetching the shopping item."}), 500

# Retrieve shopping items by price tag
@shopping_blueprint.route('/shopping/price/<price_tag>', methods=['GET'])
def get_shopping_items_by_price(price_tag):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('SELECT * FROM Shopping WHERE PriceTag = %s', (price_tag,))
        items = cur.fetchall()

        if items:
            return jsonify(items), 200
        else:
            return jsonify({"error": "No shopping items found with the specified price tag."}), 404
    except Exception as e:
        return jsonify({"error": "An error occurred fetching the shopping items by price tag."}), 500


# Update a shopping item
@shopping_blueprint.route('/shopping/<int:shopping_id>', methods=['PUT'])
def update_shopping_item(shopping_id):
    data = request.get_json()
    try:
        name = data['name']
        price_tag = data['price_tag']
        shopping_area_size = data['shopping_area_size']
        overall_rating = data['overall_rating']
        activity_type_id = data['activity_type_id']

        query = '''
            UPDATE Shopping 
            SET Name = %s, PriceTag = %s, Shopping_Area_Size = %s, OverallRating = %s, ActivityTypeID = %s 
            WHERE ShoppingID = %s
        '''
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute(query, (name, price_tag, shopping_area_size, overall_rating, activity_type_id, shopping_id))
        conn.commit()

        if cur.rowcount == 0:
            return jsonify({"error": "Shopping item not found."}), 404

        return jsonify({"message": "Shopping item updated successfully."}), 200
    except KeyError as e:
        return jsonify({"error": f"Missing field: {e}"}), 400
    except Exception as e:
        return jsonify({"error": "An error occurred updating the shopping item."}), 500

# Delete a shopping item
@shopping_blueprint.route('/shopping/<int:shopping_id>', methods=['DELETE'])
def delete_shopping_item(shopping_id):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('DELETE FROM Shopping WHERE ShoppingID = %s', (shopping_id,))
        conn.commit()

        if cur.rowcount == 0:
            return jsonify({"error": "Shopping item not found."}), 404

        return jsonify({"message": "Shopping item deleted successfully."}), 200
    except Exception as e:
        return jsonify({"error": "An error occurred deleting the shopping item."}), 500
    
