FROM ruby:2.5.1

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
  python3-dev build-essential python-pip

WORKDIR /code
COPY . /code

EXPOSE 5000
RUN pip install -r requirements.txt
ENTRYPOINT ["python", "wsgi.py"]
