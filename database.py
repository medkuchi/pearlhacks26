import sqlite3

def get_db():
    conn = sqlite3.connect('roommates1.db') #************* changed to roommates1
    conn.row_factory = sqlite3.Row
    return conn