#!/usr/bin/env bash

# to make script abort, when any command fails
set -e
set -o pipefail

./.test/docker/clean_centos/up.sh

ansible-playbook -i hosts/dev/ -i user_vault.yml playbooks/testing/run_cmd_remote.yml
ansible-playbook -i hosts/dev/ -i user_vault.yml playbooks/testing/test-role.yml

ansible-playbook -i hosts/dev/ -i user_vault.yml playbooks/testing/test-role.yml

./.test/docker/clean_centos/down.sh
