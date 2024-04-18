from flask import Blueprint, request, jsonify, make_response
import json
from src import db

user_blueprint = Blueprint('user', __name__)

# Get name and budget from user 

@user_blueprint.route('/user', methods=['GET'])
def get_user_info():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM User')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


@user_blueprint.route('/user/<int:UserID>', methods=['DELETE'])
def delete_user(UserID):
    cursor = db.get_db().cursor()
    try:
        # Execute the DELETE statement
        cursor.execute('DELETE FROM User WHERE UserID = %s', (UserID,))
        db.get_db().commit()

        # Check if the delete was successful
        if cursor.rowcount == 0:
            return jsonify({'error': 'No user found with that ID'}), 404

        return jsonify({'message': 'User deleted successfully'}), 200

    except Exception as e:
        db.get_db().rollback()  # Rollback transaction if any error occurs
        return jsonify({'error': 'Failed to delete user due to: {}'.format(str(e))}), 500



#Get details for specific user by UserID
@user_blueprint.route('/user/<Name>', methods=['GET'])
def get_name_by_id(Name):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM User WHERE Name = %s', (Name,))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


@user_blueprint.route('/budget', methods=['PUT'])
def update_user():
    info = request.json
    required_keys = ['UserID', 'Name', 'Age', 'Occupation', 'Hometown', 'Budget', 'Dislikes', 'Likes', 'Gender', 'DietaryRestrictions', 'SubscriptionPlan', 'PaymentID', 'Balance', 'PaymentMethod']

    # Check if all required keys are in the JSON payload
    if not all(key in info for key in required_keys):
        missing_keys = [key for key in required_keys if key not in info]
        return jsonify({'error': 'Missing keys: {}'.format(missing_keys)}), 400

    # If all keys are present, extract them
    UserID = info['UserID']
    Name = info['Name']
    Age = info['Age']
    Occupation = info['Occupation']
    Hometown = info['Hometown']
    Budget = info['Budget']
    Dislikes = info['Dislikes']
    Likes = info['Likes']
    Gender = info['Gender']
    DietaryRestrictions = info['DietaryRestrictions']
    SubscriptionPlan = info['SubscriptionPlan']
    PaymentID = info['PaymentID']
    Balance = info['Balance']
    PaymentMethod = info['PaymentMethod']
    
    # Your SQL query remains the same
    query = '''
        UPDATE User SET Name = %s, Age = %s, Occupation = %s, Hometown = %s, Budget = %s, Dislikes = %s,
        Likes = %s, Gender = %s, DietaryRestrictions = %s, SubscriptionPlan = %s, PaymentID = %s,
        Balance = %s, PaymentMethod = %s WHERE UserID = %s
    '''
    data = (Name, Age, Occupation, Hometown, Budget, Dislikes, Likes, Gender, DietaryRestrictions,
            SubscriptionPlan, PaymentID, Balance, PaymentMethod, UserID)
    
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()
    return jsonify({'message': 'User info is now updated.'})

# # Delete user's budget from DB by UserID
# @user_blueprint.route('/user/<Name>', methods=['DELETE'])
# def delete_user_budget(Name):
#     cursor = db.get_db().cursor()
#     cursor.execute('UPDATE User SET Budget = NULL WHERE Name = %s', (Name,))
#     db.get_db().commit()
#     return 'User budget deleted.', 200

# # Delete user's likes from DB by UserID
# @user_blueprint.route('/user/<int:UserID>/likes', methods=['DELETE'])
# def delete_user_likes(UserID):
#     cursor = db.get_db().cursor()
#     cursor.execute('UPDATE User SET Likes = NULL WHERE UserID = %s', (UserID,))
#     db.get_db().commit()
#     return 'User likes deleted.', 200

@user_blueprint.route('/user', methods=['POST'])
def create_user():
    data = request.get_json()
    try:
        Name = data['Name']
        Age = data['Age']
        Occupation = data['Occupation']
        Hometown = data['Hometown']
        Budget = data['Budget']
        Dislikes = data['Dislikes']
        Likes = data['Likes']
        Gender = data['Gender']
        DietaryRestrictions = data['DietaryRestrictions']
        SubscriptionPlan = data['SubscriptionPlan']
        PaymentID = data['PaymentID']
        Balance = data['Balance']
        PaymentMethod = data['PaymentMethod']

        query = '''
            INSERT INTO User (Name, Age, Occupation, Hometown, Budget, Dislikes, Likes, Gender, DietaryRestrictions, SubscriptionPlan, PaymentID, Balance, PaymentMethod) 
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        '''
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute(query, (Name, Age, Occupation, Hometown, Budget, Dislikes, Likes, Gender, DietaryRestrictions, SubscriptionPlan, PaymentID, Balance, PaymentMethod))
        conn.commit()

        return jsonify({"message": "User created successfully.", "id": cur.lastrowid}), 201

    except KeyError as e:
        return jsonify({"error": f"Missing field: {e}"}), 400
    except Exception as e:
        return jsonify({"error": "An error occurred creating the user."}), 500

