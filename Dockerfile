FROM node:10-alpine

EXPOSE 3000
EXPOSE 3001
WORKDIR /opt/polyglot-v2/

RUN apk add --no-cache linux-headers && \
    apk add --no-cache --virtual .build-deps build-base && \
    apk add --no-cache python3 gcc python3-dev musl-dev py3-pip bash git ca-certificates wget tzdata openssl && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    rm -r /root/.cache && \
    cd /opt && \
    git clone --depth=1 --single-branch --branch master https://github.com/UniversalDevicesInc/polyglot-v2.git && \
    cd /opt/polyglot-v2 && \
    npm install && \
    apk del .build-deps

VOLUME /root/.polyglot
VOLUME /usr/lib/python3.8/site-packages

ENV NODE_ENV=development

# Run Polyglot
CMD npm start
