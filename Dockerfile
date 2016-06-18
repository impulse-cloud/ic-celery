FROM impulsecloud/ic-ubuntu:python3.5

MAINTAINER Johann du Toit <johann@winkreports.com>

RUN apt-get update && apt-get install -y \
  supervisor && \
  pip install lxml && \
  pip install cryptography && \
  pip install Pillow && \
  pip install SQLAlchemy && \
  pip install psycopg2 && \
  pip install pycrypto && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD . /opt/django/

RUN ln -s /opt/django/supervisord.conf /etc/supervisor/conf.d/

VOLUME ["/opt/django/app"]
EXPOSE 80
CMD ["/opt/django/run.sh"]
