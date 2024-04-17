########################################################
# Sample customers blueprint of endpoints
# Remove this file if you are not using it in your project
########################################################
from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


art_blueprint = Blueprint('art', __name__)

# Update art activity information 
@art_blueprint.route('/art', methods=['PUT'])
def update_art():
    info = request.json
    id = info['ArtMuseumID']
    name = info['Name']
    arttype = info['ArtType']
    college = info['CollegeStudents']
    rate = info ['OverallRating']
    price = info['PriceTag']
    location = info['Location']
    activity = info['ActivityTypeID']

    query = 'UPDATE art SET Name = %s, ArtType = %s, CollegeStudents = %s, OverallRating = %s, PriceTag= %s, Location = %s, ActivityTypeID = %s where ArtMuseumID = %s'
    data = (name, arttype, college, rate, price,location, activity, id)
    cursor = db.get_db().cursor()
    x = cursor.execute(query, data)
    db.get_db().commit()
    return 'Art info updated.'

# Get all art and museums from the DB
@art_blueprint.route('/art', methods=['GET'])
def get_arts():
    cursor = db.get_db().cursor()
    cursor.execute('select ArtMuseumID, Name, ArtType, CollegeStudents,\
        OverallRating, PriceTag, Location, ActivityTypeID from artmuseums')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get details for specific art/museum activity
@art_blueprint.route('/art/<ArtMuseumID>', methods=['GET'])
def get_art(ArtMuseumID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from art where id = {0}'.format(ArtMuseumID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Input new art/museum
@art_blueprint.route('/art', methods=['POST'])
def add_new_art():

    # collecting data from the request object 
    info = request.json
    current_app.logger.info(info)

    # extracting the variables
    name = info['Name']
    arttype = info['ArtType']
    college = info['CollegeStudents']
    rate = info ['OverallRating']
    price = info['PriceTag']
    location = info['Location']
    activity = info['ActivityTypeID']

    # constructing the query
    query = 'INSERT INTO art_activity (Name, ArtType, CollegeStudents, OverallRating, PriceTag, Location, ActivityTypeID) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)'
    data = (name, arttype, college, rate, price,location, activity, id)
    current_app.logger.info(query)
    
    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()

    return 'Art added successfully.'

# Delete art/museum from DB
@art_blueprint.route('/art/<ArtMuseumID>', methods=['DELETE'])
def delete_user(ArtMuseumID):
    cursor = db.get_db().cursor()
    cursor.execute('DELETE FROM artmuseums WHERE ArtMuseumID = %s', (ArtMuseumID,))
    db.get_db().commit()
    return 'Art deleted.', 200

# Get arts museums by art type
@art_blueprint.route('/art/<art_type>', methods=['GET'])
def get_arts_museums_by_art_type(art_type):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM ArtsMuseums WHERE ArtType = %s', (art_type,))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    if json_data:
        return jsonify(json_data), 200
    else:
        return 'No arts museums found for the specified art type.', 404
