#!/usr/bin/env bash

# load vars
. "${0%/*}/.env.sh"

# build
docker build -t "$IMAGE" "$SCRIPT_DIR"
