FROM python:3.6.0-alpine

WORKDIR /app
ADD . /app

RUN apk --update add build-base python3-dev && rm -rf /var/cache/apk/*
ADD requirements.txt /app
RUN pip install -r /app/requirements.txt

ENV POST_DATABASE_HOST post_db
ENV POST_DATABASE post

ENTRYPOINT ["python3", "post_app.py"]
