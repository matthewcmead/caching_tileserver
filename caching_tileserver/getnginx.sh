#!/usr/bin/env bash

yum install -y createrepo
cat >/etc/yum.repos.d/nginx.repo <<'_EOF'
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=0
enabled=1
_EOF

reposync -r nginx -p /project/nginx_repo
cd /project/nginx_repo
createrepo -v nginx
