#!/bin/bash

set -o verbose

function clean_stop {
  # supervisord will tell us the pid of celery
  CELERYPID=$(/usr/bin/supervisorctl pid celery)

  # Send SIGUSR1 to each child process, which triggers a SoftTimeLimitExceeded exception
  pgrep -P $CELERYPID | while read x; do kill -USR1 $x; done

  # Normal warm shutdown of celery
  /usr/bin/supervisorctl stop all
  exit
}

# Docker will send TERM when it's time to shutdown
trap clean_stop SIGTERM

# See if we need to wait on any databases
if [ -n "${PG_ISREADY_URI}" ];
then
  until pg_isready -d ${PG_ISREADY_URI}
  do
    sleep 5
  done
fi

if [ -n "${SSH_KEY}" ];
then
  mkdir -p /root/.ssh
  echo "${SSH_KEY}" | base64 --decode > /root/.ssh/id_rsa
  chmod 700 /root/.ssh/id_rsa
  echo -e "Host *\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
fi

if [ -z "${GIT_TREEISH}" ];
then
  GIT_TREEISH=HEAD
fi

if [ -n "${GIT_SSH_REPO}" ];
then
  cd /opt/django/app/
  rm -rf *
  git archive --format=tar --remote=${GIT_SSH_REPO} ${GIT_TREEISH} | tar xf -
fi

if [ -z "${BROKER_URL}" ]
then
    echo "No BROKER_URL specified!"
    exit 1
fi

if [ "${INSTANCE_TYPE}" == "beat" ]
then
    echo "Starting Beat Instance with broker ${BROKER_URL}"
#    sed -i "s/#BEATfiles/files/g" /opt/django/supervisord.conf
    ln -s /opt/django/celerybeat.conf /etc/supervisor/conf.d/
else
    echo "Starting Worker Instance with broker ${BROKER_URL}"
#    sed -i "s/#WORKERfiles/files/g" /opt/django/supervisord.conf
    ln -s /opt/django/celeryd.conf /etc/supervisor/conf.d/; \
fi

if [ -n "${DJANGO_INIT_SCRIPT}" ] && [ -f "${DJANGO_INIT_SCRIPT}" ];
then
        echo "running init script ${DJANGO_INIT_SCRIPT}"
        (eval "${DJANGO_INIT_SCRIPT}")
fi

/usr/bin/supervisord
