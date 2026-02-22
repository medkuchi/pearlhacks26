from flask import Flask, render_template, session, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///users.db'
app.config['SECRET_KEY'] = 'your_secret_key'
db = SQLAlchemy(app)

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100))
    email = db.Column(db.String(120), unique=True)
    age = db.Column(db.Integer)
    major = db.Column(db.String(100))
    sleep_schedule = db.Column(db.String(50))
    living_preference = db.Column(db.String(50))
    building_preference = db.Column(db.String(100))
    rent_min = db.Column(db.Integer)
    rent_max = db.Column(db.Integer)
    cleanliness = db.Column(db.Integer)
    num_bedrooms = db.Column(db.Integer)
    num_bathrooms = db.Column(db.Integer)
    bio = db.Column(db.Text)

with app.app_context():
    db.create_all()

@app.route("/")
def home():
    return render_template("login.html")

@app.route("/login")
def login_page():
    return render_template("login.html")
@app.route("/login", methods=["POST"])
def login():
    session["name"] = request.form["name"]
    session["email"] = request.form["email"]
    return redirect(url_for("survey"))
@app.route("/survey")
def survey():
    return render_template("survey.html")

@app.route('/swipe')
def swipe():
    swipe_list = [] #make sure to replace with database or gemini api results
    return render_template('swipe.html' , swipe=swipe_list)

@app.route('/submit_survey', methods=['POST'])
def submit_survey():
    #User data
    new_user = User(
        name = session['name'],
        email = session['email'],
        age = request.form['age'],
        major = request.form['major'],
        sleep_schedule = request.form['sleep'],
        living_preference = request.form['living'],
        building_preference = request.form['building_preference'],
        rent_min = request.form['rent_min'],
        rent_max = request.form['rent_max'],
        cleanliness = request.form['cleanliness'],
        num_bedrooms = request.form['num_bedrooms'],
        num_bathrooms = request.form['num_bathrooms'],
        bio = request.form['bio']
    )

    db.session.add(new_user)
    db.session.commit()
    return redirect(url_for('swipe'))

if __name__ == '__main__':
    app.run(debug=True)