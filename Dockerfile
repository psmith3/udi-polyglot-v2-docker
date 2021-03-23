FROM alpine:latest

EXPOSE 3000
# Rachio Websocket
EXPOSE 3001

RUN mkdir -p /opt/udi-polyglotv2/
WORKDIR /opt/udi-polyglotv2/

RUN apk add --no-cache --virtual .build-deps linux-headers build-base && \
    apk add --no-cache python3 python3-dev py3-pip bash git ca-certificates wget tzdata openssl && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    rm -r /root/.cache && \
    apk add --update nodejs && \
    apk add --update npm && \
    wget -q https://s3.amazonaws.com/polyglotv2/binaries/polyglot-v2-linux-x64.tar.gz && \
    tar -zxf /opt/udi-polyglotv2/polyglot-v2-linux-x64.tar.gz && \
    chmod +x /opt/udi-polyglotv2/polyglot-v2-linux-x64 && \
    apk del .build-deps  

VOLUME /root/.polyglot

CMD /opt/udi-polyglotv2/polyglot-v2-linux-x64
