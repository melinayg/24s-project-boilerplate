########################################################
# Sample customers blueprint of endpoints
# Remove this file if you are not using it in your project
########################################################
from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


restaurants_blueprint = Blueprint('restaurants', __name__)

# Update User information for user
@restaurants_blueprint.route('/restaurants', methods=['PUT'])
def update_restaurant():
    info = request.json
    rest_id = info['RestaurantID']
    name = info['Name']
    reservations = info['Reservations']
    cuisine = info['CuisineType']
    price = info['PriceTag']
    location = info['Location']
    activity = info['ActivityType']

    query = 'UPDATE restaurants SET Name = %s, Reservations = %s, CuisineType = %s, PriceTag= %s, Location = %s, ActivityType = %s where RestaurantID = %s'
    data = (name, reservations, cuisine, price,location, activity, rest_id)
    cursor = db.get_db().cursor()
    x = cursor.execute(query, data)
    db.get_db().commit()
    return 'Restaurant info updated.'

# Get all restaurants from the DB
@restaurants_blueprint.route('/restaurants', methods=['GET'])
def get_restaurants():
    cursor = db.get_db().cursor()
    cursor.execute('select RestaurantID, Name, Reservations, CuisineType,\
        PriceTag, Location, ActivityType from restaurants')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get restaurant detail for customer with particular userID
@restaurants_blueprint.route('/restaurants/<RestaurantID>', methods=['GET'])
def get_restaurant(userID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from restaurants where id = {0}'.format(userID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Input new restaurant
@restaurants_blueprint.route('/restaurants', methods=['POST'])
def add_new_restaurant():

    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    # extracting the variables
    name = the_data['Name']
    reservations = the_data['Reservations']
    cuisine = the_data['CuisineType']
    price = the_data['PriceTag']
    location = the_data['Location']
    activity = the_data['ActivityType']

    # constructing the query
    query = 'INSERT INTO restaurants (Name, Reservations, CuisineType, PriceTag, Location, ActivityType) VALUES (%s, %s, %s, %s, %s, %s)'
    data = (name, reservations, cuisine, price, location, activity)
    current_app.logger.info(query)
    
    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()

    return 'Restaurant added successfully.'


# Delete restaurant from DB
@restaurants_blueprint.route('/restaurants/<RestaurantID>', methods=['DELETE'])
def delete_user(RestaurantID):
    cursor = db.get_db().cursor()
    cursor.execute('DELETE FROM restaurants WHERE RestaurantID = %s', (RestaurantID,))
    db.get_db().commit()
    return 'Restaurant deleted.', 200

# Get restaurants by cuisine type
@restaurants_blueprint.route('/restaurants/<CuisineType>', methods=['GET'])
def get_restaurants_by_cuisine(cuisine_type):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM restaurants WHERE CuisineType = %s', (cuisine_type,))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    if json_data:
        return jsonify(json_data), 200
    else:
        return 'No restaurants found for the specified cuisine type.', 404