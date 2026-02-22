# Imports
from flask import Flask, render_template,request, session, redirect
from flask_socketio import join_room, leave_room, send, SocketIO
import random
from string import ascii_uppercase
from database import get_db
from matching import top_matches


# My App
app = Flask(__name__)
app.secret_key = 'pearlhacks2026'

#new stuff
app.config["SECRET_KEY"] = "abc123"
socketio = SocketIO(app)

@app.route("/")
def login():
    return render_template("login.html")

@app.route("/InformationForm")
def survey():
    return render_template("survey.html")

@app.route("/Match")
def swipe():
    user1 = {
        "name": "Aiden Park",
        "sleep_schedule": "night_owl",
        "cleanliness": 3,
        "living_preference": "on_campus",
        "rent_min": 500,
        "rent_max": 800
    }

    db = get_db()
    n_user = session.get('n_user', 1)
    #current_user = db.execute('SELECT * FROM users WHERE id = ?', (n_user,)).fetchone()
    all_users = db.execute('SELECT * FROM users').fetchall()

    matches = top_matches(user1, all_users)

    if matches:
        users = []
        for match in matches:
            user = dict(match['user']) 
            user['score'] = match['compatibility']['score']
            user['reasoning'] = match['compatibility']['reasoning']
            users.append(user)
    else:
        users = []
    return render_template("swipe.html", users=users)



@app.route("/Messages")
def messages():
    user1 = {
        "name": "Aiden Park",
        "sleep_schedule": "night_owl",
        "cleanliness": 3,
        "living_preference": "on_campus",
        "rent_min": 500,
        "rent_max": 800
    }

    db = get_db()
    #current_user = db.execute('SELECT * FROM users WHERE id = ?', (n_user,)).fetchone()
    all_users = db.execute('SELECT * FROM users').fetchall()

    return render_template("messages.html", users=all_users)

# For each chat
@app.route("/Messages/<int:user_id>")
def chat(user_id):
    db = get_db()

    current_user = "Aiden Park"


    room =f"chat_{user_id}" #f"chat_{min(current_user,user_id)}_{max(current_user,user_id)}"
    other_user = db.execute('SELECT * FROM users WHERE id = ?', (user_id,)).fetchone()

    

    return render_template("chat.html",current_user = current_user,other_user=other_user,room=room)

# Listens for messages
@socketio.on("join")
def on_join(data):
    join_room(data["room"])

@socketio.on("send_message")
def handle_message(data):
    send({"username":data["username"],"message": data["message"]}, room=data["room"])



@app.route("/Notifications")
def matches():
    return render_template("matches.html")

@app.route("/Profile")
def profile():
    return render_template("profile.html")


if __name__ == "__main__":
    #app.run(debug=True)
    socketio.run(app, debug=True)