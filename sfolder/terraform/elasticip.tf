##########################################
# ELASTIC IP                             #
##########################################
resource "aws_eip" "mademoiselle" {
  vpc = true

  associate_with_private_ip = "10.0.0.12"
  depends_on                = [aws_internet_gateway.gw]
}
