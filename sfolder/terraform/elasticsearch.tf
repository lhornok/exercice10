##########################################
# ELASTICSEARCH                          #
##########################################

variable "domain" {
  default = "madelk"
}

resource "aws_elasticsearch_domain" "es" {
  domain_name = var.domain
  elasticsearch_version = "7.7"
  
  cluster_config {
    instance_type = "t2.small.elasticsearch"
  }

  vpc_options {
    subnet_ids = [
      aws_subnet.private_subnet_e.id,
    ]

    security_group_ids = [aws_security_group.es.id]
  }

  ebs_options {
    ebs_enabled = true
    iops = 0
    volume_size = 10
    volume_type = "gp2"
  }

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  access_policies = <<CONFIG
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "es.amazonaws.com"
      },
      "Action": [
        "logs:PutLogEvents",
        "logs:PutLogEventsBatch",
        "logs:CreateLogStream"
      ],
      "Resource": "arn:aws:logs:*"
    }
  ]
}
CONFIG

}

resource "aws_security_group" "es" {
  name        = "${aws_vpc.main.id}-elasticsearch-${var.domain}"
  description = "Managed by Terraform"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port = 443
    to_port   = 443 
    protocol  = "tcp"

    cidr_blocks = [
      aws_vpc.main.cidr_block,
    ]
  }
}
