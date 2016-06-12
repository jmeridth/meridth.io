import os

from datetime import date
from flask import Flask, render_template
app = Flask(__name__)


@app.route("/")
def home():
    years_experience = date.today().year - 2000
    recaptcha_sitekey = os.environ['MERIDTH_IO_RECAPTCHA_SITEKEY']
    return render_template('index.html', years_experience=years_experience,
                           recaptcha_sitekey=recaptcha_sitekey)


@app.errorhandler(404)
@app.errorhandler(500)
def page_not_found(e):
    return render_template('error.html'), 404

if __name__ == "__main__":
    app.run()
