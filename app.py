# Imports
from flask import Flask, render_template, session, redirect
from database import get_db
from matching import top_matches

# My App
app = Flask(__name__)
app.secret_key = 'pearlhacks2026'

@app.route("/")
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
def chat():
    return render_template("chat.html")

@app.route("/Notifications")
def matches():
    return render_template("matches.html")



if __name__ == "__main__":
    app.run(debug=True)