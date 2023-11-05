wait-for-it --timeout 0 --service=$DB_ADDRESS:3306 -- echo "DB is up"

echo "Make migrations"
python manage.py makemigrations --no-input

echo "Migrate"
python manage.py migrate --no-input

echo "Create admin"

script="
from django.contrib.auth.models import User;

username = '$ADMIN_NAME';
password = '$ADMIN_PASS';
email = '$ADMIN_MAIL';

if User.objects.filter(username=username).count()==0:
    User.objects.create_superuser(username, email, password);
    print('Superuser created.');
else:
    print('Superuser creation skipped.');
"
printf "$script" | python manage.py shell

echo "Collect static"
python manage.py collectstatic --noinput

echo "Run server"
gunicorn --bind 0.0.0.0:8000 nodes_control.asgi -k uvicorn.workers.UvicornWorker -w 4