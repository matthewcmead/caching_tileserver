#!/usr/bin/env bash

export PATH=${PATH}:/opt/conda/bin

/usr/src/app/run.sh "$@" 2>&1
