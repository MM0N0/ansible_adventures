#!/usr/bin/env bash
DOCKERHUB_ID=mm0n0
IMAGE_NAME=c7_ansible_test_host
VERSION=v1
SCRIPT_DIR=$( cd ${0%/*} && pwd -P )

export IMAGE=$DOCKERHUB_ID/$IMAGE_NAME:$VERSION
export IMAGE_NAME
export SCRIPT_DIR
