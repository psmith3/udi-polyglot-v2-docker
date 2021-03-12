#!/bin/bash
find /root/.polyglot/nodeservers/ -name 'requirements.txt' -exec pip3 install -r {} \;
/opt/udi-polyglotv2/polyglot-v2-freebsd-x64
