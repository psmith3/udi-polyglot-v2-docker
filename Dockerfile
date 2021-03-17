FROM ubuntu:bionic

EXPOSE 3000
# Rachio Websocket
EXPOSE 3001

RUN mkdir -p /opt/udi-polyglotv2/
WORKDIR /opt/udi-polyglotv2/

RUN apt-get update \
  && apt-get install -y wget \
  && apt-get install -y git \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 --no-cache-dir install --upgrade pip \
  && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && apt install -y nodejs \
  && rm -rf /var/lib/apt/lists/*

RUN wget -q https://s3.amazonaws.com/polyglotv2/binaries/polyglot-v2-linux-x64.tar.gz
RUN tar -zxf /opt/udi-polyglotv2/polyglot-v2-linux-x64.tar.gz

COPY run.sh /opt/
RUN chmod +x /opt/run.sh
RUN chmod +x /opt/udi-polyglotv2/polyglot-v2-linux-x64

ENV PYTHON=/usr/bin/python
ENV PYTHON3=/usr/bin/python3
ENV NODE_ENV=development

VOLUME /root/.polyglot

CMD /opt/run.sh
