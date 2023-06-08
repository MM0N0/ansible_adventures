#!/usr/bin/env bash

# load vars
. "${0%/*}/vars.sh"

# build
docker build -t "$IMAGE" "$SCRIPT_DIR"

# publish
docker push "$IMAGE"
