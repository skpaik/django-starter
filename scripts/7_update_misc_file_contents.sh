#!/bin/bash
projectName=$1

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