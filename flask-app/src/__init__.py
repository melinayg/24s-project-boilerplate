# Some set up for the application 

from flask import Flask
from flaskext.mysql import MySQL

# create a MySQL object that we will use in other parts of the API
db = MySQL()

def create_app():
    app = Flask(__name__)
    
    # secret key that will be used for securely signing the session 
    # cookie and can be used for any other security related needs by 
    # extensions or your application
    app.config['SECRET_KEY'] = 'someCrazyS3cR3T!Key.!'

    # these are for the DB object to be able to connect to MySQL. 
    app.config['MYSQL_DATABASE_USER'] = 'root'
    app.config['MYSQL_DATABASE_PASSWORD'] = open('/secrets/db_root_password.txt').readline().strip()
    app.config['MYSQL_DATABASE_HOST'] = 'db'
    app.config['MYSQL_DATABASE_PORT'] = 3306
    app.config['MYSQL_DATABASE_DB'] = 'GoMass'  # Change this to your DB name

    # Initialize the database object with the settings above. 
    db.init_app(app)
    
     # Default route
    @app.route("/")
    def welcome():
        return "<h1>Welcome to the GoMass API TESTING</h1>"

    # Import the blueprint objects 
    from src.Movies.movies import movies_blueprint
    from src.PaymentPlan.payment_plan import payment_plan_blueprint
    from src.Transportation.transportation import transportation_blueprint
    from src.Shopping.shopping import shopping_blueprint
    from src.User.user import user_blueprint
    from src.OutdoorActivity.OutdoorActivity import outdoor


    # Register blueprints with the app object and give a url prefix to each
    app.register_blueprint(movies_blueprint, url_prefix='/movies')
    app.register_blueprint(payment_plan_blueprint, url_prefix='/payment_plan')
    app.register_blueprint(outdoor, url_prefix='/outdoor')
    app.register_blueprint(transportation_blueprint, url_prefix='/transportation')
    app.register_blueprint(shopping_blueprint, url_prefix='/shopping')
    app.register_blueprint(user_blueprint,   url_prefix='/user')
    return app