FROM impulsecloud/ic-ubuntu:latest

MAINTAINER Johann du Toity <johann@impulsecloud.com.au>

RUN apt-get update && apt-get install -y \
  supervisor && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD . /opt/django/

RUN ln -s /opt/django/supervisord.conf /etc/supervisor/conf.d/
#    ln -s /opt/django/celeryd.conf /etc/supervisor/conf.d/; \
#    ln -s /opt/django/celerybeat.conf /etc/supervisor/conf.d/

VOLUME ["/opt/django/app"]
EXPOSE 80
CMD ["/opt/django/run.sh"]
