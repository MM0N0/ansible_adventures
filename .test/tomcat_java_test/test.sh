#!/usr/bin/env bash
./.test/docker/c7_ansible_test_host/down.sh > /dev/null 2>&1 || echo "no running container"

# to make script abort, when any command fails
set -e
set -o pipefail

./.test/docker/c7_ansible_test_host/up.sh

ANSIBLE_CMD="ansible-playbook -i hosts/dev/ -i user_vault.yml \
             playbooks/testing/java_test/java-role.yml \
             playbooks/testing/tomcat_test/tomcat-role.yml"

# do root- and non-root-tasks
# running with can_become_root=true
$ANSIBLE_CMD -e "can_become_root=true" $1

# run tests
$ANSIBLE_CMD --tags test

#./.test/docker/c7_ansible_test_host/down.sh
