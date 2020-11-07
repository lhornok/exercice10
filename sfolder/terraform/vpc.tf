##########################################
# VPC / SUBNETS                          #
##########################################

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main"
  }
}

# Subnet NAT Gateway
resource "aws_subnet" "private_subnet_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.101.0/24"

  tags = {
    Name = "private_subnet_a"
  }
}

# Subnet MYSQL RDS, memcache
resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.102.0/24"
  availability_zone = var.azs.0

  tags = {
    Name = "private_subnet_b"
  }
}

# Subnet MYSQL RDS, memcache
resource "aws_subnet" "private_subnet_c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.103.0/24"
  availability_zone = var.azs.1


  tags = {
    Name = "private_subnet_c"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = ["${aws_subnet.private_subnet_b.id}", "${aws_subnet.private_subnet_c.id}"]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_elasticache_subnet_group" "mademoizelle" {
  name       = "cache-subnet"
  subnet_ids = ["${aws_subnet.private_subnet_b.id}", "${aws_subnet.private_subnet_c.id}"]
}

# Subnet EC2 Worpress
resource "aws_subnet" "private_subnet_d" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.104.0/24"

  tags = {
    Name = "private_subnet_d"
  }
}

# Subnet ES
resource "aws_subnet" "private_subnet_e" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.105.0/24"

  tags = {
    Name = "private_subnet_e"
  }
}
