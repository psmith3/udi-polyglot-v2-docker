FROM node:10-alpine

EXPOSE 3000
# Rachio Websocket
EXPOSE 3001

RUN	apk add --no-cache linux-headers build-base && \
		apk add --no-cache python3 python3-dev py3-pip bash git ca-certificates wget tzdata openssl && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    rm -r /root/.cache && \
    
#RUN apt-get update && apt-get dist-upgrade -y
#RUN apt-get -qqy install git python3-pip python3-dev python2.7-dev python-pip nano wget zip

RUN mkdir -p /opt/udi-polyglotv2/
WORKDIR /opt/udi-polyglotv2/

RUN wget -q https://s3.amazonaws.com/polyglotv2/binaries/polyglot-v2-linux-x64.tar.gz
RUN tar -zxf /opt/udi-polyglotv2/polyglot-v2-linux-x64.tar.gz

COPY run.sh /opt/
RUN chmod +x /opt/run.sh
RUN chmod +x /opt/udi-polyglotv2/polyglot-v2-linux-x64

CMD /opt/run.sh
