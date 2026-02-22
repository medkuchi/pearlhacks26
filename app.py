# Imports
from flask import Flask, render_template,request, session, redirect, jsonify
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


        print("DEBUG: top_matches returned:", matches)
        for u in users:
            print(u['name'], "score:", u['score'], "reasoning:", u['reasoning'])
    else:
        users = []
    return render_template("swipe.html", users=users)

# POST - records the swipe
@app.route("/Match", methods=['POST'])
def record_swipe():
    data = request.get_json()
    db = get_db()
    db.execute('INSERT INTO swipes (swiper_id, swiped_id, direction) VALUES (?, ?, ?)',
               (1, data['swiped_id'], data['direction']))
    db.commit()
    return jsonify({'status': 'ok'})


@app.route("/Messages") 
def messages(): 
    db = get_db() # temporary debug 
    all_swipes = db.execute('SELECT * FROM swipes').fetchall() 
    print("All swipes:", [dict(s) for s in all_swipes]) 
    # liked_users = db.execute(""" SELECT * FROM users WHERE id IN ( SELECT swiped_id FROM swipes WHERE swiper_id = 1 AND direction = 'right' ) """).fetchall() 
    liked_users = db.execute(""" SELECT * FROM users WHERE id IN ( SELECT swiped_id FROM swipes WHERE swiper_id = 1 AND direction = 'right' 
                AND id=(
                    SELECT MAX(id) FROM swipes s2
                    WHERE s2.swiped_id=swipes.swiped_id
                    AND s2.swiper_id=1
       )
     )
    """).fetchall() 

    return render_template("messages.html", users=liked_users)

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
    db = get_db()
    all_users = db.execute('SELECT * FROM users').fetchall()
    
    # randomly pick 3-5 users to show as notifications
    num = random.randint(3, 5)
    random_matches = random.sample(list(all_users), num)
    
    return render_template('matches.html', users=random_matches)

@app.route("/Profile")
def profile():
    return render_template("profile.html")


if __name__ == "__main__":
    #app.run(debug=True)
    socketio.run(app, debug=True)