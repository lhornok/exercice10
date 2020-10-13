#!/usr/bin/env bash

ansible-playbook -i hosts --user ubuntu --become --ask-vault-pass provision.yml
