
from flask import Blueprint, request, jsonify, make_response
import json
from src import db


groupact_blueprint = Blueprint('group_activity', __name__)

# creating group_activity data
@groupact_blueprint.route('/group_activity', methods=['POST'])
def create_group_activity():
    data = request.get_json()
    try:
        friends_no = data['type']
        grp_budget = data['budget']
        meeeting_time = data['safety']
        group_activity_id = data['group_activity_id']

        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('INSERT INTO group_activity (friends_no, grp_budget, meeeting_time, group_activity_id) VALUES (%s, %s, %s, %s, %s)', 
                    (friends_no, grp_budget, meeeting_time, group_activity_id)
                )
        conn.commit()
        

        return jsonify({"message": "group_activity created successfully.", "id": cur.lastrowid}), 201
    except KeyError as e:
        return jsonify({"error": f"Missing field: {e}"}), 400
    except Exception as e:
        return jsonify({"error": "An error occurred creating the group_activity."}), 500


# Retrieve all group_activity possibl
@groupact_blueprint.route('/group_activity', methods=['GET'])
def get_all_groupact():
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('SELECT * FROM group_activity')
        group_activity = cur.fetchall()

        return jsonify(group_activity), 200
    except Exception as e:
        return jsonify({"error": "An error occurred fetching the group_activity."}), 500

# Retrieve a single group_activity
@groupact_blueprint.route('/group_activity/<int:group_activity_id>', methods=['GET'])
def get_trnasportation(group_activity_id):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('SELECT * FROM group_activity WHERE group_activity_id = %s', (group_activity_id))
        group_activity = cur.fetchone()

        if group_activity:
            return jsonify(group_activity), 200
        else:
            return jsonify({"error": "group_activity not found."}), 404
    except Exception as e:
        return jsonify({"error": "An error occurred fetching the group_activity."}), 500
    
# adding a new group_activity
@groupact_blueprint.route('/group_activity', methods=['POST'])
def create_new_group_activity():
    data = request.get_json()
    try:
        group_activity_id = data['group_activity_id']
        new_group_activity = data.pop('new_group_activity', None)  

        # Build the SQL query dynamically
        columns = ', '.join(data.keys())  # Gets column names excluding 'group_activity_id'
        placeholders = ', '.join(['%s'] * len(data))  # Generates placeholders for the values
        values = tuple(data.values())  # Get the values corresponding to the columns

        conn = db.get_db()
        cur = conn.cursor()

        if new_group_activity:  # If a new group_activity is provided, add it to the SQL query
            columns += ', new_group_activity'
            placeholders += ', %s'
            values += (new_group_activity)

        query = f'INSERT INTO group_activity ({columns}, group_activity_id) VALUES ({placeholders}, %s)'
        cur.execute(query, values + (group_activity_id,)) 
        conn.commit()

        return jsonify({"message": "group_activity created successfully.", "id": cur.lastrowid}), 201
    except KeyError as e:
        return jsonify({"error": f"Missing field: {e}"}), 400
    except Exception as e:
        return jsonify({"error": "An error occurred creating the group_activity."}), 500
    
# updating no. of people in the group information
@groupact_blueprint.route('/group_activity/<int:group_activity_id>', methods=['PUT'])
def update_group_activity(group_activity_id):
    try:
        data = request.get_json()
        friends_no = data['friends_no']

        conn = db.get_db()
        cur = conn.cursor()

        # Update the number of people in the group
        cur.execute('UPDATE group_activity SET friends_no = %s WHERE group_activity_id = %s', (friends_no, group_activity_id))
        conn.commit()

        return jsonify({"message": "Number of people in the group updated successfully."}), 200
    except KeyError as e:
        return jsonify({"error": f"Missing field: {e}"}), 400
    except Exception as e:
        return jsonify({"error": "An error occurred while updating the number of people in the group."}), 500

# Delete a group
@groupact_blueprint.route('/group_activity/<int:group_activity_id>', methods=['DELETE'])
def delete_group_activity(group_activity_id):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('DELETE FROM group_activity WHERE group_activity_id = %s', (group_activity_id,))
        conn.commit()

        if cur.rowcount == 0:
            return jsonify({"error": "group_activity not found."}), 404

        return jsonify({"message": "group_activity deleted successfully."}), 200
    except Exception as e:
        return jsonify({"error": "An error occurred deleting the group_activity."}), 500
    
# updating group_activity information
@groupact_blueprint.route('/group_activity', methods=['PUT'])
def update_customer():
    try:
        friends_no = data['type']
        grp_budget = data['budget']
        meeting_time = data['safety']
        group_activity_id = data['group_activity_id']

        query = 'UPDATE group_activity SET friends_no = %s, grp_budget = %s, meeting_time = %s WHERE group_activity_id = %s'
        data = (friends_no, grp_budget, meeting_time, group_activity_id)
        cursor = db.get_db().cursor()
        cursor.execute(query, data)
        db.get_db().commit()

        return 'group_activity info updated.', 200
    except KeyError as e:
        return jsonify({"error": f"Missing field: {e}"}), 400
    except Exception as e:
        return jsonify({"error": "An error occurred while updating group_activity info."}), 500