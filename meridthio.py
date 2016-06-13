import os
import re

from datetime import date
from flask import Flask, render_template

app = Flask(__name__)


def is_email_address_valid(email):
    """Validate the email address using a regex."""
    pattern = ("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@"
               "[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$")
    if not re.match(pattern, email):
        return False
    return True


@app.route("/")
def home():
    current_year = date.today().year
    years_experience = current_year - 2000
    return render_template('index.html',
                           current_year=current_year,
                           years_experience=years_experience)


@app.errorhandler(404)
@app.errorhandler(500)
@app.errorhandler(401)
def error(e):
    return render_template('error.html'), 404

if __name__ == "__main__":
    app.run()
