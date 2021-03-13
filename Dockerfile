FROM debian:buster

EXPOSE 3000
# Rachio Websocket
EXPOSE 3001

RUN apt-get update && apt-get dist-upgrade -y
RUN apt-get -qqy install git python3-pip python3-dev python2.7-dev python-pip nano wget zip

RUN mkdir -p /opt/udi-polyglotv2/
WORKDIR /opt/udi-polyglotv2/

RUN wget -q https://s3.amazonaws.com/polyglotv2/binaries/2.2.10/polyglot-v2-linux-x64.tar.gz
RUN tar -zxf /opt/udi-polyglotv2/polyglot-v2-linux-x64.tar.gz

COPY run.sh /opt/
RUN chmod +x /opt/run.sh
RUN chmod +x /opt/udi-polyglotv2/polyglot-v2-linux-x64

CMD /opt/run.sh
