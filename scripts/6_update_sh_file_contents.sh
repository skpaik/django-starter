#!/bin/bash
projectName=$1


cat >build.sh<<EOL
#!/bin/bash
EOL


cat >migrate_db.sh<<EOL
#!/bin/bash
python3 manage.py makemigrations
python3 manage.py migrate

python3 manage.py syncdb --noinput
echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@admin.com', 'admin')" | python manage.py shell

EOL


cat >prepare.sh<<EOL
#!/bin/bash
chmod +x run.sh
chmod +x build.sh
chmod +x migrate_db.sh
source .venv/bin/activate
python3 -m pip install --upgrade pip
python3 -m pip install django
EOL


cat >run.sh<<EOL
#!/bin/bash
python3 manage.py runserver
EOL