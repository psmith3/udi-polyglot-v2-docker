FROM alpine:latest

EXPOSE 3000
# Rachio Websocket
EXPOSE 3001

RUN apk --update-cache add python3 py3-pip openssl ca-certificates
RUN apk --update-cache add --virtual build-dependencies python3-dev build-base wget \
  && pip3 install -r requirements.txt \
  && python3 setup.py install \
  && apk del build-dependencies
  
RUN apk add --update nodejs

#RUN mkdir -p /opt/udi-polyglotv2/
#WORKDIR /opt/udi-polyglotv2/

#RUN wget -q https://s3.amazonaws.com/polyglotv2/binaries/polyglot-v2-linux-x64.tar.gz
#RUN tar -zxf /opt/udi-polyglotv2/polyglot-v2-linux-x64.tar.gz

#COPY run.sh /opt/
#RUN chmod +x /opt/run.sh
#RUN chmod +x /opt/udi-polyglotv2/polyglot-v2-linux-x64

#VOLUME /root/.polyglot

#CMD /opt/run.sh
