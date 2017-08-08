FROM matthewcmead/anaconda-nb-docker-centos7 as builder

# Configure environment
ENV LANG=en_US.utf8 \
    LC_ALL=en_US.utf8

COPY pips /project/pips

RUN \
    touch /tmp/install_timestamp \
&&  sed -i "s/override_install_langs=en_US.UTF-8/override_install_langs=en_US.utf8/g" /etc/yum.conf \
&&  yum groups mark install "Development Tools" \
&&  yum groups mark convert "Development Tools" \
&&  yum groupinstall -y 'Development Tools' \
&&  pip install --no-index --find-links /project/pips \
        pyproj \
        MapProxy \
        gunicorn \
        eventlet

FROM matthewcmead/tileserver-gl-centos7 as runner

# Configure environment
ENV LANG=en_US.utf8 \
    LC_ALL=en_US.utf8

COPY --from=builder /opt/conda /opt/conda
COPY --from=builder /etc/profile.d/conda.sh /etc/profile.d

COPY nginx.repo /etc/yum.repos.d
COPY nginx_repo /tmp
#RUN yum install -y \
#      epel-release \
RUN yum install -y \
      nginx \
&&  yum clean all

COPY bin/tini /tini
RUN chmod 755 /tini
RUN rm -f /etc/nginx/conf.d/default.conf
COPY mapproxy.yaml /usr/src/app
COPY scripts /usr/src/app
COPY nginx_conf/nginx.conf /etc/nginx/nginx.conf
COPY nginx_conf/map.conf /etc/nginx/conf.d
COPY map_src /map

run sed -i "s/-p 80/-p 8080/;" /usr/src/app/run.sh

VOLUME /data
VOLUME /cache

WORKDIR /data

EXPOSE 80

ENV OUTSIDE_PORT=8080 \
    PROXY_HOST_TILESERVER=127.0.0.1 \
    PROXY_HOST_MAPPROXY=127.0.0.1

ENTRYPOINT ["/tini", "--", "/bin/bash", "/usr/src/app/startup_all.sh"]
