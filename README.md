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

**SSH_KEY** - If you require a special ssh private key to access a git repository, add it here. It needs to be a base64 encoded version of id_rsa. For example to add your own private key, run `cat ~/.ssh/id_rsa | base64 -w0` to generate this value.

**GIT_SSH_REPO** - A git ssh (not https!) repo url, eg. git@github.com:impulsecloud/gitrepo.git. Not required if you are manually mounting a project on /opt/django/app. Default: None

**GIT_TREEISH** - A git treeish specification of which files to fetch inside the repo. Examples are: `HEAD`, `HEAD:/mysubdir/`, `dev_branch:/project2`, `v1.5.3`, `master`. Default: HEAD

Typically you will then have your own convention for environment variables used in Django's settings.py such as the DB_URI and DEBUG mode.

