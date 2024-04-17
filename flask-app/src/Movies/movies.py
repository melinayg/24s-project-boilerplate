from flask import Blueprint, request, jsonify, make_response
from src import db

movies_blueprint = Blueprint('movies', __name__)

# Create a new movie
@movies_blueprint.route('/movies', methods=['POST'])
def create_movie():
    data = request.get_json()
    try:
        theater_location = data['theater_location']
        name = data['name']
        overall_rating = data['overall_rating']
        genre = data['genre']
        activity_type_id = data['activity_type_id']

        query = '''
            INSERT INTO Movies (TheaterLocation, Name, OverallRating, Genre, Activity_Type_ID) 
            VALUES (%s, %s, %s, %s, %s)
        '''
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute(query, (theater_location, name, overall_rating, genre, activity_type_id))
        conn.commit()

        return jsonify({"message": "Movie created successfully.", "id": cur.lastrowid}), 201
    except KeyError as e:
        return jsonify({"error": f"Missing field: {e}"}), 400
    except Exception as e:
        return jsonify({"error": "An error occurred creating the movie."}), 500

# Get name and budget from user 
@movies_blueprint.route('/movies', methods=['GET'])
def get_user_info():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Movies')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@movies_blueprint.route('/movies/id/<int:movie_id>', methods=['GET'])
def get_movie_by_id(movie_id):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('SELECT * FROM Movies WHERE MovieID = %s', (movie_id,))
        movie = cur.fetchone()

        if not movie:
            return jsonify({"message": "No movie found with this ID."}), 404

        return jsonify(movie), 200
    except Exception as e:
        return jsonify({"error": "An error occurred fetching the movie: " + str(e)}), 500


@movies_blueprint.route('/movies/genre/<string:genre>', methods=['GET'])
def get_genre_movies(genre):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        # Use a parameterized query to prevent SQL injection
        cur.execute('SELECT * FROM Movies WHERE Genre = %s', (genre,))
        movies = cur.fetchall()

        # If no movies found, return a suitable message
        if not movies:
            return jsonify({"message": "No movies found for this genre."}), 404

        return jsonify(movies), 200
    except Exception as e:
        return jsonify({"error": "An error occurred fetching the movies: " + str(e)}), 500


@movies_blueprint.route('/movies/ratings/<float:rating>', methods=['GET'])
def get_ratings_movies(rating):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        # Use a parameterized query to prevent SQL injection
        # Ensure the rating is a valid decimal within your specified range
        if not (1 <= rating <= 3):
            return jsonify({"message": "Rating must be between 1.0 and 3.0"}), 400

        cur.execute('SELECT * FROM Movies WHERE OverallRating = %s', (rating,))
        movies = cur.fetchall()

        # If no movies found, return a suitable message
        if not movies:
            return jsonify({"message": "No movies found for this rating."}), 404

        return jsonify(movies), 200
    except Exception as e:
        return jsonify({"error": "An error occurred fetching the movies: " + str(e)}), 500


# Update a movie
@movies_blueprint.route('/movies/<int:movie_id>', methods=['PUT'])
def update_movie(movie_id):
    data = request.get_json()
    try:
        theater_location = data['theater_location']
        name = data['name']
        overall_rating = data['overall_rating']
        genre = data['genre']
        activity_type_id = data['activity_type_id']

        query = '''
            UPDATE Movies 
            SET TheaterLocation = %s, Name = %s, OverallRating = %s, Genre = %s, Activity_Type_ID = %s 
            WHERE MovieID = %s
        '''
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute(query, (theater_location, name, overall_rating, genre, activity_type_id, movie_id))
        conn.commit()

        if cur.rowcount == 0:
            return jsonify({"error": "Movie not found."}), 404

        return jsonify({"message": "Movie updated successfully."}), 200
    except KeyError as e:
        return jsonify({"error": f"Missing field: {e}"}), 400
    except Exception as e:
        return jsonify({"error": "An error occurred updating the movie."}), 500

# Delete a movie
@movies_blueprint.route('/movies/<int:movie_id>', methods=['DELETE'])
def delete_movie(movie_id):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('DELETE FROM Movies WHERE MovieID = %s', (movie_id,))
        conn.commit()

        if cur.rowcount == 0:
            return jsonify({"error": "Movie not found."}), 404

        return jsonify({"message": "Movie deleted successfully."}), 200
    except Exception as e:
        return jsonify({"error": "An error occurred deleting the movie."}), 500
    

@movies_blueprint.route('/movies/price/<string:price_tag>', methods=['GET'])
def get_movies_by_price(price_tag):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        # Using LIKE to allow flexibility in searching by price tag patterns
        cur.execute('SELECT * FROM Movies WHERE PriceTag LIKE %s', ('%' + price_tag + '%',))
        movies = cur.fetchall()

        if not movies:
            return jsonify({"message": "No movies found for this price tag."}), 404

        return jsonify(movies), 200
    except Exception as e:
        return jsonify({"error": "An error occurred fetching the movies: " + str(e)}), 500


@movies_blueprint.route('/movies/theater/<string:location>', methods=['GET'])
def get_movies_by_theater_location(location):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('SELECT * FROM Movies WHERE TheaterLocation LIKE %s', ('%' + location + '%',))
        movies = cur.fetchall()

        if not movies:
            return jsonify({"message": "No movies found at this theater location."}), 404

        return jsonify(movies), 200
    except Exception as e:
        return jsonify({"error": "An error occurred fetching the movies: " + str(e)}), 500

# Register the blueprint in your app configuration
# app.register_blueprint(movies_blueprint, url_prefix='/api')
