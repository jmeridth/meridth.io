FROM python:3.6.5-alpine3.7

RUN apk update && apk upgrade && apk --update add \
  python3-dev build-base linux-headers pcre-dev

WORKDIR /code
COPY . /code

EXPOSE 5000
RUN pip install --upgrade pip && pip install -r requirements.txt
ENTRYPOINT ["python", "wsgi.py"]
