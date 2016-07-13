FROM impulsecloud/ic-ubuntu:python3.5

MAINTAINER Johann du Toit <johann@winkreports.com>

RUN apt-get update && apt-get install -y \
  supervisor && \
  pip3 install lxml && \
  pip3 install cryptography && \
  pip3 install Pillow && \
  pip3 install SQLAlchemy && \
  pip3 install psycopg2 && \
  pip3 install pycrypto && \
  pip3 install --exists-action=s -r requirements.txt && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD . /opt/django/

RUN ln -s /opt/django/supervisord.conf /etc/supervisor/conf.d/

VOLUME ["/opt/django/app"]
EXPOSE 80
CMD ["/opt/django/run.sh"]
