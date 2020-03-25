FROM impulsecloud/ic-ubuntu:18.04

MAINTAINER Johann du Toit <johann@winkreports.com>

RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - && \
  apt-get install -y \
    supervisor \
    nodejs && \
  npm install --global \
    babel-cli \
    babel-plugin-transform-react-jsx \
    babel-preset-env babel-preset-react \
    babel-plugin-transform-object-rest-spread && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD ./requirements.txt /opt/django/

RUN pip3 install --exists-action=s -r /opt/django/requirements.txt

ADD . /opt/django/

RUN ln -s /opt/django/supervisord.conf /etc/supervisor/conf.d/; \
    ln -s /usr/lib/node_modules/ /node_modules

VOLUME ["/opt/django/app"]
EXPOSE 80
CMD ["/opt/django/run.sh"]
