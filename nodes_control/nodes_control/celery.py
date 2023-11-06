import os
from celery import Celery

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'nodes_control.settings')

app = Celery('nodes_control')
app.config_from_object('django.conf:settings', namespace='CELERY')
app.autodiscover_tasks()