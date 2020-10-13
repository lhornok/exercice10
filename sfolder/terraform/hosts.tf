#################################################################################
# EC2 INSTANCE                                                                  #
# Ubuntu Server 18.04 LTS (HVM), SSD Volume Type                                #
################################################################################

resource "aws_instance" "wordpress1" {
    ami = "ami-089cc16f7f08c4457"
    instance_type = "t2.medium"
    key_name = "deployer-key"
    vpc_security_group_ids = [aws_security_group.wordpress.id, aws_security_group.sg_ssh.id, aws_security_group.memcached.id]
    subnet_id = aws_subnet.private_subnet_d.id
    associate_public_ip_address = true
    source_dest_check = false
}
