#!/usr/bin/env bash

# load vars
. "${0%/*}/.env.sh"

# stop
docker kill "${IMAGE_NAME}_container"
