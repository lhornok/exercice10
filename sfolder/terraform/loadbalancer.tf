#########################################
# APPLICATION LOAD BALANCER              #
#########################################
resource "aws_elb" "mademoizelle" {
  name            = "mademoizelle-elb-tf"
  internal        = false
  subnets         = ["${aws_subnet.private_subnet_d.id}"]
  security_groups = [aws_security_group.sg_elb.id]

  access_logs {
    bucket  = aws_s3_bucket.mademoizelle.bucket
    enabled = true
  }

  tags = {
    Environment = "production"
  }

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  instances                   = ["${aws_instance.wordpress1.id}"]
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

}

###########################################
## APPLICATION LOAD BALANCER ACCOUNT      #
##########################################

data "aws_elb_service_account" "main" {}

##########################################
# BUCKET FOR LOAD BALANCER               #
##########################################

resource "aws_s3_bucket" "mademoizelle" {
  bucket = "mademoizelle-bucket"
  acl    = "private"

  tags = {
    Name        = "Mademoizelle Bucket"
    Environment = "Prod"
  }

  policy = <<POLICY
{
  "Id": "Policy",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::mademoizelle-bucket/AWSLogs/*",
      "Principal": {
        "AWS": [
          "${data.aws_elb_service_account.main.arn}"
        ]
      }
    }
  ]
}
POLICY
}
