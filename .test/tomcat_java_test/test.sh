#!/usr/bin/env bash

# to make script abort, when any command fails
set -e
set -o pipefail

./.test/docker/clean_centos/up.sh

ansible-playbook -i hosts/dev/ -i user_vault.yml \
 playbooks/testing/java_test/java-role.yml \
 playbooks/testing/tomcat_test/tomcat-role.yml \
 -e "can_become_root=true"

curl localhost:8080

./.test/docker/clean_centos/down.sh
