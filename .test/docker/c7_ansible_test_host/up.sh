#!/usr/bin/env bash

# load vars
. "${0%/*}/vars.sh"

# build
#docker build -t "$IMAGE" "$SCRIPT_DIR"

# start
docker run --rm \
  -p 2222:22 -p 8090:8090 -p 8080:8080 \
  --name="${IMAGE_NAME}_container" --rm "$IMAGE" &
