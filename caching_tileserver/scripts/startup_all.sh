#!/usr/bin/env bash

export PATH=${PATH}:/opt/conda/bin

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  TARGET="$(readlink "$SOURCE")"
  if [[ $TARGET == /* ]]; then
    SOURCE="$TARGET"
  else
    DIR="$( dirname "$SOURCE" )"
    SOURCE="$DIR/$TARGET" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  fi
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

"${DIR}/startup_tileserver-gl.sh" "$@" &
disown %1

"${DIR}/startup_mapproxy.sh" &
disown %1

"${DIR}/startup_nginx.sh"
