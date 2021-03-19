FROM nikolaik/python-nodejs:python3.9-nodejs15-alpine

EXPOSE 3000
# Rachio Websocket
EXPOSE 3001

RUN mkdir -p /opt/udi-polyglotv2/
WORKDIR /opt/udi-polyglotv2/

RUN wget -q https://s3.amazonaws.com/polyglotv2/binaries/polyglot-v2-linux-x64.tar.gz
RUN tar -zxf /opt/udi-polyglotv2/polyglot-v2-linux-x64.tar.gz

COPY run.sh /opt/
RUN chmod +x /opt/run.sh
RUN chmod +x /opt/udi-polyglotv2/polyglot-v2-linux-x64

VOLUME /root/.polyglot

CMD /opt/run.sh
