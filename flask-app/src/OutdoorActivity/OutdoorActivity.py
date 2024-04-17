########################################################
# Sample customers blueprint of endpoints
# Remove this file if you are not using it in your project
########################################################
from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


outdoor_blueprint = Blueprint('outdoor', __name__)

# Update outdoor activity information 
@outdoor_blueprint.route('/outdoor', methods=['PUT'])
def update_outdoor():
    info = request.json
    id = info['OutdoorID']
    name = info['Name']
    difficulty = info['Difficulty_level']
    danger = info['Danger_level']
    exp = info['Experience']
    price = info['PriceTag']
    location = info['Location']
    activity = info['ActivityTypeID']

    query = 'UPDATE outdoor SET Name = %s, Difficulty_level = %s, Danger_level = %s, Experience = %s, PriceTag= %s, Location = %s, ActivityTypeID = %s where OutdoorID = %s'
    data = (name, difficulty, danger, exp, price,location, activity, id)
    cursor = db.get_db().cursor()
    x = cursor.execute(query, data)
    db.get_db().commit()
    return 'Outdoor info updated.'

# Get all outdoors from the DB
@outdoor_blueprint.route('/outdoor', methods=['GET'])
def get_outdoors():
    cursor = db.get_db().cursor()
    cursor.execute('select OutdoorID, Name, Difficulty_level, Danger_level,\
        Experience, PriceTag, Location, ActivityTypeID from Outdoor_Activity')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get outdoor detail for specific activity
@outdoor_blueprint.route('/outdoor/<OutdoorID>', methods=['GET'])
def get_outdoor(OutdoorID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from outdoor where id = {0}'.format(OutdoorID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Input new outdoor
@outdoor_blueprint.route('/outdoor', methods=['POST'])
def add_new_outdoor():

    # collecting data from the request object 
    info = request.json
    current_app.logger.info(info)

    # extracting the variables
    name = info['Name']
    difficulty = info['Difficulty_level']
    danger = info['Danger_level']
    exp = info['Experience']
    price = info['PriceTag']
    location = info['Location']
    activity = info['ActivityTypeID']

    # constructing the query
    query = 'INSERT INTO outdoor_activity (Name, Difficulty_level, Danger_level, Experience, PriceTag, Location, ActivityTypeID) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)'
    data = (name, difficulty, danger, exp, price, location, activity)
    current_app.logger.info(query)
    
    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()

    return 'Outdoor added successfully.'

# Delete outdoor from DB
@outdoor_blueprint.route('/outdoor/<OutdoorID>', methods=['DELETE'])
def delete_user(OutdoorID):
    cursor = db.get_db().cursor()
    cursor.execute('DELETE FROM outdoor_activity WHERE OutdoorID = %s', (OutdoorID,))
    db.get_db().commit()
    return 'Outdoor deleted.', 200

# Get outdoors by difficulty_level
@outdoor_blueprint.route('/outdoor/<Difficulty_level>', methods=['GET'])
def get_outdoors_by_cuisine(difficulty):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM outdoor_activity WHERE Difficulty_level = %s', (difficulty,))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    if json_data:
        return jsonify(json_data), 200
    else:
        return 'No outdoor found for the specified difficulty.', 404
