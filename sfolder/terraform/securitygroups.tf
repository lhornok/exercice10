######################################################################################################
# SECURITY GROUPS
######################################################################################################

resource "aws_security_group" "sg_rds" {

  name = "sg_rds"
  vpc_id = aws_vpc.main.id
  ingress { 
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    cidr_blocks = [aws_subnet.private_subnet_d.cidr_block]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_security_group" "wordpress" {
    name = "vpc_web"
    description = "Allow incoming HTTP connections."

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        #cidr_blocks = [aws_subnet.private_subnet_d.cidr_block]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        #cidr_blocks = [aws_subnet.private_subnet_d.cidr_block]
    }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

    vpc_id = aws_vpc.main.id

}

resource "aws_security_group" "sg_ssh" {

  name = "sg_ssh"

  description = "Permettre le SSH depuis mon IP"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["83.79.158.0/24"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  vpc_id = aws_vpc.main.id

}


resource "aws_security_group" "memcached" {

  name = "memcached"

  description = "Permettre connextion memcached"

  ingress {
    from_port = 11211
    to_port   = 11211
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  vpc_id = aws_vpc.main.id

}


resource "aws_security_group" "sg_elb" {

  name = "sg_elb"

  vpc_id = aws_vpc.main.id

  ingress {
    from_port = "80"
    to_port   = "80"
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  lifecycle {
    create_before_destroy = true
  }

}
