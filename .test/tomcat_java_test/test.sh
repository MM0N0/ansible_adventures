#!/usr/bin/env bash
./.test/docker/clean_centos/down.sh

# to make script abort, when any command fails
set -e
set -o pipefail

./.test/docker/clean_centos/up.sh

./${0%/*}/run_playbooks.sh

sleep 2 && curl localhost:8080

./.test/docker/clean_centos/down.sh
