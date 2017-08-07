#!/usr/bin/env bash

export PATH=${PATH}:/opt/conda/bin




sed -i "s/PROXY_HOST_TILESERVER/$PROXY_HOST_TILESERVER/g" /etc/nginx/conf.d/map.conf
sed -i "s/PROXY_HOST_MAPPROXY/$PROXY_HOST_MAPPROXY/g" /etc/nginx/conf.d/map.conf
sed -i "s/OUTSIDE_PORT/$OUTSIDE_PORT/g" /etc/nginx/conf.d/map.conf
/usr/bin/rm -f /run/nginx.pid
/usr/sbin/nginx -t
/usr/sbin/nginx -g 'daemon off;'
