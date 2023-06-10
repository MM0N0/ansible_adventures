#!/usr/bin/env bash
./.test/docker/c7_ansible_test_host/down.sh > /dev/null 2>&1 || echo "no running container"

# to make script abort, when any command fails
set -e
set -o pipefail

./.test/docker/c7_ansible_test_host/up.sh && sleep 2


## do root- and non-root-tasks
## running with can_become_root=true
ansible-playbook -i hosts/dev/ -i user_vault.yml \
 \
 playbooks/testing/java_test/java-role.yml \
 playbooks/testing/tomcat_test/tomcat-role.yml \
 \
 -e "can_become_root=true" \
 $1

## do non-root tasks
## running with can_become_root=false
## (can_become_root is set to false in user_vault.yml)
#ansible-playbook -i hosts/dev/ -i user_vault.yml \
# playbooks/testing/java_test/java-role.yml \
# playbooks/testing/tomcat_test/tomcat-role.yml


sleep 2 && curl localhost:8080

./.test/docker/c7_ansible_test_host/down.sh
