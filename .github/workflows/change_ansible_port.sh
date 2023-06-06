#!/usr/bin/env bash
sed -i '/        ansible_port: 2222/c\        ansible_port: 22' user_vault.yml