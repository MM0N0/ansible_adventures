#!/usr/bin/env bash

# build
SCRIPT_DIR=$( cd ${0%/*} && pwd -P )
docker build -t centos_base "$SCRIPT_DIR"
# start
docker run --rm \
  --tmpfs /run \
  --tmpfs /run/lock \
 -p 2222:22 -p 8090:8090 -p 8080:8080 \
  --name=centos_base_container --rm centos_base &

# --mount type=bind,source="$(pwd)",target=/repo \