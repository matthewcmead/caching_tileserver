#!/usr/bin/env bash

yum groups mark install "Development Tools"
yum groups mark convert "Development Tools"
yum groupinstall -y 'Development Tools'
cd /project/pips
pip download \
  pyproj \
  MapProxy \
  gunicorn \
  eventlet
