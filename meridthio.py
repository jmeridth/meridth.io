import os
import re

from datetime import date
from flask import Flask, render_template, request
from flask_mail import Mail, Message
from flask_recaptcha import ReCaptcha

app = Flask(__name__)

site_key = os.environ['MERIDTH_IO_RECAPTCHA_SITEKEY']
secret_key = os.environ['MERIDTH_IO_RECAPTCHA_SECRETKEY']
recaptcha = ReCaptcha(app=app, site_key=site_key, secret_key=secret_key)


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
                           years_experience=years_experience,
                           recaptcha=recaptcha.get_code())


@app.route("/contact", methods=["POST"])
def contact():
    if (not request.form['name'] or not request.form['email'] or
        not request.form['phont'] or not request.form['message'] or
            not is_email_address_valid(request.form['email'])):
        return False

    if recaptcha.verify():
        mail = Mail(app)
        msg = Message("",
                      sender=('Meridth.io website', 'noreply@meridth.io'),
                      recipients=['jmerdith@gmail.com'],
                      body=request.form['contact_email'])
        mail.send(msg)
    else:
        error(401)


@app.errorhandler(404)
@app.errorhandler(500)
@app.errorhandler(401)
def error(e):
    return render_template('error.html'), 404

if __name__ == "__main__":
    app.run()
