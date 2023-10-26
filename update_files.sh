#!/bin/bash
projectName=$1

cat >build.sh<<EOL
#!/bin/bash
EOL


cat >start.sh<<EOL
#!/bin/bash
chmod +x run.sh
source .venv/bin/activate
python3 -m pip install --upgrade pip
python3 -m pip install django
EOL


cat >run.sh<<EOL
#!/bin/bash
python3 manage.py runserver
EOL


cat >README.md<<EOL
# $projectName
EOL


read -r -d '' env_sample << EOM
DEBUG=1
SECRET_KEY=foo
DJANGO_ALLOWED_HOSTS=localhost 127.0.0.1 [::1]
SQL_ENGINE=django.db.backends.postgresql
SQL_DATABASE=hello_django_dev
SQL_USER=hello_django
SQL_PASSWORD=hello_django
SQL_HOST=db
SQL_PORT=5432
DATABASE=postgres
EOM

cat >.env<<EOL
$env_sample
EOL

cat >.env.sample<<EOL
$env_sample
EOL


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