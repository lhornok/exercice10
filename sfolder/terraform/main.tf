############################################
# PROVIDER FOR TERRAFORM                   #
# OUTPUT TO ANSIBLE HOST FILE              #
############################################

provider "aws" {
  profile = "default"
  region  = var.region
}

locals {
  ansible_host = templatefile("./hosts.cfg", {
    wordpress_address = aws_instance.wordpress1.public_dns
  })
  loadbalancer_host = templatefile("./loadbalancer.cfg", {
    loadbalancer = aws_elb.mademoizelle.dns_name
  })
}

output "ansiblehost" {
  value = local.ansible_host
}

output "loadbalancer" {
  value = local.loadbalancer_host
}
