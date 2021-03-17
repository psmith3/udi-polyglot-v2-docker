FROM node:10-alpine

EXPOSE 3000
# Rachio Websocket
EXPOSE 3001

RUN mkdir -p /opt/udi-polyglotv2/
WORKDIR /opt/udi-polyglotv2/

RUN apk add --no-cache libc6-compat

RUN apt-get update && apt-get dist-upgrade -y
RUN apt-get -qqy install git python3-pip python3-dev python2.7-dev python-pip nano wget zip

# RUN apt-get update && apt-get install -y apt-utils lsb-release dpkg wget git tcpdump net-tools openssl build-essential cmake software-properties-common libssl-dev python python-requests python-dev python-pip python3-dev python3-pip python3-setuptools

# RUN apt-get install -y nodejs npm

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
