Impulse Cloud Django Celery Docker Image
==================

docker image for running celery from a django installation
based off of ubuntu 14.04.2

To pull this image:
`docker pull impulsecloud/ic-celery`

Example usage to start a worker:
`docker run -p 80 -d -e BROKER_URL=amqp://admin:password@rabbitmq// -e INSTANCE_TYPE=worker -e DJANGO_INIT_SCRIPT=/opt/django/app/docker-celery.sh impulsecloud/ic-celery`

Example usage to start celery beat:
`docker run -p 80 -d -e BROKER_URL=amqp://admin:password@rabbitmq// -e INSTANCE_TYPE=beat -e DJANGO_INIT_SCRIPT=/opt/django/app/docker-celery.sh impulsecloud/ic-celery`


You must mount a django volume volume to run a specific application.  The default volume inside in the container is `/opt/django/app`.

