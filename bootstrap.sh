#!/usr/bin/env bash

terraformFileName='terraform.zip'
HOMEVAGRANT=`getent passwd vagrant | cut -d : -f 6`

function downloadTerraform {
  wget https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip -O /tmp/$terraformFileName -o /tmp/wget.log
}

function installTerraform {
  unzip /tmp/$terraformFileName -d /usr/bin
  rm /tmp/$terraformFileName
}

function installAnsible {
  pip install ansible
}

function installPythonTerraform {
  pip install python-terraform
}

function installVimPluginTerraform {
  mkdir -p $HOMEVAGRANT/.vim 
  git clone https://github.com/hashivim/vim-terraform.git $HOMEVAGRANT/.vim/pack/plugins/start/vim-terraform
} 

function installAwsCli {
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
  unzip "/tmp/awscliv2.zip"
  ./aws/install
}

function systemInstall {
  apt-get update
  apt-get install -y unzip
  apt-get install -y python-pip
  apt-get install -y python3-pip
}

function copyCredAWS {
  mkdir -p $HOMEVAGRANT/.aws
  cp /srv/config $HOMEVAGRANT/.aws/
  cp /srv/credentials $HOMEVAGRANT/.aws/credentials
  chown -R vagrant:vagrant $HOMEVAGRANT/.aws
}

function main {
  systemInstall
  downloadTerraform
  installTerraform
  installAnsible
  installPythonTerraform
  installAwsCli
  copyCredAWS
}

main
