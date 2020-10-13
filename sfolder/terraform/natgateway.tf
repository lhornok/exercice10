##########################################
# VPC NAT GATEWAY                        #
##########################################
resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.mademoiselle.id
  subnet_id     = aws_subnet.private_subnet_d.id
}
