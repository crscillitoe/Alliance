from flask import Flask, request, g
from flask_limiter import Limiter
from flask_cors import CORS, cross_origin
import uuid
import sqlite3

# ------- Flask API Configuration ------------------------------------------------ #
app = Flask(__name__)
CORS(app, support_credentials=True)

limiter = Limiter(
    app=app,
    key_func=lambda: request.headers.get("X-Real-Ip"),
)
# --------------------------------------------------------------------------------- #
# ------- Define initial database schema ------------------------------------------ #
with sqlite3.connect("alliance.db") as con:
    cur = con.cursor()
    cur.execute("""
    CREATE TABLE IF NOT EXISTS alliances(
        passphrase TEXT PRIMARY KEY,
        name TEXT,
        size INTEGER
    )
    """)
    con.commit()
# --------------------------------------------------------------------------------- #
# ------- Ensures Sqlite3 db connection is a shared resource across threads ------- #
def get_db():
    db = getattr(g, '_database', None)
    if db is None:
        db = g._database = sqlite3.connect("alliance.db")
    return db
# --------------------------------------------------------------------------------- #
# ------- Ensures Sqlite3 db connection is safely terminated on close ------------- #
@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.close()
# --------------------------------------------------------------------------------- #
# ------- Form Alliance ----------------------------------------------------------- #
@app.route("/form_alliance", methods=["GET"])
@cross_origin(support_credentials=True)
@limiter.limit("10 per day")
def form_alliance():
    random_uuid = uuid.uuid4()
    db = get_db()
    cur = db.cursor()
    cur.execute("""
    INSERT INTO alliances (passphrase, name, size)
    VALUES (
        ?,
        'Placeholder',
        1
    )
    """, (str(random_uuid), ))

    db.commit()

    return str(random_uuid), 200
# --------------------------------------------------------------------------------- #
# ------- Get Alliance Size ------------------------------------------------------- #
@app.route("/get_alliance_size", methods=["POST"])
@cross_origin(support_credentials=True)
@limiter.limit("10 per day")
def get_alliance_size():
    key = request.json['passphrase']
    cur = get_db().cursor()
    cur.execute("""
    SELECT size FROM alliances
        WHERE passphrase = ?
    """, (key, ))

    result = cur.fetchone()
    if result is None:
        return "Invalid Alliance", 200

    return str(result[0]), 200
# --------------------------------------------------------------------------------- #
# ------- Destroy Alliance -------------------------------------------------------- #
@app.route("/destroy_alliance", methods=["POST"])
@cross_origin(support_credentials=True)
@limiter.limit("1 per day")
def destroy_alliance():
    key = request.json['passphrase']
    db = get_db()
    cur = db.cursor()
    cur.execute("""
    DELETE FROM alliances
        WHERE passphrase = ?
    """, (key, ))

    if cur.rowcount == 0:
        return "Fail", 200
    else:
        db.commit()
        return "Success", 200
# --------------------------------------------------------------------------------- #
# ------- Join Alliance ----------------------------------------------------------- #
@app.route("/join_alliance", methods=["POST"])
@cross_origin(support_credentials=True)
@limiter.limit("10 per day")
def join_alliance():
    key = request.json['passphrase']
    db = get_db()
    cur = db.cursor()
    cur.execute("""
    UPDATE alliances
        SET size = size + 1
        WHERE passphrase = ?
    """, (key, ))

    if cur.rowcount == 0:
        return "Fail", 200
    else:
        db.commit()
        return "Success", 200
# --------------------------------------------------------------------------------- #
# ------- Entrypoint -------------------------------------------------------------- #
if __name__ == "__main__":
    app.run(debug=False, host="0.0.0.0")
# --------------------------------------------------------------------------------- #