#!/usr/bin/env bash

# load vars
. "${0%/*}/vars.sh"

# stop
docker kill "${IMAGE_NAME}_container"
