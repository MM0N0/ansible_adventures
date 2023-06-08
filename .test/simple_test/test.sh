#!/usr/bin/env bash
./.test/docker/c7_ansible_test_host/down.sh

# to make script abort, when any command fails
set -e
set -o pipefail

./.test/docker/c7_ansible_test_host/up.sh

ansible-playbook -vvv -i hosts/dev/ -i user_vault.yml \
 playbooks/testing/run_cmd_local.yml \
 playbooks/testing/run_cmd_remote.yml \
 playbooks/testing/simple_test/test-role.yml \
 playbooks/testing/simple_test/run_cmd_remote_show_files.yml

ansible-playbook -i hosts/dev/ -i user_vault.yml playbooks/testing/simple_test/test-role.yml

./.test/docker/c7_ansible_test_host/down.sh
