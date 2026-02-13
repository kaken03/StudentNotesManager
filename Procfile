web: gunicorn StudentNotesManager.wsgi
worker: python manage.py migrate && python manage.py collectstatic --noinput
