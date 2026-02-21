# Imports
from flask import Flask, render_template, session, redirect
from database import get_db
from matching import top_matches

# My App
app = Flask(__name__)
app.secret_key = 'pearlhacks2026'

# @app.route("/")
# def index():
#     return render_template("index.html")

#change this to ("/")
@app.route("/")
def swipe():
    db = get_db()
    n_user = session.get('n_user', 1)
    current_user = db.execute('SELECT * FROM users WHERE id = ?', (n_user,)).fetchone()
    all_users = db.execute('SELECT * FROM users').fetchall()

    matches = top_matches(current_user, all_users)
    
    if matches:
        top = matches[0]
        user = dict(top['user'])
        user['score'] = top['compatibility']['score']
        user['reasoning'] = top['compatibility']['reasoning']
    else:
        user = None
    return render_template("swipe.html", user=user)

@app.route("/Messages")
def chat():
    return render_template("chat.html")

@app.route("/Notifications")
def matches():
    return render_template("matches.html")



if __name__ == "__main__":
    app.run(debug=True)