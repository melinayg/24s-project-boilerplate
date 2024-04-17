from flask import Blueprint, request, jsonify, make_response
from src import db

payment_plan_blueprint = Blueprint('payment_plan', __name__)

# Create a new payment plan
@payment_plan_blueprint.route('/payment_plan', methods=['POST'])
def create_payment_plan():
    data = request.get_json()
    try:
        paid = data['paid']
        free = data['free']
        payment_method = data['payment_method']
        user_id = data['user_id']

        conn = db.get_db()
        cur = conn.cursor()
        cur.execute(
            'INSERT INTO PaymentPlan (Paid, Free, PaymentMethod, UserID) VALUES (%s, %s, %s, %s)',
            (paid, free, payment_method, user_id)
        )
        conn.commit()

        return jsonify({"message": "Payment plan created successfully.", "id": cur.lastrowid}), 201
    except KeyError as e:
        return jsonify({"error": f"Missing field: {e}"}), 400
    except Exception as e:
        return jsonify({"error": "An error occurred creating the payment plan."}), 500

# Get name and budget from user 
@payment_plan_blueprint.route('/payment_plan', methods=['GET'])
def get_payment_plan_info():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM PaymentPlan')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Retrieve a single payment plan
@payment_plan_blueprint.route('/payment_plan/<int:payment_id>', methods=['GET'])
def get_payment_plan(payment_id):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('SELECT * FROM PaymentPlan WHERE PaymentID = %s', (payment_id,))
        payment_plan = cur.fetchone()

        if payment_plan:
            return jsonify(payment_plan), 200
        else:
            return jsonify({"error": "Payment plan not found."}), 404
    except Exception as e:
        return jsonify({"error": "An error occurred fetching the payment plan."}), 500

# Update a payment plan
@payment_plan_blueprint.route('/payment_plan/<int:payment_id>', methods=['PUT'])
def update_payment_plan(payment_id):
    data = request.get_json()
    try:
        paid = data['paid']
        free = data['free']
        payment_method = data['payment_method']

        conn = db.get_db()
        cur = conn.cursor()
        cur.execute(
            'UPDATE PaymentPlan SET Paid = %s, Free = %s, PaymentMethod = %s WHERE PaymentID = %s',
            (paid, free, payment_method, payment_id)
        )
        conn.commit()

        if cur.rowcount == 0:
            return jsonify({"error": "Payment plan not found."}), 404

        return jsonify({"message": "Payment plan updated successfully."}), 200
    except KeyError as e:
        return jsonify({"error": f"Missing field: {e}"}), 400
    except Exception as e:
        return jsonify({"error": "An error occurred updating the payment plan."}), 500

# Delete a payment plan
@payment_plan_blueprint.route('/payment_plan/<int:payment_id>', methods=['DELETE'])
def delete_payment_plan(payment_id):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('DELETE FROM PaymentPlan WHERE PaymentID = %s', (payment_id,))
        conn.commit()

        if cur.rowcount == 0:
            return jsonify({"error": "Payment plan not found."}), 404

        return jsonify({"message": "Payment plan deleted successfully."}), 200
    except Exception as e:
        return jsonify({"error": "An error occurred deleting the payment plan."}), 500

# A route to get payment plans by user ID (Additional functionality)
@payment_plan_blueprint.route('/user_payment_plan/<int:user_id>', methods=['GET'])
def get_payment_plans_by_user(user_id):
    try:
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute('SELECT * FROM PaymentPlan WHERE UserID = %s', (user_id,))
        payment_plans = cur.fetchall()

        if payment_plans:
            return jsonify(payment_plans), 200
        else:
            return jsonify({"error": "No payment plans found for the user."}), 404
    except Exception as e:
        return jsonify({"error": "An error occurred fetching payment plans for the user."}), 500
