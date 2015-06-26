#!/bin/bash

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
