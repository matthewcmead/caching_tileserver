#!/usr/bin/env bash

export PATH=${PATH}:/opt/conda/bin

sed -i "s/PROXY_HOST_TILESERVER/$PROXY_HOST_TILESERVER/g" /usr/src/app/mapproxy.yaml
cd /usr/src/app
/opt/conda/bin/mapproxy-util create -t wsgi-app -f mapproxy.yaml config.py
gunicorn -k eventlet -w 4 -b :8081 --access-logfile - --error-logfile - config:application 2>&1
