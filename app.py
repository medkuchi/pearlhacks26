# Imports
from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy


# My App
app = Flask(__name__)



@app.route("/")
def index():
    return render_template("index.html")

#change this to ("/")
@app.route("/Swipe")
def swipe():
    return render_template("swipe.html")

@app.route("/Messages")
def chat():
    return render_template("chat.html")

@app.route("/Notifications")
def matches():
    return render_template("matches.html")



if __name__ == "__main__":
    app.run(debug=True)