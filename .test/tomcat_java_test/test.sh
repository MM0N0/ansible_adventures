#!/usr/bin/env bash
./.test/docker/clean_centos/down.sh

# to make script abort, when any command fails
set -e
set -o pipefail

./.test/docker/clean_centos/up.sh

# do root tasks
ansible-playbook -i hosts/dev/ -i user_vault.yml \
 playbooks/testing/java_test/java-role.yml \
 playbooks/testing/tomcat_test/tomcat-role.yml \
 -e "can_become_root=true" --tags root_tasks

# do non-root tasks
# (can_become_root is set to false in user_vault.yml)
ansible-playbook -i hosts/dev/ -i user_vault.yml \
 playbooks/testing/java_test/java-role.yml \
 playbooks/testing/tomcat_test/tomcat-role.yml

sleep 2 && curl localhost:8080

./.test/docker/clean_centos/down.sh
