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

Environment Variables
---------------------

**BROKER_URL** - The URL to the message broker, eg RabbitMQ.

**INSTANCE_TYPE** - What type of celery worker to spawn. Valid values are `beat` and `worker`. (Default: worker)

**DJANGO_INIT_SCRIPT** - A script to run when starting up

**PG_ISREADY_URI** - Run pg_isready with this URI before anything else. In other words, wait for the database to be ready and accepting connections.

Typically you will then have your own convention for environment variables used in Django's settings.py such as the DB_URI and DEBUG mode.

