#/bin/usr/env bash

terraform output ansiblehost > /srv/ansible/hosts
terraform output loadbalancer > /srv/ansible/roles/wordpress/vars/loadbalancer.yml
