##########################################
# BUCKET FOR CLOUDFRONT                  #
##########################################

data "aws_canonical_user_id" "current_user" {}

resource "aws_s3_bucket" "bmybucket" {
  bucket = "bmybucket"
  #acl    = "public"

  grant {
    id          = data.aws_canonical_user_id.current_user.id
    type        = "CanonicalUser"
    permissions = ["FULL_CONTROL"]
  }
  
  grant {
    type        = "Group"
    permissions = ["READ", "WRITE"]
    uri         = "http://acs.amazonaws.com/groups/s3/LogDelivery"
  }

  tags = {
    Name = "My bucket"
  }
}

locals {
  s3_origin_id = "bmybucket"
}

##########################################
# CLOUDFRONT                             #
##########################################
resource "aws_cloudfront_distribution" "test" {

  origin {
    domain_name = aws_s3_bucket.bmybucket.bucket_regional_domain_name
    origin_id   = local.s3_origin_id
  }

  enabled = true

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
}
