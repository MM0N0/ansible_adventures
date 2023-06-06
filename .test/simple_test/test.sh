#!/usr/bin/env bash
./.test/docker/clean_centos/down.sh

# to make script abort, when any command fails
set -e
set -o pipefail

./.test/docker/clean_centos/up.sh

ansible-playbook -i hosts/dev/ -i user_vault.yml \
 playbooks/testing/run_cmd_local.yml \
 playbooks/testing/run_cmd_remote.yml \
 playbooks/testing/simple_test/test-role.yml \
 playbooks/testing/simple_test/run_cmd_remote_show_files.yml

ansible-playbook -i hosts/dev/ -i user_vault.yml playbooks/testing/simple_test/test-role.yml

./.test/docker/clean_centos/down.sh
