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

#Get details for specific user by UserID
@user_blueprint.route('/user/<UserID>', methods=['GET'])
def get_user_by_id(UserID):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM User WHERE UserID = %s', (UserID,))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Update user information
@user_blueprint.route('/user', methods=['PUT'])
def update_user():
    info = request.json
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
    return 'User info is now updated.'

# Delete user's budget from DB by UserID
@user_blueprint.route('/user/<int:UserID>/Budget', methods=['DELETE'])
def delete_user_budget(UserID):
    cursor = db.get_db().cursor()
    cursor.execute('UPDATE User SET Budget = NULL WHERE UserID = %s', (UserID,))
    db.get_db().commit()
    return 'User budget deleted.', 200

# Delete user's likes from DB by UserID
@user_blueprint.route('/user/<int:UserID>/likes', methods=['DELETE'])
def delete_user_likes(UserID):
    cursor = db.get_db().cursor()
    cursor.execute('UPDATE User SET Likes = NULL WHERE UserID = %s', (UserID,))
    db.get_db().commit()
    return 'User likes deleted.', 200

#post new user
@app.route('/users', methods=['POST'])
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
        PaymentID = data['PaymentId']
        Balance = data['Balance']
        PaymentMethod = data['PaymentMethod']

        cursor = db.cursor()

        query = '''
            INSERT INTO User (Name, Age, Occupation, Hometown, Budget, Dislikes, Likes, Gender, DietaryRestrictions, SubscriptionPlan, PaymentID, Balance, PaymentMethod) 
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        '''

        cursor.execute(query, (Name, Age, Occupation, Hometown, Budget, Dislikes, Likes, Gender, DietaryRestrictions, SubscriptionPlan, PaymentID, Balance, PaymentMethod))
        db.commit()

        return jsonify({"message": "User created successfully."}), 201

    except KeyError as e:
        return jsonify({"error": f"Missing field: {e}"}), 400
    except Exception as e:
        return jsonify({"error": "An error occurred creating the user."}), 500
