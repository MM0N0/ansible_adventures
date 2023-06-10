#!/usr/bin/env bash

# load vars
. "${0%/*}/.env.sh"

# build
"$SCRIPT_DIR/build.sh"

# publish
docker push "$IMAGE"
