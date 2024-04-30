#!/bin/bash
projectName=$1

read -r -d '' dockerignore << EOM
*.yml
.git
.gitignore
.editorconfig
.vscode
*.md
*.sh
*.log
.env
EOM

cat >.dockerignore<<EOL
$dockerignore
EOL


read -r -d '' Dockerfile << EOM
# Tweak the base image by installing pipenv
FROM python:3.10 as base
RUN pip install pipenv

# Begin our actual build
FROM base as base1
# collectstatic needs the secret key to be set. We store that in this environment variable.
# Set this value in this project's .env file
ARG DJANGO_SECRET_KEY

RUN mkdir -p /usr/src/app

COPY ./_app /usr/src/app
COPY Pipfile /usr/src/app/
COPY Pipfile.lock /usr/src/app/

WORKDIR /usr/src/app

RUN pipenv install --system --deploy
RUN python manage.py collectstatic --no-input
EOM

cat >Dockerfile<<EOL
$Dockerfile
EOL


read -r -d '' docker_compose << EOM
version: '3.8'

services:
  web:
    build: ./app
    command: python manage.py runserver 0.0.0.0:8000
    volumes:
      - ./app/:/usr/src/app/
    ports:
      - 8000:8000
    env_file:
      - ./.env.dev
    depends_on:
      - db
  db:
    image: postgres:15
    volumes:
      - postgres_data:/var/lib/postgresql/data/
    environment:
      - POSTGRES_USER=hello_django
      - POSTGRES_PASSWORD=hello_django
      - POSTGRES_DB=hello_django_dev

volumes:
  postgres_data:
EOM

cat >docker-compose.yml<<EOL
$docker_compose
EOL