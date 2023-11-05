FROM python:3.11.3

ENV PYTHONUNBUFFERED 1

WORKDIR /app

COPY requirements.txt requirements.txt

RUN ["pip", "install", "-r", "requirements.txt"]

COPY ./nodes_control /app

ENTRYPOINT [ "sh", "entrypoint.sh" ]