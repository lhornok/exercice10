# nephelaiio.elastic-repo

[![Build Status](https://travis-ci.org/nephelaiio/ansible-role-elastic-repo.svg?branch=master)](https://travis-ci.org/nephelaiio/ansible-role-elastic_repo)
[![Ansible Galaxy](http://img.shields.io/badge/ansible--galaxy-nephelaiio.elastic_repo-blue.svg)](https://galaxy.ansible.com/nephelaiio/elastic_repo/)

An [ansible role](https://galaxy.ansible.com/nephelaiio/elastic-repo) to install and configure Elasticsearch's repositories

## Role Variables

The most common user overridable parameters for the role are

| required | variable | description | default |
| --- | --- | --- | --- |
| no | elasticsearch_repo_oss | whether to install the oss version of the repository | yes |
| no | elasticsearch_repo_state | the state of the repository | present |

Please refer to the [defaults file](/defaults/main.yml) for an up to date list of input parameters.

## Example Playbook

```
- hosts: servers
  roles:
     - role: nephelaiio.elastic_repo
```

## Testing

Please make sure your environment has [docker](https://www.docker.com) installed in order to run role validation tests. Additional python dependencies are listed in the [requirements file](https://github.com/nephelaiio/ansible-role-requirements/blob/master/requirements.txt)

Role is tested against the following distributions (docker images):
  * Ubuntu Bionic
  * Ubuntu Xenial
  * CentOS 7
  * Debian Stretch

You can test the role directly from sources using command ` molecule test `

## License

This project is licensed under the terms of the [MIT License](/LICENSE)
