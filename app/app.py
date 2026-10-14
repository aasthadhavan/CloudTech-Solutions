
from flask import Flask, jsonify, request

app = Flask(__name__)

employees = [
    {"id": 1, "name": "Aarav", "department": "IT"},
    {"id": 2, "name": "Meera", "department": "HR"}
]

@app.route("/")
def home():
    return jsonify({
        "message": "CloudTech Employee Management API",
        "status": "running"
    })

@app.route("/employees", methods=["GET"])
def get_employees():
    return jsonify(employees)

@app.route("/employees", methods=["POST"])
def add_employee():
    data = request.get_json(silent=True) or {}

    if not data.get("name") or not data.get("department"):
        return jsonify({
            "error": "Name and department are required"
        }), 400

    employee = {
        "id": max((e["id"] for e in employees), default=0) + 1,
        "name": data["name"],
        "department": data["department"]
    }

    employees.append(employee)
    return jsonify(employee), 201

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
